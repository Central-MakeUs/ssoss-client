import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/core/network/session_expired_notifier.dart';

import '../../domain/entities/auth_session.dart';
import '../../domain/entities/member_status.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_with_apple_usecase.dart';
import '../../domain/usecases/login_with_naver_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/restore_session_usecase.dart';
import '../../domain/usecases/withdraw_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required LoginWithNaverUseCase loginWithNaver,
    required LoginWithAppleUseCase loginWithApple,
    required WithdrawUseCase withdraw,
    required LogoutUseCase logout,
    required RestoreSessionUseCase restoreSession,
    SessionExpiredNotifier? sessionExpiredNotifier,
  })  : _loginWithNaver = loginWithNaver,
        _loginWithApple = loginWithApple,
        _withdraw = withdraw,
        _logout = logout,
        _restoreSession = restoreSession,
        super(const LoginState.initial()) {
    on<NaverLoginRequested>(_onNaverLoginRequested);
    on<AppleLoginRequested>(_onAppleLoginRequested);
    on<WithdrawRequested>(_onWithdrawRequested);
    on<SessionRestoreRequested>(_onSessionRestoreRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<SessionExpired>(_onSessionExpired);
    on<SessionExpiredAcknowledged>(_onSessionExpiredAcknowledged);
    on<FailureAcknowledged>(_onFailureAcknowledged);
    on<SignupSucceeded>(_onSignupSucceeded);
    on<SignupCompleteAcknowledged>(_onSignupCompleteAcknowledged);

    if (sessionExpiredNotifier != null) {
      _sessionExpiredSubscription =
          sessionExpiredNotifier.stream.listen((_) {
        if (!isClosed) {
          add(const LoginEvent.sessionExpired());
        }
      });
    }
  }

  final LoginWithNaverUseCase _loginWithNaver;
  final LoginWithAppleUseCase _loginWithApple;
  final WithdrawUseCase _withdraw;
  final LogoutUseCase _logout;
  final RestoreSessionUseCase _restoreSession;
  StreamSubscription<void>? _sessionExpiredSubscription;
  bool _isLoginInProgress = false;
  User? _lastAuthenticatedUser;
  Completer<void>? _pendingLogout;
  Completer<void>? _pendingWithdraw;

  @override
  Future<void> close() async {
    await _sessionExpiredSubscription?.cancel();
    return super.close();
  }

  void _emitSessionResult(
    Emitter<LoginState> emit,
    AuthSession session,
  ) {
    if (session.memberStatus == MemberStatus.pending) {
      emit(
        LoginState.pendingSignup(
          user: session.user,
          email: session.user.email ?? '',
        ),
      );
      return;
    }

    _lastAuthenticatedUser = session.user;
    emit(LoginState.authenticated(session.user));
  }

  Future<void> _onNaverLoginRequested(
    NaverLoginRequested event,
    Emitter<LoginState> emit,
  ) async {
    if (_isLoginInProgress) {
      return;
    }
    _isLoginInProgress = true;
    emit(const LoginState.loading());
    try {
      final session = await _loginWithNaver();
      _emitSessionResult(emit, session);
    } on AuthException catch (e) {
      emit(LoginState.failure(e.message));
    } on AppException catch (e) {
      emit(LoginState.failure(e.message));
    } catch (_) {
      emit(const LoginState.failure('로그인 중 오류가 발생했습니다.'));
    } finally {
      _isLoginInProgress = false;
    }
  }

  Future<void> _onAppleLoginRequested(
    AppleLoginRequested event,
    Emitter<LoginState> emit,
  ) async {
    if (_isLoginInProgress) {
      return;
    }
    _isLoginInProgress = true;
    emit(const LoginState.loading());
    try {
      final session = await _loginWithApple();
      _emitSessionResult(emit, session);
    } on AuthException catch (e) {
      emit(LoginState.failure(e.message));
    } on AppException catch (e) {
      emit(LoginState.failure(e.message));
    } catch (_) {
      emit(const LoginState.failure('로그인 중 오류가 발생했습니다.'));
    } finally {
      _isLoginInProgress = false;
    }
  }

  Future<void> _onSessionRestoreRequested(
    SessionRestoreRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginState.restoring());
    try {
      final session = await _restoreSession();
      if (session == null) {
        _lastAuthenticatedUser = null;
        emit(const LoginState.unauthenticated());
      } else if (session.memberStatus == MemberStatus.pending) {
        emit(
          LoginState.pendingSignup(
            user: session.user,
            email: session.user.email ?? '',
          ),
        );
      } else {
        _lastAuthenticatedUser = session.user;
        emit(LoginState.authenticated(session.user));
      }
    } catch (_) {
      _lastAuthenticatedUser = null;
      emit(const LoginState.unauthenticated());
    }
  }

  Future<void> performLogout() {
    final pending = _pendingLogout;
    if (pending != null && !pending.isCompleted) {
      return pending.future;
    }

    final completer = Completer<void>();
    _pendingLogout = completer;
    add(const LoginEvent.logoutRequested());
    return completer.future;
  }

  Future<void> performWithdraw() {
    final pending = _pendingWithdraw;
    if (pending != null && !pending.isCompleted) {
      return pending.future;
    }

    final completer = Completer<void>();
    _pendingWithdraw = completer;
    add(const LoginEvent.withdrawRequested());
    return completer.future;
  }

  Future<void> _onWithdrawRequested(
    WithdrawRequested event,
    Emitter<LoginState> emit,
  ) async {
    final completer = _pendingWithdraw;
    final previousUser = state is LoginAuthenticated
        ? (state as LoginAuthenticated).user
        : _lastAuthenticatedUser;
    if (previousUser != null) {
      _lastAuthenticatedUser = previousUser;
    }

    try {
      await _withdraw();
      _lastAuthenticatedUser = null;
      emit(const LoginState.unauthenticated());
      completer?.complete();
    } on AppException catch (e) {
      emit(LoginState.failure(e.message));
      completer?.completeError(e);
    } catch (e) {
      emit(const LoginState.failure('탈퇴 처리 중 오류가 발생했습니다.'));
      completer?.completeError(e);
    } finally {
      _pendingWithdraw = null;
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<LoginState> emit,
  ) async {
    final completer = _pendingLogout;

    try {
      try {
        await _logout();
      } catch (_) {
        // 로그아웃 실패해도 로컬 세션은 해제된 것으로 간주한다.
      }
      _lastAuthenticatedUser = null;
      emit(const LoginState.unauthenticated());
      completer?.complete();
    } catch (e, stackTrace) {
      completer?.completeError(e, stackTrace);
      rethrow;
    } finally {
      _pendingLogout = null;
    }
  }

  Future<void> _onSessionExpired(
    SessionExpired event,
    Emitter<LoginState> emit,
  ) async {
    if (state is! LoginAuthenticated) {
      emit(const LoginState.unauthenticated());
      return;
    }
    emit(const LoginState.sessionExpired());
  }

  Future<void> _onSessionExpiredAcknowledged(
    SessionExpiredAcknowledged event,
    Emitter<LoginState> emit,
  ) async {
    _lastAuthenticatedUser = null;
    emit(const LoginState.unauthenticated());
  }

  Future<void> _onFailureAcknowledged(
    FailureAcknowledged event,
    Emitter<LoginState> emit,
  ) async {
    final user = _lastAuthenticatedUser;
    if (user != null) {
      emit(LoginState.authenticated(user));
    }
  }

  Future<void> _onSignupSucceeded(
    SignupSucceeded event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginState.signupComplete());
  }

  Future<void> _onSignupCompleteAcknowledged(
    SignupCompleteAcknowledged event,
    Emitter<LoginState> emit,
  ) async {
    final user = _lastAuthenticatedUser;
    if (user != null) {
      emit(LoginState.authenticated(user));
      return;
    }
    emit(const LoginState.unauthenticated());
  }

  void notifySignupSucceeded(User user) {
    _lastAuthenticatedUser = user;
    add(const LoginEvent.signupSucceeded());
  }
}
