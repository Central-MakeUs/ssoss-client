import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/features/auth/presentation/bloc/login_bloc.dart';
import 'package:ssoss_flutter/features/auth/presentation/bloc/login_event.dart';

/// 로그인 성공 후 진입하는 임시 홈 화면 (placeholder).
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String routeName = 'home';
  static const String routePath = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                '로그인 성공! (임시 홈 화면)',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: () {
                  context
                      .read<LoginBloc>()
                      .add(const LoginEvent.withdrawRequested());
                },
                icon: const Icon(Icons.link_off),
                label: const Text('회원 탈퇴'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  context
                      .read<LoginBloc>()
                      .add(const LoginEvent.logoutRequested());
                },
                child: const Text('로그아웃'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
