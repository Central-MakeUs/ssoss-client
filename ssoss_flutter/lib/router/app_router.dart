import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ssoss_flutter/features/auth/presentation/bloc/login_bloc.dart';
import 'package:ssoss_flutter/features/auth/presentation/bloc/login_state.dart';
import 'package:ssoss_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:ssoss_flutter/features/auth/presentation/pages/signup/signup_complete_page.dart';
import 'package:ssoss_flutter/features/auth/presentation/pages/signup/signup_terms_page.dart';
import 'package:ssoss_flutter/features/auth/presentation/pages/splash_page.dart';
import 'package:ssoss_flutter/features/auth/presentation/pages/withdraw/withdraw_complete_page.dart';
import 'package:ssoss_flutter/common/widgets/navigation/ssoss_navigation_bar.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_create_prefill.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_generation_args.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_other_channel_args.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_save_complete_args.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_save_complete_mode.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_args.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_create_page.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_edit_page.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_generating_page.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_other_channel_create_page.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_result_page.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_save_complete_page.dart';
import 'package:ssoss_flutter/features/new_style/presentation/models/new_style_args.dart';
import 'package:ssoss_flutter/features/new_style/presentation/pages/new_style_detail_page.dart';
import 'package:ssoss_flutter/features/home/presentation/models/home_route_extra.dart';
import 'package:ssoss_flutter/features/home/presentation/pages/home_page.dart';
import 'package:ssoss_flutter/features/recommend_source/presentation/pages/recommend_source_page.dart';
import 'package:ssoss_flutter/features/template/presentation/models/template_apply_args.dart';
import 'package:ssoss_flutter/features/template/presentation/pages/template_apply/template_apply_page.dart';
import 'package:ssoss_flutter/features/template/presentation/pages/template_detail/template_detail_page.dart';
import 'package:ssoss_flutter/features/template/presentation/pages/template_edit/template_edit_page.dart';
import 'package:ssoss_flutter/features/template/presentation/pages/template_save_complete/template_save_complete_page.dart';
import 'package:ssoss_flutter/features/template/presentation/widgets/template_models.dart';
import 'package:ssoss_flutter/features/onboarding/presentation/pages/onboarding_intro_page.dart';
import 'package:ssoss_flutter/features/onboarding/presentation/pages/onboarding_operation_info_page.dart';
import 'package:ssoss_flutter/features/onboarding/presentation/pages/onboarding_store_info_complete_page.dart';
import 'package:ssoss_flutter/features/onboarding/presentation/pages/onboarding_store_info_page.dart';
import 'package:ssoss_flutter/features/store/presentation/cubit/store_cubit.dart';

const bool _forceOnboardingForDebug = false;

