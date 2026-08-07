import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/tab/ssoss_tab_bar.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/recommended_content_template_detail/recommended_content_template_detail_page.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/recommended_content_templates/recommended_content_templates_components.dart';
import 'package:ssoss_flutter/features/hashtag/domain/entities/hashtag_bundle.dart';
import 'package:ssoss_flutter/features/hashtag/domain/usecases/list_bookmarked_hashtag_bundles_usecase.dart';
import 'package:ssoss_flutter/features/hashtag/domain/usecases/unbookmark_hashtag_bundle_usecase.dart';
import 'package:ssoss_flutter/features/hashtag/presentation/cubit/bookmarked_hashtag_bundles_cubit.dart';
import 'package:ssoss_flutter/features/hashtag/presentation/cubit/bookmarked_hashtag_bundles_state.dart';
import 'package:ssoss_flutter/features/my_page/presentation/pages/saved_content_sources/saved_content_sources_components.dart';

class SavedContentSourcesPage extends StatelessWidget {
  const SavedContentSourcesPage({super.key});

  static const String routeName = 'saved-content-sources';
  static const String routePath = '/saved-content-sources';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookmarkedHashtagBundlesCubit(
        listBookmarkedHashtagBundles:
            context.read<ListBookmarkedHashtagBundlesUseCase>(),
        unbookmarkHashtagBundle: context.read<UnbookmarkHashtagBundleUseCase>(),
      ),
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

  /// TODO: 템플릿 북마크 API 연동 시 제거
  static const List<RecommendedContentTemplateItem> _dummyTemplates = [
    RecommendedContentTemplateItem(
      id: 'saved-template-1',
      category: ContentTemplateCategory.newMenu,
      title: '신메뉴 출시 안내',
      description: '새로 나온 메뉴의 특징과 매력을 소개하는 글',
      channels: ['당근', '인스타그램', '스레드'],
      isSaved: true,
    ),
  ];

  late final PageController _pageController;
  late List<RecommendedContentTemplateItem> _templateItems;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _templateItems = List.of(_dummyTemplates);
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

  RecommendedHashtagSetItem _toHashtagSetItem(HashtagBundle bundle) {
    return RecommendedHashtagSetItem(
      id: bundle.id.toString(),
      title: bundle.name,
      hashtags: bundle.hashtags,
      isSaved: true,
    );
  }

  void _unbookmarkTemplate(String itemId) {
    final hadItem = _templateItems.any((item) => item.id == itemId);
    if (!hadItem) {
      return;
    }
    setState(() {
      _templateItems = [
        for (final item in _templateItems)
          if (item.id != itemId) item,
      ];
    });
    // TODO: 템플릿 북마크 해제 API 연동
    showSsossToast(
      context,
      title: '북마크가 해제되었습니다',
      type: SsossToastType.info,
      margin: const EdgeInsets.only(bottom: 122),
    );
  }

  void _restoreTemplate(RecommendedContentTemplateItem item) {
    if (_templateItems.any((template) => template.id == item.id)) {
      return;
    }
    setState(() {
      _templateItems = [
        ..._templateItems,
        item.copyWith(isSaved: true),
      ];
    });
  }

  void _openTemplateDetail(RecommendedContentTemplateItem item) {
    unawaited(
      Navigator.of(context, rootNavigator: true).push<void>(
        MaterialPageRoute<void>(
          builder: (_) => RecommendedContentTemplateDetailPage(
            item: item,
            onSavedChanged: (isSaved) {
              if (!isSaved) {
                _unbookmarkTemplate(item.id);
                return;
              }
              _restoreTemplate(item);
            },
          ),
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
        margin: const EdgeInsets.only(bottom: 122),
      );
      return;
    }
    showSsossToast(
      context,
      title: '북마크 해제에 실패했습니다',
      type: SsossToastType.error,
      margin: const EdgeInsets.only(bottom: 122),
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
                      return SavedContentSourcesTemplateList(
                        items: _templateItems,
                        onSaveTap: _unbookmarkTemplate,
                        onItemTap: _openTemplateDetail,
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
