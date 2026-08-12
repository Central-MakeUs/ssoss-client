import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/template/domain/entities/recommended_template_detail.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/bookmark_template_usecase.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/get_applied_template_usecase.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/get_template_usecase.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/unbookmark_template_usecase.dart';
import 'package:ssoss_flutter/features/template/presentation/cubit/template_detail_cubit.dart';
import 'package:ssoss_flutter/features/template/presentation/cubit/template_detail_state.dart';
import 'package:ssoss_flutter/features/template/presentation/models/template_apply_args.dart';
import 'package:ssoss_flutter/features/template/presentation/pages/template_apply/template_apply_page.dart';
import 'package:ssoss_flutter/features/template/presentation/pages/template_detail/template_detail_components.dart';
import 'package:ssoss_flutter/features/template/presentation/util/template_label_mapper.dart';
import 'package:ssoss_flutter/features/template/presentation/widgets/template_models.dart';

class TemplateDetailPage extends StatelessWidget {
  const TemplateDetailPage({
    required this.templateId,
    this.onBookmarkChanged,
    super.key,
  });

  static const String routeName = 'template-detail';
  static const String routePath = '/template-detail';

  final int templateId;
  final ValueChanged<bool>? onBookmarkChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = TemplateDetailCubit(
          getTemplate: context.read<GetTemplateUseCase>(),
          getAppliedTemplate: context.read<GetAppliedTemplateUseCase>(),
          bookmarkTemplate: context.read<BookmarkTemplateUseCase>(),
          unbookmarkTemplate: context.read<UnbookmarkTemplateUseCase>(),
          templateId: templateId,
        );
        unawaited(cubit.load());
        return cubit;
      },
      child: _TemplateDetailView(onBookmarkChanged: onBookmarkChanged),
    );
  }
}

class _TemplateDetailView extends StatefulWidget {
  const _TemplateDetailView({this.onBookmarkChanged});

  final ValueChanged<bool>? onBookmarkChanged;

  @override
  State<_TemplateDetailView> createState() => _TemplateDetailViewState();
}

class _TemplateDetailViewState extends State<_TemplateDetailView> {
  bool _isExampleOpen = false;

  TemplateItem _toItem(RecommendedTemplateDetail detail) {
    return TemplateItem(
      id: detail.id,
      category: TemplateLabelMapper.category(detail.category),
      title: detail.title,
      description: detail.description,
      channels: TemplateLabelMapper.channels(detail.recommendedChannels),
      isSaved: detail.bookmarked,
    );
  }

  void _handleBack() {
    context.pop();
  }

  void _syncBookmarkState(bool bookmarked) {
    widget.onBookmarkChanged?.call(bookmarked);
  }

  Future<void> _onSaveTap() async {
    final cubit = context.read<TemplateDetailCubit>();
    final success = await cubit.toggleBookmark();
    if (!mounted) {
      return;
    }
    if (success) {
      final bookmarked = cubit.state.detail?.bookmarked;
      if (bookmarked != null) {
        _syncBookmarkState(bookmarked);
      }
      return;
    }
    showSsossToast(
      context,
      title: '북마크 변경에 실패했습니다',
      type: SsossToastType.error,
    );
  }

  Future<void> _onApplyTap() async {
    final cubit = context.read<TemplateDetailCubit>();
    try {
      final applied = await cubit.apply();
      if (!mounted || applied == null) {
        return;
      }
      await context.push(
        TemplateApplyPage.routePath,
        extra: TemplateApplyArgs(
          templateId: applied.id,
          body: applied.body,
        ),
      );
    } on AppException catch (error) {
      if (!mounted) {
        return;
      }
      showSsossToast(
        context,
        title: error.message,
        type: SsossToastType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateDetailCubit, TemplateDetailState>(
      builder: (context, state) {
        final detail = state.detail;

        return BackButtonListener(
          onBackButtonPressed: () async {
            _handleBack();
            return true;
          },
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: SafeArea(
              child: Column(
                children: [
                  SsossAppBar.back(
                    title: '템플릿 미리보기',
                    onBack: _handleBack,
                  ),
                  Expanded(child: _buildBody(state, detail)),
                ],
              ),
            ),
            bottomNavigationBar: detail == null
                ? null
                : TemplateDetailBottomBar(
                    isSaved: detail.bookmarked,
                    isApplying: state.isApplying,
                    onSaveTap: () => unawaited(_onSaveTap()),
                    onApplyTap: state.isApplying
                        ? null
                        : () => unawaited(_onApplyTap()),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildBody(
    TemplateDetailState state,
    RecommendedTemplateDetail? detail,
  ) {
    if (state.isLoading && detail == null) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary400),
      );
    }

    final error = state.errorMessage;
    if (error != null && detail == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                error,
                textAlign: TextAlign.center,
                style: AppTextStyles.b3.copyWith(color: AppColors.neutral500),
              ),
              const SizedBox(height: 16),
              SsossButton(
                label: '다시 시도',
                size: SsossButtonSize.small,
                type: SsossButtonType.outline,
                onPressed: () =>
                    unawaited(context.read<TemplateDetailCubit>().load()),
              ),
            ],
          ),
        ),
      );
    }

    if (detail == null) {
      return Center(
        child: AppText(
          '템플릿을 찾을 수 없습니다',
          style: AppTextStyles.b3.copyWith(color: AppColors.neutral500),
        ),
      );
    }

    return TemplateDetailBody(
      item: _toItem(detail),
      previewText: detail.body,
      exampleText: detail.exampleBody,
      isExampleOpen: _isExampleOpen,
      onExampleTap: () {
        setState(() => _isExampleOpen = !_isExampleOpen);
      },
    );
  }
}
