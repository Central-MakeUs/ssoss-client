import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_text_field.dart';
import 'package:ssoss_flutter/common/widgets/selection/ssoss_selection_button.dart';
import 'package:ssoss_flutter/common/widgets/selection/ssoss_toggle.dart';
import 'package:ssoss_flutter/common/widgets/tab/ssoss_tab_bar.dart';
import 'package:ssoss_flutter/common/widgets/tag/ssoss_tag.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

enum StoreInfoTab {
  basic('기본 정보'),
  operation('운영 정보'),
  content('콘텐츠 정보');

  const StoreInfoTab(this.label);

  final String label;
}

class StoreInfoManagementTabBar extends StatelessWidget {
  const StoreInfoManagementTabBar({
    required this.selectedTab,
    required this.onChanged,
    super.key,
  });

  final StoreInfoTab selectedTab;
  final ValueChanged<StoreInfoTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return SsossTabBar(
      width: double.infinity,
      selectedIndex: selectedTab.index,
      items: [
        for (final tab in StoreInfoTab.values) SsossTabItem(label: tab.label),
      ],
      onTap: (index) => onChanged(StoreInfoTab.values[index]),
    );
  }
}

class StoreInfoFormField extends StatelessWidget {
  const StoreInfoFormField({
    required this.label,
    super.key,
    this.controller,
    this.hintText = '입력해주세요.',
    this.initialValue,
    this.showSearchIcon = false,
    this.readOnly = false,
    this.multiline = false,
    this.onTap,
  });

  final String label;
  final TextEditingController? controller;
  final String hintText;
  final String? initialValue;
  final bool showSearchIcon;
  final bool readOnly;
  final bool multiline;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          label,
          style: AppTextStyles.h5.copyWith(color: AppColors.black),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(
            absorbing: readOnly || onTap != null,
            child: SsossTextField(
              controller: controller,
              hintText: hintText,
              showSearchIcon: showSearchIcon,
              readOnly: readOnly,
              multiline: multiline,
              textColor: AppColors.neutral800,
              hintColor: AppColors.neutral400,
            ),
          ),
        ),
      ],
    );
  }
}

class StoreInfoPlaceholderForm extends StatelessWidget {
  const StoreInfoPlaceholderForm({
    required this.title,
    required this.description,
    super.key,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.neutral50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            title,
            style: AppTextStyles.h5.copyWith(color: AppColors.black),
          ),
          const SizedBox(height: 8),
          AppText(
            description,
            style: AppTextStyles.b4.copyWith(color: AppColors.neutral500),
          ),
        ],
      ),
    );
  }
}

class StoreInfoSectionTitle extends StatelessWidget {
  const StoreInfoSectionTitle({
    required this.title,
    super.key,
    this.helperText,
  });

  final String title;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText(
          title,
          style: AppTextStyles.h5.copyWith(color: AppColors.black),
        ),
        if (helperText != null) ...[
          const SizedBox(width: 4),
          AppText(
            helperText!,
            style: AppTextStyles.b6.copyWith(color: AppColors.neutral400),
          ),
        ],
      ],
    );
  }
}

class StoreInfoDayButton extends StatelessWidget {
  const StoreInfoDayButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SsossSelectionButton(
        label: label,
        type: isSelected
            ? SsossSelectionButtonType.primarySelected
            : SsossSelectionButtonType.normal,
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        foregroundColor:
            isSelected ? AppColors.primary600 : AppColors.neutral400,
        borderColor: isSelected ? AppColors.primary300 : AppColors.neutral200,
        backgroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      ),
    );
  }
}

class StoreInfoTimeRangeField extends StatelessWidget {
  const StoreInfoTimeRangeField({
    required this.openingTime,
    required this.closingTime,
    required this.onOpeningTimeTap,
    required this.onClosingTimeTap,
    super.key,
  });

  final String openingTime;
  final String closingTime;
  final VoidCallback onOpeningTimeTap;
  final VoidCallback onClosingTimeTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StoreInfoTimeInput(
            text: openingTime,
            onTap: onOpeningTimeTap,
          ),
        ),
        SizedBox(
          width: 24,
          child: Center(
            child: AppText(
              '-',
              style: AppTextStyles.b5.copyWith(color: AppColors.neutral400),
            ),
          ),
        ),
        Expanded(
          child: _StoreInfoTimeInput(
            text: closingTime,
            onTap: onClosingTimeTap,
          ),
        ),
      ],
    );
  }
}

class StoreInfoMenuInputRow extends StatelessWidget {
  const StoreInfoMenuInputRow({
    required this.controller,
    required this.onAdd,
    super.key,
    this.hintText = 'ex) 바닐라라떼',
  });

