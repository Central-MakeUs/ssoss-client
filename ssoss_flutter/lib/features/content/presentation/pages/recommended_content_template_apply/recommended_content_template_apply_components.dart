import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_template_contents_edit_card.dart';
import 'package:ssoss_flutter/common/widgets/card/template/ssoss_template_document.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class RecommendedContentTemplateApplyBody extends StatelessWidget {
  const RecommendedContentTemplateApplyBody({
    required this.document,
    required this.onDocumentChanged,
    required this.onEditTap,
    super.key,
  });

  final SsossTemplateDocument document;
  final ValueChanged<SsossTemplateDocument> onDocumentChanged;
  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(15, 12, 16, 24),
      children: [
        const RecommendedContentTemplateApplyIntro(),
        const SizedBox(height: 32),
        RecommendedContentTemplateApplyEditor(
          document: document,
          onDocumentChanged: onDocumentChanged,
          onEditTap: onEditTap,
        ),
        const SizedBox(height: 14),
        const RecommendedContentTemplateApplyHint(),
      ],
    );
  }
}

class RecommendedContentTemplateApplyIntro extends StatelessWidget {
  const RecommendedContentTemplateApplyIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          '매장 정보가 자동으로 반영되었어요',
          style: AppTextStyles.h4.copyWith(color: AppColors.black),
        ),
        const SizedBox(height: 2),
        AppText(
          '마이페이지에 등록한 정보를 템플릿에 적용했어요',
          style: AppTextStyles.b4.copyWith(color: AppColors.neutral500),
        ),
      ],
    );
  }
}

class RecommendedContentTemplateApplyEditor extends StatelessWidget {
  const RecommendedContentTemplateApplyEditor({
    required this.document,
    required this.onDocumentChanged,
    required this.onEditTap,
    super.key,
  });

  final SsossTemplateDocument document;
  final ValueChanged<SsossTemplateDocument> onDocumentChanged;
  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RecommendedContentTemplateApplySectionHeader(onEditTap: onEditTap),
        const SizedBox(height: 8),
        RecommendedContentTemplateApplyEditCard(
          document: document,
          onDocumentChanged: onDocumentChanged,
        ),
      ],
    );
  }
}

class RecommendedContentTemplateApplySectionHeader extends StatelessWidget {
  const RecommendedContentTemplateApplySectionHeader({
    required this.onEditTap,
    super.key,
  });

  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class RecommendedContentTemplateApplyEditCard extends StatelessWidget {
  const RecommendedContentTemplateApplyEditCard({
    required this.document,
    required this.onDocumentChanged,
    super.key,
  });

  final SsossTemplateDocument document;
  final ValueChanged<SsossTemplateDocument> onDocumentChanged;

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: document.plainText));
    if (!context.mounted) {
      return;
    }
    showSsossToast(
      context,
      title: '클립보드에 복사되었습니다',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SsossTemplateContentsEditCard(
          document: document,
          onDocumentChanged: onDocumentChanged,
          minHeight: 376,
          showCounter: false,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          emptySlotColor: AppColors.primary300,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(
              left: BorderSide(color: AppColors.neutral200),
              right: BorderSide(color: AppColors.neutral200),
              bottom: BorderSide(color: AppColors.neutral200),
            ),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RecommendedContentTemplateApplyCopyButton(
                onTap: () => unawaited(_copy(context)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RecommendedContentTemplateApplyCopyButton extends StatelessWidget {
  const RecommendedContentTemplateApplyCopyButton({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 32,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AppAssets.icCopy,
                width: 18,
                height: 18,
                colorFilter: const ColorFilter.mode(
                  AppColors.neutral500,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 4),
              AppText(
                '복사하기',
                style: AppTextStyles.h8.copyWith(
                  color: AppColors.neutral500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecommendedContentTemplateApplyHint extends StatelessWidget {
  const RecommendedContentTemplateApplyHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.info_outline_rounded,
          size: 18,
          color: AppColors.info700,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: AppText(
            '[ ]로 표시된 항목을 입력하거나 수정해 주세요',
            style: AppTextStyles.b5.copyWith(color: AppColors.info700),
          ),
        ),
      ],
    );
  }
}

class RecommendedContentTemplateApplyBottomBar extends StatelessWidget {
  const RecommendedContentTemplateApplyBottomBar({
    required this.onSaveTap,
    super.key,
  });

  final VoidCallback onSaveTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
        child: SsossButton(
          label: '저장하기',
          width: double.infinity,
          height: 56,
          type: SsossButtonType.primary,
          onPressed: onSaveTap,
        ),
      ),
    );
  }
}
