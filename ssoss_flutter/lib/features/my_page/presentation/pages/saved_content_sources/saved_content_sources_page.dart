import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/tab/ssoss_tab_bar.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/hashtag/domain/entities/hashtag_bundle.dart';
import 'package:ssoss_flutter/features/hashtag/domain/usecases/list_bookmarked_hashtag_bundles_usecase.dart';
import 'package:ssoss_flutter/features/hashtag/domain/usecases/unbookmark_hashtag_bundle_usecase.dart';
import 'package:ssoss_flutter/features/hashtag/presentation/cubit/bookmarked_hashtag_bundles_cubit.dart';
import 'package:ssoss_flutter/features/hashtag/presentation/cubit/bookmarked_hashtag_bundles_state.dart';
import 'package:ssoss_flutter/features/my_page/presentation/pages/saved_content_sources/saved_content_sources_components.dart';
import 'package:ssoss_flutter/features/recommend_source/presentation/pages/recommend_source_components.dart';
import 'package:ssoss_flutter/features/template/domain/entities/recommended_template.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/list_bookmarked_templates_usecase.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/unbookmark_template_usecase.dart';
import 'package:ssoss_flutter/features/template/presentation/cubit/bookmarked_templates_cubit.dart';
import 'package:ssoss_flutter/features/template/presentation/cubit/bookmarked_templates_state.dart';
import 'package:ssoss_flutter/features/template/presentation/pages/template_detail/template_detail_page.dart';
import 'package:ssoss_flutter/features/template/presentation/util/template_label_mapper.dart';
import 'package:ssoss_flutter/features/template/presentation/widgets/template_models.dart';

class SavedContentSourcesPage extends StatelessWidget {
  const SavedContentSourcesPage({super.key});

  static const String routeName = 'saved-content-sources';
  static const String routePath = '/saved-content-sources';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = BookmarkedTemplatesCubit(
              listBookmarkedTemplates:
                  context.read<ListBookmarkedTemplatesUseCase>(),
              unbookmarkTemplate: context.read<UnbookmarkTemplateUseCase>(),
            );
            unawaited(cubit.load());
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) => BookmarkedHashtagBundlesCubit(
            listBookmarkedHashtagBundles:
                context.read<ListBookmarkedHashtagBundlesUseCase>(),
            unbookmarkHashtagBundle:
                context.read<UnbookmarkHashtagBundleUseCase>(),
          ),
        ),
      ],
      child: const _SavedContentSourcesView(),
    );
  }
}

class _SavedContentSourcesView extends StatefulWidget {
  const _SavedContentSourcesView();

  @override
  State<_SavedContentSourcesView> createState() =>
      _SavedContentSourcesViewState();
}

class _SavedContentSourcesViewState extends State<_SavedContentSourcesView> {
  static const List<SsossTabItem> _tabItems = [
    SsossTabItem(label: '템플릿'),
    SsossTabItem(label: '해시태그'),
  ];

  late final PageController _pageController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedTabIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTap(int index) {
    if (index == _selectedTabIndex) {
      return;
    }
    setState(() => _selectedTabIndex = index);
    _ensureHashtagsLoaded(index);
    unawaited(
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      ),
    );
  }

  void _onPageChanged(int index) {
    if (index == _selectedTabIndex) {
      return;
    }
    setState(() => _selectedTabIndex = index);
    _ensureHashtagsLoaded(index);
  }

  void _ensureHashtagsLoaded(int tabIndex) {
    if (tabIndex != 1) {
      return;
    }
    unawaited(context.read<BookmarkedHashtagBundlesCubit>().ensureLoaded());
  }

  RecommendSourceHashtagSetItem _toHashtagSetItem(HashtagBundle bundle) {
    return RecommendSourceHashtagSetItem(
      id: bundle.id.toString(),
      title: bundle.name,
      hashtags: bundle.hashtags,
      isSaved: true,
    );
  }

  TemplateItem _toTemplateItem(RecommendedTemplate template) {
    return TemplateItem(
      id: template.id,
      category: TemplateLabelMapper.category(template.category),
      title: template.title,
      description: template.description,
      channels: TemplateLabelMapper.channels(template.recommendedChannels),
      isSaved: true,
    );
  }

  Future<void> _unbookmarkTemplate(int itemId) async {
    final success =
        await context.read<BookmarkedTemplatesCubit>().unbookmark(itemId);
    if (!mounted) {
      return;
    }
    if (success) {
      showSsossToast(
        context,
        title: '북마크가 해제되었습니다',
        type: SsossToastType.info,
      );
      return;
    }
    showSsossToast(
      context,
      title: '북마크 해제에 실패했습니다',
      type: SsossToastType.error,
    );
  }

  void _openTemplateDetail(TemplateItem item) {
    unawaited(
      Navigator.of(context, rootNavigator: true).push<void>(
        MaterialPageRoute<void>(
          builder: (_) => TemplateDetailPage(templateId: item.id),
        ),
      ),
    );
  }

  Future<void> _unbookmarkHashtag(String itemId) async {
    final bundleId = int.tryParse(itemId);
    if (bundleId == null) {
      return;
    }
    final success = await context
        .read<BookmarkedHashtagBundlesCubit>()
        .unbookmark(bundleId);
    if (!mounted) {
      return;
    }
    if (success) {
      showSsossToast(
        context,
        title: '북마크가 해제되었습니다',
        type: SsossToastType.info,
      );
      return;
    }
    showSsossToast(
      context,
      title: '북마크 해제에 실패했습니다',
      type: SsossToastType.error,
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
              title: '저장한 콘텐츠 소스',
              onBack: () => Navigator.of(context).pop(),
            ),
            SsossTabBar(
              width: double.infinity,
              selectedIndex: _selectedTabIndex,
              items: _tabItems,
              onTap: _onTabTap,
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _tabItems.length,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return BlocBuilder<BookmarkedTemplatesCubit,
                          BookmarkedTemplatesState>(
                        builder: (context, state) {
                          return SavedContentSourcesTemplateList(
                            items: state.items
                                .map(_toTemplateItem)
                                .toList(growable: false),
                            isLoading: state.isLoading,
                            errorMessage: state.errorMessage,
                            onRetry: () => unawaited(
                              context.read<BookmarkedTemplatesCubit>().load(),
                            ),
                            onSaveTap: (itemId) =>
                                unawaited(_unbookmarkTemplate(itemId)),
                            onItemTap: _openTemplateDetail,
                          );
                        },
                      );
                    case 1:
                      return BlocBuilder<BookmarkedHashtagBundlesCubit,
                          BookmarkedHashtagBundlesState>(
                        builder: (context, state) {
                          return SavedContentSourcesHashtagList(
                            items: state.items
                                .map(_toHashtagSetItem)
                                .toList(growable: false),
                            isLoading: state.isLoading,
                            errorMessage: state.errorMessage,
                            onRetry: () => unawaited(
                              context
                                  .read<BookmarkedHashtagBundlesCubit>()
                                  .load(),
                            ),
                            onSaveTap: (itemId) =>
                                unawaited(_unbookmarkHashtag(itemId)),
                          );
                        },
                      );
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
