import 'dart:async';

import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_text_field.dart';
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

  final TextEditingController _searchController = TextEditingController();
  late List<RecommendedContentTemplateItem> _items;
  ContentTemplateCategory _selectedCategory = ContentTemplateCategory.all;
  int _selectedTabIndex = 0;
  String _searchKeyword = '';

  @override
  void initState() {
    super.initState();
    _items = List.of(_initialItems);
  }

  @override
  void dispose() {
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

  @override
  Widget build(BuildContext context) {
    final visibleItems = _visibleItems;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SsossAppBar.back(
        title: '추천 콘텐츠 소스',
        onBack: () => Navigator.of(context).pop(),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0, 3, 0, 34),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SsossTextField(
                controller: _searchController,
                height: 44,
                hintText: '템플릿명, 키워드로 검색',
                showSearchIcon: true,
                searchIconColor: AppColors.neutral700,
                hintColor: AppColors.neutral500,
                textColor: AppColors.neutral800,
                onChanged: (value) {
                  setState(() => _searchKeyword = value);
                },
              ),
            ),
            const SizedBox(height: 8),
            ContentTemplateTabBar(
              selectedIndex: _selectedTabIndex,
              onChanged: (index) {
                setState(() => _selectedTabIndex = index);
              },
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ContentTemplateFilterBar(
                selectedCategory: _selectedCategory,
                onChanged: (category) {
                  setState(() => _selectedCategory = category);
                },
              ),
            ),
            const SizedBox(height: 16),
            for (final item in visibleItems) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ContentTemplateCard(
                  item: item,
                  onSaveTap: () => _toggleSaved(item.id),
                  onTap: () => _openDetail(item),
                ),
              ),
              if (item != visibleItems.last) const SizedBox(height: 12),
            ],
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
