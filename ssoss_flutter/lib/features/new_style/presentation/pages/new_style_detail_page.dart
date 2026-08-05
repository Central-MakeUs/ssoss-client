import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/create/content_create_step_detail.dart';
import 'package:ssoss_flutter/features/new_style/presentation/cubit/new_style_detail_cubit.dart';
import 'package:ssoss_flutter/features/new_style/presentation/cubit/new_style_detail_state.dart';
import 'package:ssoss_flutter/features/new_style/presentation/models/new_style_args.dart';
import 'package:ssoss_flutter/features/new_style/presentation/widgets/new_style_reference_section.dart';

/// 이 스타일로 새로 만들기 — 상세 입력.
class NewStyleDetailPage extends StatelessWidget {
  const NewStyleDetailPage({
    required this.args,
    super.key,
  });

  static const String routeName = 'new-style-detail';
  static const String routePath = '/new-style/detail';

  final NewStyleDetailArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewStyleDetailCubit(args: args),
      child: const _NewStyleDetailView(),
    );
  }
}

class _NewStyleDetailView extends StatelessWidget {
  const _NewStyleDetailView();

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
                    // 업로드 API 추후 연동 — 빈 콜백으로 UI만 활성.
                    onPressed: state.canSubmit ? () {} : null,
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
