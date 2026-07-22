import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/modal/ssoss_modal.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_create_flow.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_generation_args.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_save_complete_args.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_save_complete_mode.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_generating_page.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_save_complete_page.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/result/content_result_body.dart';
import 'package:ssoss_flutter/features/home/presentation/pages/home_page.dart';

/// 콘텐츠 생성 결과 화면 (더미).
class ContentResultPage extends StatelessWidget {
  const ContentResultPage({
    required this.args,
    super.key,
  });

  static const String routeName = 'content-result';
  static const String routePath = '/content/create/result';

  final ContentGenerationArgs args;

  bool get _isMulti => args.input.channels.length >= 2;

  bool get _isOtherChannel => args.flow == ContentCreateFlow.otherChannel;

  /// 생성에 포함되지 않은 채널이 남아 있는지 여부.
  bool get _hasRemainingChannels => UploadChannel.values
      .any((channel) => !args.input.channels.contains(channel));

  void _goHome(BuildContext context) {
    context.go(HomePage.routePath);
  }

  void _save(BuildContext context) {
    if (_isOtherChannel) {
      context.go(
        ContentSaveCompletePage.routePath,
        extra: const ContentSaveCompleteArgs(
          mode: ContentSaveCompleteMode.finalSave,
        ),
      );
      return;
    }

    final mode = _hasRemainingChannels
        ? ContentSaveCompleteMode.continueAvailable
        : ContentSaveCompleteMode.finalSave;
    context.go(
      ContentSaveCompletePage.routePath,
      extra: ContentSaveCompleteArgs(
        mode: mode,
        previousInput:
            mode == ContentSaveCompleteMode.continueAvailable ? args.input : null,
      ),
    );
  }

  Future<void> _remake(BuildContext context) async {
    final result = await showSsossModal(
      context,
      title: '콘텐츠를 다시 생성할까요?',
      message: '기존 생성 결과는 저장 되지 않아요',
      primaryButtonLabel: '다시 생성하기',
      secondaryButtonLabel: '취소하기',
      showButtonIcons: false,
    );

    if (result != SsossModalResult.primary || !context.mounted) {
      return;
    }

    // 동일 채널·입력으로 생성 중 화면을 다시 시작한다.
    context.go(ContentGeneratingPage.routePath, extra: args);
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
              SsossAppBar.back(
                title: _isOtherChannel ? '다른 채널용 생성 결과' : '콘텐츠 생성 결과',
                onBack: () => _goHome(context),
              ),
              Expanded(
                child: _isMulti
                    ? ContentResultMultiBody(input: args.input)
                    : ContentResultSingleBody(input: args.input),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  border: Border(
                    top: BorderSide(color: AppColors.neutral200),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SsossButton(
                        label: '다시 생성하기',
                        type: SsossButtonType.outline,
                        width: double.infinity,
                        onPressed: () => unawaited(_remake(context)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SsossButton(
                        label: '저장하기',
                        width: double.infinity,
                        onPressed: () => _save(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
