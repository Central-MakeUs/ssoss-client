import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/refresh/ssoss_pull_refresh_indicator.dart';
import 'package:ssoss_flutter/common/widgets/tab/ssoss_tab_bar.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/delete_content_usecase.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/list_contents_usecase.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/rename_content_usecase.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/cubit/content_generation_management_cubit.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/cubit/content_generation_management_state.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/cubit/saved_template_management_cubit.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/cubit/saved_template_management_state.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_detail/content_detail_page.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_generation_management/content_generation_management_components.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_generation_management/saved_content_template_detail_page.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/delete_saved_template_usecase.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/list_saved_templates_usecase.dart';
import 'package:ssoss_flutter/features/template/domain/usecases/rename_saved_template_usecase.dart';

class ContentGenerationManagementPage extends StatefulWidget {
  const ContentGenerationManagementPage({
    super.key,
    this.isActive = true,
    this.initialTabIndex = 0,
  });

  static const String routeName = 'content-generation-management';
  static const String routePath = '/content-generation-management';

  /// 홈 IndexedStack에서 이 탭이 선택됐는지. true가 되면 목록을 재조회한다.
  final bool isActive;

  /// 0 = 생성 콘텐츠, 1 = 템플릿.
  final int initialTabIndex;

  static Widget buildAppBar(BuildContext context) {
    return const SsossAppBar.defaultTitle(title: '콘텐츠 생성 관리');
  }

  @override
  State<ContentGenerationManagementPage> createState() =>
      _ContentGenerationManagementPageState();
}

class _ContentGenerationManagementPageState
    extends State<ContentGenerationManagementPage> {
  late final ContentGenerationManagementCubit _cubit;
  late final SavedTemplateManagementCubit _savedTemplateCubit;

  @override
  void initState() {
    super.initState();
    _cubit = ContentGenerationManagementCubit(
      listContents: context.read<ListContentsUseCase>(),
      deleteContent: context.read<DeleteContentUseCase>(),
      renameContent: context.read<RenameContentUseCase>(),
    );
    _savedTemplateCubit = SavedTemplateManagementCubit(
      listSavedTemplates: context.read<ListSavedTemplatesUseCase>(),
      renameSavedTemplate: context.read<RenameSavedTemplateUseCase>(),
      deleteSavedTemplate: context.read<DeleteSavedTemplateUseCase>(),
    );
    unawaited(_cubit.loadInitial());
    unawaited(_savedTemplateCubit.loadInitial());
  }

  @override
  void didUpdateWidget(covariant ContentGenerationManagementPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isActive && widget.isActive) {
      unawaited(_cubit.refresh());
      unawaited(_savedTemplateCubit.refresh());
    }
  }

  @override
  void dispose() {
    unawaited(_cubit.close());
    unawaited(_savedTemplateCubit.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _cubit),
        BlocProvider.value(value: _savedTemplateCubit),
      ],
      child: _ContentGenerationManagementView(
        initialTabIndex: widget.initialTabIndex,
      ),
    );
  }
}

class _ContentGenerationManagementView extends StatefulWidget {
  const _ContentGenerationManagementView({
    this.initialTabIndex = 0,
  });

  final int initialTabIndex;

  @override
  State<_ContentGenerationManagementView> createState() =>
      _ContentGenerationManagementViewState();
}

