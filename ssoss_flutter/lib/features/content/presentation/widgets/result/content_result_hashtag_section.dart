import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_contents_card.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_contents_card_block.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class ContentResultHashtagSection extends StatelessWidget {
  const ContentResultHashtagSection({
    required this.hashtags,
    super.key,
  });

  final List<String> hashtags;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: AppText(
                '해시태그',
                style: AppTextStyles.h5.copyWith(color: AppColors.neutral700),
              ),
            ),
            SizedBox(
              width: 32,
              height: 32,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
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
          blocks: [SsossContentsCardHashtagsBlock(hashtags)],
          width: double.infinity,
        ),
      ],
    );
  }
}
