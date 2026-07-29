import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class ContentDetailInfoPanel extends StatelessWidget {
  const ContentDetailInfoPanel({
    required this.purpose,
    required this.tone,
    required this.channelsLabel,
    required this.keywords,
    super.key,
  });

  final String purpose;
  final String tone;
  final String channelsLabel;
  final List<String> keywords;

  @override
  Widget build(BuildContext context) {
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
          _DetailMetaText(
            channelsLabel: channelsLabel,
            purpose: purpose,
            tone: tone,
          ),
          if (keywords.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                AppText(
                  '활용 키워드',
                  style: AppTextStyles.h6.copyWith(color: AppColors.neutral500),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AppText(
                    keywords.join(', '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.b4.copyWith(
                      color: AppColors.neutral500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class ContentDetailSection extends StatelessWidget {
  const ContentDetailSection({
    required this.title,
    required this.child,
    super.key,
    this.onEditTap,
  });

  final String title;
  final Widget child;
  final VoidCallback? onEditTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: AppText(
                title,
                style: AppTextStyles.h5.copyWith(color: AppColors.black),
              ),
            ),
            SizedBox(
              width: 32,
              height: 32,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: onEditTap,
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
        child,
      ],
    );
  }
}

class ContentDetailActionButtons extends StatelessWidget {
  const ContentDetailActionButtons({
    super.key,
    this.onCreateOtherChannel,
    this.onReuse,
  });

  final VoidCallback? onCreateOtherChannel;
  final VoidCallback? onReuse;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (onCreateOtherChannel != null) ...[
          SsossButton(
            label: '다른 채널용으로 만들기',
            size: SsossButtonSize.large,
            type: SsossButtonType.outline,
            width: double.infinity,
            backgroundColor: AppColors.primary50,
            foregroundColor: AppColors.primary500,
            borderColor: AppColors.primary300,
            textStyle: AppTextStyles.h5,
            onPressed: onCreateOtherChannel,
          ),
          // 배포 최소 기능: 이 스타일로 새로 만들기 임시 비활성
          // const SizedBox(height: 12),
        ],
        // 배포 최소 기능: 이 스타일로 새로 만들기 임시 비활성
        // SsossButton(
        //   label: '이 스타일로 새로 만들기',
        //   size: SsossButtonSize.large,
        //   type: SsossButtonType.outline,
        //   width: double.infinity,
        //   backgroundColor: AppColors.white,
        //   foregroundColor: AppColors.black,
        //   borderColor: AppColors.neutral200,
        //   textStyle: AppTextStyles.h5,
        //   onPressed: onReuse,
        // ),
      ],
    );
  }
}

class _DetailMetaText extends StatelessWidget {
  const _DetailMetaText({
    required this.channelsLabel,
    required this.purpose,
    required this.tone,
  });

  final String channelsLabel;
  final String purpose;
  final String tone;

  @override
  Widget build(BuildContext context) {
    return AppText(
      '$channelsLabel · $purpose · $tone',
      style: AppTextStyles.h5.copyWith(color: AppColors.black),
    );
  }
}
