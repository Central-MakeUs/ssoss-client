import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';

class ContentChannelShortcuts extends StatelessWidget {
  const ContentChannelShortcuts({
    super.key,
    this.onChannelTap,
  });

  final ValueChanged<UploadChannel>? onChannelTap;

  static const _channels =
      <({UploadChannel channel, String title, String subtitle, String icon})>[
    (
      channel: UploadChannel.blog,
      title: '블로그',
      subtitle: '글',
      icon: AppAssets.brandNaverBlog,
    ),
    (
      channel: UploadChannel.instagram,
      title: '인스타그램',
      subtitle: '캡션',
      icon: AppAssets.brandInstagram,
    ),
    (
      channel: UploadChannel.carrot,
      title: '당근',
      subtitle: '비즈 문구',
      icon: AppAssets.brandDaangn,
    ),
    (
      channel: UploadChannel.thread,
      title: '스레드',
      subtitle: '포스팅',
      icon: AppAssets.brandThread,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          '채널별 콘텐츠 생성 바로가기',
          style: AppTextStyles.h5.copyWith(color: AppColors.neutral700),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _ChannelShortcutCard(
                title: _channels[0].title,
                subtitle: _channels[0].subtitle,
                iconAsset: _channels[0].icon,
                onTap: onChannelTap == null
                    ? null
                    : () => onChannelTap!(_channels[0].channel),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _ChannelShortcutCard(
                title: _channels[1].title,
                subtitle: _channels[1].subtitle,
                iconAsset: _channels[1].icon,
                onTap: onChannelTap == null
                    ? null
                    : () => onChannelTap!(_channels[1].channel),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _ChannelShortcutCard(
                title: _channels[2].title,
                subtitle: _channels[2].subtitle,
                iconAsset: _channels[2].icon,
                onTap: onChannelTap == null
                    ? null
                    : () => onChannelTap!(_channels[2].channel),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _ChannelShortcutCard(
                title: _channels[3].title,
                subtitle: _channels[3].subtitle,
                iconAsset: _channels[3].icon,
                onTap: onChannelTap == null
                    ? null
                    : () => onChannelTap!(_channels[3].channel),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ChannelShortcutCard extends StatelessWidget {
  const _ChannelShortcutCard({
    required this.title,
    required this.subtitle,
    required this.iconAsset,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final String iconAsset;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.neutral100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: iconAsset.endsWith('.svg')
                    ? SvgPicture.asset(
                        iconAsset,
                        width: 20,
                        height: 20,
                      )
                    : Image.asset(iconAsset, width: 20, height: 20),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Wrap(
                  spacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    AppText(
                      title,
                      style: AppTextStyles.h8.copyWith(
                        color: AppColors.neutral800,
                      ),
                    ),
                    AppText(
                      subtitle,
                      style: AppTextStyles.b5.copyWith(
                        color: AppColors.neutral400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
