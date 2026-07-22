import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'login_state.freezed.dart';

@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState.initial() = LoginInitial;

  /// 콜드 스타트 세션 복원 중. 스플래시에 머물며 로그인 화면을 노출하지 않는다.
  const factory LoginState.restoring() = LoginRestoring;

  const factory LoginState.loading() = LoginLoading;

  /// 가입 대기(PENDING) — 약관 동의 화면.
  const factory LoginState.pendingSignup({
    required User user,
    required String email,
  }) = LoginPendingSignup;

  const factory LoginState.authenticated(User user) = LoginAuthenticated;

  /// 회원가입 API 성공 — 완료 화면.
  const factory LoginState.signupComplete() = LoginSignupComplete;

  /// 로그인 후 화면에서 refresh 실패. 모달 표시 전까지 라우트 유지.
  const factory LoginState.sessionExpired() = LoginSessionExpired;

  const factory LoginState.unauthenticated() = LoginUnauthenticated;
  const factory LoginState.failure(String message) = LoginFailure;
}
