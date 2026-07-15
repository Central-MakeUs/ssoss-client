import 'dart:async';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'common/widgets/button/ssoss_button.dart';
import 'common/widgets/modal/ssoss_modal.dart';
import 'core/config/app_config.dart';
import 'core/network/network_providers.dart';
import 'core/network/session_expired_notifier.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login_with_apple_usecase.dart';
import 'features/auth/domain/usecases/login_with_naver_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/domain/usecases/restore_session_usecase.dart';
import 'features/auth/domain/usecases/withdraw_usecase.dart';
import 'features/auth/presentation/auth_providers.dart';
import 'features/auth/presentation/bloc/login_bloc.dart';
import 'features/auth/presentation/bloc/login_event.dart';
import 'features/auth/presentation/bloc/login_state.dart';
import 'features/content/presentation/content_providers.dart';
import 'router/app_router.dart';

class SsossApp extends StatefulWidget {
  const SsossApp({super.key});

  @override
  State<SsossApp> createState() => _SsossAppState();
}

class _SsossAppState extends State<SsossApp> {
  late final GoRouter _router;
  bool _isSessionExpiredModalVisible = false;

  @override
  void initState() {
    super.initState();
    _router = createAppRouter(context.read<LoginBloc>());
  }

  Future<void> _showSessionExpiredModal(BuildContext context) async {
    if (_isSessionExpiredModalVisible) return;
    _isSessionExpiredModalVisible = true;

    try {
      await showSsossModal(
        context,
        title: '세션이 만료되었습니다. 다시 로그인해 주세요.',
        showButtonIcons: false,
        barrierDismissible: false,
        actions: Builder(
          builder: (dialogContext) => SsossButton(
            label: '확인',
            size: SsossButtonSize.medium,
            type: SsossButtonType.primary,
            width: double.infinity,
            showLeftIcon: false,
            showRightIcon: false,
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
          ),
        ),
      );
    } finally {
      _isSessionExpiredModalVisible = false;
      if (context.mounted) {
        context.read<LoginBloc>().add(
              const LoginEvent.sessionExpiredAcknowledged(),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = AppConfig.instance;

    return MaterialApp.router(
      title: config.flavor.displayName,
      routerConfig: _router,
      builder: (context, child) {
        return BlocListener<LoginBloc, LoginState>(
          listenWhen: (previous, current) =>
              current is LoginSessionExpired &&
              previous is! LoginSessionExpired,
          listener: (context, state) {
            unawaited(_showSessionExpiredModal(context));
          },
          child: child ?? const SizedBox.shrink(),
        );
      },
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
        ...ContentProviders.build(),
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
            sessionExpiredNotifier: context.read<SessionExpiredNotifier>(),
          )..add(const LoginEvent.sessionRestoreRequested());
        },
        child: const SsossApp(),
      ),
    );
  }
}
