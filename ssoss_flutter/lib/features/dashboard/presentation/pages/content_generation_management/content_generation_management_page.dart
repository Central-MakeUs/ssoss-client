import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/cubit/content_generation_management_cubit.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/cubit/content_generation_management_state.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_detail/content_detail_page.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_generation_management/content_generation_management_components.dart';

class ContentGenerationManagementPage extends StatelessWidget {
  const ContentGenerationManagementPage({super.key});

  static const String routeName = 'content-generation-management';
  static const String routePath = '/content-generation-management';

  static Widget buildAppBar(BuildContext context) {
    return const SsossAppBar.defaultTitle(title: '콘텐츠 생성 관리');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = ContentGenerationManagementCubit();
        unawaited(cubit.loadItems());
        return cubit;
      },
      child: const _ContentGenerationManagementView(),
    );
  }
}

class _ContentGenerationManagementView extends StatelessWidget {
  const _ContentGenerationManagementView();

  static const List<String> _filters = [
    '전체',
    '블로그',
    '인스타그램',
    '당근',
    '스레드',
  ];

  Future<void> _confirmDelete(
    BuildContext context,
    ContentManagementItem item,
  ) async {
    final cubit = context.read<ContentGenerationManagementCubit>();
    final shouldDelete = await showContentDeleteConfirmDialog(context);
    if (!context.mounted || !shouldDelete) {
      return;
    }
    await cubit.deleteItem(item);
  }

  void _openDetail(BuildContext context, ContentManagementItem item) {
    context.read<ContentGenerationManagementCubit>().closeDeleteMenu();
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
    return BlocBuilder<ContentGenerationManagementCubit,
        ContentGenerationManagementState>(
      builder: (context, state) {
        final cubit = context.read<ContentGenerationManagementCubit>();
        final visibleItems = state.visibleItems;

        return ColoredBox(
          color: AppColors.white,
          child: SafeArea(
            top: false,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 3, 16, 34),
              children: [
                ContentManagementFilterBar(
                  filters: _filters,
                  selectedFilter: state.selectedFilter,
                  onFilterSelected: cubit.selectFilter,
                ),
                const SizedBox(height: 12),
                ContentManagementSummaryRow(
                  count: visibleItems.length,
                  sortLabel: state.isLatestFirst ? '최신순' : '오래된순',
                  onSortTap: cubit.toggleSort,
                ),
                const SizedBox(height: 4),
                for (final item in visibleItems) ...[
                  ContentManagementCard(
                    item: item,
                    showDeleteMenu: state.openedMenuItemId == item.id,
                    onTap: () => _openDetail(context, item),
                    onMoreTap: () => cubit.toggleDeleteMenu(item.id),
                    onDeleteTap: () => unawaited(_confirmDelete(context, item)),
                    onReuseTap: () {},
                  ),
                  if (item != visibleItems.last) const SizedBox(height: 12),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
