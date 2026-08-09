import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ssoss_flutter/common/widgets/input/ssoss_focused_input_scroller.dart';
import 'package:ssoss_flutter/common/widgets/picker/ssoss_time_picker_bottom_sheet.dart';
import 'package:ssoss_flutter/common/widgets/store_info/store_info_components.dart';
import 'package:ssoss_flutter/common/widgets/store_info/store_operation_info_form.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/home/presentation/pages/home_page.dart';
import 'package:ssoss_flutter/features/onboarding/presentation/pages/onboarding_components.dart';
import 'package:ssoss_flutter/features/onboarding/presentation/pages/onboarding_store_info_complete_page.dart';
import 'package:ssoss_flutter/features/store/domain/entities/store_info.dart';
import 'package:ssoss_flutter/features/store/presentation/cubit/store_cubit.dart';
import 'package:ssoss_flutter/utils/store_time_format.dart';

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
  final Map<StoreFacilityType, bool> _facilities = {
    StoreFacilityType.takeout: true,
    StoreFacilityType.reservation: true,
    StoreFacilityType.parking: false,
  };

  Future<void> _finishOnboarding() async {
    await context.read<StoreCubit>().completeOnboarding();
    if (!mounted) return;
    context.go(HomePage.routePath);
  }

  Future<void> _saveOperationInfo() async {
    try {
      final openTime = _openingTime == '00:00' ? null : _openingTime;
      final closeTime = _closingTime == '00:00' ? null : _closingTime;
      await context.read<StoreCubit>().saveOperation(
            StoreOperationInfoInput(
              businessDays: [
                for (final day in _selectedDays)
                  if (BusinessDay.fromLabel(day) != null)
                    BusinessDay.fromLabel(day)!,
              ],
              openTime: openTime,
              closeTime: closeTime,
              takeoutAvailable: _facilities[StoreFacilityType.takeout] ?? false,
              reservationAvailable:
                  _facilities[StoreFacilityType.reservation] ?? false,
              parkingAvailable: _facilities[StoreFacilityType.parking] ?? false,
            ),
          );
      if (!mounted) return;
      unawaited(context.push(OnboardingStoreInfoCompletePage.routePath));
    } on AppException catch (e) {
      if (!mounted) return;
      showSsossToast(
        context,
        title: e.message,
        type: SsossToastType.warning,
      );
    } catch (_) {
      if (!mounted) return;
      showSsossToast(
        context,
        title: '매장 운영 정보를 저장하지 못했습니다.',
        type: SsossToastType.warning,
      );
    }
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
    final selected = await SsossTimePickerBottomSheet.show(
      context,
      isOpeningTime: isOpeningTime,
      openingTime: _openingTime,
      closingTime: _closingTime,
    );

    if (!mounted || selected == null) {
      return;
    }

    final apiTime = StoreTimeFormat.toApi(selected);
    setState(() {
      if (isOpeningTime) {
        _openingTime = apiTime;
        return;
      }
      _closingTime = apiTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    final storeState = context.watch<StoreCubit>().state;

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
                padding: const EdgeInsets.fromLTRB(
                  24,
                  6,
                  24,
                  24 + kSsossFocusedInputScrollPaddingBottom,
                ),
                children: [
                  const _OperationInfoTitle(),
                  const SizedBox(height: 28),
                  StoreOperationInfoForm(
                    selectedDays: _selectedDays,
                    facilities: _facilities,
                    showSignatureMenus: false,
                    onDayTap: _toggleDay,
                    openingTime: StoreTimeFormat.toDisplay(_openingTime),
                    closingTime: StoreTimeFormat.toDisplay(_closingTime),
                    onOpeningTimeTap: () {
                      unawaited(_showTimePicker(isOpeningTime: true));
                    },
                    onClosingTimeTap: () {
                      unawaited(_showTimePicker(isOpeningTime: false));
                    },
                    onFacilityChanged: (type, value) {
                      setState(() => _facilities[type] = value);
                    },
                  ),
                ],
              ),
            ),
            OnboardingActionBar(
              primaryLabel: '다음',
              showSkipButton: true,
              isLoading: storeState.isSavingOperation,
              onPrimaryTap: () => unawaited(_saveOperationInfo()),
              onSkipTap: () => unawaited(_finishOnboarding()),
            ),
          ],
        ),
      ),
    );
  }
}

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
