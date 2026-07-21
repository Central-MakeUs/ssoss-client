import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/tag/ssoss_tag.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_generation_management/content_generation_management_components.dart';

class ContentDetailData {
  const ContentDetailData({
    required this.item,
    required this.title,
    required this.keywords,
    required this.body,
    required this.hashtags,
  });

  final ContentManagementItem item;
  final String title;
  final List<String> keywords;
  final String body;
  final List<String> hashtags;
}

class ContentDetailInfoPanel extends StatelessWidget {
  const ContentDetailInfoPanel({
    required this.item,
    required this.keywords,
    super.key,
  });

  final ContentManagementItem item;
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
          _DetailMetaText(item: item),
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
            GestureDetector(
              onTap: onEditTap,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.all(7),
                child: SvgPicture.asset(
                  AppAssets.icEdit2,
                  width: 18,
                  height: 18,
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

class ContentDetailTextCard extends StatelessWidget {
  const ContentDetailTextCard({
    required this.text,
    super.key,
    this.onCopyTap,
  });

  final String text;
  final VoidCallback? onCopyTap;

  @override
  Widget build(BuildContext context) {
    return _CopyableContentCard(
      onCopyTap: onCopyTap ?? () => _copyText(text),
      child: AppText(
        text,
        style: AppTextStyles.b4.copyWith(color: AppColors.black),
      ),
    );
  }
}

class ContentDetailHashtagCard extends StatelessWidget {
  const ContentDetailHashtagCard({
    required this.hashtags,
    super.key,
    this.onCopyTap,
  });

  final List<String> hashtags;
  final VoidCallback? onCopyTap;

  @override
  Widget build(BuildContext context) {
    return _CopyableContentCard(
      onCopyTap: onCopyTap ?? () => _copyText(hashtags.join(' ')),
      contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
      child: Wrap(
        spacing: 6,
        runSpacing: 8,
        children: [
          for (final hashtag in hashtags)
            SsossTag(
              label: hashtag,
              type: SsossTagType.gray,
              showLeftIcon: false,
              showRightIcon: false,
            ),
        ],
      ),
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
        const SizedBox(height: 12),
        SsossButton(
          label: '콘텐츠 재활용하기',
          size: SsossButtonSize.large,
          type: SsossButtonType.outline,
          width: double.infinity,
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.black,
          borderColor: AppColors.neutral200,
          textStyle: AppTextStyles.h5,
          onPressed: onReuse,
        ),
      ],
    );
  }
}

class _CopyableContentCard extends StatelessWidget {
  const _CopyableContentCard({
    required this.child,
    required this.onCopyTap,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 20,
    ),
  });

  final Widget child;
  final VoidCallback onCopyTap;
  final EdgeInsetsGeometry contentPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: contentPadding,
          decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(
              top: BorderSide(color: AppColors.neutral200),
              left: BorderSide(color: AppColors.neutral200),
              right: BorderSide(color: AppColors.neutral200),
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: child,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: AppColors.neutral200),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(12),
            ),
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: onCopyTap,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 7,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      AppAssets.icCopy,
                      width: 18,
                      height: 18,
                      colorFilter: const ColorFilter.mode(
                        AppColors.neutral500,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 4),
                    AppText(
                      '복사하기',
                      style: AppTextStyles.h8.copyWith(
                        color: AppColors.neutral500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DetailMetaText extends StatelessWidget {
  const _DetailMetaText({required this.item});

  final ContentManagementItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _MetaText(item.channel),
        const _MetaDivider(),
        _MetaText(item.category),
        const _MetaDivider(),
        _MetaText(item.tone),
      ],
    );
  }
}

class _MetaText extends StatelessWidget {
  const _MetaText(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AppText(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.h5.copyWith(color: AppColors.black),
      ),
    );
  }
}

class _MetaDivider extends StatelessWidget {
  const _MetaDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: AppText(
        '·',
        style: AppTextStyles.h5.copyWith(color: AppColors.neutral400),
      ),
    );
  }
}

void _copyText(String text) {
  unawaited(Clipboard.setData(ClipboardData(text: text)));
}
