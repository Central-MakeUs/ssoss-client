import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

enum SsossNavigationItem {
  contentCreation,
  dashboard,
  placeDiagnosis,
  myPage,
}

class SsossNavigationBar extends StatelessWidget {
  const SsossNavigationBar({
    required this.currentItem,
    required this.onItemSelected,
    super.key,
  });

  final SsossNavigationItem currentItem;
  final ValueChanged<SsossNavigationItem> onItemSelected;

  static const double _topPadding = 10;
  static const double _contentHeight = 67;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.neutral200),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(top: _topPadding),
          child: SizedBox(
            height: _contentHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: SsossNavigationItem.values
                  .map(
                    (item) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: _SsossNavigationButton(
                          item: item,
                          isSelected: item == currentItem,
                          onTap: () => onItemSelected(item),
                        ),
                      ),
                    ),
                  )
                  .toList(growable: false),
            ),
          ),
        ),
      ),
    );
  }
}

class _SsossNavigationButton extends StatelessWidget {
  const _SsossNavigationButton({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final SsossNavigationItem item;
  final bool isSelected;
  final VoidCallback onTap;

  static const double _iconSize = 30;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primary400 : AppColors.neutral400;

    return Semantics(
      button: true,
      selected: isSelected,
      label: item.label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SvgPicture.asset(
                item.assetPath,
                width: _iconSize,
                height: _iconSize,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
              const SizedBox(height: 8),
              AppText(
                item.label,
                textAlign: TextAlign.center,
                style: AppTextStyles.h9.copyWith(
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension SsossNavigationItemX on SsossNavigationItem {
  String get label {
    switch (this) {
      case SsossNavigationItem.contentCreation:
        return '콘텐츠 생성';
      case SsossNavigationItem.dashboard:
        return '대시보드';
      case SsossNavigationItem.placeDiagnosis:
        return '플레이스 진단';
      case SsossNavigationItem.myPage:
        return '마이페이지';
    }
  }

  String get assetPath {
    switch (this) {
      case SsossNavigationItem.contentCreation:
        return AppAssets.navContent;
      case SsossNavigationItem.dashboard:
        return AppAssets.navDashboard;
      case SsossNavigationItem.placeDiagnosis:
        return AppAssets.navPlaceDiagnosis;
      case SsossNavigationItem.myPage:
        return AppAssets.navMyPage;
    }
  }
}
