import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'core/config/app_config.dart';
import 'core/network/network_providers.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login_with_apple_usecase.dart';
import 'features/auth/domain/usecases/login_with_naver_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/domain/usecases/restore_session_usecase.dart';
import 'features/auth/domain/usecases/withdraw_usecase.dart';
import 'features/auth/presentation/auth_providers.dart';
import 'features/auth/presentation/bloc/login_bloc.dart';
import 'features/auth/presentation/bloc/login_event.dart';
import 'router/app_router.dart';

class SsossApp extends StatefulWidget {
  const SsossApp({super.key});

  @override
  State<SsossApp> createState() => _SsossAppState();
}

class _SsossAppState extends State<SsossApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = createAppRouter(context.read<LoginBloc>());
  }

  @override
  Widget build(BuildContext context) {
    final config = AppConfig.instance;

    return MaterialApp.router(
      title: config.flavor.displayName,
      routerConfig: _router,
      localizationsDelegates: const [
        AppFlowyEditorLocalizations.delegate,
      ],
      supportedLocales: AppFlowyEditorLocalizations.delegate.supportedLocales,
    );
  }
}

class SsossAppScope extends StatelessWidget {
  const SsossAppScope({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...NetworkProviders.build(),
        ...AuthProviders.build(),
      ],
      child: BlocProvider<LoginBloc>(
        create: (context) {
          final repository = context.read<AuthRepository>();
          return LoginBloc(
            loginWithNaver: LoginWithNaverUseCase(repository),
            loginWithApple: LoginWithAppleUseCase(repository),
            withdraw: WithdrawUseCase(repository),
            logout: LogoutUseCase(repository),
            restoreSession: RestoreSessionUseCase(repository),
          )..add(const LoginEvent.sessionRestoreRequested());
        },
        child: const SsossApp(),
      ),
    );
  }
}
