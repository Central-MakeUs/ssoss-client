import 'package:ssoss_flutter/core/service/shared_preferences_service.dart';
import 'package:ssoss_flutter/features/store/data/datasources/store_remote_datasource.dart';
import 'package:ssoss_flutter/features/store/data/models/store_info_requests.dart';
import 'package:ssoss_flutter/features/store/domain/entities/store_info.dart';
import 'package:ssoss_flutter/features/store/domain/repositories/store_repository.dart';

class StoreRepositoryImpl implements StoreRepository {
  StoreRepositoryImpl({
    required StoreRemoteDatasource remoteDatasource,
    required SharedPreferencesService preferences,
  })  : _remote = remoteDatasource,
        _preferences = preferences;

  static const _onboardingCompletedKey = 'store_onboarding_completed';

  final StoreRemoteDatasource _remote;
  final SharedPreferencesService _preferences;

  @override
  Future<StoreInfo> getMyStore() async {
    final response = await _remote.getMyStore();
    return response.toEntity();
  }

  @override
  Future<void> saveBasicInfo(StoreBasicInfoInput input) {
    return _remote.saveBasicInfo(StoreBasicInfoRequest.fromInput(input));
  }

  @override
  Future<void> saveOperationInfo(StoreOperationInfoInput input) {
    return _remote.saveOperationInfo(
      StoreOperationInfoRequest.fromInput(input),
    );
  }

  @override
  Future<void> saveContentInfo(StoreContentInfoInput input) {
    return _remote.saveContentInfo(StoreContentInfoRequest.fromInput(input));
  }

  @override
  Future<bool> hasCompletedOnboarding() async {
    return _preferences.readBool(_onboardingCompletedKey);
  }

  @override
  Future<void> markOnboardingCompleted() {
    return _preferences.writeBool(_onboardingCompletedKey, true);
  }
}
