import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_contents_card.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_contents_card_block.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_recommendation_card.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class ContentResultSection extends StatelessWidget {
  const ContentResultSection({
    required this.title,
    required this.blocks,
    this.onEdit,
    super.key,
  });

  final String title;
  final List<SsossContentsCardBlock> blocks;
  final VoidCallback? onEdit;

  factory ContentResultSection.text({
    required String title,
    required String content,
    SsossRecommendationCardItem? recommendation,
    VoidCallback? onEdit,
    Key? key,
  }) {
    return ContentResultSection(
      key: key,
      title: title,
      onEdit: onEdit,
      blocks: [
        if (recommendation != null)
          SsossContentsCardRecommendationBlock(recommendation),
        SsossContentsCardTextBlock(content),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: AppText(
                title,
                style: AppTextStyles.h5.copyWith(color: AppColors.neutral700),
              ),
            ),
            SizedBox(
              width: 32,
              height: 32,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: onEdit,
                icon: SvgPicture.asset(
                  AppAssets.icEdit2,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.neutral500,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SsossContentsCard(
          blocks: blocks,
          width: double.infinity,
        ),
      ],
    );
  }
}
