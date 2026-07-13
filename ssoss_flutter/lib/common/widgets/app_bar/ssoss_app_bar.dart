import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

enum SsossAppBarAction {
  none,
  done,
  bell,
}

class SsossAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SsossAppBar({
    required this.title,
    this.showBackButton = false,
    this.action = SsossAppBarAction.none,
    this.onBack,
    this.onDone,
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
        onBellTap = null;

  const SsossAppBar.back({
    required this.title,
    required this.onBack,
    super.key,
  })  : showBackButton = true,
        action = SsossAppBarAction.none,
        onDone = null,
        onBellTap = null;

  const SsossAppBar.backWithDone({
    required this.title,
    required this.onBack,
    required this.onDone,
    super.key,
  })  : showBackButton = true,
        action = SsossAppBarAction.done,
        onBellTap = null;

  const SsossAppBar.withBell({
    required this.title,
    required this.onBellTap,
    super.key,
  })  : showBackButton = false,
        action = SsossAppBarAction.bell,
        onBack = null,
        onDone = null;

  final String title;
  final bool showBackButton;
  final SsossAppBarAction action;
  final VoidCallback? onBack;
  final VoidCallback? onDone;
  final VoidCallback? onBellTap;

  static const double height = 58;
  static const double _sideSlotWidth = 32;

  @override
  Size get preferredSize => const Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.neutral200),
          ),
        ),
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
                  child: AppText(
                    title,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.h4.copyWith(
                      color: AppColors.neutral800,
                    ),
                  ),
                ),
                SizedBox(
                  width: _sideSlotWidth,
                  height: _sideSlotWidth,
                  child: _buildAction(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget? _buildAction() {
    switch (action) {
      case SsossAppBarAction.none:
        return null;
      case SsossAppBarAction.done:
        return _DoneActionButton(onTap: onDone);
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
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
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

class _DoneActionButton extends StatelessWidget {
  const _DoneActionButton({
    required this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '완료',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Center(
          child: AppText(
            '완료',
            maxLines: 1,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            style: AppTextStyles.h6.copyWith(
              color: AppColors.primary600,
            ),
          ),
        ),
      ),
    );
  }
}
