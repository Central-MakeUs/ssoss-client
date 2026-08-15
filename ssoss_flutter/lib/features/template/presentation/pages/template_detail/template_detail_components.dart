import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ssoss_flutter/common/widgets/accordion/ssoss_accordion.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/template/presentation/widgets/template_list.dart';
import 'package:ssoss_flutter/features/template/presentation/widgets/template_models.dart';

class TemplateDetailBody extends StatelessWidget {
  const TemplateDetailBody({
    required this.item,
    required this.previewText,
    required this.exampleText,
    required this.isExampleOpen,
    required this.onExampleTap,
    super.key,
  });

  final TemplateItem item;
  final String previewText;
  final String exampleText;
  final bool isExampleOpen;
  final VoidCallback onExampleTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(15, 12, 16, 40),
      children: [
        TemplateDetailHeader(item: item),
        const SizedBox(height: 24),
        const TemplateDetailDivider(),
        const SizedBox(height: 24),
        TemplatePreviewSection(
          previewText: previewText,
          exampleText: exampleText,
          isExampleOpen: isExampleOpen,
          onExampleTap: onExampleTap,
        ),
        const SizedBox(height: 24),
        const TemplateNoticeBox(),
      ],
    );
  }
}

class TemplateDetailHeader extends StatelessWidget {
  const TemplateDetailHeader({
    required this.item,
    super.key,
  });

  final TemplateItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TemplateCategoryTag(category: item.category),
        const SizedBox(height: 8),
        TemplateDetailTitle(
          title: item.title,
          description: item.description,
        ),
        const SizedBox(height: 10),
        TemplateRecommendedChannels(channels: item.channels),
      ],
    );
  }
}

class TemplateDetailTitle extends StatelessWidget {
  const TemplateDetailTitle({
    required this.title,
    required this.description,
    super.key,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          title,
          style: AppTextStyles.h4.copyWith(color: AppColors.neutral800),
        ),
        const SizedBox(height: 2),
        AppText(
          description,
          style: AppTextStyles.b4.copyWith(color: AppColors.black),
        ),
      ],
    );
  }
}

class TemplateDetailDivider extends StatelessWidget {
  const TemplateDetailDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, color: AppColors.neutral200);
  }
}

class TemplatePreviewSection extends StatelessWidget {
  const TemplatePreviewSection({
    required this.previewText,
    required this.exampleText,
    required this.isExampleOpen,
    required this.onExampleTap,
    super.key,
  });

  final String previewText;
  final String exampleText;
  final bool isExampleOpen;
  final VoidCallback onExampleTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          '미리보기',
          style: AppTextStyles.h5.copyWith(color: AppColors.black),
        ),
        const SizedBox(height: 12),
        TemplatePreviewCard(
          previewText: previewText,
          exampleText: exampleText,
          isExampleOpen: isExampleOpen,
          onExampleTap: onExampleTap,
        ),
        const SizedBox(height: 16),
        const TemplateInfoHint(),
      ],
    );
  }
}

class TemplatePreviewCard extends StatelessWidget {
  const TemplatePreviewCard({
    required this.previewText,
    required this.exampleText,
    required this.isExampleOpen,
    required this.onExampleTap,
    super.key,
  });

  final String previewText;
  final String exampleText;
  final bool isExampleOpen;
  final VoidCallback onExampleTap;

  @override
  Widget build(BuildContext context) {
    final padding = isExampleOpen
        ? const EdgeInsets.fromLTRB(16, 20, 16, 20)
        : const EdgeInsets.fromLTRB(16, 20, 16, 0);

    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutral200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TemplatePreviewText(text: previewText),
          const TemplateDetailDivider(),
          const SizedBox(height: 8),
          TemplateExampleAccordion(
            isOpen: isExampleOpen,
            exampleText: exampleText,
            onTap: onExampleTap,
          ),
        ],
      ),
    );
  }
}

class TemplatePreviewText extends StatelessWidget {
  const TemplatePreviewText({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: AppText(
        text,
        style: AppTextStyles.b4.copyWith(color: AppColors.black),
      ),
    );
  }
}

class TemplateExampleAccordion extends StatelessWidget {
  const TemplateExampleAccordion({
    required this.isOpen,
    required this.exampleText,
    required this.onTap,
    super.key,
  });

  final bool isOpen;
  final String exampleText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SsossAccordion(
          title: '예시 보기',
          isOpen: isOpen,
          onTap: onTap,
        ),
        if (isOpen) ...[
          const SizedBox(height: 12),
          TemplateExampleContent(text: exampleText),
        ] else ...[
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}

class TemplateExampleContent extends StatelessWidget {
  const TemplateExampleContent({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.neutral50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: AppText(
        text,
        style: AppTextStyles.b4.copyWith(color: AppColors.neutral600),
      ),
    );
  }
}

class TemplateInfoHint extends StatelessWidget {
  const TemplateInfoHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.info_outline_rounded,
          size: 20,
          color: AppColors.neutral500,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: AppText(
            '실제 생성 시 마이페이지 내 입력된 매장 정보가 자동으로\n반영됩니다.',
            style: AppTextStyles.b5.copyWith(color: AppColors.neutral500),
          ),
        ),
      ],
    );
  }
}

class TemplateNoticeBox extends StatelessWidget {
  const TemplateNoticeBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.warning50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AppAssets.icToastWarning,
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(
                  AppColors.warning700,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
              AppText(
                '안내',
                style: AppTextStyles.h8.copyWith(
                  color: AppColors.warning700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          AppText(
            '템플릿은 참고용 예시입니다. 전체 문구를 자유롭게 편집해 가게 정보와 '
            '채널 특성에 맞게 활용해 주세요. 템플릿 사용으로 발생하는 문제는 '
            '쏘쓰가 책임지지 않습니다.',
            style: AppTextStyles.b5.copyWith(color: AppColors.warning700),
          ),
        ],
      ),
    );
  }
}

class TemplateDetailBottomBar extends StatelessWidget {
  const TemplateDetailBottomBar({
    required this.isSaved,
    required this.onSaveTap,
    required this.onApplyTap,
    this.isApplying = false,
    super.key,
  });

  final bool isSaved;
  final VoidCallback onSaveTap;
  final VoidCallback? onApplyTap;
  final bool isApplying;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.neutral200),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
          child: Row(
            children: [
              TemplateDetailSaveAction(
                isSaved: isSaved,
                onTap: onSaveTap,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SsossButton(
                  label: '템플릿 적용하기',
                  height: 56,
                  type: SsossButtonType.primary,
                  isLoading: isApplying,
                  onPressed: onApplyTap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TemplateDetailSaveAction extends StatelessWidget {
  const TemplateDetailSaveAction({
    required this.isSaved,
    required this.onTap,
    super.key,
  });

  final bool isSaved;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: isSaved ? '저장 해제' : '저장',
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.neutral200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: IgnorePointer(
                child: TemplateSaveButton(
                  isSaved: isSaved,
                  onTap: onTap,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
