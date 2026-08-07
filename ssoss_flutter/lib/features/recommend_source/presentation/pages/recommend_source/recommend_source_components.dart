import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/common/widgets/input/ssoss_text_field.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/template/presentation/widgets/template_list.dart';

class RecommendSourceHashtagSetItem {
  const RecommendSourceHashtagSetItem({
    required this.id,
    required this.title,
    required this.hashtags,
    this.isSaved = false,
  });

  final String id;
  final String title;
  final List<String> hashtags;
  final bool isSaved;

  RecommendSourceHashtagSetItem copyWith({bool? isSaved}) {
    return RecommendSourceHashtagSetItem(
      id: id,
      title: title,
      hashtags: hashtags,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}

class RecommendSourceHeader extends StatelessWidget {
  const RecommendSourceHeader({
    required this.searchController,
    required this.onSearchChanged,
    this.showIntro = false,
    super.key,
  });

  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final bool showIntro;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showIntro) ...[
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: RecommendSourceIntro(),
          ),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RecommendSourceSearchField(
            controller: searchController,
            onChanged: onSearchChanged,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class RecommendSourceIntro extends StatelessWidget {
  const RecommendSourceIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: AppText(
        '상황에 맞는 템플릿과\n해시태그를 골라 바로 활용해보세요',
        style: AppTextStyles.h4.copyWith(color: AppColors.black),
      ),
    );
  }
}

class RecommendSourceSearchField extends StatelessWidget {
  const RecommendSourceSearchField({
    required this.controller,
    required this.onChanged,
    super.key,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SsossTextField(
      controller: controller,
      hintText: '템플릿명, 키워드로 검색',
      showSearchIcon: true,
      searchIconColor: AppColors.neutral700,
      hintColor: AppColors.neutral500,
      textColor: AppColors.neutral800,
      onChanged: onChanged,
    );
  }
}

class RecommendSourceHashtagSetList extends StatefulWidget {
  const RecommendSourceHashtagSetList({
    required this.items,
    required this.onSaveTap,
    required this.onLoadMore,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.errorMessage,
    this.onRetry,
    super.key,
  });

  final List<RecommendSourceHashtagSetItem> items;
  final ValueChanged<String> onSaveTap;
  final VoidCallback onLoadMore;
  final bool isLoading;
  final bool isLoadingMore;
  final String? errorMessage;
  final VoidCallback? onRetry;

  @override
  State<RecommendSourceHashtagSetList> createState() =>
      _RecommendSourceHashtagSetListState();
}

class _RecommendSourceHashtagSetListState
    extends State<RecommendSourceHashtagSetList> {
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
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      widget.onLoadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary400),
      );
    }

    if (widget.errorMessage != null && widget.items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                widget.errorMessage!,
                textAlign: TextAlign.center,
                style: AppTextStyles.b3.copyWith(color: AppColors.neutral500),
              ),
              if (widget.onRetry != null) ...[
                const SizedBox(height: 16),
                TextButton(
                  onPressed: widget.onRetry,
                  child: AppText(
                    '다시 시도',
                    style:
                        AppTextStyles.b3.copyWith(color: AppColors.primary400),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }

    if (widget.items.isEmpty) {
      return Center(
        child: AppText(
          '해시태그 묶음이 없습니다',
          style: AppTextStyles.b3.copyWith(color: AppColors.neutral500),
        ),
      );
    }

    final itemCount = widget.items.length + (widget.isLoadingMore ? 1 : 0);

    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
      itemBuilder: (context, index) {
        if (index >= widget.items.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: CircularProgressIndicator(color: AppColors.primary400),
            ),
          );
        }

        final item = widget.items[index];
        return RecommendSourceHashtagSetCard(
          item: item,
          onSaveTap: () => widget.onSaveTap(item.id),
        );
      },
      separatorBuilder: (_, index) {
        if (index >= widget.items.length - 1 && widget.isLoadingMore) {
          return const SizedBox.shrink();
        }
        return const SizedBox(height: 18);
      },
      itemCount: itemCount,
    );
  }
}

class RecommendSourceHashtagSetCard extends StatelessWidget {
  const RecommendSourceHashtagSetCard({
    required this.item,
    required this.onSaveTap,
    super.key,
  });

  final RecommendSourceHashtagSetItem item;
  final VoidCallback onSaveTap;

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: item.hashtags.join(' ')));
    if (!context.mounted) {
      return;
    }
    showSsossToast(
      context,
      title: '클립보드에 복사되었습니다',
      margin: const EdgeInsets.only(bottom: 122),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.neutral200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RecommendSourceHashtagSetHeader(
                  item: item,
                  onSaveTap: onSaveTap,
                ),
                const SizedBox(height: 16),
                RecommendSourceHashtagWrap(hashtags: item.hashtags),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.neutral200),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RecommendSourceHashtagCopyButton(
                  onTap: () => unawaited(_copy(context)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RecommendSourceHashtagSetHeader extends StatelessWidget {
  const RecommendSourceHashtagSetHeader({
    required this.item,
    required this.onSaveTap,
    super.key,
  });

  final RecommendSourceHashtagSetItem item;
  final VoidCallback onSaveTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Flexible(
                child: AppText(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.h5.copyWith(color: AppColors.black),
                ),
              ),
              const SizedBox(width: 6),
              AppText(
                '${item.hashtags.length}개',
                style: AppTextStyles.b5.copyWith(color: AppColors.neutral400),
              ),
            ],
          ),
        ),
        TemplateSaveButton(
          isSaved: item.isSaved,
          onTap: onSaveTap,
        ),
      ],
    );
  }
}

class RecommendSourceHashtagWrap extends StatelessWidget {
  const RecommendSourceHashtagWrap({
    required this.hashtags,
    super.key,
  });

  final List<String> hashtags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 8,
      children: [
        for (final hashtag in hashtags)
          RecommendSourceHashtagChip(label: hashtag),
      ],
    );
  }
}

class RecommendSourceHashtagChip extends StatelessWidget {
  const RecommendSourceHashtagChip({
    required this.label,
    super.key,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.neutral100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: AppText(
        label,
        style: AppTextStyles.b5.copyWith(color: AppColors.neutral500),
      ),
    );
  }
}

class RecommendSourceHashtagCopyButton extends StatelessWidget {
  const RecommendSourceHashtagCopyButton({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 32,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AppAssets.icCopy,
                width: 18,
                height: 18,
                colorFilter: const ColorFilter.mode(
                  AppColors.neutral500,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 4),
              AppText(
                '복사하기',
                style: AppTextStyles.h8.copyWith(
                  color: AppColors.neutral500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