  final TextEditingController controller;
  final VoidCallback onAdd;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SsossTextField(
            controller: controller,
            hintText: hintText,
            textColor: AppColors.neutral800,
            hintColor: AppColors.neutral400,
          ),
        ),
        const SizedBox(width: 8),
        SsossButton(
          label: '추가하기',
          size: SsossButtonSize.medium,
          width: 72,
          height: 44,
          onPressed: onAdd,
          backgroundColor: AppColors.primary400,
          foregroundColor: AppColors.white,
          textStyle: AppTextStyles.h8,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
      ],
    );
  }
}

class StoreInfoMenuTagWrap extends StatelessWidget {
  const StoreInfoMenuTagWrap({
    required this.menus,
    required this.onRemove,
    super.key,
  });

  final List<String> menus;
  final ValueChanged<String> onRemove;

  @override
  Widget build(BuildContext context) {
    if (menus.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final menu in menus)
          GestureDetector(
            onTap: () => onRemove(menu),
            child: SsossTag(
              label: menu,
              type: SsossTagType.gray,
              showLeftIcon: false,
              showRightIcon: true,
              icon: const Icon(Icons.close, size: 12),
              iconSize: 12,
              backgroundColor: AppColors.neutral100,
              foregroundColor: AppColors.neutral500,
            ),
          ),
      ],
    );
  }
}

enum StoreFacilityType {
  takeout('포장', Icons.shopping_bag_outlined),
  reservation('예약', Icons.calendar_today_outlined),
  parking('주차', Icons.local_parking_outlined);

  const StoreFacilityType(this.label, this.icon);

  final String label;
  final IconData icon;
}

class StoreInfoFacilityRow extends StatelessWidget {
  const StoreInfoFacilityRow({
    required this.type,
    required this.isEnabled,
    required this.onChanged,
    super.key,
  });

  final StoreFacilityType type;
  final bool isEnabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final statusColor = isEnabled ? AppColors.neutral600 : AppColors.neutral400;

    return SizedBox(
      height: 36,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(
                  type.icon,
                  size: 20,
                  color: AppColors.neutral600,
                ),
                const SizedBox(width: 8),
                AppText(
                  type.label,
                  style: AppTextStyles.h6.copyWith(
                    color: AppColors.neutral600,
                  ),
                ),
              ],
            ),
          ),
          AppText(
            isEnabled ? '가능' : '불가',
            style: AppTextStyles.b5.copyWith(color: statusColor),
          ),
          const SizedBox(width: 12),
          SsossToggle(
            isChecked: isEnabled,
            onChanged: onChanged,
            activeColor: AppColors.primary400,
            inactiveColor: AppColors.neutral300,
          ),
        ],
      ),
    );
  }
}

class _StoreInfoTimeInput extends StatelessWidget {
  const _StoreInfoTimeInput({
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isPlaceholder = text == '00:00';

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.neutral200),
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          height: 44,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: AppText(
                text,
                textAlign: TextAlign.center,
                style: AppTextStyles.b4.copyWith(
                  color: isPlaceholder
                      ? AppColors.neutral400
                      : AppColors.neutral800,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StoreInfoTimePickerBottomSheet extends StatefulWidget {
  const StoreInfoTimePickerBottomSheet({super.key});

  @override
  State<StoreInfoTimePickerBottomSheet> createState() =>
      _StoreInfoTimePickerBottomSheetState();
}

class _StoreInfoTimePickerBottomSheetState
    extends State<StoreInfoTimePickerBottomSheet> {
  static const List<String> _periods = ['오전', '오후'];
  static const List<int> _hours = [6, 7, 8, 9, 10];
  static const List<int> _minutes = [0, 10, 20, 30, 40, 50];

  int _periodIndex = 0;
  int _hourIndex = 2;
  int _minuteIndex = 3;

  String get _selectedTime {
    final period = _periods[_periodIndex];
    final hour = _hours[_hourIndex].toString().padLeft(2, '0');
    final minute = _minutes[_minuteIndex].toString().padLeft(2, '0');
    return '$period $hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFDEDEDE),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _StoreInfoTimePickerWheel(
                periods: _periods,
                hours: _hours,
                minutes: _minutes,
                periodIndex: _periodIndex,
                hourIndex: _hourIndex,
                minuteIndex: _minuteIndex,
                onPeriodChanged: (index) {
                  setState(() => _periodIndex = index);
                },
                onHourChanged: (index) {
                  setState(() => _hourIndex = index);
                },
                onMinuteChanged: (index) {
                  setState(() => _minuteIndex = index);
                },
              ),
            ),
            const SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SsossButton(
                label: '확인',
                size: SsossButtonSize.large,
                width: double.infinity,
                height: 56,
                onPressed: () => Navigator.of(context).pop(_selectedTime),
                backgroundColor: AppColors.primary400,
                foregroundColor: AppColors.white,
                textStyle: AppTextStyles.h5,
              ),
            ),
            const SizedBox(height: 34),
          ],
        ),
      ),
    );
  }
}

