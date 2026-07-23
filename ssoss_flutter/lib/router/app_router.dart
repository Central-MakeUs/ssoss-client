import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import 'package:ssoss_flutter/features/auth/presentation/bloc/login_bloc.dart';
import 'package:ssoss_flutter/features/auth/presentation/bloc/login_state.dart';
import 'package:ssoss_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:ssoss_flutter/features/auth/presentation/pages/signup/signup_complete_page.dart';
import 'package:ssoss_flutter/features/auth/presentation/pages/signup/signup_terms_page.dart';
import 'package:ssoss_flutter/features/auth/presentation/pages/splash_page.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_generation_args.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_save_complete_args.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_save_complete_mode.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_args.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_create_page.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_edit_page.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_generating_page.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_other_channel_create_page.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_result_page.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_save_complete_page.dart';
import 'package:ssoss_flutter/features/home/presentation/pages/home_page.dart';

/// [LoginBloc] 의 인증 상태에 따라 스플래시/로그인/홈으로 분기하는 라우터를 생성한다.
///
/// 새 화면 추가 시 이 파일의 `routes` 에 라우트를 등록한다.
GoRouter createAppRouter(LoginBloc loginBloc) {
  return GoRouter(
    initialLocation: SplashPage.routePath,
    refreshListenable: _GoRouterRefreshStream(loginBloc.stream),
    redirect: (context, state) {
      final authState = loginBloc.state;
      final location = state.matchedLocation;
      final isOnSplash = location == SplashPage.routePath;
      final isOnLogin = location == LoginPage.routePath;
      final isOnSignupTerms = location == SignupTermsPage.routePath;
      final isOnSignupComplete = location == SignupCompletePage.routePath;
      final isOnSignupFlow = isOnSignupTerms || isOnSignupComplete;

      // 세션 복원 중에는 스플래시에 머문다 (로그인 화면 플래시 방지).
      final isResolvingAuth =
          authState is LoginInitial || authState is LoginRestoring;
      if (isResolvingAuth) {
        return isOnSplash ? null : SplashPage.routePath;
      }

      // 세션 만료 모달 표시 중에는 현재 라우트 유지.
      if (authState is LoginSessionExpired) {
        return null;
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

      final isAuthenticated = authState is LoginAuthenticated;

      if (!isAuthenticated) {
        if (isOnLogin) return null;
        if (isOnSignupFlow) return LoginPage.routePath;
        return LoginPage.routePath;
      }

      if (isOnLogin || isOnSplash || isOnSignupFlow) {
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
        name: HomePage.routeName,
        path: HomePage.routePath,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        name: ContentCreatePage.routeName,
        path: ContentCreatePage.routePath,
        builder: (context, state) {
          final channel = state.extra is UploadChannel
              ? state.extra! as UploadChannel
              : null;
          return ContentCreatePage(initialChannel: channel);
        },
      ),
      GoRoute(
        name: ContentOtherChannelCreatePage.routeName,
        path: ContentOtherChannelCreatePage.routePath,
        builder: (context, state) {
          final previous = state.extra;
          if (previous is! ContentCreateInput) {
            return const ContentCreatePage();
          }
          return ContentOtherChannelCreatePage(
            baseInput: previous,
            completedChannels: previous.channels,
          );
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
    ],
  );
}

/// Bloc/Stream 의 변경을 go_router 의 `refreshListenable` 로 연결하는 어댑터.
class _GoRouterRefreshStream extends ChangeNotifier {
  _GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (_) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    super.dispose();
  }
}
