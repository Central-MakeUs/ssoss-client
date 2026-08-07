import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/modal/ssoss_modal.dart';
import 'package:ssoss_flutter/common/widgets/selection/ssoss_filter_chip.dart';
import 'package:ssoss_flutter/common/widgets/tag/ssoss_tag.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/recommended_content_templates/recommended_content_templates_components.dart';

class ContentManagementItem {
  const ContentManagementItem({
    required this.contentId,
    required this.date,
    required this.channel,
    required this.category,
    required this.tone,
    required this.title,
    required this.tags,
    this.initialChannel,
  });

  final int contentId;
  final String date;

  /// 표시용 채널 라벨. 예: `블로그`, `블로그/인스타그램`, `모든 채널`
  final String channel;

  /// 상세 진입 시 초기 탭. null이면 첫 채널.
  final UploadChannel? initialChannel;
  final String category;
  final String tone;

  /// 카드 미리보기 제목(서버 말줄임 그대로).
  final String title;
  final List<String> tags;

  static const int maxDashboardTagCount = 2;

  String get menuId => contentId.toString();

  bool get showsHashtags => tags.isNotEmpty;

  List<String> get dashboardTags {
    if (!showsHashtags) {
      return const [];
    }
    return tags.take(maxDashboardTagCount).toList(growable: false);
  }
}

class SavedContentTemplateManagementItem {
  const SavedContentTemplateManagementItem({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.channels,
    required this.body,
    required this.date,
  });

  final String id;
  final ContentTemplateCategory category;
  final String title;
  final String description;
  final List<String> channels;
  final String body;
  final String date;
}

class ContentManagementTabBar extends StatelessWidget {
  const ContentManagementTabBar({
    super.key,
    this.selectedIndex = 0,
    this.onTabSelected,
  });

  final int selectedIndex;
  final ValueChanged<int>? onTabSelected;

