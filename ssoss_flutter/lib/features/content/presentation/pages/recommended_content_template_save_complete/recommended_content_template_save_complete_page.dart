import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/navigation/ssoss_navigation_bar.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/recommended_content_template_save_complete/recommended_content_template_save_complete_components.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/recommended_content_templates/recommended_content_templates_page.dart';
import 'package:ssoss_flutter/features/home/presentation/pages/home_page.dart';

class RecommendedContentTemplateSaveCompletePage extends StatelessWidget {
  const RecommendedContentTemplateSaveCompletePage({super.key});

  static const String routeName = 'recommended-content-template-save-complete';
  static const String routePath = '/recommended-content-template-save-complete';

  void _goHome(BuildContext context) {
    context.go(HomePage.routePath);
  }

  void _goHistory(BuildContext context) {
    context.go(
      HomePage.routePath,
      extra: SsossNavigationItem.dashboard,
    );
  }

  void _goTemplates(BuildContext context) {
    context.go(RecommendedContentTemplatesPage.routePath);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              SsossAppBar.exitOnly(
                title: '저장 완료',
                onExit: () => _goHome(context),
              ),
              Expanded(
                child: RecommendedContentTemplateSaveCompleteBody(
                  onViewHistory: () => _goHistory(context),
                  onViewTemplates: () => _goTemplates(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
