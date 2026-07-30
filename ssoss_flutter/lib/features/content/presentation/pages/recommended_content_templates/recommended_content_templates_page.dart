import 'dart:async';

import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/tab/ssoss_tab_bar.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/recommended_content_template_detail/recommended_content_template_detail_page.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/recommended_content_templates/recommended_content_templates_components.dart';

class RecommendedContentTemplatesPage extends StatefulWidget {
  const RecommendedContentTemplatesPage({super.key});

  static const String routeName = 'recommended-content-templates';
  static const String routePath = '/recommended-content-templates';

  @override
  State<RecommendedContentTemplatesPage> createState() =>
      _RecommendedContentTemplatesPageState();
}

class _RecommendedContentTemplatesPageState
    extends State<RecommendedContentTemplatesPage> {
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

  static const List<RecommendedHashtagSetItem> _initialHashtagSets = [
    RecommendedHashtagSetItem(
      id: 'hashtag-1',
      title: '카공 카페',
      hashtags: [
        '#카공',
        '#카공족',
        '#작업하기좋은카페',
        '#작업실',
        '#00동카공',
        '#조용한카페',
        '#스터디',
        '#카공카페',
        '#콘센트',
        '#노트북가능카페',
      ],
    ),
    RecommendedHashtagSetItem(
      id: 'hashtag-2',
      title: '이벤트/할인 홍보',
      hashtags: [
        '#이벤트',
        '#카페이벤트',
        '#할인이벤트',
        '#오늘의이벤트',
        '#주말이벤트',
        '#기간한정',
        '#특별할인',
        '#첫방문할인',
      ],
    ),
    RecommendedHashtagSetItem(
      id: 'hashtag-3',
      title: '동네 고객 유입 해시태그',
      hashtags: [
        '#마포카페',
        '#합정카페',
        '#연남동카페',
        '#홍대카페',
        '#동네카페',
        '#숨은카페',
        '#지역맛집',
        '#연남동핫한카페',
        '#마포인기카페',
      ],
    ),
  ];

  static const List<SsossTabItem> _tabItems = [
    SsossTabItem(label: '템플릿'),
    SsossTabItem(label: '해시태그'),
  ];

  final TextEditingController _searchController = TextEditingController();
  late final PageController _pageController;
  late List<RecommendedContentTemplateItem> _items;
  late List<RecommendedHashtagSetItem> _hashtagSets;
  ContentTemplateCategory _selectedCategory = ContentTemplateCategory.all;
  int _selectedTabIndex = 0;
  String _searchKeyword = '';

  @override
  void initState() {
    super.initState();
    _items = List.of(_initialItems);
    _hashtagSets = List.of(_initialHashtagSets);
    _pageController = PageController(initialPage: _selectedTabIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<RecommendedContentTemplateItem> get _visibleItems {
    final keyword = _searchKeyword.trim();

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

  List<RecommendedHashtagSetItem> get _visibleHashtagSets {
    final keyword = _searchKeyword.trim();
    if (keyword.isEmpty) {
      return _hashtagSets;
    }

    return _hashtagSets.where((item) {
      return item.title.contains(keyword) ||
          item.hashtags.any((hashtag) => hashtag.contains(keyword));
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
  }

  @override
  Widget build(BuildContext context) {
    final visibleItems = _visibleItems;
    final visibleHashtagSets = _visibleHashtagSets;
    final isHashtagTab = _selectedTabIndex == 1;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            SsossAppBar.back(
              title: '추천 콘텐츠 소스',
              onBack: () => Navigator.of(context).pop(),
            ),
            RecommendedContentTemplateHeader(
              searchController: _searchController,
              showIntro: isHashtagTab,
              onSearchChanged: (value) {
                setState(() => _searchKeyword = value);
              },
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
                      return RecommendedHashtagSetList(
                        items: visibleHashtagSets,
                        onSaveTap: _toggleHashtagSaved,
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

  void _toggleHashtagSaved(String itemId) {
    setState(() {
      _hashtagSets = [
        for (final item in _hashtagSets)
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
