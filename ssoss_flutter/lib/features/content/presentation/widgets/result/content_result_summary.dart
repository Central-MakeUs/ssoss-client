import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_label_mapper.dart';

class ContentResultSummary extends StatelessWidget {
  const ContentResultSummary({
    required this.input,
    super.key,
  });

  final ContentCreateInput input;

  @override
  Widget build(BuildContext context) {
    final meta = [
      ContentLabelMapper.channelsJoined(input.channels),
      ContentLabelMapper.purpose(input.purpose),
      ContentLabelMapper.tone(input.tone),
    ].join(' · ');

    final keywords = input.keywords.isEmpty
        ? '디저트, 크루아상, 을지로베이커리'
        : input.keywords.join(', ');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.neutral50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            meta,
            style: AppTextStyles.h5.copyWith(color: AppColors.neutral700),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                '활용 키워드',
                style: AppTextStyles.h6.copyWith(color: AppColors.neutral500),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppText(
                  keywords,
                  style: AppTextStyles.b4.copyWith(color: AppColors.neutral500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
