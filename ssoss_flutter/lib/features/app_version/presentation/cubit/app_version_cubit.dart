import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/features/app_version/domain/usecases/check_app_version_usecase.dart';
import 'package:ssoss_flutter/features/app_version/presentation/cubit/app_version_state.dart';

class AppVersionCubit extends Cubit<AppVersionState> {
  AppVersionCubit({
    required CheckAppVersionUseCase checkAppVersion,
  })  : _checkAppVersion = checkAppVersion,
        super(const AppVersionState.checking());

  final CheckAppVersionUseCase _checkAppVersion;

  /// 현재 앱 버전을 조회한다. 실패 시 [AppVersionState.allowed]로 통과한다.
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
    } catch (_) {
      if (isClosed) {
        return;
      }
      // 조회 실패 시 사용자를 막지 않는다.
      emit(const AppVersionState.allowed());
    }
  }
}
