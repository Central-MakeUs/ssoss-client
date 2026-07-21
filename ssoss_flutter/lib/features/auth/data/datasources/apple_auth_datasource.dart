import '../models/apple_account_model.dart';

/// Apple SDK 인증 데이터소스.
abstract class AppleAuthDatasource {
  /// Apple 인증 수행. 취소 시 [AuthException.cancelled] throw.
  Future<AppleAccountModel> login();
}
