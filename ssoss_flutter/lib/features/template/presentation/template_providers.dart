import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:ssoss_flutter/features/template/data/datasources/template_remote_datasource.dart';
import 'package:ssoss_flutter/features/template/data/datasources/template_remote_datasource_impl.dart';
import 'package:ssoss_flutter/features/template/data/repositories/template_repository_impl.dart';
import 'package:ssoss_flutter/features/template/domain/repositories/template_repository.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/get_applied_template_usecase.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/get_saved_template_usecase.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/get_template_usecase.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/list_saved_templates_usecase.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/list_templates_usecase.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/save_template_usecase.dart';

/// template 피처 전용 provider 묶음.
class TemplateProviders {
  TemplateProviders._();

  static List<SingleChildWidget> build() => [
        ProxyProvider<Dio, TemplateRemoteDatasource>(
          update: (_, dio, __) => TemplateRemoteDatasourceImpl(dio),
        ),
        ProxyProvider<TemplateRemoteDatasource, TemplateRepository>(
          update: (_, remote, __) => TemplateRepositoryImpl(
            remoteDatasource: remote,
          ),
        ),
        ProxyProvider<TemplateRepository, ListTemplatesUseCase>(
          update: (_, repository, __) => ListTemplatesUseCase(repository),
        ),
        ProxyProvider<TemplateRepository, GetTemplateUseCase>(
          update: (_, repository, __) => GetTemplateUseCase(repository),
        ),
        ProxyProvider<TemplateRepository, GetAppliedTemplateUseCase>(
          update: (_, repository, __) => GetAppliedTemplateUseCase(repository),
        ),
        ProxyProvider<TemplateRepository, SaveTemplateUseCase>(
          update: (_, repository, __) => SaveTemplateUseCase(repository),
        ),
        ProxyProvider<TemplateRepository, ListSavedTemplatesUseCase>(
          update: (_, repository, __) => ListSavedTemplatesUseCase(repository),
        ),
        ProxyProvider<TemplateRepository, GetSavedTemplateUseCase>(
          update: (_, repository, __) => GetSavedTemplateUseCase(repository),
        ),
      ];
}
