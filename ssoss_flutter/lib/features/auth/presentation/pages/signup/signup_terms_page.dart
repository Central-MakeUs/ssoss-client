import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/selection/ssoss_checkbox.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/auth/domain/entities/social_provider.dart';
import 'package:ssoss_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:ssoss_flutter/features/auth/domain/usecases/signup_usecase.dart';
import 'package:ssoss_flutter/features/auth/presentation/bloc/login_bloc.dart';
import 'package:ssoss_flutter/features/auth/presentation/bloc/login_event.dart';
import 'package:ssoss_flutter/features/auth/presentation/bloc/login_state.dart';
import 'package:ssoss_flutter/features/auth/presentation/cubit/signup_terms_cubit.dart';
import 'package:ssoss_flutter/features/auth/presentation/cubit/signup_terms_state.dart';
import 'package:ssoss_flutter/features/auth/presentation/widgets/signup/signup_terms_components.dart';

class SignupTermsPage extends StatelessWidget {
  const SignupTermsPage({super.key});

  static const String routeName = 'signup-terms';
  static const String routePath = '/signup/terms';

  @override
  Widget build(BuildContext context) {
    final loginState = context.watch<LoginBloc>().state;
    if (loginState is! LoginPendingSignup) {
      return const SizedBox.shrink();
    }

    return BlocProvider(
      create: (context) => SignupTermsCubit(
        SignupUseCase(context.read<AuthRepository>()),
      ),
      child: _SignupTermsView(
        provider: loginState.user.provider,
        email: loginState.email,
      ),
    );
  }
}

class _SignupTermsView extends StatelessWidget {
  const _SignupTermsView({
    required this.provider,
    required this.email,
  });

  final SocialProvider provider;
  final String email;

  Future<void> _onBack(BuildContext context) async {
    context.read<LoginBloc>().add(const LoginEvent.logoutRequested());
  }

  Future<void> _onSubmit(BuildContext context) async {
    final cubit = context.read<SignupTermsCubit>();
    try {
      final session = await cubit.submit();
      if (!context.mounted) {
        return;
      }
      context.read<LoginBloc>().notifySignupSucceeded(session.user);
    } on AppException catch (e) {
      if (!context.mounted) {
        return;
      }
      showSsossToast(
        context,
        title: e.message,
        type: SsossToastType.error,
      );
    } catch (_) {
      if (!context.mounted) {
        return;
      }
      showSsossToast(
        context,
        title: '회원가입 중 오류가 발생했습니다.',
        type: SsossToastType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            SsossAppBar.back(
              title: '',
              onBack: () => unawaited(_onBack(context)),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                child: BlocBuilder<SignupTermsCubit, SignupTermsState>(
                  builder: (context, state) {
                    final cubit = context.read<SignupTermsCubit>();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SignupProviderHeader(provider: provider),
                        const SizedBox(height: 18),
                        SignupEmailField(email: email),
                        const SizedBox(height: 40),
                        SsossCheckbox(
                          isChecked: state.agreeAll,
                          label: '아래 약관에 모두 동의합니다',
                          gap: 14,
                          iconSize: 20,
                          textStyle: AppTextStyles.h6.copyWith(
                            color: AppColors.neutral600,
                          ),
                          onTap: cubit.toggleAgreeAll,
                        ),
                        const SizedBox(height: 20),
                        const SignupTermsDivider(),
                        const SizedBox(height: 20),
                        SsossCheckbox(
                          isChecked: state.age14,
                          label: '본인은 만 14세 이상입니다 (필수)',
                          gap: 14,
                          iconSize: 20,
                          textStyle: AppTextStyles.b4.copyWith(
                            color: AppColors.neutral600,
                          ),
                          onTap: cubit.toggleAge14,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: SsossCheckbox(
                                isChecked: state.serviceTerms,
                                label: '서비스 이용 약관 (필수)',
                                gap: 14,
                                iconSize: 20,
                                textStyle: AppTextStyles.b4.copyWith(
                                  color: AppColors.neutral600,
                                ),
                                onTap: cubit.toggleServiceTerms,
                              ),
                            ),
                            const SignupTermsViewLink(),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: SsossCheckbox(
                                isChecked: state.privacyPolicy,
                                label: '개인정보 수집 및 이용 (필수)',
                                gap: 14,
                                iconSize: 20,
                                textStyle: AppTextStyles.b4.copyWith(
                                  color: AppColors.neutral600,
                                ),
                                onTap: cubit.togglePrivacyPolicy,
                              ),
                            ),
                            const SignupTermsViewLink(),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            BlocBuilder<SignupTermsCubit, SignupTermsState>(
              builder: (context, state) {
                return Container(
                  width: double.infinity,
                  color: AppColors.neutral50,
                  padding: const EdgeInsets.fromLTRB(24, 4, 24, 0),
                  child: SsossButton(
                    label: '다음',
                    width: double.infinity,
                    enabled: state.canSubmit,
                    isLoading: state.isSubmitting,
                    onPressed: () => unawaited(_onSubmit(context)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
