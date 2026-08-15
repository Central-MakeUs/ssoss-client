import 'package:ssoss_flutter/features/store/domain/entities/store_info.dart';
import 'package:ssoss_flutter/features/store/domain/repositories/store_repository.dart';

class SaveStoreOperationInfoUseCase {
  const SaveStoreOperationInfoUseCase(this._repository);

  final StoreRepository _repository;

  Future<void> call(StoreOperationInfoInput input) {
    return _repository.saveOperationInfo(input);
  }
}
