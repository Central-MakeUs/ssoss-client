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

class TemplateApplyBody extends StatelessWidget {
  const TemplateApplyBody({
    required this.document,
    required this.hasStoreInfo,
    required this.onDocumentChanged,
    required this.onEditTap,
    super.key,
  });

  final SsossTemplateDocument document;
  final bool hasStoreInfo;
  final ValueChanged<SsossTemplateDocument> onDocumentChanged;
  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(15, 12, 16, 24),
      children: [
        TemplateApplyIntro(hasStoreInfo: hasStoreInfo),
        const SizedBox(height: 32),
        TemplateApplyEditor(
          document: document,
          onDocumentChanged: onDocumentChanged,
          onEditTap: onEditTap,
        ),
        const SizedBox(height: 14),
        const TemplateApplyHint(),
      ],
    );
  }
}

class TemplateApplyIntro extends StatelessWidget {
  const TemplateApplyIntro({
    required this.hasStoreInfo,
    super.key,
  });

  final bool hasStoreInfo;

  @override
  Widget build(BuildContext context) {
    if (!hasStoreInfo) {
      return const TemplateApplyStoreInfoWarning();
    }

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

class TemplateApplyStoreInfoWarning extends StatelessWidget {
  const TemplateApplyStoreInfoWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.warning50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            size: 20,
            color: AppColors.warning700,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  '매장 정보가 아직 입력되지 않았어요',
                  style: AppTextStyles.h8.copyWith(
                    color: AppColors.warning700,
                  ),
                ),
                const SizedBox(height: 4),
                AppText(
                  '[매장명]처럼 표시된 내용을 직접 입력하거나 수정해 주세요.',
                  style: AppTextStyles.b5.copyWith(
                    color: AppColors.warning700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TemplateApplyEditor extends StatelessWidget {
  const TemplateApplyEditor({
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
        TemplateApplySectionHeader(onEditTap: onEditTap),
        const SizedBox(height: 8),
        TemplateApplyEditCard(
          document: document,
          onDocumentChanged: onDocumentChanged,
        ),
      ],
    );
  }
}

class TemplateApplySectionHeader extends StatelessWidget {
  const TemplateApplySectionHeader({
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

class TemplateApplyEditCard extends StatelessWidget {
  const TemplateApplyEditCard({
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
              TemplateApplyCopyButton(
                onTap: () => unawaited(_copy(context)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TemplateApplyCopyButton extends StatelessWidget {
  const TemplateApplyCopyButton({
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

class TemplateApplyHint extends StatelessWidget {
  const TemplateApplyHint({super.key});

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

class TemplateApplyBottomBar extends StatelessWidget {
  const TemplateApplyBottomBar({
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
