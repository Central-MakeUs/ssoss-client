import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/input/ssoss_text_field.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class FrequentPhraseField extends StatelessWidget {
  const FrequentPhraseField({
    required this.label,
    required this.controller,
    super.key,
  });

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          label,
          style: AppTextStyles.h5.copyWith(color: AppColors.black),
        ),
        const SizedBox(height: 8),
        SsossTextField(
          controller: controller,
          hintText: '입력해주세요',
          height: 44,
          textColor: AppColors.neutral800,
          hintColor: AppColors.neutral400,
        ),
      ],
    );
  }
}

class FrequentPhraseAddButton extends StatelessWidget {
  const FrequentPhraseAddButton({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary50,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: double.infinity,
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add,
                size: 22,
                color: AppColors.primary500,
              ),
              const SizedBox(width: 8),
              AppText(
                '추가하기',
                style: AppTextStyles.h5.copyWith(
                  color: AppColors.primary500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
