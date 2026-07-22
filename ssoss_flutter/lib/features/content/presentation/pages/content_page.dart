import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ssoss_flutter/common/widgets/card/content-edit/ssoss_contents_edit_document.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_contents_edit_card.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_recommendation_card.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_recent_item.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_create_page.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/home/content_channel_shortcuts.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/home/content_hero_section.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/home/content_recent_section.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/home/content_template_section.dart';

/// 콘텐츠 생성 탭의 첫 화면 본문. 상단 AppBar·하단 네비게이션은 [HomePage]에서 제공한다.
class ContentPage extends StatelessWidget {
  const ContentPage({
    super.key,
    this.recentContents,
  });

  /// `null`이면 프리뷰 데이터를 사용한다. 빈 목록을 넘기면 빈 상태 UI가 표시된다.
  final List<ContentRecentItem>? recentContents;

  void _openCreate(BuildContext context, [UploadChannel? channel]) {
    unawaited(context.push(ContentCreatePage.routePath, extra: channel));
  }

  @override
  Widget build(BuildContext context) {
    final items = recentContents ?? contentRecentPreviewItems;

    return ColoredBox(
      color: AppColors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ContentHeroSection(onCreateTap: () => _openCreate(context)),
            const SizedBox(height: 36),
            ContentChannelShortcuts(
              onChannelTap: (channel) => _openCreate(context, channel),
            ),
            const SizedBox(height: 36),
            const ContentTemplateSection(),
            const SizedBox(height: 36),
            ContentRecentSection(recentContents: items),
            const SizedBox(height: 36),
            const _ContentsEditPreview(),
          ],
        ),
      ),
    );
  }
}

class _ContentsEditPreview extends StatefulWidget {
  const _ContentsEditPreview();

  @override
  State<_ContentsEditPreview> createState() => _ContentsEditPreviewState();
}

class _ContentsEditPreviewState extends State<_ContentsEditPreview> {
  var document = SsossContentsEditDocument(
    blocks: [
      SsossContentsEditTextBlock(
        id: 'text-0',
        text: '고정 문구\n가격: [가격]원\n뒤',
      ),
      SsossContentsEditRecommendationBlock(
        item: SsossRecommendationCardItem(
          id: 'recommendation-0',
          label: '추천 사진',
          title: '매장 사진',
          description: '분위기 있는 사진',
        ),
      ),
      SsossContentsEditTextBlock(
        id: 'text-1',
        text: '뒤',
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SsossContentsEditCard(
          document: document,
          onDocumentChanged: (value) => setState(() => document = value),
        ),
        const SizedBox(height: 36),
        ElevatedButton(
          onPressed: () => setState(() => document = document.reset()),
          child: const Text('초기화'),
        ),
      ],
    );
  }
}
