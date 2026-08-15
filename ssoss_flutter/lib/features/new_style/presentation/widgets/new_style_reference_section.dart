import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

/// 원본 스타일 안내 + 「참고한 콘텐츠」카드.
class NewStyleReferenceSection extends StatelessWidget {
  const NewStyleReferenceSection({
    required this.referenceRawText,
    super.key,
  });

  static const int _titleMaxLength = 20;

  final String referenceRawText;

  /// 20자를 넘으면 앞 20자만 남기고 `...`을 붙인다.
  String get _displayTitle {
    final text = referenceRawText.trim();
    final chars = text.characters;
    if (chars.length <= _titleMaxLength) return text;
    return '${chars.take(_titleMaxLength)}...';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          '원본 스타일을 참고해 만들어요',
          style: AppTextStyles.h4.copyWith(color: AppColors.black),
        ),
        const SizedBox(height: 4),
        AppText(
          '기존 글의 톤과 구성, 분량을 참고해 생성해요',
          style: AppTextStyles.b5.copyWith(color: AppColors.neutral500),
        ),
        const SizedBox(height: 12),
        Container(
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
                '참고한 콘텐츠',
                style: AppTextStyles.h8.copyWith(color: AppColors.neutral500),
              ),
              const SizedBox(height: 4),
              AppText(
                _displayTitle,
                maxLines: 1,
                style: AppTextStyles.b4.copyWith(color: AppColors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
