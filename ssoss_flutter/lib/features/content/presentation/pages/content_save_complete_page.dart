import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_save_complete_args.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_save_complete_mode.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_other_channel_create_page.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/result/content_save_complete_view.dart';
import 'package:ssoss_flutter/features/home/presentation/pages/home_page.dart';

/// 콘텐츠 저장 완료 화면.
///
/// [args.mode]로 CTA를 분기한다. 채널 개수로 UI를 가르지 않는다.
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

  void _goOtherChannel(BuildContext context) {
    final previous = args.previousInput;
    if (previous == null) {
      return;
    }
    context.go(
      ContentOtherChannelCreatePage.routePath,
      extra: previous,
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
                onExit: () => _goHome(context),
              ),
              Expanded(
                child: ContentSaveCompleteView(
                  mode: args.mode,
                  onCreateForOtherChannel: args.mode ==
                              ContentSaveCompleteMode.continueAvailable &&
                          args.previousInput != null
                      ? () => _goOtherChannel(context)
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
