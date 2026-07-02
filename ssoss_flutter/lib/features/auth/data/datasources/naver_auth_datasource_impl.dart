import 'dart:developer' as dev;

import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_naver_login/interface/types/naver_account_result.dart';
import 'package:flutter_naver_login/interface/types/naver_login_result.dart';
import 'package:flutter_naver_login/interface/types/naver_login_status.dart';
import 'package:flutter_naver_login/interface/types/naver_token.dart';

import 'package:ssoss_flutter/core/exception/app_exception.dart';

import '../models/naver_account_model.dart';
import 'naver_auth_datasource.dart';

const _tag = 'NaverAuth';

class NaverAuthDatasourceImpl implements NaverAuthDatasource {
  const NaverAuthDatasourceImpl();

  @override
  Future<NaverAccountModel> login() async {
    final NaverLoginResult result = await FlutterNaverLogin.logIn();

    dev.log(
      '[login] status=${result.status} errorMessage=${result.errorMessage}',
      name: _tag,
    );

    if (result.status == NaverLoginStatus.error) {
      dev.log('[login] → error: ${result.errorMessage}', name: _tag);
      throw AuthException.socialFailed(
        result.errorMessage ?? '네이버 로그인에 실패했습니다.',
      );
    }

    final token = await _resolveAccessToken(result);
    final account = await _resolveAccount(result);

    dev.log(
      '[login] token=${token?.substring(0, token.length.clamp(0, 8))}… '
      'accountId=${account?.id}',
      name: _tag,
    );

    if (token != null && token.isNotEmpty && account?.id?.isNotEmpty == true) {
      return NaverAccountModel.fromResult(
        accessToken: token,
        account: account!,
      );
    }

    if (result.status == NaverLoginStatus.loggedOut) {
      final message = result.errorMessage;
      dev.log('[login] → loggedOut message=$message', name: _tag);
      if (_looksLikeUserCancelled(message)) {
        throw AuthException.cancelled();
      }
      throw AuthException.socialFailed(
        message ?? '네이버 로그인 처리 중 세션이 종료되었습니다.',
      );
    }

    dev.log(
      '[login] → token/account 획득 실패: ${result.errorMessage}',
      name: _tag,
    );
    throw AuthException.socialFailed(
      result.errorMessage ?? '네이버 계정 정보를 가져오지 못했습니다.',
    );
  }

  @override
  Future<void> logout() async {
    await FlutterNaverLogin.logOut();
  }

  @override
  Future<void> logoutAndDeleteToken() async {
    await FlutterNaverLogin.logOutAndDeleteToken();
  }

  Future<String?> _resolveAccessToken(NaverLoginResult result) async {
    final tokenFromResult = result.accessToken?.accessToken;
    dev.log('[resolveAccessToken] tokenFromResult=$tokenFromResult',
        name: _tag);
    if (tokenFromResult != null && tokenFromResult.isNotEmpty) {
      return tokenFromResult;
    }

    final NaverToken token = await FlutterNaverLogin.getCurrentAccessToken();
    if (token.accessToken.isEmpty) return null;
    return token.accessToken;
  }

  Future<NaverAccountResult?> _resolveAccount(NaverLoginResult result) async {
    final accountFromResult = result.account;
    if (accountFromResult?.id?.isNotEmpty == true) {
      return accountFromResult;
    }

    final account = await FlutterNaverLogin.getCurrentAccount();
    if (account.id == null || account.id!.isEmpty) return null;
    return account;
  }

  bool _looksLikeUserCancelled(String? message) {
    if (message == null || message.isEmpty) return true;
    final normalized = message.toLowerCase();
    return normalized.contains('canceled by user') ||
        normalized.contains('cancelled by user') ||
        normalized.contains('cancel') ||
        normalized.contains('취소');
  }
}
