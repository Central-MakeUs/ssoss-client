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
        onBellTap = null;

  const SsossAppBar.back({
    required this.title,
    required this.onBack,
    super.key,
  })  : showBackButton = true,
        action = SsossAppBarAction.none,
        onDone = null,
        onExit = null,
        onBellTap = null;

  const SsossAppBar.backWithDone({
    required this.title,
    required this.onBack,
    required this.onDone,
    super.key,
  })  : showBackButton = true,
        action = SsossAppBarAction.done,
        onExit = null,
        onBellTap = null;

  /// 뒤로가기 없이 우측 `나가기`만 표시한다. [title]이 있으면 중앙에 표시한다.
  const SsossAppBar.exitOnly({
    required this.onExit,
    this.title = '',
    super.key,
  })  : showBackButton = false,
        action = SsossAppBarAction.exit,
        onBack = null,
        onDone = null,
        onBellTap = null;

  const SsossAppBar.withBell({
    required this.title,
    required this.onBellTap,
    super.key,
  })  : showBackButton = false,
        action = SsossAppBarAction.bell,
        onBack = null,
        onDone = null,
        onExit = null;

  final String title;
  final bool showBackButton;
  final SsossAppBarAction action;
  final VoidCallback? onBack;
  final VoidCallback? onDone;
  final VoidCallback? onExit;
  final VoidCallback? onBellTap;

  static const double height = 58;
  static const double _sideSlotWidth = 32;

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
            children: [
              SizedBox(
                width: _sideSlotWidth,
                height: _sideSlotWidth,
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
                    : AppText(
                        title,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.h4.copyWith(
                          color: AppColors.neutral800,
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
        height: _sideSlotWidth,
      );
    }
    if (_hasTextAction) {
      return SizedBox(
        height: _sideSlotWidth,
        child: child,
      );
    }
    return SizedBox(
      width: _sideSlotWidth,
      height: _sideSlotWidth,
      child: child,
    );
  }

  Widget? _buildAction() {
    switch (action) {
      case SsossAppBarAction.none:
        return null;
      case SsossAppBarAction.done:
        return _TextActionButton(
          label: '완료',
          onTap: onDone,
        );
      case SsossAppBarAction.exit:
        return _TextActionButton(
          label: '나가기',
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
        child: Center(
          child: SvgPicture.asset(
            assetPath,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              AppColors.neutral500,
              BlendMode.srcIn,
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
          child: Center(
            child: AppText(
              label,
              maxLines: 1,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              style: AppTextStyles.h6.copyWith(
                color: AppColors.primary600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
