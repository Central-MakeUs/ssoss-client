import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/modal/ssoss_modal.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

/// 추천 카드 삭제 시 feature 계층의 repository / use case를 연결한다.
typedef SsossRecommendationDeleteCallback = Future<void> Function(
  SsossRecommendationCardItem item,
);

class SsossRecommendationCardItem {
  const SsossRecommendationCardItem({
    required this.id,
    required this.label,
    required this.title,
    required this.description,
    this.dismissible = false,
  });

  /// 서버 삭제 API 호출 시 사용하는 식별자.
  final String id;
  final String label;
  final String title;
  final String description;
  final bool dismissible;
}

class SsossRecommendationCardDeleteConfig {
  const SsossRecommendationCardDeleteConfig({
    this.title = '추천 안내를 삭제할까요?',
    this.message = '삭제하면 다시 볼 수 없어요.',
    this.confirmLabel = '확인',
    this.cancelLabel = '취소',
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
}

/// 삭제 확인 모달을 띄운 뒤, 확인 시 [onDelete]를 호출한다.
/// 확인 시 `true`, 취소·닫기 시 `false`를 반환한다.
Future<bool> confirmDeleteSsossRecommendation(
  BuildContext context, {
  required SsossRecommendationCardItem item,
  SsossRecommendationDeleteCallback? onDelete,
  SsossRecommendationCardDeleteConfig config =
      const SsossRecommendationCardDeleteConfig(),
}) async {
  final result = await showSsossModal(
    context,
    title: config.title,
    message: config.message,
    primaryButtonLabel: config.confirmLabel,
    secondaryButtonLabel: config.cancelLabel,
    showButtonIcons: false,
  );

  if (result != SsossModalResult.primary) {
    return false;
  }

  if (onDelete != null) {
    await onDelete(item);
  }

  return true;
}

class SsossRecommendationCard extends StatefulWidget {
  const SsossRecommendationCard({
    required this.item,
    super.key,
    this.onDelete,
    this.onDeleted,
    this.deleteConfig = const SsossRecommendationCardDeleteConfig(),
  });

  final SsossRecommendationCardItem item;
  final SsossRecommendationDeleteCallback? onDelete;
  final VoidCallback? onDeleted;
  final SsossRecommendationCardDeleteConfig deleteConfig;

  @override
  State<SsossRecommendationCard> createState() =>
      _SsossRecommendationCardState();
}

class _SsossRecommendationCardState extends State<SsossRecommendationCard> {
  bool _isDeleting = false;

  Future<void> _handleDismissTap() async {
    if (_isDeleting) {
      return;
    }

    setState(() => _isDeleting = true);
    try {
      final deleted = await confirmDeleteSsossRecommendation(
        context,
        item: widget.item,
        onDelete: widget.onDelete,
        config: widget.deleteConfig,
      );

      if (deleted && mounted) {
        widget.onDeleted?.call();
      }
    } finally {
      if (mounted) {
        setState(() => _isDeleting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasDismissButton = widget.item.dismissible;

    return IgnorePointer(
      ignoring: _isDeleting,
      child: Opacity(
        opacity: _isDeleting ? 0.5 : 1,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.image_outlined,
                          size: 20,
                          color: AppColors.primary500,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: AppText(
                            widget.item.label,
                            style: AppTextStyles.h9.copyWith(
                              color: AppColors.primary500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (hasDismissButton)
                    GestureDetector(
                      onTap: _handleDismissTap,
                      behavior: HitTestBehavior.opaque,
                      child: const Icon(
                        Icons.close,
                        size: 24,
                        color: AppColors.neutral500,
                      ),
                    ),
                ],
              ),
              SizedBox(height: hasDismissButton ? 16 : 20),
              AppText(
                widget.item.title,
                style: AppTextStyles.h5.copyWith(
                  color: AppColors.neutral600,
                ),
              ),
              const SizedBox(height: 4),
              AppText(
                widget.item.description,
                style: AppTextStyles.b5.copyWith(
                  color: AppColors.neutral400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
