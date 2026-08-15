import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/card/template/ssoss_template_document.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/store/presentation/cubit/store_cubit.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/save_template_usecase.dart';
import 'package:ssoss_flutter/features/template/presentation/cubit/template_apply_cubit.dart';
import 'package:ssoss_flutter/features/template/presentation/cubit/template_apply_state.dart';
import 'package:ssoss_flutter/features/template/presentation/models/template_apply_args.dart';
import 'package:ssoss_flutter/features/template/presentation/pages/template_apply/template_apply_components.dart';
import 'package:ssoss_flutter/features/template/presentation/pages/template_edit/template_edit_page.dart';
import 'package:ssoss_flutter/features/template/presentation/pages/template_save_complete/template_save_complete_page.dart';

class TemplateApplyPage extends StatelessWidget {
  const TemplateApplyPage({
    required this.args,
    super.key,
  });

  static const String routeName = 'template-apply';
  static const String routePath = '/template-apply';

  final TemplateApplyArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TemplateApplyCubit(
        saveTemplate: context.read<SaveTemplateUseCase>(),
      ),
      child: _TemplateApplyView(args: args),
    );
  }
}

class _TemplateApplyView extends StatefulWidget {
  const _TemplateApplyView({
    required this.args,
  });

  final TemplateApplyArgs args;

  @override
  State<_TemplateApplyView> createState() => _TemplateApplyViewState();
}

class _TemplateApplyViewState extends State<_TemplateApplyView> {
  late SsossTemplateDocument _document;
  late bool _hasStoreInfo;

  @override
  void initState() {
    super.initState();
    final storeInfo = context.read<StoreCubit>().state.info;
    _hasStoreInfo = storeInfo.basic.status.isCompleted;
    _document = SsossTemplateDocument.fromTemplate(widget.args.body);
  }

  Future<void> _openEdit() async {
    final result = await context.push<SsossTemplateDocument>(
      TemplateEditPage.routePath,
      extra: TemplateEditArgs(document: _document),
    );
    if (result == null || !mounted) {
      return;
    }
    setState(() => _document = result);
  }

  Future<void> _onSaveTap() async {
    final success = await context.read<TemplateApplyCubit>().save(
          templateId: widget.args.templateId,
          body: _document.text,
        );
    if (!mounted || !success) {
      return;
    }
    context.go(TemplateSaveCompletePage.routePath);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TemplateApplyCubit, TemplateApplyState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage &&
          current.errorMessage != null,
      listener: (context, state) {
        final message = state.errorMessage;
        if (message == null) {
          return;
        }
        showSsossToast(
          context,
          title: message,
          type: SsossToastType.error,
        );
        context.read<TemplateApplyCubit>().clearError();
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: [
              SsossAppBar.backWithLabel(
                title: '템플릿 적용',
                label: '닫기',
                onBack: () => context.pop(),
                onDone: () => context.pop(),
              ),
              Expanded(
                child: TemplateApplyBody(
                  document: _document,
                  hasStoreInfo: _hasStoreInfo,
                  onDocumentChanged: (document) {
                    setState(() => _document = document);
                  },
                  onEditTap: () => unawaited(_openEdit()),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar:
            BlocBuilder<TemplateApplyCubit, TemplateApplyState>(
          builder: (context, state) {
            return TemplateApplyBottomBar(
              isLoading: state.isSaving,
              onSaveTap: state.isSaving ? null : () => unawaited(_onSaveTap()),
            );
          },
        ),
      ),
    );
  }
}
