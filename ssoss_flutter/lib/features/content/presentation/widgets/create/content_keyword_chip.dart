import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class ContentKeywordChip extends StatelessWidget {
  const ContentKeywordChip({
    required this.keyword,
    required this.onRemove,
    super.key,
  });

  final String keyword;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.neutral100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            '#$keyword',
            style: AppTextStyles.b5.copyWith(color: AppColors.neutral500),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            behavior: HitTestBehavior.opaque,
            child: const Icon(
              Icons.close,
              size: 12,
              color: AppColors.neutral500,
            ),
          ),
        ],
      ),
    );
  }
}
