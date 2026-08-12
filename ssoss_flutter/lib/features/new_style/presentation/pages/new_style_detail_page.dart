import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_create_flow.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_generation_args.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_generating_page.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/create/content_create_step_detail.dart';
import 'package:ssoss_flutter/features/new_style/presentation/cubit/new_style_detail_cubit.dart';
import 'package:ssoss_flutter/features/new_style/presentation/cubit/new_style_detail_state.dart';
import 'package:ssoss_flutter/features/new_style/presentation/models/new_style_args.dart';
import 'package:ssoss_flutter/features/new_style/presentation/widgets/new_style_reference_section.dart';

/// 이 스타일로 새로 만들기 — 상세 입력.
class NewStyleDetailPage extends StatelessWidget {
  const NewStyleDetailPage({
    required this.routeArgs,
    super.key,
  });

  static const String routeName = 'new-style';
  static const String routePath = '/new-style';

  final NewStyleDetailRouteArgs routeArgs;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewStyleDetailCubit(
        args: routeArgs.args,
        restoredInput: routeArgs.restoredInput,
      ),
      child: const _NewStyleDetailView(),
    );
  }
}

class _NewStyleDetailView extends StatelessWidget {
  const _NewStyleDetailView();

  void _submit(BuildContext context) {
    final cubit = context.read<NewStyleDetailCubit>();
    final input = cubit.buildCreateInput();
    if (input == null || cubit.buildStyleReuseInput() == null) {
      return;
    }
    final args = cubit.args;
    context.go(
      ContentGeneratingPage.routePath,
      extra: ContentGenerationArgs(
        input: input,
        flow: ContentCreateFlow.styleReuse,
        styleReuseContentChannelId: args.contentChannelId,
        newStyleArgs: args,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewStyleDetailCubit, NewStyleDetailState>(
      builder: (context, state) {
        final cubit = context.read<NewStyleDetailCubit>();

        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: Column(
              children: [
                SsossAppBar.back(
                  title: '콘텐츠 생성',
                  onBack: () => context.pop(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        NewStyleReferenceSection(
                          referenceRawText: cubit.referenceRawText,
                        ),
                        const SizedBox(height: 36),
                        ContentCreateStepDetail(
                          highlight: state.highlight,
                          forbidden: state.forbidden,
                          keywords: state.keywords,
                          photoGuideEnabled: state.photoGuideEnabled,
                          onHighlightChanged: cubit.setHighlight,
                          onForbiddenChanged: cubit.setForbidden,
                          onAddKeyword: cubit.addKeyword,
                          onRemoveKeyword: cubit.removeKeyword,
                          onTogglePhotoGuide: cubit.togglePhotoGuide,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: SsossButton(
                    label: '콘텐츠 생성하기',
                    width: double.infinity,
                    type: SsossButtonType.primary,
                    enabled: state.canSubmit,
                    onPressed:
                        state.canSubmit ? () => _submit(context) : null,
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
