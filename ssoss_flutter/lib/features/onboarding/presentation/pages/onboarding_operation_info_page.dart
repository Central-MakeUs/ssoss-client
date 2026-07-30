import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:ssoss_flutter/common/widgets/picker/ssoss_time_picker_bottom_sheet.dart';
import 'package:ssoss_flutter/common/widgets/selection/ssoss_toggle.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/home/presentation/pages/home_page.dart';
import 'package:ssoss_flutter/features/onboarding/presentation/pages/onboarding_components.dart';
import 'package:ssoss_flutter/features/onboarding/presentation/pages/onboarding_store_info_complete_page.dart';

class OnboardingOperationInfoPage extends StatefulWidget {
  const OnboardingOperationInfoPage({super.key});

  static const String routeName = 'onboarding-operation-info';
  static const String routePath = '/onboarding/operation-info';

  @override
  State<OnboardingOperationInfoPage> createState() =>
      _OnboardingOperationInfoPageState();
}

class _OnboardingOperationInfoPageState
    extends State<OnboardingOperationInfoPage> {
  final Set<String> _selectedDays = {};
  String _openingTime = '00:00';
  String _closingTime = '00:00';
  final Map<_OnboardingFacilityType, bool> _facilities = {
    _OnboardingFacilityType.takeout: true,
    _OnboardingFacilityType.reservation: true,
    _OnboardingFacilityType.parking: false,
  };

  void _finishOnboarding() {
    context.go(HomePage.routePath);
  }

  void _toggleDay(String day) {
    setState(() {
      if (_selectedDays.contains(day)) {
        _selectedDays.remove(day);
        return;
      }
      _selectedDays.add(day);
    });
  }

  Future<void> _showTimePicker({required bool isOpeningTime}) async {
    final selected = await SsossTimePickerBottomSheet.show(context);

    if (!mounted || selected == null) {
      return;
    }

    setState(() {
      if (isOpeningTime) {
        _openingTime = selected;
        return;
      }
      _closingTime = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            OnboardingTopBar(
              showBackButton: true,
              onBack: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                  return;
                }
                context.go('/onboarding/store-info');
              },
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 6, 24, 24),
                children: [
                  const _OperationInfoTitle(),
                  const SizedBox(height: 28),
                  _OnboardingSection(
                    label: '영업 시간',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (final day in _weekdays)
                              _DayChip(
                                label: day,
                                isSelected: _selectedDays.contains(day),
                                onTap: () => _toggleDay(day),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _TimeBox(
                                label: _openingTime,
                                onTap: () => _showTimePicker(
                                  isOpeningTime: true,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            AppText(
                              '-',
                              style: AppTextStyles.b5.copyWith(
                                color: AppColors.neutral400,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _TimeBox(
                                label: _closingTime,
                                onTap: () => _showTimePicker(
                                  isOpeningTime: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  _OnboardingSection(
                    label: '편의 시설',
                    child: Column(
                      children: [
                        for (final type in _OnboardingFacilityType.values) ...[
                          _FacilityRow(
                            type: type,
                            isEnabled: _facilities[type] ?? false,
                            onChanged: (value) {
                              setState(() => _facilities[type] = value);
                            },
                          ),
                          if (type != _OnboardingFacilityType.values.last)
                            const SizedBox(height: 12),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            OnboardingActionBar(
              primaryLabel: '다음',
              showSkipButton: true,
              onPrimaryTap: () {
                unawaited(
                  context.push(OnboardingStoreInfoCompletePage.routePath),
                );
              },
              onSkipTap: _finishOnboarding,
            ),
          ],
        ),
      ),
    );
  }
}

const _weekdays = ['월', '화', '수', '목', '금', '토', '일'];

class _OperationInfoTitle extends StatelessWidget {
  const _OperationInfoTitle();

  @override
  Widget build(BuildContext context) {
    final baseStyle = AppTextStyles.h3.copyWith(color: AppColors.black);

    return RichText(
      text: TextSpan(
        style: baseStyle,
        children: [
          const TextSpan(text: '콘텐츠를 더 잘 만들 수 있게\n'),
          TextSpan(
            text: '운영 정보',
            style: baseStyle.copyWith(color: AppColors.primary400),
          ),
          const TextSpan(text: '를 입력해주세요'),
        ],
      ),
    );
  }
}

class _OnboardingSection extends StatelessWidget {
  const _OnboardingSection({
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          label,
          style: AppTextStyles.h5.copyWith(color: const Color(0xFF151515)),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foregroundColor =
        isSelected ? AppColors.primary500 : AppColors.neutral400;
    final borderColor =
        isSelected ? AppColors.primary300 : AppColors.neutral200;
    final backgroundColor = isSelected ? AppColors.primary50 : AppColors.white;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 38,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: AppText(
          label,
          style: AppTextStyles.h8.copyWith(color: foregroundColor),
        ),
      ),
    );
  }
}

class _TimeBox extends StatelessWidget {
  const _TimeBox({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.neutral200),
        ),
        child: AppText(
          label,
          style: AppTextStyles.b4.copyWith(color: AppColors.neutral500),
        ),
      ),
    );
  }
}

enum _OnboardingFacilityType {
  takeout('포장', '가능', AppAssets.icBag),
  reservation('예약', '가능', AppAssets.icCalendar),
  parking('주차', '불가', AppAssets.icParking);

  const _OnboardingFacilityType(this.label, this.status, this.iconPath);

  final String label;
  final String status;
  final String iconPath;
}

class _FacilityRow extends StatelessWidget {
  const _FacilityRow({
    required this.type,
    required this.isEnabled,
    required this.onChanged,
  });

  final _OnboardingFacilityType type;
  final bool isEnabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final statusColor = isEnabled ? AppColors.neutral600 : AppColors.neutral400;

    return SizedBox(
      height: 36,
      child: Row(
        children: [
          SvgPicture.asset(
            type.iconPath,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              AppColors.neutral600,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: AppText(
              type.label,
              style: AppTextStyles.h6.copyWith(
                color: AppColors.neutral600,
              ),
            ),
          ),
          AppText(
            isEnabled ? '가능' : type.status,
            style: AppTextStyles.b5.copyWith(color: statusColor),
          ),
          const SizedBox(width: 12),
          SsossToggle(
            isChecked: isEnabled,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
