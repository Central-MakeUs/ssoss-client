import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/auth/domain/entities/social_provider.dart';
import 'package:ssoss_flutter/features/store/presentation/cubit/store_cubit.dart';
import 'package:ssoss_flutter/features/store/presentation/cubit/store_state.dart';

import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import '../widgets/apple_login_button.dart';
import '../widgets/naver_login_button.dart';

/// 로그인 진입 화면. 네이버·Apple 로그인 버튼을 제공하고 [LoginBloc] 상태를 구독한다.
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const String routeName = 'login';
  static const String routePath = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: BlocBuilder<StoreCubit, StoreState>(
          buildWhen: (previous, current) =>
              previous.isBootstrapped != current.isBootstrapped,
          builder: (context, storeState) {
            return BlocConsumer<LoginBloc, LoginState>(
              listenWhen: (previous, current) => current is LoginFailure,
              listener: (context, state) {
                if (state is LoginFailure) {
                  showSsossToast(
                    context,
                    title: state.message,
                    type: SsossToastType.error,
                  );
                }
              },
              builder: (context, state) {
                final loadingProvider = _loadingProvider(
                  authState: state,
                  isStoreBootstrapped: storeState.isBootstrapped,
                );
                final isNaverLoading =
                    loadingProvider == SocialProvider.naver;
                final isAppleLoading =
                    loadingProvider == SocialProvider.apple;
                final isAnyLoading = loadingProvider != null;

                return Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              AppAssets.appIcon,
                              width: 150,
                              height: 150,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 24),
                            Text.rich(
                              TextSpan(
                                style: AppTextStyles.h4.copyWith(
                                  color: AppColors.neutral800,
                                ),
                                children: [
                                  const TextSpan(text: '사장님의 콘텐츠 비법, '),
                                  TextSpan(
                                    text: '쏘쓰',
                                    style: AppTextStyles.h4.copyWith(
                                      color: AppColors.primary400,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 42),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          NaverLoginButton(
                            enabled: !isAnyLoading,
                            isLoading: isNaverLoading,
                            onPressed: () {
                              context.read<LoginBloc>().add(
                                    const LoginEvent.naverLoginRequested(),
                                  );
                            },
                          ),
                          const SizedBox(height: 12),
                          AppleLoginButton(
                            enabled: !isAnyLoading,
                            isLoading: isAppleLoading,
                            onPressed: () {
                              context.read<LoginBloc>().add(
                                    const LoginEvent.appleLoginRequested(),
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  /// 소셜 로그인 API 또는 이후 매장 정보 부트스트랩이 진행 중이면 해당 provider를 반환한다.
  static SocialProvider? _loadingProvider({
    required LoginState authState,
    required bool isStoreBootstrapped,
  }) {
    if (authState is LoginLoading) {
      return authState.provider;
    }
    if (authState is LoginAuthenticated && !isStoreBootstrapped) {
      return authState.user.provider;
    }
    return null;
  }
}
