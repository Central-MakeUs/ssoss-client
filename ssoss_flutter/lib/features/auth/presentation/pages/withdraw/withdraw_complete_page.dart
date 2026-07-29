import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/auth/presentation/bloc/login_bloc.dart';
import 'package:ssoss_flutter/features/auth/presentation/bloc/login_event.dart';
import 'package:ssoss_flutter/features/auth/presentation/pages/login_page.dart';

class WithdrawCompletePage extends StatefulWidget {
  const WithdrawCompletePage({super.key});

  static const String routeName = 'withdraw-complete';
  static const String routePath = '/withdraw/complete';

  @override
  State<WithdrawCompletePage> createState() => _WithdrawCompletePageState();
}

class _WithdrawCompletePageState extends State<WithdrawCompletePage> {
  Timer? _timer;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), _goLogin);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _goLogin() {
    if (!mounted || _navigated) {
      return;
    }
    _navigated = true;
    _timer?.cancel();
    context.read<LoginBloc>().add(
          const LoginEvent.withdrawCompleteAcknowledged(),
        );
    context.go(LoginPage.routePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: PopScope(
        canPop: false,
        child: SafeArea(
          child: Column(
            children: [
              const SsossAppBar.defaultTitle(
                title: '',
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText(
                          '회원탈퇴가 완료되었어요',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.h3.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        AppText(
                          '그동안 쏘쓰를 이용해 주셔서 감사합니다',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.b4.copyWith(
                            color: AppColors.neutral500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
