import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_contents_card.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_contents_card_block.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_hashtag_input.dart';
import 'package:ssoss_flutter/common/widgets/tab/ssoss_tab_bar.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_channel_content.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_detail.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/get_content_usecase.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_args.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_channel_merge.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_persist_mode.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_result.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_target.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_label_mapper.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_other_channel_args.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_photo_guide_display.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_edit_page.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_other_channel_create_page.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/cubit/content_detail_cubit.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/cubit/content_detail_state.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_detail/content_detail_components.dart';
import 'package:ssoss_flutter/features/new_style/presentation/models/new_style_args.dart';
import 'package:ssoss_flutter/features/new_style/presentation/util/open_new_style_flow.dart';
import 'package:ssoss_flutter/utils/photo_guide_parser.dart';

class ContentDetailPage extends StatelessWidget {
  const ContentDetailPage({
    required this.contentId,
    this.initialChannel,
    super.key,
  });

  static const String routeName = 'content-detail';
  static const String routePath = '/content-detail';

  final int contentId;

  /// 다중 채널일 때 처음 선택할 탭. null이면 첫 채널.
  final UploadChannel? initialChannel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = ContentDetailCubit(
          getContent: context.read<GetContentUseCase>(),
          contentId: contentId,
        );
        unawaited(cubit.load());
        return cubit;
      },
      child: _ContentDetailView(initialChannel: initialChannel),
    );
  }
}

class _ContentDetailView extends StatelessWidget {
  const _ContentDetailView({this.initialChannel});

  final UploadChannel? initialChannel;

