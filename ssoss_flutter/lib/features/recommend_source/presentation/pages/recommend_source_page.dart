import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/tab/ssoss_tab_bar.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/hashtag/domain/entities/hashtag_bundle.dart';
import 'package:ssoss_flutter/features/hashtag/domain/usecases/bookmark_hashtag_bundle_usecase.dart';
import 'package:ssoss_flutter/features/hashtag/domain/usecases/list_hashtag_bundles_usecase.dart';
import 'package:ssoss_flutter/features/hashtag/domain/usecases/unbookmark_hashtag_bundle_usecase.dart';
import 'package:ssoss_flutter/features/hashtag/presentation/cubit/hashtag_catalog_cubit.dart';
import 'package:ssoss_flutter/features/hashtag/presentation/cubit/hashtag_catalog_state.dart';
import 'package:ssoss_flutter/features/home/presentation/pages/home_page.dart';
import 'package:ssoss_flutter/features/recommend_source/presentation/pages/recommend_source_components.dart';
import 'package:ssoss_flutter/features/template/domain/entities/recommended_template.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/list_templates_usecase.dart';
import 'package:ssoss_flutter/features/template/presentation/cubit/template_catalog_cubit.dart';
import 'package:ssoss_flutter/features/template/presentation/cubit/template_catalog_state.dart';
import 'package:ssoss_flutter/features/template/presentation/pages/template_detail/template_detail_page.dart';
import 'package:ssoss_flutter/features/template/presentation/util/template_label_mapper.dart';
import 'package:ssoss_flutter/features/template/presentation/widgets/template_list.dart';
import 'package:ssoss_flutter/features/template/presentation/widgets/template_models.dart';
import 'package:ssoss_flutter/utils/debouncer.dart';

class RecommendSourcePage extends StatelessWidget {
  const RecommendSourcePage({
    super.key,
    this.initialCategory = TemplateCategory.all,
  });

  static const String routeName = 'recommend-source';
  static const String routePath = '/recommend-source';

  final TemplateCategory initialCategory;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = TemplateCatalogCubit(
              listTemplates: context.read<ListTemplatesUseCase>(),
              initialCategory: TemplateLabelMapper.apiCategory(initialCategory),
            );
            unawaited(cubit.loadInitial());
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) => HashtagCatalogCubit(
            listHashtagBundles: context.read<ListHashtagBundlesUseCase>(),
            bookmarkHashtagBundle: context.read<BookmarkHashtagBundleUseCase>(),
            unbookmarkHashtagBundle:
                context.read<UnbookmarkHashtagBundleUseCase>(),
          ),
        ),
      ],
      child: const _RecommendSourceView(),
    );
  }
}

class _RecommendSourceView extends StatefulWidget {
  const _RecommendSourceView();

  @override
  State<_RecommendSourceView> createState() => _RecommendSourceViewState();
}

class _RecommendSourceViewState extends State<_RecommendSourceView> {
  static const List<SsossTabItem> _tabItems = [
    SsossTabItem(label: '템플릿'),
    SsossTabItem(label: '해시태그'),
  ];

