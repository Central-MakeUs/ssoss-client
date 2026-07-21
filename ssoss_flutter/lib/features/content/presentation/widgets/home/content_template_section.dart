import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class ContentTemplateItem {
  const ContentTemplateItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageAsset,
  });

  final String id;
  final String title;
  final String description;
  final String imageAsset;
}

class ContentTemplateSection extends StatelessWidget {
  const ContentTemplateSection({
    super.key,
    this.templates = _defaultTemplates,
    this.onViewAllTap,
    this.onTemplateTap,
  });

  final List<ContentTemplateItem> templates;
  final VoidCallback? onViewAllTap;
  final ValueChanged<ContentTemplateItem>? onTemplateTap;

  static const _defaultTemplates = [
    ContentTemplateItem(
      id: 'new-menu',
      title: '신메뉴 소개',
      description: '우리 가게 신메뉴 홍보하기',
      imageAsset: AppAssets.imgDrink,
    ),
    ContentTemplateItem(
      id: 'event-discount',
      title: '이벤트/할인 안내',
      description: '이벤트로 재방문율 사로잡기',
      imageAsset: AppAssets.imgCoupon,
    ),
    ContentTemplateItem(
      id: 'introduction',
      title: '매장 소개',
      description: '신규 고객을 위한 소개하기',
      imageAsset: AppAssets.imgNotice,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    '추천 콘텐츠 소스',
                    style:
                        AppTextStyles.h5.copyWith(color: AppColors.neutral700),
                  ),
                  const SizedBox(height: 2),
                  AppText(
                    '상황별 템플릿과 해시태그를 골라 활용해보세요',
                    style:
                        AppTextStyles.b5.copyWith(color: AppColors.neutral500),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onViewAllTap,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      '전체 보기',
                      style: AppTextStyles.h8.copyWith(
                        color: AppColors.neutral500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: AppColors.neutral500,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 72,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: templates.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final template = templates[index];
              return _ContentTemplateCard(
                item: template,
                onTap: onTemplateTap == null
                    ? null
                    : () => onTemplateTap!(template),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ContentTemplateCard extends StatelessWidget {
  const _ContentTemplateCard({
    required this.item,
    this.onTap,
  });

  final ContentTemplateItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.only(
      topLeft: Radius.circular(12),
      topRight: Radius.circular(8),
      bottomLeft: Radius.circular(8),
      bottomRight: Radius.circular(8),
    );

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 230,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: borderRadius,
          border: Border.all(color: AppColors.neutral200),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primary50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                item.imageAsset,
                width: 32,
                height: 32,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    item.title,
                    style: AppTextStyles.h6.copyWith(
                      color: AppColors.neutral600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  AppText(
                    item.description,
                    style: AppTextStyles.b5.copyWith(
                      color: AppColors.neutral500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