class _ContentGenerationManagementViewState
    extends State<_ContentGenerationManagementView> {
  static const List<SsossTabItem> _tabItems = [
    SsossTabItem(label: '생성 콘텐츠'),
    SsossTabItem(label: '템플릿'),
  ];

  late final PageController _pageController;
  late int _selectedTabIndex = widget.initialTabIndex;

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

  void _closeMenus() {
    context.read<ContentGenerationManagementCubit>().closeDeleteMenu();
    context.read<SavedTemplateManagementCubit>().closeDeleteMenu();
  }

  void _onTabTap(int index) {
    if (index == _selectedTabIndex) {
      return;
    }
    _closeMenus();
    setState(() => _selectedTabIndex = index);
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
    _closeMenus();
    setState(() => _selectedTabIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ContentGenerationManagementCubit,
            ContentGenerationManagementState>(
          listenWhen: (previous, current) =>
              previous.errorMessage != current.errorMessage &&
              current.errorMessage != null,
          listener: (context, state) {
            final message = state.errorMessage;
            if (message == null) {
              return;
            }
            showSsossToast(
              context,
              title: message,
              type: SsossToastType.error,
            );
          },
        ),
        BlocListener<SavedTemplateManagementCubit,
            SavedTemplateManagementState>(
          listenWhen: (previous, current) =>
              previous.errorMessage != current.errorMessage &&
              current.errorMessage != null,
          listener: (context, state) {
            final message = state.errorMessage;
            if (message == null) {
              return;
            }
            showSsossToast(
              context,
              title: message,
              type: SsossToastType.error,
            );
          },
        ),
      ],
      child: ColoredBox(
        color: AppColors.white,
        child: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                        return const _GeneratedContentTab();
                      case 1:
                        return const _SavedTemplateTab();
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

class _GeneratedContentTab extends StatefulWidget {
  const _GeneratedContentTab();

  @override
  State<_GeneratedContentTab> createState() => _GeneratedContentTabState();
}

class _GeneratedContentTabState extends State<_GeneratedContentTab>
    with AutomaticKeepAliveClientMixin {
  static const List<String> _filters = [
    '전체',
    '블로그',
    '인스타그램',
    '당근',
    '스레드',
  ];

  final ScrollController _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }
    final cubit = context.read<ContentGenerationManagementCubit>();
    if (cubit.state.openedMenuItemId != null) {
      cubit.closeDeleteMenu();
    }
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      unawaited(cubit.loadMore());
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    ContentManagementItem item,
  ) async {
    final cubit = context.read<ContentGenerationManagementCubit>();
    cubit.closeDeleteMenu();
    final shouldDelete = await showContentDeleteConfirmDialog(context);
    if (!context.mounted || !shouldDelete) {
      return;
    }
    await cubit.deleteItem(item);
  }

  Future<void> _openTitleEditDialog(
    BuildContext context,
    ContentManagementItem item,
  ) async {
    final cubit = context.read<ContentGenerationManagementCubit>();
    cubit.closeDeleteMenu();
    await showContentTitleEditDialog(
      context,
      initialTitle: item.name,
      onSave: (title) => cubit.renameItem(item, title),
    );
  }

  Future<void> _openDetail(
    BuildContext context,
    ContentManagementItem item,
  ) async {
    context.read<ContentGenerationManagementCubit>().closeDeleteMenu();
    final didMutate = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => ContentDetailPage(
          contentId: item.contentId,
          initialChannel: item.initialChannel,
        ),
      ),
    );
    if (!context.mounted) {
      return;
    }
    if (didMutate == true) {
      unawaited(context.read<ContentGenerationManagementCubit>().refresh());
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<ContentGenerationManagementCubit,
        ContentGenerationManagementState>(
      builder: (context, state) {
        final cubit = context.read<ContentGenerationManagementCubit>();

        return GestureDetector(
          onTap: state.openedMenuItemId == null ? null : cubit.closeDeleteMenu,
          behavior: HitTestBehavior.opaque,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ContentManagementFilterBar(
                      filters: _filters,
                      selectedFilter: state.selectedFilter,
                      onFilterSelected: cubit.selectFilter,
                    ),
                    const SizedBox(height: 12),
                    ContentManagementSummaryRow(
                      count: state.totalCount,
                      sortLabel: state.sortLabel,
                      onSortTap: state.isLoading
                          ? null
                          : () => unawaited(cubit.toggleSort()),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CustomScrollView(
                  controller: _scrollController,
                  physics: state.isLoading
                      ? const NeverScrollableScrollPhysics()
                      : const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                  slivers: [
                    if (!state.isLoading)
                      CupertinoSliverRefreshControl(
                        refreshTriggerPullDistance: 100,
                        refreshIndicatorExtent: 60,
                        onRefresh: cubit.refresh,
                        builder: buildSsossPullRefreshIndicator,
                      ),
                    if (state.isLoading)
                      const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary400,
                          ),
                        ),
                      )
                    else ...[
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final item = state.items[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      index == state.items.length - 1 ? 0 : 12,
                                ),
                                child: ContentManagementCard(
                                  item: item,
                                  showDeleteMenu:
                                      state.openedMenuItemId == item.menuId,
                                  onTap: () => unawaited(
                                    _openDetail(context, item),
                                  ),
                                  onMoreTap: () => cubit.toggleDeleteMenu(
                                    item.menuId,
                                  ),
                                  onTitleEditTap: () => unawaited(
                                    _openTitleEditDialog(context, item),
                                  ),
                                  onDeleteTap: () => unawaited(
                                    _confirmDelete(context, item),
                                  ),
                                ),
                              );
                            },
                            childCount: state.items.length,
                          ),
                        ),
                      ),
                      _ListBottomSliver(isLoadingMore: state.isLoadingMore),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SavedTemplateTab extends StatefulWidget {
  const _SavedTemplateTab();

  @override
  State<_SavedTemplateTab> createState() => _SavedTemplateTabState();
}

class _SavedTemplateTabState extends State<_SavedTemplateTab>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }
    final cubit = context.read<SavedTemplateManagementCubit>();
    if (cubit.state.openedMenuItemId != null) {
      cubit.closeDeleteMenu();
    }
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      unawaited(cubit.loadMore());
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    SavedContentTemplateManagementItem item,
  ) async {
    final cubit = context.read<SavedTemplateManagementCubit>();
    cubit.closeDeleteMenu();
    await showSavedTemplateDeleteConfirmDialog(
      context,
      onDelete: () => cubit.deleteItem(item),
    );
  }

  Future<void> _openTitleEditDialog(
    BuildContext context,
    SavedContentTemplateManagementItem item,
  ) async {
    final cubit = context.read<SavedTemplateManagementCubit>();
    cubit.closeDeleteMenu();
    await showContentTitleEditDialog(
      context,
      initialTitle: item.title,
      onSave: (title) => cubit.renameItem(item, title),
    );
  }

  Future<void> _openDetail(
    BuildContext context,
    SavedContentTemplateManagementItem item,
  ) async {
    context.read<SavedTemplateManagementCubit>().closeDeleteMenu();
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => SavedContentTemplateDetailPage(
          savedTemplateId: item.savedTemplateId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<SavedTemplateManagementCubit,
        SavedTemplateManagementState>(
      builder: (context, state) {
        final cubit = context.read<SavedTemplateManagementCubit>();

        return GestureDetector(
          onTap: state.openedMenuItemId == null ? null : cubit.closeDeleteMenu,
          behavior: HitTestBehavior.opaque,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ContentManagementSummaryRow(
                  count: state.totalCount,
                  sortLabel: state.sortLabel,
                  onSortTap: state.isLoading
                      ? null
                      : () => unawaited(cubit.toggleSort()),
                ),
              ),
              Expanded(
                child: CustomScrollView(
                  controller: _scrollController,
                  physics: state.isLoading
                      ? const NeverScrollableScrollPhysics()
                      : const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                  slivers: [
                    if (!state.isLoading)
                      CupertinoSliverRefreshControl(
                        refreshTriggerPullDistance: 100,
                        refreshIndicatorExtent: 60,
                        onRefresh: cubit.refresh,
                        builder: buildSsossPullRefreshIndicator,
                      ),
                    if (state.isLoading)
                      const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary400,
                          ),
                        ),
                      )
                    else ...[
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final item = state.items[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      index == state.items.length - 1 ? 0 : 12,
                                ),
                                child: SavedContentTemplateManagementCard(
                                  item: item,
                                  showDeleteMenu:
                                      state.openedMenuItemId == item.menuId,
                                  onTap: () => unawaited(
                                    _openDetail(context, item),
                                  ),
                                  onMoreTap: () => cubit.toggleDeleteMenu(
                                    item.menuId,
                                  ),
                                  onTitleEditTap: () => unawaited(
                                    _openTitleEditDialog(context, item),
                                  ),
                                  onDeleteTap: () => unawaited(
                                    _confirmDelete(context, item),
                                  ),
                                ),
                              );
                            },
                            childCount: state.items.length,
                          ),
                        ),
                      ),
                      _ListBottomSliver(isLoadingMore: state.isLoadingMore),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ListBottomSliver extends StatelessWidget {
  const _ListBottomSliver({required this.isLoadingMore});

  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    if (isLoadingMore) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Center(
            child: CircularProgressIndicator(
              color: AppColors.primary400,
            ),
          ),
        ),
      );
    }
    return const SliverToBoxAdapter(
      child: SizedBox(height: 34),
    );
  }
}
