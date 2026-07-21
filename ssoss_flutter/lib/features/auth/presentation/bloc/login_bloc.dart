import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/core/network/session_expired_notifier.dart';

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

  @override
  Future<void> close() async {
    await _sessionExpiredSubscription?.cancel();
    return super.close();
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
      emit(LoginState.authenticated(session.user));
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
      emit(LoginState.authenticated(session.user));
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
        emit(const LoginState.unauthenticated());
      } else {
        emit(LoginState.authenticated(session.user));
      }
    } catch (_) {
      emit(const LoginState.unauthenticated());
    }
  }

  Future<void> _onWithdrawRequested(
    WithdrawRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginState.loading());
    try {
      await _withdraw();
      emit(const LoginState.unauthenticated());
    } on AppException catch (e) {
      emit(LoginState.failure(e.message));
    } catch (_) {
      emit(const LoginState.failure('탈퇴 처리 중 오류가 발생했습니다.'));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<LoginState> emit,
  ) async {
    try {
      await _logout();
    } catch (_) {
      // 로그아웃 실패해도 로컬 세션은 해제된 것으로 간주한다.
    }
    emit(const LoginState.unauthenticated());
  }

  Future<void> _onSessionExpired(
    SessionExpired event,
    Emitter<LoginState> emit,
  ) async {
    // 로그인 화면·미인증에서는 모달 없이 바로 unauthenticated.
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
    emit(const LoginState.unauthenticated());
  }
}
