import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

enum SsossAppBarAction {
  none,
  done,
  exit,
  bell,
}

class SsossAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SsossAppBar({
    required this.title,
    this.showBackButton = false,
    this.action = SsossAppBarAction.none,
    this.onBack,
    this.onDone,
    this.onExit,
    this.onBellTap,
    this.actionLabel,
    super.key,
  });

  const SsossAppBar.defaultTitle({
    required this.title,
    super.key,
  })  : showBackButton = false,
        action = SsossAppBarAction.none,
        onBack = null,
        onDone = null,
        onExit = null,
        onBellTap = null,
        actionLabel = null;

  const SsossAppBar.back({
    required this.title,
    required this.onBack,
    super.key,
  })  : showBackButton = true,
        action = SsossAppBarAction.none,
        onDone = null,
        onExit = null,
        onBellTap = null,
        actionLabel = null;

  const SsossAppBar.backWithDone({
    required this.title,
    required this.onBack,
    required this.onDone,
    super.key,
  })  : showBackButton = true,
        action = SsossAppBarAction.done,
        onExit = null,
        onBellTap = null,
        actionLabel = '완료';

  const SsossAppBar.backWithLabel({
    required this.title,
    required String label,
    required this.onBack,
    required this.onDone,
    super.key,
  })  : showBackButton = true,
        action = SsossAppBarAction.done,
        onExit = null,
        onBellTap = null,
        actionLabel = label;

  /// 뒤로가기 없이 우측 `나가기`만 표시한다. [title]이 있으면 중앙에 표시한다.
  const SsossAppBar.exitOnly({
    required this.onExit,
    this.title = '',
    super.key,
  })  : showBackButton = false,
        action = SsossAppBarAction.exit,
        onBack = null,
        onDone = null,
        onBellTap = null,
        actionLabel = '나가기';

  const SsossAppBar.withBell({
    required this.title,
    required this.onBellTap,
    super.key,
  })  : showBackButton = false,
        action = SsossAppBarAction.bell,
        onBack = null,
        onDone = null,
        onExit = null,
        actionLabel = null;

  final String title;
  final bool showBackButton;
  final SsossAppBarAction action;
  final VoidCallback? onBack;
  final VoidCallback? onDone;
  final VoidCallback? onExit;
  final VoidCallback? onBellTap;
  final String? actionLabel;

  static const double height = 58;
  static const double _sideSlotWidth = 32;

  static const TextHeightBehavior _textHeightBehavior = TextHeightBehavior(
    applyHeightToFirstAscent: false,
    applyHeightToLastDescent: false,
  );

  @override
  Size get preferredSize => const Size.fromHeight(height);

  bool get _hasTextAction =>
      action == SsossAppBarAction.done || action == SsossAppBarAction.exit;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: SizedBox(
        height: height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: _sideSlotWidth,
                height: height,
                child: showBackButton
                    ? _AppBarIconButton(
                        assetPath: AppAssets.icChevronLeft,
                        semanticLabel: '뒤로가기',
                        onTap: onBack,
                      )
                    : null,
              ),
              Expanded(
                child: title.isEmpty
                    ? const SizedBox.shrink()
                    : Center(
                        child: AppText(
                          title,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textHeightBehavior: _textHeightBehavior,
                          style: AppTextStyles.h4.copyWith(
                            color: AppColors.neutral800,
                          ),
                        ),
                      ),
              ),
              _buildTrailing(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrailing() {
    final child = _buildAction();
    if (child == null) {
      return const SizedBox(
        width: _sideSlotWidth,
        height: height,
      );
    }
    if (_hasTextAction) {
      // 타이틀과 동일하게 앱바 전체 높이 기준 수직 중앙 정렬.
      return SizedBox(
        height: height,
        child: Align(
          alignment: Alignment.centerRight,
          child: child,
        ),
      );
    }
    return SizedBox(
      width: _sideSlotWidth,
      height: height,
      child: child,
    );
  }

  Widget? _buildAction() {
    switch (action) {
      case SsossAppBarAction.none:
        return null;
      case SsossAppBarAction.done:
        return _TextActionButton(
          label: actionLabel ?? '완료',
          onTap: onDone,
        );
      case SsossAppBarAction.exit:
        return _TextActionButton(
          label: actionLabel ?? '나가기',
          onTap: onExit,
        );
      case SsossAppBarAction.bell:
        return _AppBarIconButton(
          assetPath: AppAssets.icBell,
          semanticLabel: '알림',
          onTap: onBellTap,
        );
    }
  }
}

class _AppBarIconButton extends StatelessWidget {
  const _AppBarIconButton({
    required this.assetPath,
    required this.semanticLabel,
    required this.onTap,
  });

  final String assetPath;
  final String semanticLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        // 부모 슬롯(앱바 전체 높이)을 채운 뒤 아이콘을 수직·수평 중앙에 둔다.
        child: SizedBox.expand(
          child: Center(
            child: SvgPicture.asset(
              assetPath,
              width: 24,
              height: 24,
              alignment: Alignment.center,
              colorFilter: const ColorFilter.mode(
                AppColors.neutral500,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TextActionButton extends StatelessWidget {
  const _TextActionButton({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: AppText(
            label,
            maxLines: 1,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            textHeightBehavior: SsossAppBar._textHeightBehavior,
            style: AppTextStyles.h6.copyWith(
              color: AppColors.primary600,
            ),
          ),
        ),
      ),
    );
  }
}
