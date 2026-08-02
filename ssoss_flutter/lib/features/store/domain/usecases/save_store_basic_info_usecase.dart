import 'package:ssoss_flutter/features/store/domain/entities/store_info.dart';
import 'package:ssoss_flutter/features/store/domain/repositories/store_repository.dart';

class SaveStoreBasicInfoUseCase {
  const SaveStoreBasicInfoUseCase(this._repository);

  final StoreRepository _repository;

  Future<void> call(StoreBasicInfoInput input) {
    return _repository.saveBasicInfo(input);
  }
}
