import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/core/config/app_config.dart';

import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import '../widgets/naver_login_button.dart';

/// 로그인 진입 화면. 네이버 로그인 버튼을 제공하고 [LoginBloc] 상태를 구독한다.
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const String routeName = 'login';
  static const String routePath = '/login';

  @override
  Widget build(BuildContext context) {
    final config = AppConfig.instance;

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          listenWhen: (previous, current) => current is LoginFailure,
          listener: (context, state) {
            if (state is LoginFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            final isLoading = state is LoginLoading;
            final errorMessage =
                state is LoginFailure ? state.message : null;

            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      config.flavor.displayName,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '네이버 계정으로 간편하게 시작하세요.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 40),
                    NaverLoginButton(
                      enabled: !isLoading,
                      onPressed: () {
                        context
                            .read<LoginBloc>()
                            .add(const LoginEvent.naverLoginRequested());
                      },
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 40,
                      child: isLoading
                          ? const Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            )
                          : errorMessage != null
                              ? Text(
                                  '오류: $errorMessage',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error,
                                      ),
                                )
                              : null,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
