import 'package:ssoss_flutter/features/store/domain/repositories/store_repository.dart';

class CheckStoreOnboardingUseCase {
  const CheckStoreOnboardingUseCase(this._repository);

  final StoreRepository _repository;

  Future<bool> call() => _repository.hasCompletedOnboarding();
}
