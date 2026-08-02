import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/modal/ssoss_modal.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/domain/entities/generation_detail.dart';
import 'package:ssoss_flutter/features/content/domain/repositories/content_repository.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/run_generation_usecase.dart';
import 'package:ssoss_flutter/features/content/presentation/cubit/content_generating_cubit.dart';
import 'package:ssoss_flutter/features/content/presentation/cubit/content_generating_state.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_create_flow.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_generation_args.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_other_channel_args.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_create_page.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_other_channel_create_page.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_result_page.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/content_generation_failure_view.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/content_generating_view.dart';
import 'package:ssoss_flutter/features/home/presentation/pages/home_page.dart';

/// 콘텐츠 생성 대기·실패 화면.
class ContentGeneratingPage extends StatefulWidget {
  const ContentGeneratingPage({
    required this.args,
    super.key,
  });

  static const String routeName = 'content-generating';
  static const String routePath = '/content/create/generating';

  final ContentGenerationArgs args;

  @override
  State<ContentGeneratingPage> createState() => _ContentGeneratingPageState();
}

class _ContentGeneratingPageState extends State<ContentGeneratingPage> {
  bool _isExitModalVisible = false;
  bool _isGenerationComplete = false;
  GenerationDetail? _completedDetail;

  ContentGenerationArgs get args => widget.args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContentGeneratingCubit(
        runGeneration: context.read<RunGenerationUseCase>(),
        contentRepository: context.read<ContentRepository>(),
      )..start(args.input),
      child: BlocListener<ContentGeneratingCubit, ContentGeneratingState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (detail) {
              _completedDetail = detail;
              if (_isExitModalVisible) {
                _isGenerationComplete = true;
                return;
              }
              _goToResult(detail);
            },
          );
        },
        child: BlocBuilder<ContentGeneratingCubit, ContentGeneratingState>(
          builder: (context, state) {
            final isFailure = state.maybeWhen(
              failure: (_) => true,
              orElse: () => false,
            );
            return PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, _) {
                if (didPop) {
                  return;
                }
                if (isFailure) {
                  _goBackToCreate(context);
                  return;
                }
                unawaited(
                  _onExitPressed(context.read<ContentGeneratingCubit>()),
                );
              },
              child: Scaffold(
                backgroundColor: AppColors.white,
                body: SafeArea(
                  child: state.when(
                    loading: () => _buildLoading(context),
                    success: (_) => _buildLoading(context),
                    failure: (message) => ContentGenerationFailureView(
                      onBack: () => _goBackToCreate(context),
                      onClose: () => context.go(HomePage.routePath),
                      onRetry: () =>
                          context.read<ContentGeneratingCubit>().start(
                                args.input,
                              ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _goBackToCreate(BuildContext context) {
    if (args.flow == ContentCreateFlow.otherChannel) {
      final sourceContentId = args.input.sourceContentId;
      if (sourceContentId != null && sourceContentId.isNotEmpty) {
        context.go(
          ContentOtherChannelCreatePage.routePath,
          extra: ContentOtherChannelArgs(
            sourceContentId: sourceContentId,
            excludedChannels: args.completedChannels,
            previousInput: args.input,
            initialSelected: args.input.channels,
          ),
        );
        return;
      }
    }
    context.go(
      ContentCreatePage.routePath,
      extra: args.input,
    );
  }

  Widget _buildLoading(BuildContext blocContext) {
    return Column(
      children: [
        SsossAppBar.exitOnly(
          onExit: () => unawaited(
            _onExitPressed(blocContext.read<ContentGeneratingCubit>()),
          ),
        ),
        const Expanded(child: ContentGeneratingView()),
      ],
    );
  }

  void _goToResult(GenerationDetail detail) {
    context.go(
      ContentResultPage.routePath,
      extra: args.copyWith(generationDetail: detail),
    );
  }

  /// [cubit]은 BlocProvider 하위 context에서 미리 읽어 전달한다.
  Future<void> _onExitPressed(ContentGeneratingCubit cubit) async {
    if (_isExitModalVisible) {
      return;
    }

    _isExitModalVisible = true;
    final result = await showSsossModal(
      context,
      title: '콘텐츠 생성을 중단할까요?',
      message: '지금 나가면 콘텐츠 생성이 중단되며\n생성 결과는 저장되지 않아요',
      primaryButtonLabel: '계속 생성하기',
      secondaryButtonLabel: '중단하기',
      showButtonIcons: false,
    );

    if (!mounted) {
      return;
    }

    _isExitModalVisible = false;

    if (result == SsossModalResult.secondary) {
      if (!cubit.isClosed) {
        cubit.cancel();
      }
      context.go(HomePage.routePath);
      return;
    }

    if (_isGenerationComplete && _completedDetail != null) {
      _goToResult(_completedDetail!);
    }
  }
}
