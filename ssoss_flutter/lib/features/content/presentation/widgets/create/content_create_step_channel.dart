import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_text_button.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';

class ContentCreateStepChannel extends StatelessWidget {
  const ContentCreateStepChannel({
    required this.selected,
    required this.onToggle,
    super.key,
  });

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppText(
              '업로드 채널',
              style: AppTextStyles.h5.copyWith(color: AppColors.neutral700),
            ),
            const SizedBox(width: 2),
            AppText(
              '*',
              style: AppTextStyles.h5.copyWith(color: AppColors.primary600),
            ),
          ],
        ),
        const SizedBox(height: 2),
        AppText(
          '한 번에 여러 채널을 생성할 수도 있어요',
          style: AppTextStyles.b5.copyWith(color: AppColors.neutral400),
        ),
        const SizedBox(height: 12),
        for (var i = 0; i < _options.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          SsossTextButton(
            title: _options[i].label,
            width: double.infinity,
            height: 56,
            type: selected.contains(_options[i].channel)
                ? SsossTextButtonType.selected
                : SsossTextButtonType.normal,
            icon: SizedBox(
              width: 24,
              height: 24,
              child: _options[i].icon.endsWith('.svg')
                  ? SvgPicture.asset(_options[i].icon, width: 24, height: 24)
                  : Image.asset(_options[i].icon, width: 24, height: 24),
            ),
            onTap: () => onToggle(_options[i].channel),
          ),
        ],
      ],
    );
  }
}
