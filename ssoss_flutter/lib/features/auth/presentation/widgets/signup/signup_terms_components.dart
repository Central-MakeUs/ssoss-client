import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
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
          child: SvgPicture.asset(
            isNaver ? AppAssets.brandNaver : AppAssets.brandApple,
            width: 16,
            height: 16,
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
    required this.url,
    super.key,
  });

  final String url;

  Future<void> _openUrl() async {
    final uri = Uri.parse(url);
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unawaited(_openUrl()),
      behavior: HitTestBehavior.opaque,
      child: AppText(
        '보기',
        style: AppTextStyles.b5.copyWith(color: AppColors.neutral400),
      ),
    );
  }
}
