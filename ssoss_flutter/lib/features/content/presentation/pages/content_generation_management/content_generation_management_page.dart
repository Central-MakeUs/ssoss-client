import 'dart:async';

import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_detail/content_detail_page.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/content_generation_management/content_generation_management_components.dart';

class ContentGenerationManagementPage extends StatefulWidget {
  const ContentGenerationManagementPage({super.key});

  static const String routeName = 'content-generation-management';
  static const String routePath = '/content-generation-management';

  static Widget buildAppBar(BuildContext context) {
    return const SsossAppBar.defaultTitle(title: '콘텐츠 생성 관리');
  }

  @override
  State<ContentGenerationManagementPage> createState() =>
      _ContentGenerationManagementPageState();
}

class _ContentGenerationManagementPageState
    extends State<ContentGenerationManagementPage> {
  static const List<String> _filters = [
    '전체',
    '블로그',
    '인스타그램',
    '당근',
    '스레드',
  ];

  static const List<ContentManagementItem> _initialItems = [
    ContentManagementItem(
      id: 'content-1',
      date: '26.09.01',
      channel: '블로그',
      category: '정보성',
      tone: '일상형',
      title: '을지로 크루아상 맛집 | 겹겹이 살아있는 바삭함',
      tags: ['#을지로카페', '#을지로크루아상'],
    ),
    ContentManagementItem(
      id: 'content-2',
      date: '26.08.23',
      channel: '블로그',
      category: '이벤트/할인',
      tone: '일상형',
      title: '신메뉴 앙버터 토스트 출시! 선착순 이벤트',
      tags: ['#을지로카페', '#을지로토스트'],
    ),
    ContentManagementItem(
      id: 'content-3',
      date: '26.08.20',
      channel: '블로그',
      category: '정보성',
      tone: '일상형',
      title: '녹차라떼 리뉴얼 소식! 진하고 향긋한 맛',
      tags: ['#을지로카페', '#녹차라떼맛집'],
    ),
  ];

  late List<ContentManagementItem> _items;
  String _selectedFilter = '전체';
  bool _isLatestFirst = true;
  String? _openedMenuItemId;

  @override
  void initState() {
    super.initState();
    _items = List.of(_initialItems);
  }

  List<ContentManagementItem> get _visibleItems {
    final filteredItems = _selectedFilter == '전체'
        ? _items
        : _items.where((item) => item.channel == _selectedFilter).toList();
    return _isLatestFirst ? filteredItems : filteredItems.reversed.toList();
  }

  void _toggleSort() {
    setState(() {
      _isLatestFirst = !_isLatestFirst;
      _openedMenuItemId = null;
    });
  }

  void _toggleDeleteMenu(String itemId) {
    setState(() {
      _openedMenuItemId = _openedMenuItemId == itemId ? null : itemId;
    });
  }

  Future<void> _confirmDelete(ContentManagementItem item) async {
    setState(() => _openedMenuItemId = null);

    final shouldDelete = await showContentDeleteConfirmDialog(context);
    if (!mounted || !shouldDelete) {
      return;
    }

    setState(() {
      _items.removeWhere((content) => content.id == item.id);
    });
  }

  void _openDetail(ContentManagementItem item) {
    setState(() => _openedMenuItemId = null);
    unawaited(
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => ContentDetailPage(item: item),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleItems = _visibleItems;

    return ColoredBox(
      color: AppColors.white,
      child: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 3, 16, 34),
          children: [
            ContentManagementFilterBar(
              filters: _filters,
              selectedFilter: _selectedFilter,
              onFilterSelected: (filter) {
                setState(() {
                  _selectedFilter = filter;
                  _openedMenuItemId = null;
                });
              },
            ),
            const SizedBox(height: 12),
            ContentManagementSummaryRow(
              count: visibleItems.length,
              sortLabel: _isLatestFirst ? '최신순' : '오래된순',
              onSortTap: _toggleSort,
            ),
            const SizedBox(height: 4),
            for (final item in visibleItems) ...[
              ContentManagementCard(
                item: item,
                showDeleteMenu: _openedMenuItemId == item.id,
                onTap: () => _openDetail(item),
                onMoreTap: () => _toggleDeleteMenu(item.id),
                onDeleteTap: () => _confirmDelete(item),
                onReuseTap: () {},
              ),
              if (item != visibleItems.last) const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}
