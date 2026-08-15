import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ssoss_flutter/common/widgets/input/ssoss_focused_input_scroller.dart';
import 'package:ssoss_flutter/common/widgets/store_info/store_basic_info_form.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/exception/app_exception.dart';
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
  String? _storeType;

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

  Future<void> _saveBasicInfo() async {
    final type = StoreType.fromLabel(_storeType);
    if (type == null) {
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
              type: type,
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
                padding: const EdgeInsets.fromLTRB(
                  24,
                  6,
                  24,
                  24 + kSsossFocusedInputScrollPaddingBottom,
                ),
                children: [
                  const _StoreInfoTitle(),
                  const SizedBox(height: 28),
                  StoreBasicInfoForm(
                    storeNameController: _storeNameController,
                    addressController: _addressController,
                    introController: _introController,
                    storeType: _storeType,
                    markRequiredFields: true,
                    onStoreTypeSelected: (value) {
                      setState(() => _storeType = value);
                    },
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
