import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/delete_content_usecase.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/list_contents_usecase.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/recommended_content_templates/recommended_content_templates_components.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/cubit/content_generation_management_cubit.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/cubit/content_generation_management_state.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_detail/content_detail_page.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_generation_management/content_generation_management_components.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_generation_management/saved_content_template_detail_page.dart';
import 'package:ssoss_flutter/features/new_style/presentation/models/new_style_args.dart';
import 'package:ssoss_flutter/features/new_style/presentation/util/open_new_style_flow.dart';

class ContentGenerationManagementPage extends StatefulWidget {
  const ContentGenerationManagementPage({
    super.key,
    this.isActive = true,
  });

  static const String routeName = 'content-generation-management';
  static const String routePath = '/content-generation-management';

  /// 홈 IndexedStack에서 이 탭이 선택됐는지. true가 되면 목록을 재조회한다.
  final bool isActive;

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

  @override
  void initState() {
    super.initState();
    _cubit = ContentGenerationManagementCubit(
      listContents: context.read<ListContentsUseCase>(),
      deleteContent: context.read<DeleteContentUseCase>(),
    );
    unawaited(_cubit.loadInitial());
  }

  @override
  void didUpdateWidget(covariant ContentGenerationManagementPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isActive && widget.isActive) {
      unawaited(_cubit.refresh());
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
      child: const _ContentGenerationManagementView(),
    );
  }
}

const String _newMenuSavedTemplateBody = '''
보니스 커피에 새 메뉴가 출시되었습니다!

✨ 신메뉴: 크림브륄레 커피
💰 가격: 6,800원

바삭하게 토치로 마무리한 크림브륄레 크림과 깊은 풍미의 커피가 어우러진 시즌 한정 메뉴입니다.

신선한 재료로 정성껏 만들었습니다. 많은 사랑 부탁드립니다 🙏

📍 서울 마포구 동교로16길 21
⏰ 영업시간: 수, 목, 금, 토, 일 오전 9:00 ~ 오후 8:00
📞 02-1234-5678''';

const String _eventSavedTemplateBody = '''
보니스 커피에서 특별 이벤트를 진행합니다!

🎁 이벤트: 주말 한정 디저트 세트 할인
📅 기간: 9월 1일 ~ 9월 7일

매장에서 인기 있는 디저트와 음료를 함께 즐길 수 있는 주말 한정 이벤트입니다.

많은 관심과 참여 부탁드립니다.

📍 서울 마포구 동교로16길 21
⏰ 영업시간: 수, 목, 금, 토, 일 오전 9:00 ~ 오후 8:00
📞 02-1234-5678''';

const String _noticeSavedTemplateBody = '''
보니스 커피에서 안내드립니다.

📢 공지: 임시 휴무 안내

매장 내부 정비로 인해 하루 쉬어갑니다.

이용에 참고 부탁드립니다.

📍 서울 마포구 동교로16길 21
⏰ 영업시간: 수, 목, 금, 토, 일 오전 9:00 ~ 오후 8:00
📞 02-1234-5678''';

class _SavedTemplateList extends StatelessWidget {
  const _SavedTemplateList({
    required this.items,
    required this.scrollController,
  });

  final List<SavedContentTemplateManagementItem> items;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 34),
      itemBuilder: (context, index) {
        final item = items[index];
        return SavedContentTemplateManagementCard(
          item: item,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => SavedContentTemplateDetailPage(item: item),
            ),
          ),
          onMoreTap: () {},
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemCount: items.length,
    );
  }
}

class _ContentGenerationManagementView extends StatefulWidget {
  const _ContentGenerationManagementView();

  @override
  State<_ContentGenerationManagementView> createState() =>
      _ContentGenerationManagementViewState();
}

