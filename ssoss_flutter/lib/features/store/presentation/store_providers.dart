import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:ssoss_flutter/core/service/shared_preferences_service.dart';
import 'package:ssoss_flutter/features/store/data/datasources/store_remote_datasource.dart';
import 'package:ssoss_flutter/features/store/data/datasources/store_remote_datasource_impl.dart';
import 'package:ssoss_flutter/features/store/data/repositories/store_repository_impl.dart';
import 'package:ssoss_flutter/features/store/domain/repositories/store_repository.dart';
import 'package:ssoss_flutter/features/store/domain/usecases/check_store_onboarding_usecase.dart';
import 'package:ssoss_flutter/features/store/domain/usecases/clear_store_onboarding_usecase.dart';
import 'package:ssoss_flutter/features/store/domain/usecases/complete_store_onboarding_usecase.dart';
import 'package:ssoss_flutter/features/store/domain/usecases/get_my_store_usecase.dart';
import 'package:ssoss_flutter/features/store/domain/usecases/save_store_basic_info_usecase.dart';
import 'package:ssoss_flutter/features/store/domain/usecases/save_store_content_info_usecase.dart';
import 'package:ssoss_flutter/features/store/domain/usecases/save_store_operation_info_usecase.dart';

class StoreProviders {
  StoreProviders._();

  static List<SingleChildWidget> build() => [
        ProxyProvider<Dio, StoreRemoteDatasource>(
          update: (_, dio, __) => StoreRemoteDatasourceImpl(dio),
        ),
        ProxyProvider<StoreRemoteDatasource, StoreRepository>(
          update: (_, remote, __) => StoreRepositoryImpl(
            remoteDatasource: remote,
            preferences: SharedPreferencesService(),
          ),
        ),
        ProxyProvider<StoreRepository, GetMyStoreUseCase>(
          update: (_, repository, __) => GetMyStoreUseCase(repository),
        ),
        ProxyProvider<StoreRepository, SaveStoreBasicInfoUseCase>(
          update: (_, repository, __) => SaveStoreBasicInfoUseCase(repository),
        ),
        ProxyProvider<StoreRepository, SaveStoreOperationInfoUseCase>(
          update: (_, repository, __) =>
              SaveStoreOperationInfoUseCase(repository),
        ),
        ProxyProvider<StoreRepository, SaveStoreContentInfoUseCase>(
          update: (_, repository, __) =>
              SaveStoreContentInfoUseCase(repository),
        ),
        ProxyProvider<StoreRepository, CheckStoreOnboardingUseCase>(
          update: (_, repository, __) =>
              CheckStoreOnboardingUseCase(repository),
        ),
        ProxyProvider<StoreRepository, CompleteStoreOnboardingUseCase>(
          update: (_, repository, __) =>
              CompleteStoreOnboardingUseCase(repository),
        ),
        ProxyProvider<StoreRepository, ClearStoreOnboardingUseCase>(
          update: (_, repository, __) =>
              ClearStoreOnboardingUseCase(repository),
        ),
      ];
}
