import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/create/content_create_step_channel.dart';
import 'package:ssoss_flutter/features/new_style/presentation/cubit/new_style_channel_cubit.dart';
import 'package:ssoss_flutter/features/new_style/presentation/cubit/new_style_channel_state.dart';
import 'package:ssoss_flutter/features/new_style/presentation/models/new_style_args.dart';
import 'package:ssoss_flutter/features/new_style/presentation/pages/new_style_detail_page.dart';

/// 이 스타일로 새로 만들기 — 채널 선택.
class NewStyleChannelPage extends StatelessWidget {
  const NewStyleChannelPage({
    required this.args,
    super.key,
  });

  static const String routeName = 'new-style';
  static const String routePath = '/new-style';

  final NewStyleArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewStyleChannelCubit(),
      child: _NewStyleChannelView(args: args),
    );
  }
}

class _NewStyleChannelView extends StatelessWidget {
  const _NewStyleChannelView({required this.args});

  final NewStyleArgs args;

  void _goNext(BuildContext context, NewStyleChannelState state) {
    if (!state.canGoNext) {
      return;
    }
    unawaited(
      context.push(
        NewStyleDetailPage.routePath,
        extra: NewStyleDetailArgs(
          source: args,
          channels: List.of(state.channels),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewStyleChannelCubit, NewStyleChannelState>(
      builder: (context, state) {
        final cubit = context.read<NewStyleChannelCubit>();

        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: Column(
              children: [
                SsossAppBar.back(
                  title: '채널 선택',
                  onBack: () => context.pop(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                    child: ContentCreateStepChannel(
                      selected: state.channels,
                      onToggle: cubit.toggleChannel,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: SsossButton(
                    label: '다음',
                    width: double.infinity,
                    type: SsossButtonType.primary,
                    enabled: state.canGoNext,
                    onPressed: state.canGoNext
                        ? () => _goNext(context, state)
                        : null,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
