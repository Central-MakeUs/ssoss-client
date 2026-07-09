import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:ssoss_flutter/core/exception/app_exception.dart';

import '../models/apple_account_model.dart';
import 'apple_auth_datasource.dart';

class AppleAuthDatasourceImpl implements AppleAuthDatasource {
  const AppleAuthDatasourceImpl();

  @override
  Future<AppleAccountModel> login() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      return AppleAccountModel(
        userIdentifier: credential.userIdentifier ?? '',
        identityToken: credential.identityToken,
        authorizationCode: credential.authorizationCode,
        email: credential.email,
        givenName: credential.givenName,
        familyName: credential.familyName,
      );
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        throw AuthException.cancelled();
      }
      throw AuthException.socialFailed('Apple 로그인에 실패했습니다.');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw AuthException.socialFailed('Apple 로그인에 실패했습니다.');
    }
  }
}