class _ContentGenerationManagementViewState
    extends State<_ContentGenerationManagementView> {
  static const List<String> _filters = [
    '전체',
    '블로그',
    '인스타그램',
    '당근',
    '스레드',
  ];

  static const List<SavedContentTemplateManagementItem> _templateItems = [
    SavedContentTemplateManagementItem(
      id: 'saved-template-1',
      category: ContentTemplateCategory.newMenu,
      title: '신메뉴 출시 안내',
      description: '새로 나온 메뉴의 특징과 매력을 소개하는 글',
      channels: ['당근', '인스타그램', '스레드'],
      body: _newMenuSavedTemplateBody,
      date: '26.09.02.',
    ),
    SavedContentTemplateManagementItem(
      id: 'saved-template-2',
      category: ContentTemplateCategory.event,
      title: '주말 한정 이벤트 안내',
      description: '기간, 혜택, 참여 방법을 명확하게 전달하는 글',
      channels: ['당근', '인스타그램', '스레드'],
      body: _eventSavedTemplateBody,
      date: '26.09.01.',
    ),
    SavedContentTemplateManagementItem(
      id: 'saved-template-3',
      category: ContentTemplateCategory.notice,
      title: '임시 휴무 안내',
      description: '운영 일정 변경을 고객에게 전달하는 글',
      channels: ['블로그', '인스타그램'],
      body: _noticeSavedTemplateBody,
      date: '26.08.30.',
    ),
  ];

  final ScrollController _scrollController = ScrollController();
  int _selectedTabIndex = 0;

  bool get _isTemplateTab => _selectedTabIndex == 1;

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
    if (_isTemplateTab) {
      return;
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
    context.read<ContentGenerationManagementCubit>().closeDeleteMenu();
    await showContentTitleEditDialog(
      context,
      initialTitle: item.title,
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

  void _onTabSelected(int index) {
    if (index == _selectedTabIndex) {
      return;
    }
    context.read<ContentGenerationManagementCubit>().closeDeleteMenu();
    setState(() => _selectedTabIndex = index);
  }

  Future<void> _openNewStyle(
    BuildContext context,
    ContentManagementItem item,
  ) async {
    context.read<ContentGenerationManagementCubit>().closeDeleteMenu();
    await openNewStyleFlow(
      context,
      args: NewStyleArgs(
        sourceContentId: item.contentId.toString(),
        purpose: item.purpose,
        tone: item.writingTone,
        referenceChannel: item.initialChannel ?? UploadChannel.blog,
        referenceRawText: item.title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContentGenerationManagementCubit,
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
      child: BlocBuilder<ContentGenerationManagementCubit,
          ContentGenerationManagementState>(
        builder: (context, state) {
          final cubit = context.read<ContentGenerationManagementCubit>();

          return GestureDetector(
            onTap:
                state.openedMenuItemId == null ? null : cubit.closeDeleteMenu,
            behavior: HitTestBehavior.opaque,
            child: ColoredBox(
              color: AppColors.white,
              child: SafeArea(
                top: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ContentManagementTabBar(
                      selectedIndex: _selectedTabIndex,
                      onTabSelected: _onTabSelected,
                    ),
                    const SizedBox(height: 16),
                    ColoredBox(
                      color: AppColors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (!_isTemplateTab) ...[
                              ContentManagementFilterBar(
                                filters: _filters,
                                selectedFilter: state.selectedFilter,
                                onFilterSelected: cubit.selectFilter,
                              ),
                              const SizedBox(height: 12),
                            ],
                            ContentManagementSummaryRow(
                              count: _isTemplateTab
                                  ? _templateItems.length
                                  : state.totalCount,
                              sortLabel: state.sortLabel,
                              onSortTap: state.isLoading
                                  ? null
                                  : () => unawaited(cubit.toggleSort()),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: _isTemplateTab
                          ? _SavedTemplateList(
                              items: _templateItems,
                              scrollController: _scrollController,
                            )
                          : CustomScrollView(
                              controller: _scrollController,
                              physics: state.isLoading
                                  ? const NeverScrollableScrollPhysics()
                                  : const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics(),
                                    ),
                              slivers: [
                                if (!state.isLoading)
                                  // 당김 인디케이터가 슬라버 공간을 차지 → 카드는 항상 그 아래
                                  CupertinoSliverRefreshControl(
                                    refreshTriggerPullDistance: 100,
                                    refreshIndicatorExtent: 60,
                                    onRefresh: cubit.refresh,
                                    builder: _buildPullRefreshIndicator,
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
                                    padding: const EdgeInsets.fromLTRB(
                                      16,
                                      4,
                                      16,
                                      0,
                                    ),
                                    sliver: SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        (context, index) {
                                          final item = state.items[index];
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              bottom: index ==
                                                      state.items.length - 1
                                                  ? 0
                                                  : 12,
                                            ),
                                            child: ContentManagementCard(
                                              item: item,
                                              showDeleteMenu:
                                                  state.openedMenuItemId ==
                                                      item.menuId,
                                              onTap: () => unawaited(
                                                _openDetail(context, item),
                                              ),
                                              onMoreTap: () =>
                                                  cubit.toggleDeleteMenu(
                                                item.menuId,
                                              ),
                                              onTitleEditTap: () => unawaited(
                                                _openTitleEditDialog(
                                                  context,
                                                  item,
                                                ),
                                              ),
                                              onDeleteTap: () => unawaited(
                                                _confirmDelete(context, item),
                                              ),
                                              onReuseTap: () => unawaited(
                                                _openNewStyle(context, item),
                                              ),
                                            ),
                                          );
                                        },
                                        childCount: state.items.length,
                                      ),
                                    ),
                                  ),
                                  if (state.isLoadingMore)
                                    const SliverToBoxAdapter(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 24),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: AppColors.primary400,
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    const SliverToBoxAdapter(
                                      child: SizedBox(height: 34),
                                    ),
                                ],
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  static Widget _buildPullRefreshIndicator(
    BuildContext context,
    RefreshIndicatorMode refreshState,
    double pulledExtent,
    double refreshTriggerPullDistance,
    double refreshIndicatorExtent,
  ) {
    // 공간이 부족하면 숨겨서 찌그러짐 방지
    if (pulledExtent < 28) {
      return const SizedBox.shrink();
    }

    final percentage =
        (pulledExtent / refreshTriggerPullDistance).clamp(0.0, 1.0);
    final isRefreshing = refreshState == RefreshIndicatorMode.refresh ||
        refreshState == RefreshIndicatorMode.done;

    return Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          color: AppColors.primary400,
          value: isRefreshing ? null : percentage,
        ),
      ),
    );
  }
}
