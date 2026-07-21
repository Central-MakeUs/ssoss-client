import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_recent_item.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/home/content_recent_list_item.dart';

class ContentRecentSection extends StatelessWidget {
  const ContentRecentSection({
    super.key,
    this.recentContents = const [],
    this.onCreateTap,
    this.onContentTap,
    this.onViewAllTap,
  });

  final List<ContentRecentItem> recentContents;
  final VoidCallback? onCreateTap;
  final ValueChanged<ContentRecentItem>? onContentTap;
  final VoidCallback? onViewAllTap;

  static const _maxVisibleCount = 3;

  List<ContentRecentItem> get _visibleContents {
    final sorted = List<ContentRecentItem>.from(recentContents)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sorted.take(_maxVisibleCount).toList();
  }

  @override
  Widget build(BuildContext context) {
    final visibleContents = _visibleContents;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: AppText(
                '최근 생성된 콘텐츠',
                style: AppTextStyles.h5.copyWith(color: AppColors.neutral700),
              ),
            ),
            if (visibleContents.isNotEmpty)
              GestureDetector(
                onTap: onViewAllTap,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
        if (visibleContents.isEmpty)
          _EmptyRecentContents(onCreateTap: onCreateTap)
        else
          Column(
            children: [
              for (var i = 0; i < visibleContents.length; i++) ...[
                if (i > 0) const SizedBox(height: 12),
                ContentRecentListItem(
                  item: visibleContents[i],
                  onTap: onContentTap == null
                      ? null
                      : () => onContentTap!(visibleContents[i]),
                ),
              ],
            ],
          ),
      ],
    );
  }
}

class _EmptyRecentContents extends StatelessWidget {
  const _EmptyRecentContents({this.onCreateTap});

  final VoidCallback? onCreateTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        color: AppColors.neutral100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            '아직 생성된 콘텐츠가 없어요',
            style: AppTextStyles.h6.copyWith(
              color: AppColors.neutral500,
            ),
          ),
          const SizedBox(height: 12),
          SsossButton(
            label: '콘텐츠 생성하러 가기',
            size: SsossButtonSize.small,
            type: SsossButtonType.outline,
            onPressed: onCreateTap,
          ),
        ],
      ),
    );
  }
}
