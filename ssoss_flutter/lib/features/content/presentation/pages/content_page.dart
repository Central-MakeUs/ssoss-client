import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ssoss_flutter/common/widgets/navigation/ssoss_navigation_bar.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/list_contents_usecase.dart';
import 'package:ssoss_flutter/features/content/presentation/cubit/content_recent_cubit.dart';
import 'package:ssoss_flutter/features/content/presentation/cubit/content_recent_state.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_recent_item.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_create_page.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/recommended_content_template_detail/recommended_content_template_detail_page.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/recommended_content_templates/recommended_content_templates_components.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/recommended_content_templates/recommended_content_templates_page.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/home/content_channel_shortcuts.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/home/content_hero_section.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/home/content_recent_section.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/home/content_template_section.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_detail/content_detail_page.dart';
import 'package:ssoss_flutter/features/home/presentation/pages/home_page.dart';

/// 콘텐츠 생성 탭의 첫 화면 본문. 상단 AppBar·하단 네비게이션은 [HomePage]에서 제공한다.
class ContentPage extends StatefulWidget {
  const ContentPage({
    super.key,
    this.isActive = true,
  });

  /// 홈 IndexedStack에서 이 탭이 선택됐는지. true가 되면 최근 목록을 재조회한다.
  final bool isActive;

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  late final ContentRecentCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = ContentRecentCubit(
      listContents: context.read<ListContentsUseCase>(),
    );
    unawaited(_cubit.load());
  }

  @override
  void didUpdateWidget(covariant ContentPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isActive && widget.isActive) {
      unawaited(_cubit.load());
    }
  }

  @override
  void dispose() {
    unawaited(_cubit.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: const _ContentPageView(),
    );
  }
}

class _ContentPageView extends StatelessWidget {
  const _ContentPageView();

  void _openCreate(BuildContext context, [UploadChannel? channel]) {
    unawaited(context.push(ContentCreatePage.routePath, extra: channel));
  }

  void _openDashboard(BuildContext context) {
    if (HomePage.selectTab(context, SsossNavigationItem.dashboard)) {
      return;
    }
    context.go(
      HomePage.routePath,
      extra: SsossNavigationItem.dashboard,
    );
  }

  Future<void> _openContentDetail(
    BuildContext context,
    ContentRecentItem item,
  ) async {
    final contentId = int.tryParse(item.id);
    if (contentId == null) {
      return;
    }
    final didMutate = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => ContentDetailPage(
          contentId: contentId,
          initialChannel: item.firstChannel,
        ),
      ),
    );
    if (!context.mounted) {
      return;
    }
    if (didMutate == true) {
      unawaited(context.read<ContentRecentCubit>().load());
    }
  }

  void _openRecommendedTemplates(BuildContext context) {
    unawaited(context.push(RecommendedContentTemplatesPage.routePath));
  }

  void _openRecommendedTemplate(
    BuildContext context,
    ContentTemplateItem item,
  ) {
    final recommendedItem = _recommendedTemplateForHomeItem(item);
    if (recommendedItem == null) {
      return;
    }
    unawaited(
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => RecommendedContentTemplateDetailPage(
            item: recommendedItem,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            ContentTemplateSection(
              onViewAllTap: () => _openRecommendedTemplates(context),
              onTemplateTap: (item) => _openRecommendedTemplate(context, item),
            ),
            const SizedBox(height: 36),
            BlocBuilder<ContentRecentCubit, ContentRecentState>(
              builder: (context, state) {
                return ContentRecentSection(
                  recentContents: state.items,
                  isLoading: state.isLoading,
                  onCreateTap: () => _openCreate(context),
                  onContentTap: (item) =>
                      unawaited(_openContentDetail(context, item)),
                  onViewAllTap: () => _openDashboard(context),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

RecommendedContentTemplateItem? _recommendedTemplateForHomeItem(
  ContentTemplateItem item,
) {
  switch (item.id) {
    case 'new-menu':
      return const RecommendedContentTemplateItem(
        id: 'template-1',
        category: ContentTemplateCategory.newMenu,
        title: '신메뉴 출시 안내',
        description: '새로 나온 메뉴의 특징과 매력을 소개하는 글',
        channels: ['당근', '인스타그램', '스레드'],
      );
    case 'event-discount':
      return const RecommendedContentTemplateItem(
        id: 'template-2',
        category: ContentTemplateCategory.event,
        title: '주말 한정 이벤트 안내',
        description: '기간, 혜택, 참여 방법을 명확하게 전달하는 글',
        channels: ['당근', '인스타그램', '스레드'],
      );
    case 'introduction':
      return const RecommendedContentTemplateItem(
        id: 'template-4',
        category: ContentTemplateCategory.storeIntro,
        title: '매장 분위기 소개',
        description: '우리 가게의 공간감과 장점을 소개하는 글',
        channels: ['인스타그램', '스레드'],
      );
  }
  return null;
}
