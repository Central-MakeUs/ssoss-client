import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_focused_input_scroller.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_create_input.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_create_prefill.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/presentation/cubit/content_create_cubit.dart';
import 'package:ssoss_flutter/features/content/presentation/cubit/content_create_state.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_create_flow.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_generation_args.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_generating_page.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/create/content_create_progress_bar.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/create/content_create_step_channel.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/create/content_create_step_content.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/create/content_create_step_detail.dart';
import 'package:ssoss_flutter/features/home/presentation/pages/home_page.dart';

class ContentCreatePage extends StatelessWidget {
  const ContentCreatePage({
    super.key,
    this.initialChannel,
    this.restoredInput,
    this.prefill,
  });

  static const String routeName = 'content-create';
  static const String routePath = '/content/create';

  final UploadChannel? initialChannel;

  /// 생성 실패 후 복귀 시 이전 입력값.
  final ContentCreateInput? restoredInput;

  /// 매장 정보 등에서 가져온 신규 생성용 초기 입력값.
  final ContentCreatePrefill? prefill;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContentCreateCubit(
        initialChannel: initialChannel,
        restoredInput: restoredInput,
        prefill: prefill,
      ),
      child: const _ContentCreateView(),
    );
  }
}

class _ContentCreateView extends StatelessWidget {
  const _ContentCreateView();

  void _handleBack(BuildContext context) {
    final shouldLeave = context.read<ContentCreateCubit>().goBack();
    if (!shouldLeave) {
      return;
    }
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(HomePage.routePath);
    }
  }

  void _submit(BuildContext context) {
    final input = context.read<ContentCreateCubit>().buildCreateInput();
    if (input == null) {
      return;
    }
    context.go(
      ContentGeneratingPage.routePath,
      extra: ContentGenerationArgs(
        input: input,
        flow: ContentCreateFlow.initial,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContentCreateCubit, ContentCreateState>(
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            if (didPop) {
              return;
            }
            _handleBack(context);
          },
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: SafeArea(
              child: Column(
                children: [
                  SsossAppBar.back(
                    title: '콘텐츠 생성',
                    onBack: () => _handleBack(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: ContentCreateProgressBar(currentStep: state.step),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(
                        16,
                        20,
                        16,
                        24 + kSsossFocusedInputScrollPaddingBottom,
                      ),
                      child: switch (state.step) {
                        ContentCreateStep.channel => ContentCreateStepChannel(
                            selected: state.channels,
                            onToggle: context
                                .read<ContentCreateCubit>()
                                .toggleChannel,
                          ),
                        ContentCreateStep.content => ContentCreateStepContent(
                            selectedPurpose: state.purpose,
                            selectedTone: state.tone,
                            onSelectPurpose: context
                                .read<ContentCreateCubit>()
                                .selectPurpose,
                            onSelectTone:
                                context.read<ContentCreateCubit>().selectTone,
                          ),
                        ContentCreateStep.detail => ContentCreateStepDetail(
                            highlight: state.highlight,
                            forbidden: state.forbidden,
                            keywords: state.keywords,
                            photoGuideEnabled: state.photoGuideEnabled,
                            onHighlightChanged:
                                context.read<ContentCreateCubit>().setHighlight,
                            onForbiddenChanged:
                                context.read<ContentCreateCubit>().setForbidden,
                            onAddKeyword:
                                context.read<ContentCreateCubit>().addKeyword,
                            onRemoveKeyword: context
                                .read<ContentCreateCubit>()
                                .removeKeyword,
                            onTogglePhotoGuide: context
                                .read<ContentCreateCubit>()
                                .togglePhotoGuide,
                          ),
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: SsossButton(
                      label: state.step == ContentCreateStep.detail
                          ? '콘텐츠 생성하기'
                          : '다음',
                      width: double.infinity,
                      type: SsossButtonType.primary,
                      enabled: switch (state.step) {
                        ContentCreateStep.channel => state.canGoNextFromChannel,
                        ContentCreateStep.content => state.canGoNextFromContent,
                        ContentCreateStep.detail => state.canSubmit,
                      },
                      onPressed: () {
                        if (state.step == ContentCreateStep.detail) {
                          _submit(context);
                        } else {
                          context.read<ContentCreateCubit>().goNext();
                        }
                      },
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
