import 'package:flutter/material.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_recent_item.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/content_channel_shortcuts.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/content_hero_section.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/content_recent_section.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/content_template_section.dart';

/// 콘텐츠 생성 탭의 첫 화면 본문. 상단 AppBar·하단 네비게이션은 [HomePage]에서 제공한다.
class ContentPage extends StatelessWidget {
  const ContentPage({
    super.key,
    this.recentContents,
  });

  /// `null`이면 프리뷰 데이터를 사용한다. 빈 목록을 넘기면 빈 상태 UI가 표시된다.
  final List<ContentRecentItem>? recentContents;

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
            ContentHeroSection(onCreateTap: () {}),
            const SizedBox(height: 36),
            const ContentChannelShortcuts(),
            const SizedBox(height: 36),
            const ContentTemplateSection(),
            const SizedBox(height: 36),
            // const ContentRecentSection(),
            ContentRecentSection(recentContents: items),
          ],
        ),
      ),
    );
  }
}
