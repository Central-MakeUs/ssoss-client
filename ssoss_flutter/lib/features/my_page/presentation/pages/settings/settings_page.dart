import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/modal/ssoss_modal.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/auth/presentation/bloc/login_bloc.dart';
import 'package:ssoss_flutter/features/auth/presentation/bloc/login_event.dart';
import 'package:ssoss_flutter/features/auth/presentation/bloc/login_state.dart';
import 'package:ssoss_flutter/features/my_page/presentation/pages/settings/settings_components.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const String routeName = 'settings';
  static const String routePath = '/settings';

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) => current is LoginFailure,
      listener: (context, state) {
        if (state is! LoginFailure) {
          return;
        }
        showSsossToast(
          context,
          title: state.message,
          type: SsossToastType.error,
        );
        context.read<LoginBloc>().add(const LoginEvent.failureAcknowledged());
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              SsossAppBar.back(
                title: '설정',
                onBack: () => Navigator.of(context).pop(),
              ),
              const Expanded(child: SettingsBody()),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  Future<void> _onLogout(BuildContext context) async {
    await showSsossModal(
      context,
      title: '로그아웃',
      message: '정말 로그아웃하시겠습니까?',
      primaryButtonLabel: '로그아웃',
      secondaryButtonLabel: '취소',
      showButtonIcons: false,
      onPrimaryPressedAsync: () => context.read<LoginBloc>().performLogout(),
    );
  }

  Future<void> _onWithdraw(BuildContext context) async {
    await showSsossModal(
      context,
      title: '탈퇴하시겠어요?',
      primaryButtonLabel: '탈퇴하기',
      secondaryButtonLabel: '취소',
      showButtonIcons: false,
      onPrimaryPressedAsync: () => context.read<LoginBloc>().performWithdraw(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 11, 16, 32),
      child: SettingsMenuGroup(
        children: [
          SettingsMenuItem(
            label: '개인정보 처리방침',
            onTap: () {},
          ),
          const SizedBox(height: 10),
          SettingsMenuItem(
            label: '로그 아웃',
            onTap: () => _onLogout(context),
          ),
          const SizedBox(height: 10),
          SettingsWithdrawButton(onTap: () => _onWithdraw(context)),
        ],
      ),
    );
  }
}
