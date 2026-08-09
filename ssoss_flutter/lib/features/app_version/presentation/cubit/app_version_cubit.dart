import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/features/app_version/domain/usecases/check_app_version_usecase.dart';
import 'package:ssoss_flutter/features/app_version/presentation/cubit/app_version_state.dart';

class AppVersionCubit extends Cubit<AppVersionState> {
  AppVersionCubit({
    required CheckAppVersionUseCase checkAppVersion,
  })  : _checkAppVersion = checkAppVersion,
        super(const AppVersionState.checking());

  final CheckAppVersionUseCase _checkAppVersion;

  /// 현재 앱 버전을 조회한다.
  ///
  /// 네트워크 오류 시 [AppVersionState.networkUnavailable]을 emit한다.
  /// 그 외 조회 실패는 [AppVersionState.allowed]로 통과한다.
  Future<void> check() async {
    emit(const AppVersionState.checking());
    try {
      final result = await _checkAppVersion();
      if (isClosed) {
        return;
      }
      if (result.updateRequired) {
        emit(
          AppVersionState.updateRequired(
            minimumVersion: result.minimumVersion,
          ),
        );
      } else {
        emit(const AppVersionState.allowed());
      }
    } on NetworkException {
      if (isClosed) {
        return;
      }
      emit(const AppVersionState.networkUnavailable());
    } catch (_) {
      if (isClosed) {
        return;
      }
      emit(const AppVersionState.allowed());
    }
  }
}
