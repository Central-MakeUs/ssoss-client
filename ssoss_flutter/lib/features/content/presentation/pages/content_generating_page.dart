import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_generation_args.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_result_page.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/content_generating_view.dart';
import 'package:ssoss_flutter/features/home/presentation/pages/home_page.dart';

/// 콘텐츠 생성 대기 화면.
///
/// 백엔드 완료 대기 대신 당분간 2초 후 결과 화면으로 이동한다.
class ContentGeneratingPage extends StatefulWidget {
  const ContentGeneratingPage({
    required this.args,
    super.key,
  });

  static const String routeName = 'content-generating';
  static const String routePath = '/content/create/generating';

  final ContentGenerationArgs args;

  @override
  State<ContentGeneratingPage> createState() => _ContentGeneratingPageState();
}

class _ContentGeneratingPageState extends State<ContentGeneratingPage> {
  Timer? _navigateTimer;

  @override
  void initState() {
    super.initState();
    _navigateTimer = Timer(const Duration(seconds: 2), () {
      if (!mounted) {
        return;
      }
      context.go(ContentResultPage.routePath, extra: widget.args);
    });
  }

  @override
  void dispose() {
    _navigateTimer?.cancel();
    super.dispose();
  }

  void _exitToHome() {
    _navigateTimer?.cancel();
    context.go(HomePage.routePath);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          return;
        }
        _exitToHome();
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              SsossAppBar.exitOnly(
                onExit: _exitToHome,
              ),
              const Expanded(
                child: ContentGeneratingView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
