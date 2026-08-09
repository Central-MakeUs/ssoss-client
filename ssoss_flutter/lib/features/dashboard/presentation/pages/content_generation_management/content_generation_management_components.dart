import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_text_field.dart';
import 'package:ssoss_flutter/common/widgets/modal/ssoss_modal.dart';
import 'package:ssoss_flutter/common/widgets/selection/ssoss_filter_chip.dart';
import 'package:ssoss_flutter/common/widgets/tag/ssoss_tag.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/template/presentation/widgets/template_list.dart';
import 'package:ssoss_flutter/features/template/presentation/widgets/template_models.dart';

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
    required this.savedTemplateId,
    required this.category,
    required this.title,
    required this.description,
    required this.date,
  });

  final int savedTemplateId;
  final TemplateCategory category;
  final String title;
  final String description;
  final String date;

  String get menuId => savedTemplateId.toString();

  SavedContentTemplateManagementItem copyWith({String? title}) {
    return SavedContentTemplateManagementItem(
      savedTemplateId: savedTemplateId,
      category: category,
      title: title ?? this.title,
      description: description,
      date: date,
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
    this.showDeleteMenu = false,
    this.onTap,
    this.onMoreTap,
    this.onTitleEditTap,
    this.onDeleteTap,
  });

  final SavedContentTemplateManagementItem item;
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
                      TemplateCategoryTag(category: item.category),
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
                    style:
                        AppTextStyles.h5.copyWith(color: AppColors.neutral800),
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
              label: '이름 수정하기',
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
  Future<void> Function(String title)? onSave,
}) {
  return showDialog<String>(
    context: context,
    barrierColor: AppColors.black.withValues(alpha: 0.5),
    barrierDismissible: onSave == null,
    builder: (_) => _ContentTitleEditDialog(
      initialTitle: initialTitle,
      onSave: onSave,
    ),
  );
}

class _ContentTitleEditDialog extends StatefulWidget {
  const _ContentTitleEditDialog({
    required this.initialTitle,
    this.onSave,
  });

  final String initialTitle;
  final Future<void> Function(String title)? onSave;

  @override
  State<_ContentTitleEditDialog> createState() =>
      _ContentTitleEditDialogState();
}

class _ContentTitleEditDialogState extends State<_ContentTitleEditDialog> {
  static const int _minTitleLength = 2;
  static const int _maxTitleLength = 20;

  late final TextEditingController _controller;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialTitle);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _canSubmit => SsossTextField.isWithinLength(
        _controller.text,
        minLength: _minTitleLength,
        maxLength: _maxTitleLength,
      );

  void _close() {
    if (_isSaving) {
      return;
    }
    Navigator.of(context).pop();
  }

  Future<void> _submit() async {
    final trimmed = _controller.text.trim();
    if (_isSaving ||
        !SsossTextField.isWithinLength(
          trimmed,
          minLength: _minTitleLength,
          maxLength: _maxTitleLength,
        )) {
      return;
    }

    final onSave = widget.onSave;
    if (onSave == null) {
      Navigator.of(context).pop(trimmed);
      return;
    }

    setState(() => _isSaving = true);
    try {
      await onSave(trimmed);
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop(trimmed);
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: SsossModal(
        title: '콘텐츠 이름을 수정해보세요',
        message: '최소 2자, 최대 20자까지 입력할 수 있어요',
        width: double.infinity,
        showButtonIcons: false,
        isActionsDisabled: _isSaving,
        onClose: _isSaving ? null : _close,
        content: SsossTextField(
          controller: _controller,
          hintText: 'ex) 여름 한정 복숭아 빙수 홍보',
          hintColor: AppColors.neutral500,
          textColor: AppColors.neutral800,
          width: double.infinity,
          maxLength: _maxTitleLength,
          enabled: !_isSaving,
          onChanged: (_) => setState(() {}),
        ),
        actions: Row(
          children: [
            Expanded(
              child: SsossButton(
                label: '취소',
                size: SsossButtonSize.medium,
                type: SsossButtonType.neutral,
                width: double.infinity,
                enabled: !_isSaving,
                onPressed: _isSaving ? null : _close,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SsossButton(
                label: '저장',
                size: SsossButtonSize.medium,
                type: SsossButtonType.primary,
                width: double.infinity,
                enabled: _canSubmit && !_isSaving,
                isLoading: _isSaving,
                onPressed: _canSubmit && !_isSaving
                    ? () => unawaited(_submit())
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> showSavedTemplateDeleteConfirmDialog(
  BuildContext context, {
  required Future<void> Function() onDelete,
}) async {
  final result = await showSsossModal(
    context,
    title: '저장한 콘텐츠를 삭제하시겠어요?',
    message: '삭제한 콘텐츠는 복구할 수 없어요',
    primaryButtonLabel: '삭제',
    secondaryButtonLabel: '취소',
    showButtonIcons: false,
    onPrimaryPressedAsync: onDelete,
  );
  return result == SsossModalResult.primary;
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
