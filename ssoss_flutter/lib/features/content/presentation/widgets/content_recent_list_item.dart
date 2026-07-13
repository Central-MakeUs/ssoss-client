import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_recent_item.dart';

class ContentRecentListItem extends StatelessWidget {
  const ContentRecentListItem({
    required this.item,
    super.key,
    this.onTap,
  });

  final ContentRecentItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.neutral50,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      item.title,
                      style: AppTextStyles.h5.copyWith(
                        color: AppColors.neutral800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        AppText(
                          item.formattedDate,
                          style: AppTextStyles.b6.copyWith(
                            color: AppColors.neutral400,
                          ),
                        ),
                        const SizedBox(width: 4),
                        AppText(
                          '|',
                          style: AppTextStyles.h8.copyWith(
                            color: AppColors.neutral200,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: AppText(
                            item.channelsLabel,
                            style: AppTextStyles.b6.copyWith(
                              color: AppColors.neutral400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.chevron_right,
                size: 24,
                color: AppColors.neutral300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
