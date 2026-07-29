import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/accordion/ssoss_accordion.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/recommended_content_templates/recommended_content_templates_components.dart';

class ContentTemplateDetailBody extends StatelessWidget {
  const ContentTemplateDetailBody({
    required this.item,
    required this.previewText,
    required this.isExampleOpen,
    required this.onExampleTap,
    super.key,
  });

  final RecommendedContentTemplateItem item;
  final String previewText;
  final bool isExampleOpen;
  final VoidCallback onExampleTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(15, 12, 16, 40),
      children: [
        ContentTemplateDetailHeader(item: item),
        const SizedBox(height: 24),
        const ContentTemplateDetailDivider(),
        const SizedBox(height: 24),
        ContentTemplatePreviewSection(
          previewText: previewText,
          isExampleOpen: isExampleOpen,
          onExampleTap: onExampleTap,
        ),
        const SizedBox(height: 24),
        const ContentTemplateNoticeBox(),
      ],
    );
  }
}

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
        ContentTemplateCategoryTag(category: item.category),
        const SizedBox(height: 8),
        ContentTemplateDetailTitle(
          title: item.title,
          description: item.description,
        ),
        const SizedBox(height: 10),
        ContentTemplateRecommendedChannels(channels: item.channels),
      ],
    );
  }
}

class ContentTemplateDetailTitle extends StatelessWidget {
  const ContentTemplateDetailTitle({
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

class ContentTemplateDetailDivider extends StatelessWidget {
  const ContentTemplateDetailDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, color: AppColors.neutral200);
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
        ContentTemplatePreviewCard(
          previewText: previewText,
          isExampleOpen: isExampleOpen,
          onExampleTap: onExampleTap,
        ),
        const SizedBox(height: 16),
        const ContentTemplateInfoHint(),
      ],
    );
  }
}

class ContentTemplatePreviewCard extends StatelessWidget {
  const ContentTemplatePreviewCard({
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
    final padding = isExampleOpen
        ? const EdgeInsets.all(16)
        : const EdgeInsets.fromLTRB(16, 20, 16, 8);

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
          ContentTemplatePreviewText(text: previewText),
          const ContentTemplateDetailDivider(),
          ContentTemplateExampleAccordion(
            isOpen: isExampleOpen,
            onTap: onExampleTap,
          ),
        ],
      ),
    );
  }
}

class ContentTemplatePreviewText extends StatelessWidget {
  const ContentTemplatePreviewText({
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

class ContentTemplateExampleAccordion extends StatelessWidget {
  const ContentTemplateExampleAccordion({
    required this.isOpen,
    required this.onTap,
    super.key,
  });

  final bool isOpen;
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
          const ContentTemplateExampleContent(),
        ],
      ],
    );
  }
}

class ContentTemplateExampleContent extends StatelessWidget {
  const ContentTemplateExampleContent({super.key});

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
        '카페 모먼트에 새 메뉴가 출시되었습니다!\n\n'
        '✨ 신메뉴: 피스타치오 크림 라떼\n'
        '💰 가격: 6,500원\n\n'
        '고소한 피스타치오 크림과 부드러운 라떼가 어우러진 시즌 한정 '
        '음료입니다. 달콤한 디저트와 함께 더욱 맛있게 즐겨보세요.\n\n'
        '신선한 재료로 정성껏 만들었습니다. 많은 사랑 부탁드립니다 🙏\n\n'
        '📍 서울 성동구 서울숲2길 14\n'
        '⏰ 영업시간: 매일 오전 10:00 ~ 오후 9:00\n'
        '📞 02-3456-7890',
        style: AppTextStyles.b4.copyWith(color: AppColors.neutral600),
      ),
    );
  }
}

class ContentTemplateInfoHint extends StatelessWidget {
  const ContentTemplateInfoHint({super.key});

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
              ContentTemplateDetailSaveAction(
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

class ContentTemplateDetailSaveAction extends StatelessWidget {
  const ContentTemplateDetailSaveAction({
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
                child: ContentTemplateSaveButton(
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
