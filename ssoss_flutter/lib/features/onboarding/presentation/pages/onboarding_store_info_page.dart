import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_address_search_field.dart';

import 'package:ssoss_flutter/common/widgets/input/ssoss_select_field.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_text_field.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/home/presentation/pages/home_page.dart';
import 'package:ssoss_flutter/features/onboarding/presentation/pages/onboarding_components.dart';
import 'package:ssoss_flutter/features/onboarding/presentation/pages/onboarding_operation_info_page.dart';
import 'package:ssoss_flutter/features/store/domain/entities/store_info.dart';
import 'package:ssoss_flutter/features/store/presentation/cubit/store_cubit.dart';

class OnboardingStoreInfoPage extends StatefulWidget {
  const OnboardingStoreInfoPage({super.key});

  static const String routeName = 'onboarding-store-info';
  static const String routePath = '/onboarding/store-info';

  @override
  State<OnboardingStoreInfoPage> createState() =>
      _OnboardingStoreInfoPageState();
}

class _OnboardingStoreInfoPageState extends State<OnboardingStoreInfoPage> {
  late final TextEditingController _storeNameController;
  late final TextEditingController _addressController;
  late final TextEditingController _introController;
  StoreType? _storeType;

  @override
  void initState() {
    super.initState();
    _storeNameController = TextEditingController();
    _addressController = TextEditingController();
    _introController = TextEditingController();
  }

  @override
  void dispose() {
    _storeNameController.dispose();
    _addressController.dispose();
    _introController.dispose();
    super.dispose();
  }

  Future<void> _showStoreTypePicker() async {
    final selected = await showModalBottomSheet<StoreType>(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  '매장 유형',
                  style: AppTextStyles.h5.copyWith(
                    color: AppColors.neutral800,
                  ),
                ),
                const SizedBox(height: 12),
                ...StoreType.values.map(
                  (type) => _StoreTypeOption(
                    label: type.label,
                    isSelected: type == _storeType,
                    onTap: () => Navigator.of(context).pop(type),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selected != null) {
      setState(() => _storeType = selected);
    }
  }

  Future<void> _saveBasicInfo() async {
    final storeType = _storeType;
    if (storeType == null) {
      showSsossToast(
        context,
        title: '매장 유형을 선택해 주세요',
        type: SsossToastType.warning,
      );
      return;
    }

    try {
      await context.read<StoreCubit>().saveBasic(
            StoreBasicInfoInput(
              name: _storeNameController.text,
              type: storeType,
              address: _addressController.text,
              introduction: _introController.text,
            ),
          );
      if (!mounted) return;
      unawaited(context.push(OnboardingOperationInfoPage.routePath));
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
        title: '매장 기본 정보를 저장하지 못했습니다.',
        type: SsossToastType.warning,
      );
    }
  }

  Future<void> _skipOnboarding() async {
    await context.read<StoreCubit>().completeOnboarding();
    if (!mounted) return;
    context.go(HomePage.routePath);
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
                context.go('/onboarding/intro');
              },
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 6, 24, 24),
                children: [
                  const _StoreInfoTitle(),
                  const SizedBox(height: 28),
                  _OnboardingFormField(
                    label: '매장명',
                    required: true,
                    child: SsossTextField(
                      controller: _storeNameController,
                      hintText: '매장명을 입력해주세요',
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _OnboardingFormField(
                    label: '매장 유형',
                    required: true,
                    child: SsossSelectField(
                      value: _storeType?.label,
                      placeholder: '선택해주세요',
                      onTap: () => unawaited(_showStoreTypePicker()),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _OnboardingFormField(
                    label: '주소',
                    required: true,
                    child: SsossAddressSearchField(
                      controller: _addressController,
                      hintText: '주소를 입력해주세요',
                    ),
                  ),
                  const SizedBox(height: 32),
                  _OnboardingFormField(
                    label: '매장 한 줄 소개',
                    optional: true,
                    child: SsossTextField(
                      controller: _introController,
                      hintText: '입력해주세요',
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ],
              ),
            ),
            OnboardingActionBar(
              primaryLabel: '다음',
              showSkipButton: true,
              isLoading: storeState.isSavingBasic,
              onPrimaryTap: () => unawaited(_saveBasicInfo()),
              onSkipTap: () => unawaited(_skipOnboarding()),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoreInfoTitle extends StatelessWidget {
  const _StoreInfoTitle();

  @override
  Widget build(BuildContext context) {
    final baseStyle = AppTextStyles.h3.copyWith(color: AppColors.black);

    return RichText(
      text: TextSpan(
        style: baseStyle,
        children: [
          const TextSpan(text: '콘텐츠를 더 잘 만들 수 있게\n'),
          TextSpan(
            text: '기본 정보',
            style: baseStyle.copyWith(color: AppColors.primary400),
          ),
          const TextSpan(text: '를 입력해주세요'),
        ],
      ),
    );
  }
}

class _OnboardingFormField extends StatelessWidget {
  const _OnboardingFormField({
    required this.label,
    required this.child,
    this.required = false,
    this.optional = false,
  });

  final String label;
  final Widget child;
  final bool required;
  final bool optional;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              label,
              style: AppTextStyles.h5.copyWith(color: const Color(0xFF151515)),
            ),
            if (required) ...[
              const SizedBox(width: 2),
              AppText(
                '*',
                style: AppTextStyles.h5.copyWith(
                  color: AppColors.primary600,
                ),
              ),
            ],
            if (optional) ...[
              const SizedBox(width: 8),
              AppText(
                '선택',
                style: AppTextStyles.b6.copyWith(
                  color: AppColors.neutral400,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _StoreTypeOption extends StatelessWidget {
  const _StoreTypeOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 48,
        alignment: Alignment.centerLeft,
        child: AppText(
          label,
          style: AppTextStyles.b4.copyWith(
            color: isSelected ? AppColors.primary500 : AppColors.neutral800,
          ),
        ),
      ),
    );
  }
}
