import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/features/auth/presentation/bloc/login_bloc.dart';
import 'package:ssoss_flutter/features/auth/presentation/bloc/login_event.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_page.dart';

typedef HomeTabAppBarBuilder = Widget Function(BuildContext context);

class ContentCreationTab extends StatelessWidget {
  const ContentCreationTab({super.key});

  static Widget buildAppBar(BuildContext context) {
    return SsossAppBar.withBell(title: '', onBellTap: () {});
  }

  @override
  Widget build(BuildContext context) {
    return const ContentPage();
  }
}

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  static Widget buildAppBar(BuildContext context) {
    return const SsossAppBar.defaultTitle(title: '대시보드');
  }

  @override
  Widget build(BuildContext context) {
    return const _HomeTabPlaceholder(title: '대시보드');
  }
}

class PlaceDiagnosisTab extends StatelessWidget {
  const PlaceDiagnosisTab({super.key});

  static Widget buildAppBar(BuildContext context) {
    return const SsossAppBar.defaultTitle(title: '플레이스 진단');
  }

  @override
  Widget build(BuildContext context) {
    return const _HomeTabPlaceholder(title: '플레이스 진단');
  }
}

class MyPageTab extends StatelessWidget {
  const MyPageTab({super.key});

  static Widget buildAppBar(BuildContext context) {
    return const SsossAppBar.defaultTitle(title: '마이페이지');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OutlinedButton.icon(
              onPressed: () {
                context
                    .read<LoginBloc>()
                    .add(const LoginEvent.withdrawRequested());
              },
              icon: const Icon(Icons.link_off),
              label: const AppText('회원 탈퇴'),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                context
                    .read<LoginBloc>()
                    .add(const LoginEvent.logoutRequested());
              },
              child: const AppText('로그아웃'),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTabPlaceholder extends StatelessWidget {
  const _HomeTabPlaceholder({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppText(
        title,
        textAlign: TextAlign.center,
      ),
    );
  }
}
