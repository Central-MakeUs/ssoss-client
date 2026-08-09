import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/input/ssoss_hashtag_input.dart';
import 'package:ssoss_flutter/common/widgets/store_info/store_info_components.dart';
import 'package:ssoss_flutter/common/widgets/store_info/store_info_limits.dart';

class StoreOperationInfoForm extends StatelessWidget {
  const StoreOperationInfoForm({
    required this.selectedDays,
    required this.facilities,
    required this.onDayTap,
    required this.openingTime,
    required this.closingTime,
    required this.onOpeningTimeTap,
    required this.onClosingTimeTap,
    required this.onFacilityChanged,
    this.menus = const [],
    this.onAddMenu,
    this.onRemoveMenu,
    this.showSignatureMenus = true,
    super.key,
  });

  final Set<String> selectedDays;
  final Map<StoreFacilityType, bool> facilities;
  final ValueChanged<String> onDayTap;
  final String openingTime;
  final String closingTime;
  final VoidCallback onOpeningTimeTap;
  final VoidCallback onClosingTimeTap;
  final void Function(StoreFacilityType type, bool value) onFacilityChanged;
  final List<String> menus;
  final ValueChanged<String>? onAddMenu;
  final ValueChanged<String>? onRemoveMenu;

  /// 대표 메뉴 섹션 표시 여부. 온보딩에서는 false.
  final bool showSignatureMenus;

  static const List<String> weekdays = ['월', '화', '수', '목', '금', '토', '일'];

  @override
  Widget build(BuildContext context) {
    final onAddMenu = this.onAddMenu;
    final onRemoveMenu = this.onRemoveMenu;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const StoreInfoSectionTitle(title: '영업 시간'),
        const SizedBox(height: 12),
        Row(
          children: [
            for (final day in weekdays) ...[
              Expanded(
                child: StoreInfoDayButton(
                  label: day,
                  isSelected: selectedDays.contains(day),
                  onTap: () => onDayTap(day),
                ),
              ),
              if (day != weekdays.last) const SizedBox(width: 8),
            ],
          ],
        ),
        const SizedBox(height: 12),
        StoreInfoTimeRangeField(
          openingTime: openingTime,
          closingTime: closingTime,
          onOpeningTimeTap: onOpeningTimeTap,
          onClosingTimeTap: onClosingTimeTap,
        ),
        if (showSignatureMenus &&
            onAddMenu != null &&
            onRemoveMenu != null) ...[
          const SizedBox(height: 32),
          StoreInfoSectionTitle(
            title: '대표 메뉴',
            helperText:
                '최대 ${SsossHashtagLimits.maxCount}개, ${StoreInfoLimits.menu}자 제한',
          ),
          const SizedBox(height: 8),
          SsossHashtagInput(
            hashtags: menus,
            hintText: 'ex) 크림브륄레 커피',
            onAdd: onAddMenu,
            onRemove: onRemoveMenu,
            showHashPrefix: false,
            maxLength: StoreInfoLimits.menu,
          ),
        ],
        const SizedBox(height: 32),
        const StoreInfoSectionTitle(title: '편의 시설'),
        const SizedBox(height: 12),
        for (final type in StoreFacilityType.values) ...[
          StoreInfoFacilityRow(
            type: type,
            isEnabled: facilities[type] ?? false,
            onChanged: (value) => onFacilityChanged(type, value),
          ),
          if (type != StoreFacilityType.values.last) const SizedBox(height: 12),
        ],
      ],
    );
  }
}
