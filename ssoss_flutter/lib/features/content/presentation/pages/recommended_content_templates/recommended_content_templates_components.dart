import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/selection/ssoss_filter_chip.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

enum ContentTemplateCategory {
  all('전체'),
  newMenu('신메뉴'),
  event('이벤트'),
  storeIntro('매장 소개'),
  notice('공지');

  const ContentTemplateCategory(this.label);

  final String label;
}

class RecommendedContentTemplateItem {
  const RecommendedContentTemplateItem({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.channels,
    this.isSaved = false,
  });

  final String id;
  final ContentTemplateCategory category;
  final String title;
  final String description;
  final List<String> channels;
  final bool isSaved;

  RecommendedContentTemplateItem copyWith({bool? isSaved}) {
    return RecommendedContentTemplateItem(
      id: id,
      category: category,
      title: title,
      description: description,
      channels: channels,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}

class ContentTemplateTabBar extends StatelessWidget {
  const ContentTemplateTabBar({
    required this.selectedIndex,
    required this.onChanged,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  static const List<String> _tabs = ['템플릿', '해시태그'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var index = 0; index < _tabs.length; index++)
          Expanded(
            child: _ContentTemplateTab(
              label: _tabs[index],
              isSelected: selectedIndex == index,
              onTap: () => onChanged(index),
            ),
          ),
      ],
    );
  }
}

class _ContentTemplateTab extends StatelessWidget {
  const _ContentTemplateTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppColors.neutral800 : AppColors.neutral200,
                width: isSelected ? 2 : 1,
              ),
            ),
          ),
          child: AppText(
            label,
            style: AppTextStyles.h6.copyWith(
              color: isSelected ? AppColors.black : AppColors.neutral500,
            ),
          ),
        ),
      ),
    );
  }
}

class ContentTemplateFilterBar extends StatelessWidget {
  const ContentTemplateFilterBar({
    required this.selectedCategory,
    required this.onChanged,
    super.key,
  });

  final ContentTemplateCategory selectedCategory;
  final ValueChanged<ContentTemplateCategory> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: [
          for (final category in ContentTemplateCategory.values) ...[
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
            if (category != ContentTemplateCategory.values.last)
              const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

class ContentTemplateCard extends StatelessWidget {
  const ContentTemplateCard({
    required this.item,
    required this.onSaveTap,
    super.key,
    this.onTap,
  });

  final RecommendedContentTemplateItem item;
  final VoidCallback onSaveTap;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.neutral200),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _ContentTemplateCategoryTag(category: item.category),
                  const Spacer(),
                  _ContentTemplateSaveButton(
                    isSaved: item.isSaved,
                    onTap: onSaveTap,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              AppText(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.h5.copyWith(
                  color: AppColors.neutral800,
                ),
              ),
              const SizedBox(height: 2),
              AppText(
                item.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.b5.copyWith(
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: AppText(
                      '추천 채널',
                      style: AppTextStyles.b5.copyWith(
                        color: AppColors.neutral500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: [
                        for (final channel in item.channels)
                          _ContentTemplateChannelTag(label: channel),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContentTemplateCategoryTag extends StatelessWidget {
  const _ContentTemplateCategoryTag({required this.category});

  final ContentTemplateCategory category;

  @override
  Widget build(BuildContext context) {
    final style = _ContentTemplateCategoryStyle.from(category);

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

class _ContentTemplateChannelTag extends StatelessWidget {
  const _ContentTemplateChannelTag({required this.label});

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

class _ContentTemplateSaveButton extends StatelessWidget {
  const _ContentTemplateSaveButton({
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
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox.square(
          dimension: 24,
          child: Icon(
            isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
            size: 24,
            color: AppColors.neutral700,
          ),
        ),
      ),
    );
  }
}

class _ContentTemplateCategoryStyle {
  const _ContentTemplateCategoryStyle({
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final Color backgroundColor;
  final Color foregroundColor;

  static _ContentTemplateCategoryStyle from(ContentTemplateCategory category) {
    switch (category) {
      case ContentTemplateCategory.all:
        return const _ContentTemplateCategoryStyle(
          backgroundColor: AppColors.neutral100,
          foregroundColor: AppColors.neutral500,
        );
      case ContentTemplateCategory.newMenu:
        return const _ContentTemplateCategoryStyle(
          backgroundColor: AppColors.success50,
          foregroundColor: AppColors.success700,
        );
      case ContentTemplateCategory.event:
        return const _ContentTemplateCategoryStyle(
          backgroundColor: AppColors.primary50,
          foregroundColor: AppColors.primary600,
        );
      case ContentTemplateCategory.storeIntro:
        return const _ContentTemplateCategoryStyle(
          backgroundColor: AppColors.neutral100,
          foregroundColor: AppColors.neutral500,
        );
      case ContentTemplateCategory.notice:
        return const _ContentTemplateCategoryStyle(
          backgroundColor: AppColors.info50,
          foregroundColor: AppColors.info700,
        );
    }
  }
}
