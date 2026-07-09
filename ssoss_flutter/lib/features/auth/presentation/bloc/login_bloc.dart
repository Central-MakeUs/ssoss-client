import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/core/exception/app_exception.dart';

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
  }

  final LoginWithNaverUseCase _loginWithNaver;
  final LoginWithAppleUseCase _loginWithApple;
  final WithdrawUseCase _withdraw;
  final LogoutUseCase _logout;
  final RestoreSessionUseCase _restoreSession;
  bool _isLoginInProgress = false;

  Future<void> _onNaverLoginRequested(
    NaverLoginRequested event,
    Emitter<LoginState> emit,
  ) async {
    // Custom tab 이 열려있는 동안 중복 이벤트가 들어오면 웹뷰가 연속으로 쌓일 수 있다.
    if (_isLoginInProgress) {
      return;
    }
    _isLoginInProgress = true;
    emit(const LoginState.loading());
    try {
      final session = await _loginWithNaver();
      emit(LoginState.authenticated(session.user));
    } on AuthException catch (e) {
      // 취소 포함 모든 인증 오류는 안내 메시지를 보여준다.
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
    emit(const LoginState.loading());
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
}
