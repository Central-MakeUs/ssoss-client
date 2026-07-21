import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/common/widgets/tooltip/ssoss_tooltip.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_save_complete_mode.dart';

/// 저장 완료 본문. [mode]에 따라 하단 CTA만 분기한다.
class ContentSaveCompleteView extends StatelessWidget {
  const ContentSaveCompleteView({
    required this.mode,
    super.key,
    this.onCreateForOtherChannel,
  });

  final ContentSaveCompleteMode mode;
  final VoidCallback? onCreateForOtherChannel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppAssets.imgComplete,
                    width: 135,
                    height: 135,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 24),
                  AppText(
                    '저장이 완료되었어요',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.h2.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  AppText(
                    '저장한 콘텐츠는 저장 내역에서\n확인할 수 있어요',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.b4.copyWith(
                      color: AppColors.neutral400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: switch (mode) {
            ContentSaveCompleteMode.continueAvailable =>
              _ContinueAvailableActions(
                onCreateForOtherChannel: onCreateForOtherChannel,
              ),
            ContentSaveCompleteMode.finalSave => const _FinalSaveActions(),
          },
        ),
      ],
    );
  }
}

class _ContinueAvailableActions extends StatelessWidget {
  const _ContinueAvailableActions({
    this.onCreateForOtherChannel,
  });

  final VoidCallback? onCreateForOtherChannel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SsossTooltip(
          message: '이 콘텐츠를 다른 채널용으로 이어서 만들 수 있어요',
          direction: SsossTooltipDirection.up,
        ),
        const SizedBox(height: 8),
        SsossButton(
          label: '다른 채널용으로 만들기',
          width: double.infinity,
          onPressed: onCreateForOtherChannel,
        ),
        const SizedBox(height: 12),
        const SsossButton(
          label: '저장 내역 보기',
          type: SsossButtonType.secondary,
          width: double.infinity,
        ),
      ],
    );
  }
}

class _FinalSaveActions extends StatelessWidget {
  const _FinalSaveActions();

  @override
  Widget build(BuildContext context) {
    return const SsossButton(
      label: '저장 내역 보기',
      width: double.infinity,
    );
  }
}
