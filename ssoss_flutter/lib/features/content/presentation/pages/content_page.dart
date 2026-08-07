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
import 'package:ssoss_flutter/features/content/presentation/widgets/home/content_channel_shortcuts.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/home/content_hero_section.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/home/content_recent_section.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/home/content_template_section.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_detail/content_detail_page.dart';
import 'package:ssoss_flutter/features/home/presentation/pages/home_page.dart';
import 'package:ssoss_flutter/features/recommend_source/presentation/pages/recommend_source/recommend_source_page.dart';
import 'package:ssoss_flutter/features/template/presentation/widgets/template_models.dart';

/// 콘텐츠 생성 탭의 첫 화면 본문. 상단 헤더·하단 네비게이션은 [HomePage]에서 제공한다.
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

  void _openRecommendedTemplates(
    BuildContext context, [
    TemplateCategory category = TemplateCategory.all,
  ]) {
    unawaited(
      context.push(
        RecommendSourcePage.routePath,
        extra: category,
      ),
    );
  }

  TemplateCategory? _categoryForHomeTemplate(ContentTemplateItem item) {
    return switch (item.id) {
      'new-menu' => TemplateCategory.newMenu,
      'event-discount' => TemplateCategory.event,
      'introduction' => TemplateCategory.storeIntro,
      _ => null,
    };
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
              onTemplateTap: (item) {
                final category = _categoryForHomeTemplate(item);
                if (category == null) {
                  return;
                }
                _openRecommendedTemplates(context, category);
              },
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
