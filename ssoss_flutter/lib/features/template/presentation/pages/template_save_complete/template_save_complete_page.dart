import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/navigation/ssoss_navigation_bar.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/home/presentation/pages/home_page.dart';
import 'package:ssoss_flutter/features/recommend_source/presentation/pages/recommend_source/recommend_source_page.dart';
import 'package:ssoss_flutter/features/template/presentation/pages/template_save_complete/template_save_complete_components.dart';

class TemplateSaveCompletePage extends StatelessWidget {
  const TemplateSaveCompletePage({super.key});

  static const String routeName = 'template-save-complete';
  static const String routePath = '/template-save-complete';

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
    context.go(RecommendSourcePage.routePath);
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
                label: '닫기',
                onExit: () => _goHome(context),
              ),
              Expanded(
                child: TemplateSaveCompleteBody(
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
