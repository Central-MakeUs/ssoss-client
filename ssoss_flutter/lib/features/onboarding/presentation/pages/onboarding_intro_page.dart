import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ssoss_flutter/features/home/presentation/pages/home_page.dart';
import 'package:ssoss_flutter/features/onboarding/presentation/pages/onboarding_components.dart';
import 'package:ssoss_flutter/features/onboarding/presentation/pages/onboarding_store_info_page.dart';
import 'package:ssoss_flutter/features/store/presentation/cubit/store_cubit.dart';

class OnboardingIntroPage extends StatefulWidget {
  const OnboardingIntroPage({super.key});

  static const String routeName = 'onboarding-intro';
  static const String routePath = '/onboarding/intro';

  @override
  State<OnboardingIntroPage> createState() => _OnboardingIntroPageState();
}

class _OnboardingIntroPageState extends State<OnboardingIntroPage> {
  static const int _indicatorCount = 4;
  static const Duration _pageDuration = Duration(milliseconds: 420);
  static const Curve _pageCurve = Curves.easeOutCubic;

  late final PageController _pageController;
  int _currentIndex = 0;

  bool get _isFirstPage => _currentIndex == 0;
  bool get _isLastImplementedPage =>
      _currentIndex == OnboardingPages.items.length - 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _goToPreviousPage() async {
    if (_isFirstPage) {
      return;
    }
    await _pageController.previousPage(
      duration: _pageDuration,
      curve: _pageCurve,
    );
  }

  Future<void> _goToNextPage() async {
    if (_isLastImplementedPage) {
      unawaited(context.push(OnboardingStoreInfoPage.routePath));
      return;
    }
    await _pageController.nextPage(
      duration: _pageDuration,
      curve: _pageCurve,
    );
  }

  Future<void> _finishOnboarding() async {
    await context.read<StoreCubit>().completeOnboarding();
    if (!mounted) return;
    context.go(HomePage.routePath);
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = OnboardingPages.items[_currentIndex];

    return OnboardingScaffold(
      data: currentPage,
      topBar: OnboardingTopBar(
        showBackButton: !_isFirstPage,
        onBack: () => unawaited(_goToPreviousPage()),
      ),
      pageView: PageView.builder(
        controller: _pageController,
        itemCount: OnboardingPages.items.length,
        physics: const ClampingScrollPhysics(),
        onPageChanged: (index) => setState(() => _currentIndex = index),
        itemBuilder: (context, index) {
          return OnboardingAnimatedPage(
            key: ValueKey(OnboardingPages.items[index].imagePath),
            data: OnboardingPages.items[index],
            isActive: index == _currentIndex,
          );
        },
      ),
      bottomBar: OnboardingBottomBar(
        currentIndex: _isFirstPage ? 0 : _currentIndex - 1,
        indicatorCount: _indicatorCount,
        primaryLabel: _isFirstPage ? '시작하기' : '다음',
        showSkipButton: !_isFirstPage,
        onPrimaryTap: () => unawaited(_goToNextPage()),
        onSkipTap: () => unawaited(_finishOnboarding()),
      ),
    );
  }
}
