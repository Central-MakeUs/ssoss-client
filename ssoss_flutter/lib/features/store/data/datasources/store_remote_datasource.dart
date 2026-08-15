import 'package:ssoss_flutter/features/store/data/models/store_info_requests.dart';
import 'package:ssoss_flutter/features/store/data/models/store_info_response_model.dart';

abstract class StoreRemoteDatasource {
  Future<StoreInfoResponseModel> getMyStore();

  Future<void> saveBasicInfo(StoreBasicInfoRequest request);

  Future<void> saveOperationInfo(StoreOperationInfoRequest request);

  Future<void> saveContentInfo(StoreContentInfoRequest request);
}
