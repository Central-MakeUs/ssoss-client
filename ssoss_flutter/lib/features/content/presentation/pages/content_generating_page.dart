import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/modal/ssoss_modal.dart';

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
  bool _isExitModalVisible = false;
  bool _isGenerationComplete = false;

  @override
  void initState() {
    super.initState();
    _navigateTimer = Timer(const Duration(seconds: 2), _onGenerationComplete);
  }

  @override
  void dispose() {
    _navigateTimer?.cancel();
    super.dispose();
  }

  void _onGenerationComplete() {
    if (!mounted) {
      return;
    }
    if (_isExitModalVisible) {
      _isGenerationComplete = true;
      return;
    }
    _goToResult();
  }

  void _goToResult() {
    context.go(ContentResultPage.routePath, extra: widget.args);
  }

  void _goHome() {
    _navigateTimer?.cancel();
    context.go(HomePage.routePath);
  }

  Future<void> _onExitPressed() async {
    if (_isExitModalVisible) {
      return;
    }

    _isExitModalVisible = true;
    final result = await showSsossModal(
      context,
      title: '콘텐츠 생성을 중단할까요?',
      message: '지금 나가면 콘텐츠 생성이 중단되며\n생성 결과는 저장되지 않아요',
      primaryButtonLabel: '중단하기',
      secondaryButtonLabel: '취소',
      showButtonIcons: false,
    );

    if (!mounted) {
      return;
    }

    _isExitModalVisible = false;

    if (result == SsossModalResult.primary) {
      _goHome();
      return;
    }

    // 취소·X: 모달 표시 중 생성이 끝났다면 결과 화면으로 이동
    if (_isGenerationComplete) {
      _goToResult();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          return;
        }
        unawaited(_onExitPressed());
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              SsossAppBar.exitOnly(
                onExit: _onExitPressed,
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
