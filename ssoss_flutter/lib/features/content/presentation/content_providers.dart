import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:ssoss_flutter/features/content/data/datasources/content_remote_datasource.dart';
import 'package:ssoss_flutter/features/content/data/datasources/demo_content_remote_datasource.dart';
import 'package:ssoss_flutter/features/content/data/repositories/content_repository_impl.dart';
import 'package:ssoss_flutter/features/content/domain/repositories/content_repository.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/create_content_usecase.dart';

/// content 피처 전용 provider 묶음.
///
/// `SsossAppScope` 의 `MultiProvider` 에 추가한다.
/// 데모 단계이므로 [DemoContentRemoteDatasource] 를 사용한다.
class ContentProviders {
  ContentProviders._();

  static List<SingleChildWidget> build() => [
        Provider<ContentRemoteDatasource>(
          create: (_) => const DemoContentRemoteDatasource(),
        ),
        ProxyProvider<ContentRemoteDatasource, ContentRepository>(
          update: (_, remote, __) => ContentRepositoryImpl(
            remoteDatasource: remote,
          ),
        ),
        ProxyProvider<ContentRepository, CreateContentUseCase>(
          update: (_, repository, __) => CreateContentUseCase(repository),
        ),
      ];
}