  static const List<String> _tabs = ['생성 콘텐츠', '템플릿'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var index = 0; index < _tabs.length; index += 1)
          Expanded(
            child: GestureDetector(
              onTap: onTabSelected == null ? null : () => onTabSelected!(index),
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: index == selectedIndex
                          ? AppColors.neutral800
                          : AppColors.neutral200,
                      width: index == selectedIndex ? 2 : 1,
                    ),
                  ),
                ),
                child: AppText(
                  _tabs[index],
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h6.copyWith(
                    color: index == selectedIndex
                        ? AppColors.black
                        : AppColors.neutral500,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class ContentManagementFilterBar extends StatelessWidget {
  const ContentManagementFilterBar({
    required this.filters,
    required this.selectedFilter,
    required this.onFilterSelected,
    super.key,
  });

  final List<String> filters;
  final String selectedFilter;
  final ValueChanged<String> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: [
          for (final filter in filters) ...[
            SsossFilterChip(
              label: filter,
              state: filter == selectedFilter
                  ? SsossFilterChipState.selected
                  : SsossFilterChipState.normal,
              backgroundColor: filter == selectedFilter
                  ? AppColors.black
                  : AppColors.neutral100,
              foregroundColor:
                  filter == selectedFilter ? AppColors.white : AppColors.black,
              onTap: () => onFilterSelected(filter),
            ),
            if (filter != filters.last) const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

class ContentManagementSummaryRow extends StatelessWidget {
  const ContentManagementSummaryRow({
    required this.count,
    this.sortLabel = '최신순',
    this.onSortTap,
    super.key,
  });

  final int count;
  final String sortLabel;
  final VoidCallback? onSortTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          '$count건',
          style: AppTextStyles.h7.copyWith(color: AppColors.neutral400),
        ),
        GestureDetector(
          onTap: onSortTap,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AppAssets.icSort,
                  width: 18,
                  height: 18,
                  colorFilter: const ColorFilter.mode(
                    AppColors.neutral500,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 6),
                AppText(
                  sortLabel,
                  style: AppTextStyles.h6.copyWith(
                    color: AppColors.neutral500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ContentManagementCard extends StatelessWidget {
  const ContentManagementCard({
    required this.item,
    super.key,
    this.showDeleteMenu = false,
    this.onTap,
    this.onMoreTap,
    this.onTitleEditTap,
    this.onDeleteTap,
  });

  final ContentManagementItem item;
  final bool showDeleteMenu;
  final VoidCallback? onTap;
  final VoidCallback? onMoreTap;
  final VoidCallback? onTitleEditTap;
  final VoidCallback? onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Semantics(
          button: true,
          child: GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: AppColors.neutral200),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _ContentMetaText(item: item),
                      ),
                      GestureDetector(
                        onTap: onMoreTap,
                        behavior: HitTestBehavior.opaque,
                        child: const SizedBox.square(
                          dimension: 24,
                          child: Icon(
                            Icons.more_vert,
                            size: 20,
                            color: AppColors.neutral500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  AppText(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.h5.copyWith(color: AppColors.black),
                  ),
                  if (item.dashboardTags.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        for (final tag in item.dashboardTags)
                          SsossTag(
                            label: tag,
                            type: SsossTagType.gray,
                            showLeftIcon: false,
                            showRightIcon: false,
                          ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 12),
                  AppText(
                    '사용일자 ${item.date}',
                    style: AppTextStyles.b5.copyWith(
                      color: AppColors.neutral400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showDeleteMenu)
          Positioned(
            top: 40,
            right: 16,
            child: ContentDeleteMenu(
              onTitleEditTap: onTitleEditTap,
              onDeleteTap: onDeleteTap,
            ),
          ),
      ],
    );
  }
}

class SavedContentTemplateManagementCard extends StatelessWidget {
  const SavedContentTemplateManagementCard({
    required this.item,
    super.key,
    this.onTap,
    this.onMoreTap,
  });

  final SavedContentTemplateManagementItem item;
  final VoidCallback? onTap;
  final VoidCallback? onMoreTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: AppColors.neutral200),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  ContentTemplateCategoryTag(category: item.category),
                  const Spacer(),
                  GestureDetector(
                    onTap: onMoreTap,
                    behavior: HitTestBehavior.opaque,
                    child: const SizedBox.square(
                      dimension: 24,
                      child: Icon(
                        Icons.more_vert,
                        size: 20,
                        color: AppColors.neutral500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              AppText(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.h5.copyWith(color: AppColors.neutral800),
              ),
              const SizedBox(height: 2),
              AppText(
                item.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.b5.copyWith(color: AppColors.black),
              ),
              const SizedBox(height: 12),
              AppText(
                '사용일자 ${item.date}',
                style: AppTextStyles.b5.copyWith(
                  color: AppColors.neutral400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContentDeleteMenu extends StatelessWidget {
  const ContentDeleteMenu({
    required this.onDeleteTap,
    super.key,
    this.onTitleEditTap,
  });

  final VoidCallback? onTitleEditTap;
  final VoidCallback? onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.25),
            blurRadius: 6,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ContentMenuAction(
              iconAsset: AppAssets.icEdit2,
              label: '제목 수정하기',
              color: AppColors.black,
              onTap: onTitleEditTap,
            ),
            const SizedBox(height: 16),
            _ContentMenuAction(
              iconAsset: AppAssets.icDelete,
              label: '삭제하기',
              color: AppColors.error700,
              onTap: onDeleteTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _ContentMenuAction extends StatelessWidget {
  const _ContentMenuAction({
    required this.iconAsset,
    required this.label,
    required this.color,
    this.onTap,
  });

  final String iconAsset;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconAsset,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              color,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 8),
          AppText(
            label,
            style: AppTextStyles.h6.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

Future<String?> showContentTitleEditDialog(
  BuildContext context, {
  required String initialTitle,
}) {
  final controller = TextEditingController(text: initialTitle);

  return showDialog<String>(
    context: context,
    barrierColor: AppColors.black.withValues(alpha: 0.5),
    builder: (dialogContext) {
      var currentValue = initialTitle;

      void close() {
        Navigator.of(dialogContext).pop();
      }

      void submit() {
        final trimmed = currentValue.trim();
        if (trimmed.length < 2 || trimmed.length > 20) {
          return;
        }
        Navigator.of(dialogContext).pop(trimmed);
      }

      return StatefulBuilder(
        builder: (context, setState) {
          final canSubmit = currentValue.trim().length >= 2 &&
              currentValue.trim().length <= 20;

          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            child: SsossModal(
              title: '제목을 수정해보세요',
              message: '최소 2자, 최대 20자까지 입력할 수 있어요',
              width: double.infinity,
              showButtonIcons: false,
              onClose: close,
              content: TextField(
                controller: controller,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(20),
                ],
                decoration: InputDecoration(
                  hintText: 'ex) 여름 한정 복숭아 빙수 홍보',
                  hintStyle: AppTextStyles.b4.copyWith(
                    color: AppColors.neutral500,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.neutral200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.neutral500),
                  ),
                  counterText: '',
                ),
                maxLength: 20,
                style: AppTextStyles.b4.copyWith(
                  color: AppColors.neutral800,
                ),
                onChanged: (value) => setState(() => currentValue = value),
              ),
              actions: Row(
                children: [
                  Expanded(
                    child: SsossButton(
                      label: '취소',
                      size: SsossButtonSize.medium,
                      type: SsossButtonType.neutral,
                      width: double.infinity,
                      onPressed: close,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SsossButton(
                      label: '저장',
                      size: SsossButtonSize.medium,
                      type: SsossButtonType.primary,
                      width: double.infinity,
                      enabled: canSubmit,
                      onPressed: submit,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  ).whenComplete(controller.dispose);
}

Future<bool> showContentDeleteConfirmDialog(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    barrierColor: AppColors.black.withValues(alpha: 0.5),
    builder: (dialogContext) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        child: SsossModal(
          title: '저장한 콘텐츠를 삭제하시겠어요?',
          message: '삭제한 콘텐츠는 복구할 수 없어요',
          width: double.infinity,
          showButtonIcons: false,
          onClose: () => Navigator.of(dialogContext).pop(false),
          actions: Row(
            children: [
              Expanded(
                child: SsossButton(
                  label: '취소',
                  size: SsossButtonSize.medium,
                  type: SsossButtonType.neutral,
                  width: double.infinity,
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SsossButton(
                  label: '삭제',
                  size: SsossButtonSize.medium,
                  type: SsossButtonType.primary,
                  width: double.infinity,
                  onPressed: () => Navigator.of(dialogContext).pop(true),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  return result ?? false;
}

class _ContentMetaText extends StatelessWidget {
  const _ContentMetaText({required this.item});

  final ContentManagementItem item;

  @override
  Widget build(BuildContext context) {
    return AppText(
      '${item.channel} · ${item.category} · ${item.tone}',
      style: AppTextStyles.h6.copyWith(color: AppColors.neutral400),
    );
  }
}
