import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:ssoss_flutter/features/content/data/datasources/content_remote_datasource.dart';
import 'package:ssoss_flutter/features/content/data/datasources/content_remote_datasource_impl.dart';
import 'package:ssoss_flutter/features/content/data/repositories/content_repository_impl.dart';
import 'package:ssoss_flutter/features/content/domain/repositories/content_repository.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/delete_content_usecase.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/edit_content_channel_usecase.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/get_content_usecase.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/list_contents_usecase.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/poll_generation_usecase.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/rename_content_usecase.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/run_generation_usecase.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/run_style_reuse_generation_usecase.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/save_content_usecase.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/start_generation_usecase.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/start_style_reuse_usecase.dart';

/// content 피처 전용 provider 묶음.
class ContentProviders {
  ContentProviders._();

  static List<SingleChildWidget> build() => [
        ProxyProvider<Dio, ContentRemoteDatasource>(
          update: (_, dio, __) => ContentRemoteDatasourceImpl(dio),
        ),
        ProxyProvider<ContentRemoteDatasource, ContentRepository>(
          update: (_, remote, __) => ContentRepositoryImpl(
            remoteDatasource: remote,
          ),
        ),
        ProxyProvider<ContentRepository, StartGenerationUseCase>(
          update: (_, repository, __) => StartGenerationUseCase(repository),
        ),
        ProxyProvider<ContentRepository, PollGenerationUseCase>(
          update: (_, repository, __) => PollGenerationUseCase(repository),
        ),
        ProxyProvider<ContentRepository, RunGenerationUseCase>(
          update: (_, repository, __) => RunGenerationUseCase(
            startGeneration: StartGenerationUseCase(repository),
            pollGeneration: PollGenerationUseCase(repository),
          ),
        ),
        ProxyProvider<ContentRepository, StartStyleReuseUseCase>(
          update: (_, repository, __) => StartStyleReuseUseCase(repository),
        ),
        ProxyProvider<ContentRepository, RunStyleReuseGenerationUseCase>(
          update: (_, repository, __) => RunStyleReuseGenerationUseCase(
            startStyleReuse: StartStyleReuseUseCase(repository),
            pollGeneration: PollGenerationUseCase(repository),
          ),
        ),
        ProxyProvider<ContentRepository, SaveContentUseCase>(
          update: (_, repository, __) => SaveContentUseCase(repository),
        ),
        ProxyProvider<ContentRepository, EditContentChannelUseCase>(
          update: (_, repository, __) => EditContentChannelUseCase(repository),
        ),
        ProxyProvider<ContentRepository, ListContentsUseCase>(
          update: (_, repository, __) => ListContentsUseCase(repository),
        ),
        ProxyProvider<ContentRepository, GetContentUseCase>(
          update: (_, repository, __) => GetContentUseCase(repository),
        ),
        ProxyProvider<ContentRepository, DeleteContentUseCase>(
          update: (_, repository, __) => DeleteContentUseCase(repository),
        ),
        ProxyProvider<ContentRepository, RenameContentUseCase>(
          update: (_, repository, __) => RenameContentUseCase(repository),
        ),
      ];
}
