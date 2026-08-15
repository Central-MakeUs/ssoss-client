import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_focused_input_scroller.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/auth/domain/entities/withdrawal_reason.dart';
import 'package:ssoss_flutter/features/auth/presentation/bloc/login_bloc.dart';
import 'package:ssoss_flutter/features/auth/presentation/bloc/login_event.dart';
import 'package:ssoss_flutter/features/auth/presentation/bloc/login_state.dart';
import 'package:ssoss_flutter/features/my_page/presentation/pages/withdraw/withdraw_reason_components.dart';

class WithdrawReasonPage extends StatefulWidget {
  const WithdrawReasonPage({super.key});

  @override
  State<WithdrawReasonPage> createState() => _WithdrawReasonPageState();
}

class _WithdrawReasonPageState extends State<WithdrawReasonPage> {
  int? _selectedIndex;
  bool _isSubmitting = false;
  late final TextEditingController _otherController;

  @override
  void initState() {
    super.initState();
    _otherController = TextEditingController();
  }

  @override
  void dispose() {
    _otherController.dispose();
    super.dispose();
  }

  WithdrawalReason? _buildReason() {
    final index = _selectedIndex;
    if (index == null) {
      return null;
    }

    final option = kWithdrawReasonOptions[index];
    if (option.reasonCode != WithdrawalReasonCode.other) {
      return WithdrawalReason(code: option.reasonCode);
    }

    final detail = _otherController.text.trim();
    return WithdrawalReason(
      code: option.reasonCode,
      detail: detail.isEmpty ? null : detail,
    );
  }

  Future<void> _onWithdraw() async {
    if (_isSubmitting || _selectedIndex == null) {
      return;
    }

    final reason = _buildReason();
    if (reason == null) {
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      await context.read<LoginBloc>().performWithdraw(reason: reason);
    } catch (_) {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) => current is LoginFailure,
      listener: (context, state) {
        if (state is! LoginFailure) {
          return;
        }
        showSsossToast(
          context,
          title: state.message,
          type: SsossToastType.error,
        );
        context.read<LoginBloc>().add(const LoginEvent.failureAcknowledged());
      },
      child: PopScope(
        canPop: !_isSubmitting,
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: Column(
              children: [
                SsossAppBar.back(
                  title: '',
                  onBack:
                      _isSubmitting ? () {} : () => Navigator.of(context).pop(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      6,
                      16,
                      24 + kSsossFocusedInputScrollPaddingBottom,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const WithdrawReasonHeader(),
                        const SizedBox(height: 48),
                        WithdrawReasonOptionList(
                          selectedIndex: _selectedIndex,
                          isDisabled: _isSubmitting,
                          otherController: _otherController,
                          onSelected: (index) {
                            if (_isSubmitting) {
                              return;
                            }
                            setState(() => _selectedIndex = index);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: SsossButton(
                    label: '계정 탈퇴하기',
                    type: SsossButtonType.primary,
                    width: double.infinity,
                    isLoading: _isSubmitting,
                    enabled: _selectedIndex != null,
                    onPressed: () => unawaited(_onWithdraw()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
