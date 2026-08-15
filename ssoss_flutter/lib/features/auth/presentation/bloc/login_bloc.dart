import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/core/network/error_ui_suppressor.dart';
import 'package:ssoss_flutter/core/network/session_expired_notifier.dart';

import '../../domain/entities/auth_session.dart';
import '../../domain/entities/member_status.dart';
import '../../domain/entities/social_provider.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/withdrawal_reason.dart';
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
    on<WithdrawCompleteAcknowledged>(_onWithdrawCompleteAcknowledged);

    if (sessionExpiredNotifier != null) {
      _sessionExpiredSubscription = sessionExpiredNotifier.stream.listen((_) {
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
    emit(const LoginState.loading(provider: SocialProvider.naver));
    try {
      final session = await _loginWithNaver();
      _emitSessionResult(emit, session);
    } on ServerException catch (e) {
      emit(LoginState.failure(e.message));
    } on AuthException {
      emit(const LoginState.unauthenticated());
    } on AppException {
      emit(const LoginState.unauthenticated());
    } catch (_) {
      emit(const LoginState.unauthenticated());
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
    emit(const LoginState.loading(provider: SocialProvider.apple));
    try {
      final session = await _loginWithApple();
      _emitSessionResult(emit, session);
    } on ServerException catch (e) {
      emit(LoginState.failure(e.message));
    } on AuthException {
      emit(const LoginState.unauthenticated());
    } on AppException {
      emit(const LoginState.unauthenticated());
    } catch (_) {
      emit(const LoginState.unauthenticated());
    } finally {
      _isLoginInProgress = false;
    }
  }

  static const Duration _minimumSplashDuration = Duration(seconds: 2);

  Future<void> _onSessionRestoreRequested(
    SessionRestoreRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginState.restoring());
    final startedAt = DateTime.now();
    try {
      final session = await _restoreSession();
      await _ensureMinimumSplashDuration(startedAt);
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
      await _ensureMinimumSplashDuration(startedAt);
      _lastAuthenticatedUser = null;
      emit(const LoginState.unauthenticated());
    }
  }

  /// 세션 복원이 빨리 끝나도 스플래시를 최소 시간만큼 보여 준다.
  Future<void> _ensureMinimumSplashDuration(DateTime startedAt) async {
    final remaining =
        _minimumSplashDuration - DateTime.now().difference(startedAt);
    if (remaining > Duration.zero) {
      await Future<void>.delayed(remaining);
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

  Future<void> performWithdraw({WithdrawalReason? reason}) {
    final pending = _pendingWithdraw;
    if (pending != null && !pending.isCompleted) {
      return pending.future;
    }

    final completer = Completer<void>();
    _pendingWithdraw = completer;
    add(LoginEvent.withdrawRequested(reason: reason));
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
      await _withdraw(reason: event.reason);
      _lastAuthenticatedUser = null;
      emit(const LoginState.withdrawComplete());
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
    _lastAuthenticatedUser = null;
    ErrorUiSuppressor.suppressToasts = false;
    emit(const LoginState.unauthenticated());
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

  Future<void> _onWithdrawCompleteAcknowledged(
    WithdrawCompleteAcknowledged event,
    Emitter<LoginState> emit,
  ) async {
    _lastAuthenticatedUser = null;
    emit(const LoginState.unauthenticated());
  }

  void notifySignupSucceeded(User user) {
    _lastAuthenticatedUser = user;
    add(const LoginEvent.signupSucceeded());
  }
}
