import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/common/widgets/selection/ssoss_filter_chip.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/template/presentation/widgets/template_models.dart';

class TemplateFilterBar extends StatelessWidget {
  const TemplateFilterBar({
    required this.selectedCategory,
    required this.onChanged,
    super.key,
  });

  final TemplateCategory selectedCategory;
  final ValueChanged<TemplateCategory> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: [
          for (final category in TemplateCategory.values) ...[
            SsossFilterChip(
              label: category.label,
              height: 40,
              state: category == selectedCategory
                  ? SsossFilterChipState.selected
                  : SsossFilterChipState.normal,
              backgroundColor: category == selectedCategory
                  ? AppColors.black
                  : AppColors.neutral100,
              foregroundColor: category == selectedCategory
                  ? AppColors.white
                  : AppColors.black,
              onTap: () => onChanged(category),
            ),
            if (category != TemplateCategory.values.last)
              const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

class TemplateList extends StatelessWidget {
  const TemplateList({
    required this.items,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.onSaveTap,
    required this.onItemTap,
    super.key,
  });

  final List<TemplateItem> items;
  final TemplateCategory selectedCategory;
  final ValueChanged<TemplateCategory> onCategoryChanged;
  final ValueChanged<String> onSaveTap;
  final ValueChanged<TemplateItem> onItemTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TemplateFilterBar(
            selectedCategory: selectedCategory,
            onChanged: onCategoryChanged,
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 34),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = items[index];
              return TemplateCard(
                item: item,
                onSaveTap: () => onSaveTap(item.id),
                onTap: () => onItemTap(item),
              );
            },
          ),
        ),
      ],
    );
  }
}

class TemplateCard extends StatelessWidget {
  const TemplateCard({
    required this.item,
    required this.onSaveTap,
    super.key,
    this.onTap,
  });

  final TemplateItem item;
  final VoidCallback onSaveTap;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.neutral200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TemplateCardHeader(
              category: item.category,
              isSaved: item.isSaved,
              onSaveTap: onSaveTap,
            ),
            const SizedBox(height: 8),
            TemplateCardText(
              title: item.title,
              description: item.description,
            ),
            const SizedBox(height: 8),
            TemplateRecommendedChannels(
              channels: item.channels,
            ),
          ],
        ),
      ),
    );
  }
}

class TemplateCardHeader extends StatelessWidget {
  const TemplateCardHeader({
    required this.category,
    required this.isSaved,
    required this.onSaveTap,
    super.key,
  });

  final TemplateCategory category;
  final bool isSaved;
  final VoidCallback onSaveTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TemplateCategoryTag(category: category),
        const Spacer(),
        TemplateSaveButton(
          isSaved: isSaved,
          onTap: onSaveTap,
        ),
      ],
    );
  }
}

class TemplateCardText extends StatelessWidget {
  const TemplateCardText({
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
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.h5.copyWith(
            color: AppColors.neutral800,
          ),
        ),
        const SizedBox(height: 2),
        AppText(
          description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.b5.copyWith(
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}

class TemplateRecommendedChannels extends StatelessWidget {
  const TemplateRecommendedChannels({
    required this.channels,
    super.key,
  });

  final List<String> channels;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText(
          '추천 채널',
          style: AppTextStyles.b5.copyWith(
            color: AppColors.neutral500,
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Wrap(
            spacing: 4,
            runSpacing: 4,
            children: [
              for (final channel in channels)
                TemplateChannelTag(label: channel),
            ],
          ),
        ),
      ],
    );
  }
}

class TemplateCategoryTag extends StatelessWidget {
  const TemplateCategoryTag({
    required this.category,
    super.key,
  });

  final TemplateCategory category;

  @override
  Widget build(BuildContext context) {
    final style = _TemplateCategoryStyle.from(category);

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

class TemplateChannelTag extends StatelessWidget {
  const TemplateChannelTag({
    required this.label,
    super.key,
  });

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

class TemplateSaveButton extends StatelessWidget {
  const TemplateSaveButton({
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
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox.square(
          dimension: 24,
          child: SvgPicture.asset(
            isSaved ? AppAssets.icBookmarkSaved : AppAssets.icBookmark,
          ),
        ),
      ),
    );
  }
}

class _TemplateCategoryStyle {
  const _TemplateCategoryStyle({
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final Color backgroundColor;
  final Color foregroundColor;

  static _TemplateCategoryStyle from(TemplateCategory category) {
    switch (category) {
      case TemplateCategory.all:
        return const _TemplateCategoryStyle(
          backgroundColor: AppColors.neutral100,
          foregroundColor: AppColors.neutral500,
        );
      case TemplateCategory.newMenu:
        return const _TemplateCategoryStyle(
          backgroundColor: AppColors.success50,
          foregroundColor: AppColors.success700,
        );
      case TemplateCategory.event:
        return const _TemplateCategoryStyle(
          backgroundColor: AppColors.primary50,
          foregroundColor: AppColors.primary600,
        );
      case TemplateCategory.storeIntro:
        return const _TemplateCategoryStyle(
          backgroundColor: AppColors.neutral100,
          foregroundColor: AppColors.neutral500,
        );
      case TemplateCategory.notice:
        return const _TemplateCategoryStyle(
          backgroundColor: AppColors.info50,
          foregroundColor: AppColors.info700,
        );
    }
  }
}
