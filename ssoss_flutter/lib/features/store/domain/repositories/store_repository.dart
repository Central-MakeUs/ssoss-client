import 'package:ssoss_flutter/features/store/domain/entities/store_info.dart';

abstract class StoreRepository {
  Future<StoreInfo> getMyStore();

  Future<void> saveBasicInfo(StoreBasicInfoInput input);

  Future<void> saveOperationInfo(StoreOperationInfoInput input);

  Future<void> saveContentInfo(StoreContentInfoInput input);

  Future<bool> hasCompletedOnboarding();

  Future<void> markOnboardingCompleted();
}