class _StoreInfoTimePickerWheel extends StatelessWidget {
  const _StoreInfoTimePickerWheel({
    required this.periods,
    required this.hours,
    required this.minutes,
    required this.periodIndex,
    required this.hourIndex,
    required this.minuteIndex,
    required this.onPeriodChanged,
    required this.onHourChanged,
    required this.onMinuteChanged,
  });

  final List<String> periods;
  final List<int> hours;
  final List<int> minutes;
  final int periodIndex;
  final int hourIndex;
  final int minuteIndex;
  final ValueChanged<int> onPeriodChanged;
  final ValueChanged<int> onHourChanged;
  final ValueChanged<int> onMinuteChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 162,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 33,
            decoration: BoxDecoration(
              color: AppColors.neutral100,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 58,
                child: _StoreInfoPickerColumn(
                  values: periods,
                  selectedIndex: periodIndex,
                  onSelectedItemChanged: onPeriodChanged,
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(width: 44),
              SizedBox(
                width: 28,
                child: _StoreInfoPickerColumn(
                  values: [for (final hour in hours) '$hour'],
                  selectedIndex: hourIndex,
                  onSelectedItemChanged: onHourChanged,
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(
                width: 24,
                child: Center(
                  child: AppText(
                    ':',
                    style: AppTextStyles.h4.copyWith(color: AppColors.black),
                  ),
                ),
              ),
              SizedBox(
                width: 32,
                child: _StoreInfoPickerColumn(
                  values: [for (final minute in minutes) '$minute'],
                  selectedIndex: minuteIndex,
                  onSelectedItemChanged: onMinuteChanged,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StoreInfoPickerColumn extends StatelessWidget {
  const _StoreInfoPickerColumn({
    required this.values,
    required this.selectedIndex,
    required this.onSelectedItemChanged,
    required this.textAlign,
  });

  final List<String> values;
  final int selectedIndex;
  final ValueChanged<int> onSelectedItemChanged;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker.builder(
      scrollController: FixedExtentScrollController(
        initialItem: selectedIndex,
      ),
      itemExtent: 33,
      diameterRatio: 1.4,
      magnification: 1,
      squeeze: 1,
      useMagnifier: false,
      selectionOverlay: const SizedBox.shrink(),
      onSelectedItemChanged: onSelectedItemChanged,
      childCount: values.length,
      itemBuilder: (context, index) {
        return Align(
          alignment: textAlign == TextAlign.right
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: AppText(
            values[index],
            textAlign: textAlign,
            style: _styleFor(index),
          ),
        );
      },
    );
  }

  TextStyle _styleFor(int index) {
    if (index == selectedIndex) {
      return AppTextStyles.h4.copyWith(color: AppColors.black);
    }

    final distance = (index - selectedIndex).abs();
    return (distance == 1 ? AppTextStyles.h5 : AppTextStyles.h6).copyWith(
      color: AppColors.neutral300,
    );
  }
}

enum StoreContentTone {
  daily('일상형', '자연스럽고 편안한 말투'),
  emotional('감성형', '분위기와 감정을 살린 말투'),
  informative('정보형', '메뉴, 재료, 특징을 중심으로 설명하는 말투'),
  promotional('홍보형', '장점과 방문 유도를 강조하는 말투');

  const StoreContentTone(this.label, this.description);

  final String label;
  final String description;
}

class StoreContentToneList extends StatelessWidget {
  const StoreContentToneList({
    required this.selectedTone,
    required this.onChanged,
    super.key,
  });

  final StoreContentTone selectedTone;
  final ValueChanged<StoreContentTone> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final tone in StoreContentTone.values) ...[
          StoreContentToneButton(
            tone: tone,
            isSelected: tone == selectedTone,
            onTap: () => onChanged(tone),
          ),
          if (tone != StoreContentTone.values.last) const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class StoreContentToneButton extends StatelessWidget {
  const StoreContentToneButton({
    required this.tone,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final StoreContentTone tone;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor =
        isSelected ? AppColors.primary300 : AppColors.neutral200;
    final backgroundColor = isSelected ? AppColors.primary50 : AppColors.white;
    final titleColor = isSelected ? AppColors.primary500 : AppColors.neutral400;
    final descriptionColor =
        isSelected ? AppColors.neutral600 : AppColors.neutral400;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 56),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            AppText(
              tone.label,
              style: AppTextStyles.h6.copyWith(color: titleColor),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppText(
                tone.description,
                style: AppTextStyles.b5.copyWith(color: descriptionColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
