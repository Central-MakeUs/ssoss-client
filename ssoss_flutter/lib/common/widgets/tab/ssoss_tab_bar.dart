import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/tab/ssoss_tab.dart';

class SsossTabItem {
  const SsossTabItem({
    required this.label,
    this.child,
    this.chipLabel,
  });

  final String label;
  final Widget? child;
  final String? chipLabel;
}

class SsossTabBar extends StatelessWidget {
  const SsossTabBar({
    required this.items,
    required this.selectedIndex,
    super.key,
    this.onTap,
    this.width,
    this.height = 43,
    this.padding,
    this.selectedColor,
    this.unselectedColor,
    this.selectedIndicatorColor,
    this.unselectedIndicatorColor,
    this.selectedIndicatorHeight = 2,
    this.unselectedIndicatorHeight = 1,
    this.textStyle,
  });

  final List<SsossTabItem> items;
  final int selectedIndex;
  final ValueChanged<int>? onTap;
  final double? width;
  final double height;
  final EdgeInsetsGeometry? padding;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? selectedIndicatorColor;
  final Color? unselectedIndicatorColor;
  final double selectedIndicatorHeight;
  final double unselectedIndicatorHeight;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      for (var index = 0; index < items.length; index++)
        SsossTab(
          label: items[index].label,
          isSelected: index == selectedIndex,
          chipLabel: items[index].chipLabel,
          height: height,
          padding: padding,
          selectedColor: selectedColor,
          unselectedColor: unselectedColor,
          selectedIndicatorColor: selectedIndicatorColor,
          unselectedIndicatorColor: unselectedIndicatorColor,
          selectedIndicatorHeight: selectedIndicatorHeight,
          unselectedIndicatorHeight: unselectedIndicatorHeight,
          textStyle: textStyle,
          onTap: onTap == null ? null : () => onTap!(index),
          child: items[index].child,
        ),
    ];

    return SizedBox(
      width: width,
      child: Row(
        children: [
          for (final tab in tabs)
            if (width != null) Expanded(child: tab) else tab,
        ],
      ),
    );
  }
}
