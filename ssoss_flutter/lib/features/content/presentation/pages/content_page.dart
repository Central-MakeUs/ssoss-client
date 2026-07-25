import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ssoss_flutter/common/widgets/navigation/ssoss_navigation_bar.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_generation_preview_data.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_recent_item.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_create_page.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/home/content_channel_shortcuts.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/home/content_hero_section.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/home/content_recent_section.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/home/content_template_section.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_detail/content_detail_page.dart';
import 'package:ssoss_flutter/features/home/presentation/pages/home_page.dart';

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

  void _openDashboard(BuildContext context) {
    context.go(
      HomePage.routePath,
      extra: SsossNavigationItem.dashboard,
    );
  }

  void _openContentDetail(BuildContext context, ContentRecentItem item) {
    final detailItem = detailItemForRecent(item);
    if (detailItem == null) {
      return;
    }
    unawaited(
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => ContentDetailPage(item: detailItem),
        ),
      ),
    );
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
            ContentRecentSection(
              recentContents: items,
              onCreateTap: () => _openCreate(context),
              onContentTap: (item) => _openContentDetail(context, item),
              onViewAllTap: () => _openDashboard(context),
            ),
          ],
        ),
      ),
    );
  }
}