  void _pop(BuildContext context) {
    final didMutate = context.read<ContentDetailCubit>().state.didMutate;
    Navigator.of(context).pop(didMutate);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        _pop(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              SsossAppBar.back(
                title: '콘텐츠 상세 내역',
                onBack: () => _pop(context),
              ),
              Expanded(
                child: BlocBuilder<ContentDetailCubit, ContentDetailState>(
                  builder: (context, state) {
                    if (state.isLoading && state.detail == null) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary400,
                        ),
                      );
                    }
                    final error = state.errorMessage;
                    if (error != null && state.detail == null) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(error),
                        ),
                      );
                    }
                    final detail = state.detail;
                    if (detail == null || detail.contents.isEmpty) {
                      return const Center(child: Text('표시할 콘텐츠가 없어요'));
                    }
                    return _ContentDetailBody(
                      detail: detail,
                      initialChannel: initialChannel,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContentDetailBody extends StatefulWidget {
  const _ContentDetailBody({
    required this.detail,
    this.initialChannel,
  });

  final ContentDetail detail;
  final UploadChannel? initialChannel;

  @override
  State<_ContentDetailBody> createState() => _ContentDetailBodyState();
}

class _ContentDetailBodyState extends State<_ContentDetailBody> {
  late List<UploadChannel> _orderedChannels;
  late final PageController _pageController;
  late int _selectedIndex;

  bool get _isMulti => _orderedChannels.length >= 2;

  bool get _hasAllChannels =>
      _orderedChannels.length >= UploadChannel.values.length;

  @override
  void initState() {
    super.initState();
    _orderedChannels = _channelsOf(widget.detail);
    final initial = widget.initialChannel;
    final initialIndex =
        initial == null ? 0 : _orderedChannels.indexOf(initial);
    _selectedIndex = initialIndex >= 0 ? initialIndex : 0;
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void didUpdateWidget(covariant _ContentDetailBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.detail != widget.detail) {
      _orderedChannels = _channelsOf(widget.detail);
      if (_selectedIndex >= _orderedChannels.length) {
        _selectedIndex = 0;
      }
    }
  }

  static List<UploadChannel> _channelsOf(ContentDetail detail) {
    return ContentLabelMapper.orderedChannels([
      for (final item in detail.contents) item.channelResult.channel,
    ]);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  ContentChannelContent _channelContentAt(int index) {
    final channel = _orderedChannels[index];
    return widget.detail.contents.firstWhere(
      (item) => item.channelResult.channel == channel,
    );
  }

  Future<void> _openEdit(
    BuildContext context,
    ContentChannelContent channelContent,
    ContentEditTarget target,
  ) async {
    final result = channelContent.channelResult;
    final channel = result.channel;
    final parsed = PhotoGuideParser.parse(result.body);
    final initialHashtags = SsossHashtagNormalizer.stripAll(result.hashtags);

    final editResult = await Navigator.of(context).push<ContentEditResult>(
      MaterialPageRoute(
        builder: (_) => ContentEditPage(
          args: ContentEditArgs(
            channel: channel,
            target: target,
            initialTitle: result.title ?? '',
            initialBody: parsed.displayBody,
            initialHashtags: initialHashtags,
            photoGuides: parsed.placements,
            persistMode: ContentEditPersistMode.put,
            contentId: widget.detail.contentId,
            contentChannelId: channelContent.contentChannelId,
          ),
        ),
      ),
    );

    if (editResult == null || !context.mounted) {
      return;
    }

    final channelPayload = mergeEditToChannelResult(
      channel: channel,
      initialTitle: result.title ?? '',
      initialBody: parsed.displayBody,
      initialHashtags: initialHashtags,
      initialPhotoGuides: parsed.placements,
      editResult: editResult,
    );

    context.read<ContentDetailCubit>().applyChannelEdit(
          ContentChannelContent(
            contentChannelId: channelContent.contentChannelId,
            channelResult: channelPayload,
          ),
        );
  }

  void _openOtherChannelCreate(BuildContext context) {
    final channelContent = _channelContentAt(_selectedIndex);
    unawaited(
      context.push(
        ContentOtherChannelCreatePage.routePath,
        extra: ContentOtherChannelArgs(
          sourceContentId: widget.detail.contentId.toString(),
          sourceContentChannelId: channelContent.contentChannelId,
          excludedChannels: _orderedChannels,
        ),
      ),
    );
  }

  void _openNewStyle(
      BuildContext context, ContentChannelContent channelContent) {
    final result = channelContent.channelResult;
    unawaited(
      openNewStyleFlow(
        context,
        args: NewStyleArgs(
          sourceContentId: widget.detail.contentId.toString(),
          contentChannelId: channelContent.contentChannelId,
          purpose: widget.detail.purpose,
          tone: widget.detail.tone,
          referenceChannel: result.channel,
          referenceRawText: widget.detail.name,
        ),
      ),
    );
  }

  void _onTabTap(int index) {
    if (index == _selectedIndex) {
      return;
    }
    setState(() => _selectedIndex = index);
    unawaited(
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      ),
    );
  }

  void _onPageChanged(int index) {
    if (index == _selectedIndex) {
      return;
    }
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final detail = widget.detail;
    final infoPanel = ContentDetailInfoPanel(
      purpose: ContentLabelMapper.purpose(detail.purpose),
      tone: ContentLabelMapper.tone(detail.tone),
      channelsLabel: ContentLabelMapper.channelsJoined(_orderedChannels),
      keywords: detail.keywords,
    );

    if (!_isMulti) {
      return ListView(
        padding: const EdgeInsets.fromLTRB(16, 3, 16, 34),
        children: [
          infoPanel,
          const SizedBox(height: 32),
          _ChannelDetailSections(
            channelContent: _channelContentAt(0),
            onEdit: (target) => unawaited(
              _openEdit(context, _channelContentAt(0), target),
            ),
          ),
          const SizedBox(height: 27),
          ContentDetailActionButtons(
            onCreateOtherChannel:
                _hasAllChannels ? null : () => _openOtherChannelCreate(context),
            onReuse: () => _openNewStyle(context, _channelContentAt(0)),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 3, 16, 0),
          child: infoPanel,
        ),
        const SizedBox(height: 12),
        SsossTabBar(
          width: double.infinity,
          selectedIndex: _selectedIndex,
          items: [
            for (final channel in _orderedChannels)
              SsossTabItem(label: ContentLabelMapper.channel(channel)),
          ],
          onTap: _onTabTap,
        ),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: _orderedChannels.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              final channelContent = _channelContentAt(index);
              return ListView(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 34),
                children: [
                  _ChannelDetailSections(
                    channelContent: channelContent,
                    onEdit: (target) => unawaited(
                      _openEdit(context, channelContent, target),
                    ),
                  ),
                  const SizedBox(height: 27),
                  ContentDetailActionButtons(
                    onCreateOtherChannel: _hasAllChannels
                        ? null
                        : () => _openOtherChannelCreate(context),
                    onReuse: () => _openNewStyle(context, channelContent),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ChannelDetailSections extends StatelessWidget {
  const _ChannelDetailSections({
    required this.channelContent,
    required this.onEdit,
  });

  final ContentChannelContent channelContent;
  final ValueChanged<ContentEditTarget> onEdit;

  @override
  Widget build(BuildContext context) {
    final result = channelContent.channelResult;
    final channel = result.channel;
    final showTitle = channel == UploadChannel.blog;
    final showHashtagSection = channel == UploadChannel.instagram;
    final parsed = PhotoGuideParser.parse(result.body);
    final hashtags = SsossHashtagNormalizer.stripAll(result.hashtags);
    final bodyBlocks = [
      ...photoGuideBodyBlocks(
        displayBody: parsed.displayBody,
        placements: parsed.placements,
      ),
      if (channel == UploadChannel.blog && hashtags.isNotEmpty)
        SsossContentsCardHashtagsBlock(
          [
            for (final tag in hashtags) SsossHashtagNormalizer.display(tag),
          ],
          displayAsPlainText: true,
        ),
    ];
    final title = result.title ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showTitle) ...[
          ContentDetailSection(
            title: '제목',
            onEditTap: () => onEdit(ContentEditTarget.title),
            child: SsossContentsCard(
              width: double.infinity,
              contentColor: AppColors.black,
              blocks: [SsossContentsCardTextBlock(title)],
            ),
          ),
          const SizedBox(height: 32),
        ],
        ContentDetailSection(
          title: '본문',
          onEditTap: () => onEdit(ContentEditTarget.body),
          child: SsossContentsCard(
            width: double.infinity,
            contentColor: AppColors.black,
            blocks: bodyBlocks,
          ),
        ),
        if (showHashtagSection) ...[
          const SizedBox(height: 32),
          ContentDetailSection(
            title: '해시태그',
            onEditTap: () => onEdit(ContentEditTarget.hashtags),
            child: SsossContentsCard(
              width: double.infinity,
              blocks: [
                SsossContentsCardHashtagsBlock([
                  for (final tag in hashtags)
                    SsossHashtagNormalizer.display(tag),
                ]),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