  final TextEditingController _searchController = TextEditingController();
  final Debouncer _hashtagSearchDebouncer = Debouncer();
  late final PageController _pageController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedTabIndex);
  }

  @override
  void dispose() {
    _hashtagSearchDebouncer.dispose();
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onTabTap(int index) {
    if (index == _selectedTabIndex) {
      return;
    }
    setState(() => _selectedTabIndex = index);
    _ensureHashtagCatalogLoaded(index);
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
    _ensureHashtagCatalogLoaded(index);
  }

  void _ensureHashtagCatalogLoaded(int tabIndex) {
    if (tabIndex != 1) {
      return;
    }
    final cubit = context.read<HashtagCatalogCubit>();
    final keyword = _searchController.text.trim();
    if (!cubit.state.hasLoaded) {
      if (keyword.isNotEmpty) {
        unawaited(cubit.search(keyword));
      } else {
        unawaited(cubit.ensureLoaded());
      }
      return;
    }
    if (keyword != cubit.state.keyword) {
      unawaited(cubit.search(keyword));
    }
  }

  void _onSearchChanged(String value) {
    if (_selectedTabIndex != 1) {
      return;
    }
    _hashtagSearchDebouncer.run(() {
      if (!mounted) {
        return;
      }
      unawaited(context.read<HashtagCatalogCubit>().search(value));
    });
  }

  void _handleBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.go(HomePage.routePath);
  }

  RecommendSourceHashtagSetItem _toHashtagSetItem(HashtagBundle bundle) {
    return RecommendSourceHashtagSetItem(
      id: bundle.id.toString(),
      title: bundle.name,
      hashtags: bundle.hashtags,
      isSaved: bundle.bookmarked,
    );
  }

  TemplateItem _toTemplateItem(RecommendedTemplate template) {
    return TemplateItem(
      id: template.id,
      category: TemplateLabelMapper.category(template.category),
      title: template.title,
      description: template.description,
      channels: TemplateLabelMapper.channels(template.recommendedChannels),
      isSaved: template.bookmarked,
    );
  }

  Future<void> _toggleHashtagSaved(String itemId) async {
    final bundleId = int.tryParse(itemId);
    if (bundleId == null) {
      return;
    }
    final success =
        await context.read<HashtagCatalogCubit>().toggleBookmark(bundleId);
    if (!mounted || success) {
      return;
    }
    showSsossToast(
      context,
      title: '북마크 변경에 실패했습니다',
      type: SsossToastType.error,
      margin: const EdgeInsets.only(bottom: 122),
    );
  }

  void _openDetail(TemplateItem item) {
    unawaited(
      context.push(
        TemplateDetailPage.routePath,
        extra: item.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isHashtagTab = _selectedTabIndex == 1;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          return;
        }
        _handleBack(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              SsossAppBar.back(
                title: '추천 콘텐츠 소스',
                onBack: () => _handleBack(context),
              ),
              RecommendSourceHeader(
                searchController: _searchController,
                showIntro: isHashtagTab,
                onSearchChanged: _onSearchChanged,
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
                        return BlocBuilder<TemplateCatalogCubit,
                            TemplateCatalogState>(
                          builder: (context, state) {
                            final selectedCategory = state.category == null
                                ? TemplateCategory.all
                                : TemplateLabelMapper.category(state.category!);
                            return TemplateList(
                              items: state.items
                                  .map(_toTemplateItem)
                                  .toList(growable: false),
                              selectedCategory: selectedCategory,
                              isLoading: state.isLoading,
                              isLoadingMore: state.isLoadingMore,
                              hasNext: state.hasNext,
                              errorMessage: state.errorMessage,
                              onCategoryChanged: (category) => unawaited(
                                context
                                    .read<TemplateCatalogCubit>()
                                    .selectCategory(
                                      TemplateLabelMapper.apiCategory(category),
                                    ),
                              ),
                              onSaveTap: (_) {},
                              onItemTap: _openDetail,
                              onLoadMore: () => unawaited(
                                context.read<TemplateCatalogCubit>().loadMore(),
                              ),
                              onRefresh: () => context
                                  .read<TemplateCatalogCubit>()
                                  .refresh(),
                              onRetry: () => unawaited(
                                context
                                    .read<TemplateCatalogCubit>()
                                    .loadInitial(),
                              ),
                            );
                          },
                        );
                      case 1:
                        return BlocBuilder<HashtagCatalogCubit,
                            HashtagCatalogState>(
                          builder: (context, state) {
                            return RecommendSourceHashtagSetList(
                              items: state.items
                                  .map(_toHashtagSetItem)
                                  .toList(growable: false),
                              isLoading: state.isLoading,
                              isLoadingMore: state.isLoadingMore,
                              hasNext: state.hasNext,
                              errorMessage: state.errorMessage,
                              onRetry: () => unawaited(
                                context
                                    .read<HashtagCatalogCubit>()
                                    .loadInitial(),
                              ),
                              onLoadMore: () => unawaited(
                                context.read<HashtagCatalogCubit>().loadMore(),
                              ),
                              onRefresh: () =>
                                  context.read<HashtagCatalogCubit>().refresh(),
                              onSaveTap: (itemId) =>
                                  unawaited(_toggleHashtagSaved(itemId)),
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
      ),
    );
  }
}
