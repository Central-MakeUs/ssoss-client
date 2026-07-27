import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_contents_card.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_contents_card_block.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_hashtag_input.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_persist_mode.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_args.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_result.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_edit_target.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_label_mapper.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_other_channel_args.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_photo_guide_display.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_result_dummy.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_edit_page.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_other_channel_create_page.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_detail/content_detail_components.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_generation_management/content_generation_management_components.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/utils/photo_guide_parser.dart';

class ContentDetailPage extends StatefulWidget {
  const ContentDetailPage({
    required this.item,
    super.key,
  });

  static const String routeName = 'content-detail';
  static const String routePath = '/content-detail';

  final ContentManagementItem item;

  @override
  State<ContentDetailPage> createState() => _ContentDetailPageState();
}

class _ContentDetailPageState extends State<ContentDetailPage> {
  late UploadChannel _channel;
  late String _title;
  late String _body;
  late List<String> _hashtags;
  late List<String> _keywords;
  late List<PhotoGuidePlacement> _photoGuides;

  bool get _showTitle => _channel == UploadChannel.blog;

  bool get _showHashtags => _channel == UploadChannel.instagram;

  List<SsossContentsCardBlock> get _bodyBlocks => photoGuideBodyBlocks(
        displayBody: _body,
        placements: _photoGuides,
      );

  @override
  void initState() {
    super.initState();
    _channel = ContentLabelMapper.channelFromLabel(widget.item.channel) ??
        UploadChannel.blog;
    _title = _channel == UploadChannel.blog
        ? (widget.item.title.isNotEmpty
            ? widget.item.title
            : ContentResultDummy.blogTitle)
        : '';
    final rawBody = ContentResultDummy.bodyFor(_channel, compact: false);
    final parsed = PhotoGuideParser.parse(rawBody);
    _body = parsed.displayBody;
    _photoGuides = parsed.placements;
    _hashtags = _showHashtags
        ? SsossHashtagNormalizer.stripAll(
            widget.item.tags.isNotEmpty
                ? widget.item.tags
                : ContentResultDummy.instagramHashtags,
          )
        : const [];
    _keywords = widget.item.tags.isNotEmpty
        ? SsossHashtagNormalizer.stripAll(widget.item.tags)
        : const ['디저트', '크루아상', '을지로베이커리'];
  }

  Future<void> _openEdit(ContentEditTarget target) async {
    final contentId = widget.item.resolvedContentId;
    final contentChannelId = widget.item.contentChannelId;
    if (contentId == null || contentChannelId == null) {
      showSsossToast(
        context,
        title: '편집에 필요한 정보가 없어요',
        type: SsossToastType.error,
      );
      return;
    }

    final result = await Navigator.of(context).push<ContentEditResult>(
      MaterialPageRoute(
        builder: (_) => ContentEditPage(
          args: ContentEditArgs(
            channel: _channel,
            target: target,
            initialTitle: _title,
            initialBody: _body,
            initialHashtags: _hashtags,
            photoGuides: _photoGuides,
            persistMode: ContentEditPersistMode.put,
            contentId: contentId,
            contentChannelId: contentChannelId,
          ),
        ),
      ),
    );

    if (result == null || !mounted) {
      return;
    }

    setState(() {
      switch (result.target) {
        case ContentEditTarget.title:
          _title = result.title ?? _title;
        case ContentEditTarget.body:
          _body = result.body ?? _body;
          if (result.photoGuides != null) {
            _photoGuides = List<PhotoGuidePlacement>.of(result.photoGuides!);
          }
        case ContentEditTarget.hashtags:
          _hashtags = result.hashtags ?? _hashtags;
      }
    });
  }

  void _openOtherChannelCreate() {
    unawaited(
      context.push(
        ContentOtherChannelCreatePage.routePath,
        extra: ContentOtherChannelArgs(
          sourceContentId: widget.item.id,
          excludedChannels: [_channel],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            SsossAppBar.back(
              title: '콘텐츠 상세 내역',
              onBack: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 3, 16, 34),
                children: [
                  ContentDetailInfoPanel(
                    item: widget.item,
                    keywords: _keywords,
                  ),
                  if (_showTitle) ...[
                    const SizedBox(height: 32),
                    ContentDetailSection(
                      title: '제목',
                      onEditTap: () =>
                          unawaited(_openEdit(ContentEditTarget.title)),
                      child: SsossContentsCard(
                        width: double.infinity,
                        blocks: [SsossContentsCardTextBlock(_title)],
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),
                  ContentDetailSection(
                    title: '본문',
                    onEditTap: () =>
                        unawaited(_openEdit(ContentEditTarget.body)),
                    child: SsossContentsCard(
                      width: double.infinity,
                      blocks: _bodyBlocks,
                    ),
                  ),
                  if (_showHashtags) ...[
                    const SizedBox(height: 32),
                    ContentDetailSection(
                      title: '해시태그',
                      onEditTap: () =>
                          unawaited(_openEdit(ContentEditTarget.hashtags)),
                      child: SsossContentsCard(
                        width: double.infinity,
                        blocks: [
                          SsossContentsCardHashtagsBlock([
                            for (final tag in _hashtags)
                              SsossHashtagNormalizer.display(tag),
                          ]),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 27),
                  ContentDetailActionButtons(
                    onCreateOtherChannel: _openOtherChannelCreate,
                    onReuse: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
