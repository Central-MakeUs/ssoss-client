import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_text_button.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';

/// 다른 채널용 생성 — 남은 채널 멀티선택 목록.
class ContentOtherChannelSelectList extends StatelessWidget {
  const ContentOtherChannelSelectList({
    required this.available,
    required this.selected,
    required this.onToggle,
    super.key,
  });

  final List<UploadChannel> available;
  final List<UploadChannel> selected;
  final ValueChanged<UploadChannel> onToggle;

  static const _options =
      <({UploadChannel channel, String label, String icon})>[
    (
      channel: UploadChannel.blog,
      label: '블로그 글',
      icon: AppAssets.brandNaverBlog,
    ),
    (
      channel: UploadChannel.instagram,
      label: '인스타그램 캡션',
      icon: AppAssets.brandInstagram,
    ),
    (
      channel: UploadChannel.carrot,
      label: '당근 비즈 문구',
      icon: AppAssets.brandDaangn,
    ),
    (
      channel: UploadChannel.thread,
      label: '스레드 포스팅',
      icon: AppAssets.brandThread,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final options =
        _options.where((o) => available.contains(o.channel)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppText(
              '업로드할 SNS 채널 선택',
              style: AppTextStyles.h5.copyWith(color: AppColors.neutral700),
            ),
            const SizedBox(width: 8),
            AppText(
              '중복 선택 가능',
              style: AppTextStyles.b6.copyWith(color: AppColors.neutral400),
            ),
          ],
        ),
        const SizedBox(height: 12),
        for (var i = 0; i < options.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          SsossTextButton(
            title: options[i].label,
            width: double.infinity,
            height: 56,
            type: selected.contains(options[i].channel)
                ? SsossTextButtonType.selected
                : SsossTextButtonType.normal,
            icon: SizedBox(
              width: 24,
              height: 24,
              child: options[i].icon.endsWith('.svg')
                  ? SvgPicture.asset(options[i].icon, width: 24, height: 24)
                  : Image.asset(options[i].icon, width: 24, height: 24),
            ),
            onTap: () => onToggle(options[i].channel),
          ),
        ],
      ],
    );
  }
}
