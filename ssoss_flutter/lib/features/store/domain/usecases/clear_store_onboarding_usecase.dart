import 'package:ssoss_flutter/features/store/domain/repositories/store_repository.dart';

class ClearStoreOnboardingUseCase {
  const ClearStoreOnboardingUseCase(this._repository);

  final StoreRepository _repository;

  Future<void> call() => _repository.clearOnboardingCompleted();
}
