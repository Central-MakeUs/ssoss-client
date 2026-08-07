import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:ssoss_flutter/features/hashtag/data/datasources/hashtag_remote_datasource.dart';
import 'package:ssoss_flutter/features/hashtag/data/datasources/hashtag_remote_datasource_impl.dart';
import 'package:ssoss_flutter/features/hashtag/data/repositories/hashtag_repository_impl.dart';
import 'package:ssoss_flutter/features/hashtag/domain/repositories/hashtag_repository.dart';
import 'package:ssoss_flutter/features/hashtag/domain/usecases/bookmark_hashtag_bundle_usecase.dart';
import 'package:ssoss_flutter/features/hashtag/domain/usecases/list_bookmarked_hashtag_bundles_usecase.dart';
import 'package:ssoss_flutter/features/hashtag/domain/usecases/list_hashtag_bundles_usecase.dart';
import 'package:ssoss_flutter/features/hashtag/domain/usecases/unbookmark_hashtag_bundle_usecase.dart';

/// hashtag 피처 전용 provider 묶음.
class HashtagProviders {
  HashtagProviders._();

  static List<SingleChildWidget> build() => [
        ProxyProvider<Dio, HashtagRemoteDatasource>(
          update: (_, dio, __) => HashtagRemoteDatasourceImpl(dio),
        ),
        ProxyProvider<HashtagRemoteDatasource, HashtagRepository>(
          update: (_, remote, __) => HashtagRepositoryImpl(
            remoteDatasource: remote,
          ),
        ),
        ProxyProvider<HashtagRepository, ListHashtagBundlesUseCase>(
          update: (_, repository, __) => ListHashtagBundlesUseCase(repository),
        ),
        ProxyProvider<HashtagRepository, ListBookmarkedHashtagBundlesUseCase>(
          update: (_, repository, __) =>
              ListBookmarkedHashtagBundlesUseCase(repository),
        ),
        ProxyProvider<HashtagRepository, BookmarkHashtagBundleUseCase>(
          update: (_, repository, __) =>
              BookmarkHashtagBundleUseCase(repository),
        ),
        ProxyProvider<HashtagRepository, UnbookmarkHashtagBundleUseCase>(
          update: (_, repository, __) =>
              UnbookmarkHashtagBundleUseCase(repository),
        ),
      ];
}
