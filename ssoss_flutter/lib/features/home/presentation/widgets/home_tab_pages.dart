import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_page.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_generation_management/content_generation_management_page.dart';
// 배포 최소 기능: 임시 비활성
// import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
// import 'package:ssoss_flutter/features/my_page/presentation/pages/my_page/my_page_page.dart';
import 'package:ssoss_flutter/features/my_page/presentation/pages/settings/settings_page.dart';

typedef HomeTabAppBarBuilder = Widget Function(BuildContext context);

class ContentCreationTab extends StatelessWidget {
  const ContentCreationTab({
    super.key,
    this.isActive = true,
  });

  final bool isActive;

  static Widget buildAppBar(BuildContext context) {
    return SsossAppBar.defaultTitle(title: '');
  }

  @override
  Widget build(BuildContext context) {
    return ContentPage(isActive: isActive);
  }
}

class DashboardTab extends StatelessWidget {
  const DashboardTab({
    super.key,
    this.isActive = true,
  });

  final bool isActive;

  static Widget buildAppBar(BuildContext context) {
    return ContentGenerationManagementPage.buildAppBar(context);
  }

  @override
  Widget build(BuildContext context) {
    return ContentGenerationManagementPage(isActive: isActive);
  }
}

// 배포 최소 기능: 임시 비활성
// class PlaceDiagnosisTab extends StatelessWidget {
//   const PlaceDiagnosisTab({super.key});
//
//   static Widget buildAppBar(BuildContext context) {
//     return const SsossAppBar.defaultTitle(title: '플레이스 진단');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const _HomeTabPlaceholder(title: '플레이스 진단');
//   }
// }

// 배포 최소 기능: 임시 비활성
// class MyPageTab extends StatelessWidget {
//   const MyPageTab({super.key});
//
//   static Widget buildAppBar(BuildContext context) {
//     return MyPagePage.buildAppBar(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Navigator(
//       onGenerateRoute: (settings) {
//         return MaterialPageRoute<void>(
//           builder: (_) => const MyPagePage(),
//           settings: settings,
//         );
//       },
//     );
//   }
// }

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  static Widget buildAppBar(BuildContext context) {
    return const SsossAppBar.defaultTitle(title: '설정');
  }

  @override
  Widget build(BuildContext context) {
    return const SettingsBody();
  }
}

// 배포 최소 기능: 임시 비활성 (PlaceDiagnosisTab용)
// class _HomeTabPlaceholder extends StatelessWidget {
//   const _HomeTabPlaceholder({required this.title});
//
//   final String title;
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: AppText(
//         title,
//         textAlign: TextAlign.center,
//       ),
//     );
//   }
// }
