import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/modal/ssoss_modal.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/presentation/cubit/content_other_channel_create_cubit.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_create_flow.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_generation_args.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_generating_page.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/create/content_other_channel_info_banner.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/create/content_other_channel_select_list.dart';
import 'package:ssoss_flutter/features/home/presentation/pages/home_page.dart';

/// 다른 채널용 생성 — 채널 선택 화면.
class ContentOtherChannelCreatePage extends StatelessWidget {
  const ContentOtherChannelCreatePage({
    required this.baseInput,
    required this.completedChannels,
    super.key,
  });

  static const String routeName = 'content-other-channel-create';
  static const String routePath = '/content/create/other-channel';

  final ContentCreateInput baseInput;
  final List<UploadChannel> completedChannels;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContentOtherChannelCreateCubit(
        baseInput: baseInput,
        completedChannels: completedChannels,
      ),
      child: const _ContentOtherChannelCreateView(),
    );
  }
}

class _ContentOtherChannelCreateView extends StatelessWidget {
  const _ContentOtherChannelCreateView();

  Future<void> _confirmLeave(BuildContext context) async {
    final result = await showSsossModal(
      context,
      title: '홈화면으로 돌아가시겠어요?',
      message: '기존 생성 결과는 저장 되지 않아요',
      primaryButtonLabel: '다시 생성하기',
      secondaryButtonLabel: '취소',
      showButtonIcons: false,
    );

    if (result != SsossModalResult.primary || !context.mounted) {
      return;
    }

    context.go(HomePage.routePath);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContentOtherChannelCreateCubit,
        ContentOtherChannelCreateState>(
      builder: (context, state) {
        final cubit = context.read<ContentOtherChannelCreateCubit>();
        final completedChannels = UploadChannel.values
            .where((c) => !state.availableChannels.contains(c))
            .toList(growable: false);

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            if (didPop) {
              return;
            }
            unawaited(_confirmLeave(context));
          },
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: SafeArea(
              child: Column(
                children: [
                  SsossAppBar.back(
                    title: '다른 채널용 생성',
                    onBack: () => unawaited(_confirmLeave(context)),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const ContentOtherChannelInfoBanner(),
                          const SizedBox(height: 32),
                          ContentOtherChannelSelectList(
                            available: state.availableChannels,
                            selected: state.selected,
                            onToggle: cubit.toggleChannel,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: SsossButton(
                      label: '선택한 채널로 만들기',
                      width: double.infinity,
                      enabled: state.canSubmit,
                      onPressed: state.canSubmit
                          ? () {
                              final input = cubit.buildCreateInput();
                              if (input == null) {
                                return;
                              }
                              context.go(
                                ContentGeneratingPage.routePath,
                                extra: ContentGenerationArgs(
                                  input: input,
                                  flow: ContentCreateFlow.otherChannel,
                                  completedChannels: completedChannels,
                                ),
                              );
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
