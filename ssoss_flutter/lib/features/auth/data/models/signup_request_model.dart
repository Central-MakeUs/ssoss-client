import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_request_model.freezed.dart';
part 'signup_request_model.g.dart';

/// `POST /v1/signup` 요청 바디.
@freezed
abstract class SignupRequestModel with _$SignupRequestModel {
  const factory SignupRequestModel({
    required bool serviceTermsAgreed,
    required bool privacyPolicyAgreed,
    required bool marketingAgreed,
  }) = _SignupRequestModel;

  factory SignupRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestModelFromJson(json);
}
