import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_template_contents_card.dart';
import 'package:ssoss_flutter/common/widgets/card/template/ssoss_template_document.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/cubit/saved_template_detail_cubit.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/cubit/saved_template_detail_state.dart';
import 'package:ssoss_flutter/features/template/domain/entities/saved_template_detail.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/get_saved_template_usecase.dart';
import 'package:ssoss_flutter/features/template/presentation/pages/template_detail/template_detail_components.dart';
import 'package:ssoss_flutter/features/template/presentation/pages/template_edit/template_edit_page.dart';
import 'package:ssoss_flutter/features/template/presentation/util/template_label_mapper.dart';
import 'package:ssoss_flutter/features/template/presentation/widgets/template_list.dart';

class SavedContentTemplateDetailPage extends StatelessWidget {
  const SavedContentTemplateDetailPage({
    required this.savedTemplateId,
    super.key,
  });

  final int savedTemplateId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = SavedTemplateDetailCubit(
          getSavedTemplate: context.read<GetSavedTemplateUseCase>(),
          savedTemplateId: savedTemplateId,
        );
        unawaited(cubit.load());
        return cubit;
      },
      child: const _SavedContentTemplateDetailView(),
    );
  }
}

class _SavedContentTemplateDetailView extends StatelessWidget {
  const _SavedContentTemplateDetailView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedTemplateDetailCubit, SavedTemplateDetailState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: Column(
              children: [
                SsossAppBar.back(
                  title: '',
                  onBack: () => Navigator.of(context).pop(),
                ),
                Expanded(child: _buildBody(context, state)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, SavedTemplateDetailState state) {
    final detail = state.detail;

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
                    unawaited(context.read<SavedTemplateDetailCubit>().load()),
              ),
            ],
          ),
        ),
      );
    }

    if (detail == null) {
      return Center(
        child: AppText(
          '저장한 템플릿을 찾을 수 없습니다',
          style: AppTextStyles.b3.copyWith(color: AppColors.neutral500),
        ),
      );
    }

    return SavedContentTemplateDetailBody(
      detail: detail,
      onEditTap: () => unawaited(_openEdit(context, detail)),
    );
  }

  Future<void> _openEdit(
    BuildContext context,
    SavedTemplateDetail detail,
  ) async {
    final result = await context.push<SavedTemplateDetail>(
      TemplateEditPage.routePath,
      extra: TemplateEditArgs(
        document: SsossTemplateDocument.fromTemplate(detail.body),
        savedTemplateId: detail.savedTemplateId,
      ),
    );
    if (result == null || !context.mounted) {
      return;
    }
    context.read<SavedTemplateDetailCubit>().applyDetail(result);
  }
}

class SavedContentTemplateDetailBody extends StatelessWidget {
  const SavedContentTemplateDetailBody({
    required this.detail,
    required this.onEditTap,
    super.key,
  });

  final SavedTemplateDetail detail;
  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(15, 12, 16, 40),
      children: [
        _SavedTemplateDetailHeader(detail: detail),
        const SizedBox(height: 24),
        const Divider(height: 1, color: AppColors.neutral200),
        const SizedBox(height: 24),
        _SavedTemplateBodySection(
          body: detail.body,
          onEditTap: onEditTap,
        ),
        const SizedBox(height: 24),
        const TemplateNoticeBox(),
      ],
    );
  }
}

class _SavedTemplateDetailHeader extends StatelessWidget {
  const _SavedTemplateDetailHeader({required this.detail});

  final SavedTemplateDetail detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TemplateCategoryTag(
          category: TemplateLabelMapper.category(detail.category),
        ),
        const SizedBox(height: 8),
        AppText(
          detail.title,
          style: AppTextStyles.h4.copyWith(color: AppColors.neutral800),
        ),
        const SizedBox(height: 2),
        AppText(
          detail.description,
          style: AppTextStyles.b4.copyWith(color: AppColors.black),
        ),
        const SizedBox(height: 10),
        TemplateRecommendedChannels(
          channels: TemplateLabelMapper.channels(detail.recommendedChannels),
        ),
      ],
    );
  }
}

class _SavedTemplateBodySection extends StatelessWidget {
  const _SavedTemplateBodySection({
    required this.body,
    required this.onEditTap,
  });

  final String body;
  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: AppText(
                '본문',
                style: AppTextStyles.h5.copyWith(color: AppColors.black),
              ),
            ),
            GestureDetector(
              onTap: onEditTap,
              behavior: HitTestBehavior.opaque,
              child: SizedBox.square(
                dimension: 32,
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.icEdit2,
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      AppColors.neutral500,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SsossTemplateContentsCard(
          width: double.infinity,
          document: SsossTemplateDocument.fromTemplate(body),
          emptySlotColor: AppColors.primary300,
        ),
      ],
    );
  }
}
