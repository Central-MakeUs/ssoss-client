import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/my_page/presentation/pages/settings/settings_components.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const String routeName = 'settings';
  static const String routePath = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

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
            onTap: () {},
          ),
          const SizedBox(height: 10),
          SettingsWithdrawButton(onTap: () {}),
        ],
      ),
    );
  }
}
