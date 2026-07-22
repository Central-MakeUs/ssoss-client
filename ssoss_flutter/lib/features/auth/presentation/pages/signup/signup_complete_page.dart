import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/auth/presentation/bloc/login_bloc.dart';
import 'package:ssoss_flutter/features/auth/presentation/bloc/login_event.dart';
import 'package:ssoss_flutter/features/home/presentation/pages/home_page.dart';

class SignupCompletePage extends StatefulWidget {
  const SignupCompletePage({super.key});

  static const String routeName = 'signup-complete';
  static const String routePath = '/signup/complete';

  @override
  State<SignupCompletePage> createState() => _SignupCompletePageState();
}

class _SignupCompletePageState extends State<SignupCompletePage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), _goHome);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _goHome() {
    if (!mounted) {
      return;
    }
    context.read<LoginBloc>().add(
          const LoginEvent.signupCompleteAcknowledged(),
        );
    context.go(HomePage.routePath);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _goHome,
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.appIcon,
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 40),
                AppText(
                  '반갑습니다!\n회원이 되신 것을 환영합니다',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h4.copyWith(color: AppColors.neutral800),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
