import 'package:ssoss_flutter/features/store/domain/entities/store_info.dart';
import 'package:ssoss_flutter/features/store/domain/repositories/store_repository.dart';

class GetMyStoreUseCase {
  const GetMyStoreUseCase(this._repository);

  final StoreRepository _repository;

  Future<StoreInfo> call() => _repository.getMyStore();
}
