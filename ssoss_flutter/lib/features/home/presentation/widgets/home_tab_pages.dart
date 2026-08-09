import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_page.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_generation_management/content_generation_management_page.dart';
import 'package:ssoss_flutter/features/home/presentation/models/home_route_extra.dart';
import 'package:ssoss_flutter/features/my_page/presentation/pages/my_page/my_page_page.dart';

typedef HomeTabAppBarBuilder = Widget Function(BuildContext context);

class ContentCreationTab extends StatelessWidget {
  const ContentCreationTab({
    super.key,
    this.isActive = true,
  });

  final bool isActive;

  static Widget buildAppBar(BuildContext context) {
    return const _HomeLogoHeader();
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
    this.initialManagementSection = ContentManagementSection.generated,
  });

  final bool isActive;
  final ContentManagementSection initialManagementSection;

  static Widget buildAppBar(BuildContext context) {
    return ContentGenerationManagementPage.buildAppBar(context);
  }

  @override
  Widget build(BuildContext context) {
    return ContentGenerationManagementPage(
      isActive: isActive,
      initialTabIndex:
          initialManagementSection == ContentManagementSection.templates
              ? 1
              : 0,
    );
  }
}

class _HomeLogoHeader extends StatelessWidget {
  const _HomeLogoHeader();

  static const double _logoSize = 36;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: SizedBox(
        height: SsossAppBar.height,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Image.asset(
              AppAssets.appIcon,
              width: _logoSize,
              height: _logoSize,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
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
    return MyPagePage.buildAppBar(context);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute<void>(
          builder: (_) => const MyPagePage(),
          settings: settings,
        );
      },
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
