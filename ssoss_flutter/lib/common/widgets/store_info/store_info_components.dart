import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ssoss_flutter/common/widgets/input/ssoss_address_search_field.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_text_field.dart';
import 'package:ssoss_flutter/common/widgets/selection/ssoss_selection_button.dart';
import 'package:ssoss_flutter/common/widgets/selection/ssoss_toggle.dart';
import 'package:ssoss_flutter/common/widgets/tab/ssoss_tab_bar.dart';
import 'package:ssoss_flutter/common/widgets/tag/ssoss_tag.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/constants/writing_tone.dart';
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
    this.readOnly = false,
    this.multiline = false,
    this.isRequired = false,
    this.helperText,
    this.textInputAction,
    this.onTap,
  });

  final String label;
  final TextEditingController? controller;
  final String hintText;
  final String? initialValue;
  final bool readOnly;
  final bool multiline;
  final bool isRequired;
  final String? helperText;
  final TextInputAction? textInputAction;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StoreInfoSectionTitle(
          title: label,
          isRequired: isRequired,
          helperText: helperText,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(
            absorbing: readOnly || onTap != null,
            child: SsossTextField(
              controller: controller,
              hintText: hintText,
              readOnly: readOnly,
              multiline: multiline,
              textInputAction: textInputAction,
              textColor: AppColors.neutral800,
              hintColor: AppColors.neutral400,
            ),
          ),
        ),
      ],
    );
  }
}

class StoreInfoAddressFormField extends StatelessWidget {
  const StoreInfoAddressFormField({
    required this.label,
    required this.controller,
    this.hintText = '입력해주세요.',
    this.initialValue,
    this.isRequired = false,
    this.helperText,
    this.onTap,
    super.key,
  });

  final String label;
  final TextEditingController controller;
  final String hintText;
  final String? initialValue;
  final bool isRequired;
  final String? helperText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StoreInfoSectionTitle(
          title: label,
          isRequired: isRequired,
          helperText: helperText,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(
            absorbing: onTap != null,
            child: SsossAddressSearchField(
              controller: controller,
              hintText: hintText,
              initialValue: initialValue,
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
    this.isRequired = false,
    this.helperText,
  });

  final String title;
  final bool isRequired;
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
        if (isRequired) ...[
          const SizedBox(width: 2),
          AppText(
            '*',
            style: AppTextStyles.h5.copyWith(color: AppColors.primary600),
          ),
        ],
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
              icon: SvgPicture.asset(
                AppAssets.icClose,
                width: 12,
                height: 12,
                colorFilter: const ColorFilter.mode(
                  AppColors.neutral500,
                  BlendMode.srcIn,
                ),
              ),
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
  takeout('포장', AppAssets.icBag),
  reservation('예약', AppAssets.icCalendar),
  parking('주차', AppAssets.icParking);

  const StoreFacilityType(this.label, this.iconPath);

  final String label;
  final String iconPath;
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
                SvgPicture.asset(
                  type.iconPath,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColors.neutral600,
                    BlendMode.srcIn,
                  ),
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

class StoreContentToneList extends StatelessWidget {
  const StoreContentToneList({
    required this.selectedTone,
    required this.onChanged,
    super.key,
  });

  final WritingTone selectedTone;
  final ValueChanged<WritingTone> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final tone in WritingTone.values) ...[
          StoreContentToneButton(
            tone: tone,
            isSelected: tone == selectedTone,
            onTap: () => onChanged(tone),
          ),
          if (tone != WritingTone.values.last) const SizedBox(height: 12),
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

  final WritingTone tone;
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
