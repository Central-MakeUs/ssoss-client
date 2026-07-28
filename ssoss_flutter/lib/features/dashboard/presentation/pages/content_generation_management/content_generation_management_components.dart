import 'package:flutter/material.dart';
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
    this.includesInstagram = false,
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

  /// 생성 채널에 인스타그램이 포함됐는지.
  final bool includesInstagram;

  String get menuId => contentId.toString();

  bool get showsHashtags => includesInstagram && tags.isNotEmpty;
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
    super.key,
  });

  final int count;
  final String sortLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          '$count건',
          style: AppTextStyles.h7.copyWith(color: AppColors.neutral400),
        ),
        Padding(
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
    this.onDeleteTap,
    this.onReuseTap,
  });

  final ContentManagementItem item;
  final bool showDeleteMenu;
  final VoidCallback? onTap;
  final VoidCallback? onMoreTap;
  final VoidCallback? onDeleteTap;
  final VoidCallback? onReuseTap;

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
                        child: AppText(
                          item.date,
                          style: AppTextStyles.h8.copyWith(
                            color: AppColors.neutral300,
                          ),
                        ),
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
                  const SizedBox(height: 14),
                  _ContentMetaText(item: item),
                  const SizedBox(height: 2),
                  AppText(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.h5.copyWith(color: AppColors.black),
                  ),
                  if (item.showsHashtags) ...[
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        for (final tag in item.tags.take(2))
                          SsossTag(
                            label: tag,
                            type: SsossTagType.gray,
                            showLeftIcon: false,
                            showRightIcon: false,
                          ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 24),
                  SsossButton(
                    label: '이 스타일로 새로 만들기',
                    size: SsossButtonSize.small,
                    type: SsossButtonType.outline,
                    width: double.infinity,
                    onPressed: onReuseTap,
                    showRightIcon: true,
                    icon: SvgPicture.asset(
                      AppAssets.icChange,
                      width: 14,
                      height: 14,
                      colorFilter: const ColorFilter.mode(
                        AppColors.black,
                        BlendMode.srcIn,
                      ),
                    ),
                    textStyle: AppTextStyles.h8,
                    foregroundColor: AppColors.black,
                    borderColor: AppColors.neutral200,
                    backgroundColor: AppColors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showDeleteMenu)
          Positioned(
            top: 50,
            right: 12,
            child: ContentDeleteMenu(onDeleteTap: onDeleteTap),
          ),
      ],
    );
  }
}

class ContentDeleteMenu extends StatelessWidget {
  const ContentDeleteMenu({
    required this.onDeleteTap,
    super.key,
  });

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
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onDeleteTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AppAssets.icDelete,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.error700,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
              AppText(
                '삭제하기',
                style: AppTextStyles.h6.copyWith(
                  color: AppColors.error700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
                  backgroundColor: AppColors.neutral100,
                  foregroundColor: AppColors.black,
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
                  backgroundColor: AppColors.primary400,
                  foregroundColor: AppColors.white,
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
