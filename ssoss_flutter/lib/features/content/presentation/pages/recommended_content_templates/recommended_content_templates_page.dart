import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/tab/ssoss_tab_bar.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/recommended_content_template_detail/recommended_content_template_detail_page.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/recommended_content_templates/recommended_content_templates_components.dart';
import 'package:ssoss_flutter/features/hashtag/domain/entities/hashtag_bundle.dart';
import 'package:ssoss_flutter/features/hashtag/domain/usecases/bookmark_hashtag_bundle_usecase.dart';
import 'package:ssoss_flutter/features/hashtag/domain/usecases/list_hashtag_bundles_usecase.dart';
import 'package:ssoss_flutter/features/hashtag/domain/usecases/unbookmark_hashtag_bundle_usecase.dart';
import 'package:ssoss_flutter/features/hashtag/presentation/cubit/hashtag_catalog_cubit.dart';
import 'package:ssoss_flutter/features/hashtag/presentation/cubit/hashtag_catalog_state.dart';
import 'package:ssoss_flutter/features/home/presentation/pages/home_page.dart';
import 'package:ssoss_flutter/utils/debouncer.dart';

class RecommendedContentTemplatesPage extends StatelessWidget {
  const RecommendedContentTemplatesPage({
    super.key,
    this.initialCategory = ContentTemplateCategory.all,
  });

  static const String routeName = 'recommended-content-templates';
  static const String routePath = '/recommended-content-templates';

  final ContentTemplateCategory initialCategory;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HashtagCatalogCubit(
        listHashtagBundles: context.read<ListHashtagBundlesUseCase>(),
        bookmarkHashtagBundle: context.read<BookmarkHashtagBundleUseCase>(),
        unbookmarkHashtagBundle: context.read<UnbookmarkHashtagBundleUseCase>(),
      ),
      child: _RecommendedContentTemplatesView(
        initialCategory: initialCategory,
      ),
    );
  }
}

class _RecommendedContentTemplatesView extends StatefulWidget {
  const _RecommendedContentTemplatesView({
    required this.initialCategory,
  });

  final ContentTemplateCategory initialCategory;

  @override
  State<_RecommendedContentTemplatesView> createState() =>
      _RecommendedContentTemplatesViewState();
}

class _RecommendedContentTemplatesViewState
    extends State<_RecommendedContentTemplatesView> {
  static const List<RecommendedContentTemplateItem> _initialItems = [
    RecommendedContentTemplateItem(
      id: 'template-1',
      category: ContentTemplateCategory.newMenu,
      title: '신메뉴 출시 안내',
      description: '새로 나온 메뉴의 특징과 매력을 소개하는 글',
      channels: ['당근', '인스타그램', '스레드'],
    ),
    RecommendedContentTemplateItem(
      id: 'template-2',
      category: ContentTemplateCategory.event,
      title: '주말 한정 이벤트 안내',
      description: '기간, 혜택, 참여 방법을 명확하게 전달하는 글',
      channels: ['당근', '인스타그램', '스레드'],
    ),
    RecommendedContentTemplateItem(
      id: 'template-3',
      category: ContentTemplateCategory.notice,
      title: '임시 휴무 안내',
      description: '운영 일정 변경을 고객에게 전달하는 글',
      channels: ['블로그', '인스타그램'],
    ),
    RecommendedContentTemplateItem(
      id: 'template-4',
      category: ContentTemplateCategory.storeIntro,
      title: '매장 분위기 소개',
      description: '우리 가게의 공간감과 장점을 소개하는 글',
      channels: ['인스타그램', '스레드'],
    ),
  ];

  static const List<SsossTabItem> _tabItems = [
    SsossTabItem(label: '템플릿'),
    SsossTabItem(label: '해시태그'),
  ];

  final TextEditingController _searchController = TextEditingController();
  final Debouncer _hashtagSearchDebouncer = Debouncer();
  late final PageController _pageController;
  late List<RecommendedContentTemplateItem> _items;
  late ContentTemplateCategory _selectedCategory;
  int _selectedTabIndex = 0;
  String _templateSearchKeyword = '';

  @override
  void initState() {
    super.initState();
    _items = List.of(_initialItems);
    _selectedCategory = widget.initialCategory;
    _pageController = PageController(initialPage: _selectedTabIndex);
  }

  @override
  void dispose() {
    _hashtagSearchDebouncer.dispose();
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<RecommendedContentTemplateItem> get _visibleItems {
    final keyword = _templateSearchKeyword.trim();

    return _items.where((item) {
      final matchesCategory =
          _selectedCategory == ContentTemplateCategory.all ||
              item.category == _selectedCategory;
      final matchesKeyword = keyword.isEmpty ||
          item.title.contains(keyword) ||
          item.description.contains(keyword) ||
          item.channels.any((channel) => channel.contains(keyword));

      return matchesCategory && matchesKeyword;
    }).toList();
  }

  void _onTabTap(int index) {
    if (index == _selectedTabIndex) {
      return;
    }
    setState(() {
      _selectedTabIndex = index;
      if (index == 1) {
        _selectedCategory = ContentTemplateCategory.all;
      }
    });
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
    setState(() {
      _selectedTabIndex = index;
      if (index == 1) {
        _selectedCategory = ContentTemplateCategory.all;
      }
    });
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
    if (_selectedTabIndex == 1) {
      _hashtagSearchDebouncer.run(() {
        if (!mounted) {
          return;
        }
        unawaited(context.read<HashtagCatalogCubit>().search(value));
      });
      return;
    }

    setState(() => _templateSearchKeyword = value);
  }

  void _handleBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.go(HomePage.routePath);
  }

  RecommendedHashtagSetItem _toHashtagSetItem(HashtagBundle bundle) {
    return RecommendedHashtagSetItem(
      id: bundle.id.toString(),
      title: bundle.name,
      hashtags: bundle.hashtags,
      isSaved: bundle.bookmarked,
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

  @override
  Widget build(BuildContext context) {
    final visibleItems = _visibleItems;
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
              RecommendedContentTemplateHeader(
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
                        return RecommendedContentTemplateList(
                          items: visibleItems,
                          selectedCategory: _selectedCategory,
                          onCategoryChanged: (category) {
                            setState(() => _selectedCategory = category);
                          },
                          onSaveTap: _toggleSaved,
                          onItemTap: _openDetail,
                        );
                      case 1:
                        return BlocBuilder<HashtagCatalogCubit,
                            HashtagCatalogState>(
                          builder: (context, state) {
                            return RecommendedHashtagSetList(
                              items: state.items
                                  .map(_toHashtagSetItem)
                                  .toList(growable: false),
                              isLoading: state.isLoading,
                              isLoadingMore: state.isLoadingMore,
                              errorMessage: state.errorMessage,
                              onRetry: () => unawaited(
                                context
                                    .read<HashtagCatalogCubit>()
                                    .loadInitial(),
                              ),
                              onLoadMore: () => unawaited(
                                context.read<HashtagCatalogCubit>().loadMore(),
                              ),
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

  void _toggleSaved(String itemId) {
    setState(() {
      _items = [
        for (final item in _items)
          if (item.id == itemId)
            item.copyWith(isSaved: !item.isSaved)
          else
            item,
      ];
    });
  }

  void _openDetail(RecommendedContentTemplateItem item) {
    unawaited(
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => RecommendedContentTemplateDetailPage(item: item),
        ),
      ),
    );
  }
}
