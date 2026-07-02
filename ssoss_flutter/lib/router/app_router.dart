import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import 'package:ssoss_flutter/features/auth/presentation/bloc/login_bloc.dart';
import 'package:ssoss_flutter/features/auth/presentation/bloc/login_state.dart';
import 'package:ssoss_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:ssoss_flutter/features/home/presentation/pages/home_page.dart';

/// [LoginBloc] 의 인증 상태에 따라 로그인/홈으로 분기하는 라우터를 생성한다.
///
/// 새 화면 추가 시 이 파일의 `routes` 에 라우트를 등록한다.
GoRouter createAppRouter(LoginBloc loginBloc) {
  return GoRouter(
    initialLocation: LoginPage.routePath,
    refreshListenable: _GoRouterRefreshStream(loginBloc.stream),
    redirect: (context, state) {
      final isAuthenticated = loginBloc.state is LoginAuthenticated;
      final isOnLogin = state.matchedLocation == LoginPage.routePath;

      if (!isAuthenticated) {
        return isOnLogin ? null : LoginPage.routePath;
      }
      if (isOnLogin) {
        return HomePage.routePath;
      }
      return null;
    },
    routes: [
      GoRoute(
        name: LoginPage.routeName,
        path: LoginPage.routePath,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: HomePage.routeName,
        path: HomePage.routePath,
        builder: (context, state) => const HomePage(),
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
