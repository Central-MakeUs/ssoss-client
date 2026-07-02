import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.freezed.dart';

@freezed
sealed class LoginEvent with _$LoginEvent {
  const factory LoginEvent.naverLoginRequested() = NaverLoginRequested;
  const factory LoginEvent.withdrawRequested() = WithdrawRequested;
  const factory LoginEvent.sessionRestoreRequested() = SessionRestoreRequested;
  const factory LoginEvent.logoutRequested() = LogoutRequested;
}
