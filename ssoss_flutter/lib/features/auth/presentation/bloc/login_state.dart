import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'login_state.freezed.dart';

@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState.initial() = LoginInitial;
  const factory LoginState.loading() = LoginLoading;
  const factory LoginState.authenticated(User user) = LoginAuthenticated;
  const factory LoginState.unauthenticated() = LoginUnauthenticated;
  const factory LoginState.failure(String message) = LoginFailure;
}
