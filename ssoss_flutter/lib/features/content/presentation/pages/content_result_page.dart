import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/modal/ssoss_modal.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/save_content_usecase.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_create_flow.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_args.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_result.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_target.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_generation_args.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_result_draft.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_save_complete_args.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_edit_page.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_generating_page.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_save_complete_page.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/result/content_remake_credit_summary.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/result/content_result_body.dart';
import 'package:ssoss_flutter/features/credit/presentation/cubit/credit_balance_cubit.dart';
import 'package:ssoss_flutter/features/credit/presentation/cubit/credit_balance_state.dart';
import 'package:ssoss_flutter/features/home/presentation/pages/home_page.dart';

/// 콘텐츠 생성 결과 화면.
class ContentResultPage extends StatefulWidget {
  const ContentResultPage({
    required this.args,
    super.key,
  });

  static const String routeName = 'content-result';
  static const String routePath = '/content/create/result';

  final ContentGenerationArgs args;

  @override
  State<ContentResultPage> createState() => _ContentResultPageState();
}

class _ContentResultPageState extends State<ContentResultPage> {
  late ContentResultDraft _draft;
  bool _isSaving = false;

  ContentGenerationArgs get args => widget.args;

  int? get _generationId => args.generationDetail?.generationId;

  bool get _isMulti => args.input.channels.length >= 2;

  bool get _isOtherChannel => args.flow == ContentCreateFlow.otherChannel;

  @override
  void initState() {
    super.initState();
    final detail = args.generationDetail;
    if (detail == null) {
      throw StateError('ContentResultPage requires generationDetail');
    }
    _draft = ContentResultDraft.fromGenerationDetail(detail);
  }

  void _goHome(BuildContext context) {
    context.go(HomePage.routePath);
  }

  Future<void> _onBack(BuildContext context) async {
    final result = await showSsossModal(
      context,
      title: '생성된 콘텐츠가 저장되지 않았어요',
      message: '지금 나가면 생성 결과는 저장되지 않아요',
      primaryButtonLabel: '계속 진행하기',
      secondaryButtonLabel: '나가기',
      showButtonIcons: false,
    );

    if (result != SsossModalResult.secondary || !context.mounted) {
      return;
    }

    _goHome(context);
  }

  Future<void> _save(BuildContext context) async {
    if (_isSaving) {
      return;
    }

    final generationId = _generationId;
    if (generationId == null) {
      return;
    }

    setState(() => _isSaving = true);
    try {
      await context.read<SaveContentUseCase>()(
        generationId: generationId,
        channels: _draft.toGenerationChannelResults(),
      );

      if (!mounted) {
        return;
      }

      context.go(
        ContentSaveCompletePage.routePath,
        extra: const ContentSaveCompleteArgs(),
      );
    } on AppException catch (e) {
      if (!mounted) {
        return;
      }
      showSsossToast(
        context,
        title: e.message,
        type: SsossToastType.error,
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  static const int _creditPerChannel = 5;

  Future<void> _remake(BuildContext context) async {
    final deductAmount = args.input.channels.length * _creditPerChannel;
    final balanceCubit = context.read<CreditBalanceCubit>();
    unawaited(balanceCubit.refresh());

    final result = await showSsossModal(
      context,
      title: '콘텐츠를 다시 생성할까요?',
      message: '재생성하면 크레딧이 추가로 차감돼요',
      primaryButtonLabel: '다시 생성하기',
      secondaryButtonLabel: '취소',
      showButtonIcons: false,
      content: BlocBuilder<CreditBalanceCubit, CreditBalanceState>(
        bloc: balanceCubit,
        builder: (context, state) {
          return ContentRemakeCreditSummary(
            deductAmount: deductAmount,
            balance: state.balance,
            isBalanceLoading: state.isLoading && state.balance == null,
          );
        },
      ),
    );

    if (result != SsossModalResult.primary || !context.mounted) {
      return;
    }

    context.go(
      ContentGeneratingPage.routePath,
      extra: ContentGenerationArgs(
        input: args.input,
        flow: args.flow,
        styleReuseContentChannelId: args.styleReuseContentChannelId,
        conversionContentChannelId: args.conversionContentChannelId,
        newStyleArgs: args.newStyleArgs,
        completedChannels: args.completedChannels,
      ),
    );
  }

  Future<void> _openEdit(
    UploadChannel channel,
    ContentEditTarget target,
  ) async {
    final channelDraft = _draft.forChannel(channel);
    final result = await context.push<ContentEditResult>(
      ContentEditPage.routePath,
      extra: ContentEditArgs(
        channel: channel,
        target: target,
        initialTitle: channelDraft.title ?? '',
        initialBody: channelDraft.body,
        initialHashtags: channelDraft.hashtags,
        photoGuides: target == ContentEditTarget.body
            ? channelDraft.photoGuides
            : const [],
      ),
    );

    if (result == null || !mounted) {
      return;
    }

    setState(() {
      final current = _draft.forChannel(result.channel);
      switch (result.target) {
        case ContentEditTarget.title:
          _draft = _draft.updateChannel(
            result.channel,
            current.copyWith(title: result.title),
          );
        case ContentEditTarget.body:
          _draft = _draft.updateChannel(
            result.channel,
            current.copyWith(
              body: result.body,
              photoGuides: result.photoGuides ?? current.photoGuides,
            ),
          );
        case ContentEditTarget.hashtags:
          _draft = _draft.updateChannel(
            result.channel,
            current.copyWith(hashtags: result.hashtags),
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          return;
        }
        unawaited(_onBack(context));
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              SsossAppBar.back(
                title: _isOtherChannel ? '다른 채널용 생성 결과' : '콘텐츠 생성 결과',
                onBack: () => unawaited(_onBack(context)),
              ),
              Expanded(
                child: _isMulti
                    ? ContentResultMultiBody(
                        input: args.input,
                        draft: _draft,
                        onEdit: (channel, target) =>
                            unawaited(_openEdit(channel, target)),
                      )
                    : ContentResultSingleBody(
                        input: args.input,
                        draft: _draft,
                        onEdit: (channel, target) =>
                            unawaited(_openEdit(channel, target)),
                      ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  border: Border(
                    top: BorderSide(color: AppColors.neutral200),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SsossButton(
                        label: '다시 생성하기',
                        type: SsossButtonType.outline,
                        width: double.infinity,
                        enabled: !_isSaving,
                        onPressed: () => unawaited(_remake(context)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SsossButton(
                        label: '저장하기',
                        type: SsossButtonType.primary,
                        width: double.infinity,
                        isLoading: _isSaving,
                        enabled: !_isSaving,
                        onPressed: () => unawaited(_save(context)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