/// [LoginBloc] 의 인증 상태에 따라 스플래시/로그인/홈으로 분기하는 라우터를 생성한다.
///
/// 새 화면 추가 시 이 파일의 `routes` 에 라우트를 등록한다.
GoRouter createAppRouter(
  LoginBloc loginBloc, {
  required StoreCubit storeCubit,
  GlobalKey<NavigatorState>? navigatorKey,
}) {
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: SplashPage.routePath,
    refreshListenable: _GoRouterRefreshStream([
      loginBloc.stream,
      storeCubit.stream,
    ]),
    redirect: (context, state) {
      final authState = loginBloc.state;
      final location = state.matchedLocation;
      final isOnSplash = location == SplashPage.routePath;
      final isOnLogin = location == LoginPage.routePath;
      final isOnSignupTerms = location == SignupTermsPage.routePath;
      final isOnSignupComplete = location == SignupCompletePage.routePath;
      final isOnWithdrawComplete = location == WithdrawCompletePage.routePath;
      final isOnOnboarding = location == OnboardingIntroPage.routePath;
      final isOnOnboardingStoreInfo =
          location == OnboardingStoreInfoPage.routePath;
      final isOnOnboardingOperationInfo =
          location == OnboardingOperationInfoPage.routePath;
      final isOnOnboardingStoreInfoComplete =
          location == OnboardingStoreInfoCompletePage.routePath;
      final isOnSignupFlow = isOnSignupTerms || isOnSignupComplete;
      final isOnOnboardingFlow = isOnOnboarding ||
          isOnOnboardingStoreInfo ||
          isOnOnboardingOperationInfo ||
          isOnOnboardingStoreInfoComplete;

      // 세션 복원 중에는 스플래시에 머문다 (로그인 화면 플래시 방지).
      final isResolvingAuth =
          authState is LoginInitial || authState is LoginRestoring;
      if (isResolvingAuth) {
        return isOnSplash ? null : SplashPage.routePath;
      }

      // 로그인 진행·실패(설정 탈퇴 실패 포함) 중에는 현재 화면 유지.
      if (authState is LoginLoading || authState is LoginFailure) {
        return null;
      }

      if (authState is LoginPendingSignup) {
        return isOnSignupTerms ? null : SignupTermsPage.routePath;
      }

      if (authState is LoginSignupComplete) {
        return isOnSignupComplete ? null : SignupCompletePage.routePath;
      }

      if (authState is LoginWithdrawComplete) {
        return isOnWithdrawComplete ? null : WithdrawCompletePage.routePath;
      }

      final isAuthenticated = authState is LoginAuthenticated;

      if (!isAuthenticated) {
        if (isOnLogin) return null;
        if (isOnSignupFlow || isOnOnboardingFlow) {
          return LoginPage.routePath;
        }
        return LoginPage.routePath;
      }

      final storeState = storeCubit.state;
      if (!storeState.isBootstrapped) {
        // 로그인 화면에서는 스플래시로 보내지 않고 버튼 로딩을 유지한다.
        if (isOnLogin || isOnSplash) return null;
        return SplashPage.routePath;
      }

      if (_forceOnboardingForDebug || storeState.shouldShowOnboarding) {
        if (isOnOnboardingFlow) return null;
        return OnboardingIntroPage.routePath;
      }

      if (isOnLogin ||
          isOnSplash ||
          isOnSignupFlow ||
          isOnWithdrawComplete ||
          isOnOnboardingFlow) {
        return HomePage.routePath;
      }
      return null;
    },
    routes: [
      GoRoute(
        name: SplashPage.routeName,
        path: SplashPage.routePath,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        name: LoginPage.routeName,
        path: LoginPage.routePath,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: SignupTermsPage.routeName,
        path: SignupTermsPage.routePath,
        builder: (context, state) => const SignupTermsPage(),
      ),
      GoRoute(
        name: SignupCompletePage.routeName,
        path: SignupCompletePage.routePath,
        builder: (context, state) => const SignupCompletePage(),
      ),
      GoRoute(
        name: WithdrawCompletePage.routeName,
        path: WithdrawCompletePage.routePath,
        builder: (context, state) => const WithdrawCompletePage(),
      ),
      GoRoute(
        name: OnboardingIntroPage.routeName,
        path: OnboardingIntroPage.routePath,
        builder: (context, state) => const OnboardingIntroPage(),
      ),
      GoRoute(
        name: OnboardingStoreInfoPage.routeName,
        path: OnboardingStoreInfoPage.routePath,
        builder: (context, state) => const OnboardingStoreInfoPage(),
      ),
      GoRoute(
        name: OnboardingOperationInfoPage.routeName,
        path: OnboardingOperationInfoPage.routePath,
        builder: (context, state) => const OnboardingOperationInfoPage(),
      ),
      GoRoute(
        name: OnboardingStoreInfoCompletePage.routeName,
        path: OnboardingStoreInfoCompletePage.routePath,
        builder: (context, state) => const OnboardingStoreInfoCompletePage(),
      ),
      GoRoute(
        name: HomePage.routeName,
        path: HomePage.routePath,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is HomeRouteExtra) {
            return HomePage(
              key: ValueKey('${extra.tab}_${extra.managementSection}'),
              initialTab: extra.tab,
              initialManagementSection: extra.managementSection,
            );
          }
          final initialTab = extra is SsossNavigationItem
              ? extra
              : SsossNavigationItem.contentCreation;
          return HomePage(
            key: ValueKey(initialTab),
            initialTab: initialTab,
          );
        },
      ),
      GoRoute(
        name: ContentCreatePage.routeName,
        path: ContentCreatePage.routePath,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is ContentCreateInput) {
            return ContentCreatePage(restoredInput: extra);
          }
          final channel = extra is UploadChannel ? extra : null;
          return ContentCreatePage(
            initialChannel: channel,
            prefill: _contentCreatePrefill(storeCubit),
          );
        },
      ),
      GoRoute(
        name: ContentOtherChannelCreatePage.routeName,
        path: ContentOtherChannelCreatePage.routePath,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is! ContentOtherChannelArgs) {
            return const ContentCreatePage();
          }
          return ContentOtherChannelCreatePage(args: extra);
        },
      ),
      GoRoute(
        name: NewStyleDetailPage.routeName,
        path: NewStyleDetailPage.routePath,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is NewStyleDetailRouteArgs) {
            return NewStyleDetailPage(routeArgs: extra);
          }
          if (extra is NewStyleArgs) {
            return NewStyleDetailPage(
              routeArgs: NewStyleDetailRouteArgs(args: extra),
            );
          }
          return const ContentCreatePage();
        },
      ),
      GoRoute(
        name: ContentGeneratingPage.routeName,
        path: ContentGeneratingPage.routePath,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is! ContentGenerationArgs) {
            return const ContentCreatePage();
          }
          return ContentGeneratingPage(args: extra);
        },
      ),
      GoRoute(
        name: ContentResultPage.routeName,
        path: ContentResultPage.routePath,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is! ContentGenerationArgs) {
            return const ContentCreatePage();
          }
          return ContentResultPage(args: extra);
        },
      ),
      GoRoute(
        name: ContentEditPage.routeName,
        path: ContentEditPage.routePath,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is! ContentEditArgs) {
            return const ContentCreatePage();
          }
          return ContentEditPage(args: extra);
        },
      ),
      GoRoute(
        name: ContentSaveCompletePage.routeName,
        path: ContentSaveCompletePage.routePath,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is ContentSaveCompleteArgs) {
            return ContentSaveCompletePage(args: extra);
          }
          if (extra is ContentSaveCompleteMode) {
            return ContentSaveCompletePage(
              args: ContentSaveCompleteArgs(mode: extra),
            );
          }
          return const ContentSaveCompletePage(
            args: ContentSaveCompleteArgs(
              mode: ContentSaveCompleteMode.finalSave,
            ),
          );
        },
      ),
      GoRoute(
        name: RecommendSourcePage.routeName,
        path: RecommendSourcePage.routePath,
        builder: (context, state) {
          final extra = state.extra;
          final initialCategory =
              extra is TemplateCategory ? extra : TemplateCategory.all;
          return RecommendSourcePage(
            initialCategory: initialCategory,
          );
        },
      ),
      GoRoute(
        name: TemplateDetailPage.routeName,
        path: TemplateDetailPage.routePath,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is! int) {
            return const RecommendSourcePage();
          }
          return TemplateDetailPage(templateId: extra);
        },
      ),
      GoRoute(
        name: TemplateApplyPage.routeName,
        path: TemplateApplyPage.routePath,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is! TemplateApplyArgs) {
            return const RecommendSourcePage();
          }
          return TemplateApplyPage(args: extra);
        },
      ),
      GoRoute(
        name: TemplateEditPage.routeName,
        path: TemplateEditPage.routePath,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is! TemplateEditArgs) {
            return const RecommendSourcePage();
          }
          return TemplateEditPage(args: extra);
        },
      ),
      GoRoute(
        name: TemplateSaveCompletePage.routeName,
        path: TemplateSaveCompletePage.routePath,
        builder: (context, state) => const TemplateSaveCompletePage(),
      ),
    ],
  );
}

ContentCreatePrefill? _contentCreatePrefill(StoreCubit storeCubit) {
  final content = storeCubit.state.info.content;
  final prefill = ContentCreatePrefill(
    tone: content.tone,
    forbidden: content.forbidden,
    keywords: List<String>.of(content.keywords),
  );
  return prefill.isEmpty ? null : prefill;
}

/// Bloc/Stream 의 변경을 go_router 의 `refreshListenable` 로 연결하는 어댑터.
class _GoRouterRefreshStream extends ChangeNotifier {
  _GoRouterRefreshStream(List<Stream<dynamic>> streams) {
    notifyListeners();
    _subscriptions = [
      for (final stream in streams)
        stream.asBroadcastStream().listen((_) => notifyListeners()),
    ];
  }

  late final List<StreamSubscription<dynamic>> _subscriptions;

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      unawaited(subscription.cancel());
    }
    super.dispose();
  }
}
