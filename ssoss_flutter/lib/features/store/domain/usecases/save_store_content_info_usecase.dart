import 'package:ssoss_flutter/features/store/domain/entities/store_info.dart';
import 'package:ssoss_flutter/features/store/domain/repositories/store_repository.dart';

class SaveStoreContentInfoUseCase {
  const SaveStoreContentInfoUseCase(this._repository);

  final StoreRepository _repository;

  Future<void> call(StoreContentInfoInput input) {
    return _repository.saveContentInfo(input);
  }
}
