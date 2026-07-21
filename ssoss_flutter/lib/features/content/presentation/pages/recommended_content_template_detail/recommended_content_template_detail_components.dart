import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/accordion/ssoss_accordion.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/recommended_content_templates/recommended_content_templates_components.dart';

class ContentTemplateDetailHeader extends StatelessWidget {
  const ContentTemplateDetailHeader({
    required this.item,
    super.key,
  });

  final RecommendedContentTemplateItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ContentTemplateDetailCategoryTag(category: item.category),
        const SizedBox(height: 8),
        AppText(
          item.title,
          style: AppTextStyles.h4.copyWith(color: AppColors.neutral800),
        ),
        const SizedBox(height: 2),
        AppText(
          item.description,
          style: AppTextStyles.b4.copyWith(color: AppColors.black),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: AppText(
                '추천 채널',
                style: AppTextStyles.b5.copyWith(color: AppColors.neutral500),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Wrap(
                spacing: 4,
                runSpacing: 4,
                children: [
                  for (final channel in item.channels)
                    _ContentTemplateDetailChannelTag(label: channel),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ContentTemplatePreviewSection extends StatelessWidget {
  const ContentTemplatePreviewSection({
    required this.previewText,
    required this.isExampleOpen,
    required this.onExampleTap,
    super.key,
  });

  final String previewText;
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
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.neutral200),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: AppText(
                  previewText,
                  style: AppTextStyles.b4.copyWith(color: AppColors.black),
                ),
              ),
              const Divider(height: 1, color: AppColors.neutral200),
              SsossAccordion(
                title: '예시 보기',
                isOpen: isExampleOpen,
                onTap: onExampleTap,
              ),
              if (isExampleOpen) ...[
                const SizedBox(height: 8),
                AppText(
                  '보니스 커피에 새 메뉴가 출시되었습니다!\n\n'
                  '✨ 신메뉴: 딸기 크림 크루아상\n'
                  '💰 가격: 5,800원\n\n'
                  '바삭한 크루아상에 제철 딸기와 부드러운 크림을 가득 담았어요.',
                  style: AppTextStyles.b5.copyWith(color: AppColors.neutral700),
                ),
                const SizedBox(height: 8),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
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
        ),
      ],
    );
  }
}

class ContentTemplateNoticeBox extends StatelessWidget {
  const ContentTemplateNoticeBox({super.key});

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
              const Icon(
                Icons.campaign_outlined,
                size: 16,
                color: AppColors.warning700,
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

class ContentTemplateDetailBottomBar extends StatelessWidget {
  const ContentTemplateDetailBottomBar({
    required this.isSaved,
    required this.onSaveTap,
    required this.onApplyTap,
    super.key,
  });

  final bool isSaved;
  final VoidCallback onSaveTap;
  final VoidCallback onApplyTap;

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
              _ContentTemplateDetailSaveButton(
                isSaved: isSaved,
                onTap: onSaveTap,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SsossButton(
                  label: '템플릿 적용하기',
                  height: 56,
                  backgroundColor: AppColors.primary400,
                  foregroundColor: AppColors.white,
                  textStyle: AppTextStyles.h5,
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

class _ContentTemplateDetailSaveButton extends StatelessWidget {
  const _ContentTemplateDetailSaveButton({
    required this.isSaved,
    required this.onTap,
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
            child: Icon(
              isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
              size: 24,
              color: AppColors.neutral700,
            ),
          ),
        ),
      ),
    );
  }
}

class _ContentTemplateDetailCategoryTag extends StatelessWidget {
  const _ContentTemplateDetailCategoryTag({required this.category});

  final ContentTemplateCategory category;

  @override
  Widget build(BuildContext context) {
    final style = _ContentTemplateDetailCategoryStyle.from(category);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: AppText(
        category.label,
        style: AppTextStyles.b6.copyWith(color: style.foregroundColor),
      ),
    );
  }
}

class _ContentTemplateDetailChannelTag extends StatelessWidget {
  const _ContentTemplateDetailChannelTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.neutral50,
        borderRadius: BorderRadius.circular(4),
      ),
      child: AppText(
        label,
        style: AppTextStyles.b5.copyWith(color: AppColors.neutral500),
      ),
    );
  }
}

class _ContentTemplateDetailCategoryStyle {
  const _ContentTemplateDetailCategoryStyle({
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final Color backgroundColor;
  final Color foregroundColor;

  static _ContentTemplateDetailCategoryStyle from(
    ContentTemplateCategory category,
  ) {
    switch (category) {
      case ContentTemplateCategory.all:
        return const _ContentTemplateDetailCategoryStyle(
          backgroundColor: AppColors.neutral100,
          foregroundColor: AppColors.neutral500,
        );
      case ContentTemplateCategory.newMenu:
        return const _ContentTemplateDetailCategoryStyle(
          backgroundColor: AppColors.success50,
          foregroundColor: AppColors.success700,
        );
      case ContentTemplateCategory.event:
        return const _ContentTemplateDetailCategoryStyle(
          backgroundColor: AppColors.primary50,
          foregroundColor: AppColors.primary600,
        );
      case ContentTemplateCategory.storeIntro:
        return const _ContentTemplateDetailCategoryStyle(
          backgroundColor: AppColors.neutral100,
          foregroundColor: AppColors.neutral500,
        );
      case ContentTemplateCategory.notice:
        return const _ContentTemplateDetailCategoryStyle(
          backgroundColor: AppColors.info50,
          foregroundColor: AppColors.info700,
        );
    }
  }
}
