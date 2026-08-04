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
import 'package:ssoss_flutter/features/dashboard/presentation/cubit/content_generation_management_cubit.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/cubit/content_generation_management_state.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_detail/content_detail_page.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_generation_management/content_generation_management_components.dart';
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

  final ScrollController _scrollController = ScrollController();

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
                    ColoredBox(
                      color: AppColors.white,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 3, 16, 0),
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
                              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    final item = state.items[index];
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        bottom: index == state.items.length - 1
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
                                            cubit.toggleDeleteMenu(item.menuId),
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
                                  padding: EdgeInsets.symmetric(vertical: 24),
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
