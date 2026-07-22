import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/auth/domain/entities/social_provider.dart';

class SignupProviderHeader extends StatelessWidget {
  const SignupProviderHeader({
    required this.provider,
    super.key,
  });

  final SocialProvider provider;

  static const Color _naverGreen = Color(0xFF03C75A);

  @override
  Widget build(BuildContext context) {
    final isNaver = provider == SocialProvider.naver;
    final title = isNaver ? '네이버로 로그인' : '애플로 로그인';

    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isNaver ? _naverGreen : AppColors.black,
            shape: BoxShape.circle,
          ),
          child: isNaver
              ? const AppText(
                  'N',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                )
              : const Icon(
                  Icons.apple,
                  color: AppColors.white,
                  size: 18,
                ),
        ),
        const SizedBox(width: 12),
        AppText(
          title,
          style: AppTextStyles.h3.copyWith(color: AppColors.black),
        ),
      ],
    );
  }
}

class SignupEmailField extends StatelessWidget {
  const SignupEmailField({
    required this.email,
    super.key,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.neutral50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: AppText(
        email,
        style: AppTextStyles.b4.copyWith(color: AppColors.neutral400),
      ),
    );
  }
}

class SignupTermsDivider extends StatelessWidget {
  const SignupTermsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: 1,
      color: AppColors.neutral200,
    );
  }
}

class SignupTermsViewLink extends StatelessWidget {
  const SignupTermsViewLink({
    this.onTap,
    super.key,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AppText(
        '보기',
        style: AppTextStyles.b5.copyWith(color: AppColors.neutral400),
      ),
    );
  }
}
