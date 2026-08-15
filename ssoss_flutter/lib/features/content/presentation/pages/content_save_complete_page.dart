import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/navigation/ssoss_navigation_bar.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_save_complete_args.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/result/content_save_complete_view.dart';
import 'package:ssoss_flutter/features/home/presentation/pages/home_page.dart';

/// 콘텐츠 저장 완료 화면.
class ContentSaveCompletePage extends StatelessWidget {
  const ContentSaveCompletePage({
    required this.args,
    super.key,
  });

  static const String routeName = 'content-save-complete';
  static const String routePath = '/content/create/save-complete';

  final ContentSaveCompleteArgs args;

  void _goHome(BuildContext context) {
    context.go(HomePage.routePath);
  }

  void _goHistory(BuildContext context) {
    context.go(
      HomePage.routePath,
      extra: SsossNavigationItem.dashboard,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          return;
        }
        _goHome(context);
      },
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
                child: ContentSaveCompleteView(
                  onViewHistory: () => _goHistory(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
