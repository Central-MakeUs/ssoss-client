import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_contents_edit_card.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_hashtag_input.dart';
import 'package:ssoss_flutter/common/widgets/modal/ssoss_modal.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/content/presentation/cubit/content_edit_cubit.dart';
import 'package:ssoss_flutter/features/content/presentation/cubit/content_edit_state.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_args.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_target.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/edit/content_edit_bottom_bar.dart';

/// 콘텐츠 섹션 편집 화면.
class ContentEditPage extends StatelessWidget {
  const ContentEditPage({
    required this.args,
    super.key,
  });

  static const String routeName = 'content-edit';
  static const String routePath = '/content/create/result/edit';

  final ContentEditArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContentEditCubit(args: args),
      child: const _ContentEditView(),
    );
  }
}

class _ContentEditView extends StatelessWidget {
  const _ContentEditView();

  Future<void> _onReset(BuildContext context) async {
    final result = await showSsossModal(
      context,
      title: '수정한 내용을 초기화하시겠어요?',
      message: '초기화하면 변경한 내용이 모두 사라지고\n초안으로 돌아가요',
      primaryButtonLabel: '초기화하기',
      secondaryButtonLabel: '취소',
      showButtonIcons: false,
    );
    if (result != SsossModalResult.primary || !context.mounted) {
      return;
    }
    context.read<ContentEditCubit>().reset();
  }

  void _onSubmit(BuildContext context) {
    final editResult = context.read<ContentEditCubit>().buildResult();
    if (editResult == null) {
      return;
    }
    context.pop(editResult);
  }

  void _onAddHashtag(BuildContext context, String raw) {
    final cubit = context.read<ContentEditCubit>();
    final state = cubit.state;
    if (state.hashtags.length >= SsossHashtagLimits.maxCount) {
      return;
    }
    final normalized = SsossHashtagNormalizer.normalize(raw);
    if (normalized == null) {
      if (raw.trim().isNotEmpty) {
        showSsossToast(
          context,
          title: '해시태그는 ${SsossHashtagLimits.maxLength}자 이하로 입력해주세요',
          type: SsossToastType.warning,
        );
      }
      return;
    }
    final added = cubit.addHashtag(raw);
    if (!added && state.hashtags.contains(normalized)) {
      showSsossToast(
        context,
        title: '이미 추가된 해시태그예요',
        type: SsossToastType.warning,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContentEditCubit, ContentEditState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: Column(
              children: [
                SsossAppBar.back(
                  title: '콘텐츠 편집',
                  onBack: () => context.pop(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                    child: _EditBody(
                      state: state,
                      onAddHashtag: (raw) => _onAddHashtag(context, raw),
                    ),
                  ),
                ),
                ContentEditBottomBar(
                  canSubmit: state.canSubmit,
                  onReset: () => unawaited(_onReset(context)),
                  onSubmit: () => _onSubmit(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _EditBody extends StatelessWidget {
  const _EditBody({
    required this.state,
    required this.onAddHashtag,
  });

  final ContentEditState state;
  final ValueChanged<String> onAddHashtag;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ContentEditCubit>();

    switch (state.target) {
      case ContentEditTarget.hashtags:
        return SsossHashtagInput(
          hashtags: state.hashtags,
          showHeader: true,
          onAdd: onAddHashtag,
          onRemove: cubit.removeHashtag,
        );
      case ContentEditTarget.title:
      case ContentEditTarget.body:
        final document = state.document;
        if (document == null) {
          return const SizedBox.shrink();
        }
        final sectionLabel = state.target == ContentEditTarget.title
            ? '제목 편집'
            : '본문 편집';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              sectionLabel,
              style: AppTextStyles.h5.copyWith(color: AppColors.neutral700),
            ),
            const SizedBox(height: 8),
            SsossContentsEditCard(
              document: document,
              maxLength: cubit.maxLength,
              width: double.infinity,
              onDocumentChanged: cubit.updateDocument,
            ),
          ],
        );
    }
  }
}
