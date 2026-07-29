import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/common/widgets/input/ssoss_text_field.dart';
import 'package:ssoss_flutter/common/widgets/selection/ssoss_filter_chip.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
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

class RecommendedHashtagSetItem {
  const RecommendedHashtagSetItem({
    required this.id,
    required this.title,
    required this.hashtags,
    this.isSaved = false,
  });

  final String id;
  final String title;
  final List<String> hashtags;
  final bool isSaved;

  RecommendedHashtagSetItem copyWith({bool? isSaved}) {
    return RecommendedHashtagSetItem(
      id: id,
      title: title,
      hashtags: hashtags,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}

class RecommendedContentTemplateControls extends StatelessWidget {
  const RecommendedContentTemplateControls({
    required this.searchController,
    required this.selectedTabIndex,
    required this.selectedCategory,
    required this.onSearchChanged,
    required this.onTabChanged,
    required this.onCategoryChanged,
    this.showIntro = false,
    this.showCategoryFilter = true,
    super.key,
  });

  final TextEditingController searchController;
  final int selectedTabIndex;
  final ContentTemplateCategory selectedCategory;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<int> onTabChanged;
  final ValueChanged<ContentTemplateCategory> onCategoryChanged;
  final bool showIntro;
  final bool showCategoryFilter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showIntro) ...[
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: RecommendedContentSourceIntro(),
          ),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RecommendedContentTemplateSearchField(
            controller: searchController,
            onChanged: onSearchChanged,
          ),
        ),
        const SizedBox(height: 8),
        ContentTemplateTabBar(
          selectedIndex: selectedTabIndex,
          onChanged: onTabChanged,
        ),
        if (showCategoryFilter) ...[
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ContentTemplateFilterBar(
              selectedCategory: selectedCategory,
              onChanged: onCategoryChanged,
            ),
          ),
        ],
      ],
    );
  }
}

class RecommendedContentSourceIntro extends StatelessWidget {
  const RecommendedContentSourceIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: AppText(
        '상황에 맞는 템플릿과\n해시태그를 골라 바로 활용해보세요',
        style: AppTextStyles.h4.copyWith(color: AppColors.black),
      ),
    );
  }
}

class RecommendedContentTemplateSearchField extends StatelessWidget {
  const RecommendedContentTemplateSearchField({
    required this.controller,
    required this.onChanged,
    super.key,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SsossTextField(
      controller: controller,
      height: 44,
      hintText: '템플릿명, 키워드로 검색',
      showSearchIcon: true,
      searchIconColor: AppColors.neutral700,
      hintColor: AppColors.neutral500,
      textColor: AppColors.neutral800,
      onChanged: onChanged,
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

class RecommendedContentTemplateList extends StatelessWidget {
  const RecommendedContentTemplateList({
    required this.items,
    required this.onSaveTap,
    required this.onItemTap,
    super.key,
  });

  final List<RecommendedContentTemplateItem> items;
  final ValueChanged<String> onSaveTap;
  final ValueChanged<RecommendedContentTemplateItem> onItemTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 34),
      children: [
        for (final item in items)
          ContentTemplateCard(
            item: item,
            onSaveTap: () => onSaveTap(item.id),
            onTap: () => onItemTap(item),
          ),
      ],
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
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 150),
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.neutral200),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContentTemplateCardHeader(
                category: item.category,
                isSaved: item.isSaved,
                onSaveTap: onSaveTap,
              ),
              const SizedBox(height: 8),
              ContentTemplateCardText(
                title: item.title,
                description: item.description,
              ),
              const SizedBox(height: 8),
              ContentTemplateRecommendedChannels(
                channels: item.channels,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContentTemplateCardHeader extends StatelessWidget {
  const ContentTemplateCardHeader({
    required this.category,
    required this.isSaved,
    required this.onSaveTap,
    super.key,
  });

  final ContentTemplateCategory category;
  final bool isSaved;
  final VoidCallback onSaveTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ContentTemplateCategoryTag(category: category),
        const Spacer(),
        ContentTemplateSaveButton(
          isSaved: isSaved,
          onTap: onSaveTap,
        ),
      ],
    );
  }
}

class ContentTemplateCardText extends StatelessWidget {
  const ContentTemplateCardText({
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

class ContentTemplateRecommendedChannels extends StatelessWidget {
  const ContentTemplateRecommendedChannels({
    required this.channels,
    super.key,
  });

  final List<String> channels;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                ContentTemplateChannelTag(label: channel),
            ],
          ),
        ),
      ],
    );
  }
}

class ContentTemplateCategoryTag extends StatelessWidget {
  const ContentTemplateCategoryTag({
    required this.category,
    super.key,
  });

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

class ContentTemplateChannelTag extends StatelessWidget {
  const ContentTemplateChannelTag({
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

class ContentTemplateSaveButton extends StatelessWidget {
  const ContentTemplateSaveButton({
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

class RecommendedHashtagSetList extends StatelessWidget {
  const RecommendedHashtagSetList({
    required this.items,
    required this.onSaveTap,
    super.key,
  });

  final List<RecommendedHashtagSetItem> items;
  final ValueChanged<String> onSaveTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 34),
      itemBuilder: (context, index) {
        final item = items[index];
        return RecommendedHashtagSetCard(
          item: item,
          onSaveTap: () => onSaveTap(item.id),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 18),
      itemCount: items.length,
    );
  }
}

class RecommendedHashtagSetCard extends StatelessWidget {
  const RecommendedHashtagSetCard({
    required this.item,
    required this.onSaveTap,
    super.key,
  });

  final RecommendedHashtagSetItem item;
  final VoidCallback onSaveTap;

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: item.hashtags.join(' ')));
    if (!context.mounted) {
      return;
    }
    showSsossToast(
      context,
      title: '클립보드에 복사되었습니다',
      margin: const EdgeInsets.only(bottom: 122),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.neutral200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RecommendedHashtagSetHeader(
                  item: item,
                  onSaveTap: onSaveTap,
                ),
                const SizedBox(height: 16),
                RecommendedHashtagWrap(hashtags: item.hashtags),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.neutral200),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RecommendedHashtagCopyButton(
                  onTap: () => unawaited(_copy(context)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RecommendedHashtagSetHeader extends StatelessWidget {
  const RecommendedHashtagSetHeader({
    required this.item,
    required this.onSaveTap,
    super.key,
  });

  final RecommendedHashtagSetItem item;
  final VoidCallback onSaveTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Flexible(
                child: AppText(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.h5.copyWith(color: AppColors.black),
                ),
              ),
              const SizedBox(width: 6),
              AppText(
                '${item.hashtags.length}개',
                style: AppTextStyles.b5.copyWith(color: AppColors.neutral400),
              ),
            ],
          ),
        ),
        ContentTemplateSaveButton(
          isSaved: item.isSaved,
          onTap: onSaveTap,
        ),
      ],
    );
  }
}

class RecommendedHashtagWrap extends StatelessWidget {
  const RecommendedHashtagWrap({
    required this.hashtags,
    super.key,
  });

  final List<String> hashtags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 8,
      children: [
        for (final hashtag in hashtags) RecommendedHashtagChip(label: hashtag),
      ],
    );
  }
}

class RecommendedHashtagChip extends StatelessWidget {
  const RecommendedHashtagChip({
    required this.label,
    super.key,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.neutral100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: AppText(
        label,
        style: AppTextStyles.b5.copyWith(color: AppColors.neutral500),
      ),
    );
  }
}

class RecommendedHashtagCopyButton extends StatelessWidget {
  const RecommendedHashtagCopyButton({
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
