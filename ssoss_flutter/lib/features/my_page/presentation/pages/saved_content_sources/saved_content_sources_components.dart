import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/recommend_source/presentation/pages/recommend_source_components.dart';
import 'package:ssoss_flutter/features/template/presentation/widgets/template_list.dart';
import 'package:ssoss_flutter/features/template/presentation/widgets/template_models.dart';

class SavedContentSourcesCountHeader extends StatelessWidget {
  const SavedContentSourcesCountHeader({
    required this.count,
    super.key,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: AppText(
        '$count건',
        style: AppTextStyles.h7.copyWith(color: AppColors.neutral400),
      ),
    );
  }
}

class SavedContentSourcesTemplateList extends StatelessWidget {
  const SavedContentSourcesTemplateList({
    required this.items,
    required this.onSaveTap,
    super.key,
    this.onItemTap,
  });

  final List<TemplateItem> items;
  final ValueChanged<int> onSaveTap;
  final ValueChanged<TemplateItem>? onItemTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SavedContentSourcesCountHeader(count: items.length),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: items.isEmpty
              ? Center(
                  child: AppText(
                    '저장한 템플릿이 없습니다',
                    style: AppTextStyles.b3.copyWith(
                      color: AppColors.neutral500,
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 34),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return TemplateCard(
                      item: item,
                      onSaveTap: () => onSaveTap(item.id),
                      onTap: onItemTap == null ? null : () => onItemTap!(item),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class SavedContentSourcesHashtagList extends StatelessWidget {
  const SavedContentSourcesHashtagList({
    required this.items,
    required this.onSaveTap,
    this.isLoading = false,
    this.errorMessage,
    this.onRetry,
    super.key,
  });

  final List<RecommendSourceHashtagSetItem> items;
  final ValueChanged<String> onSaveTap;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    if (isLoading && items.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary400),
      );
    }

    if (errorMessage != null && items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                errorMessage!,
                textAlign: TextAlign.center,
                style: AppTextStyles.b3.copyWith(color: AppColors.neutral500),
              ),
              if (onRetry != null) ...[
                const SizedBox(height: 16),
                SsossButton(
                  label: '다시 시도',
                  size: SsossButtonSize.small,
                  type: SsossButtonType.outline,
                  onPressed: onRetry,
                ),
              ],
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SavedContentSourcesCountHeader(count: items.length),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: items.isEmpty
              ? Center(
                  child: AppText(
                    '저장한 해시태그가 없습니다',
                    style: AppTextStyles.b3.copyWith(
                      color: AppColors.neutral500,
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 34),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 18),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return RecommendSourceHashtagSetCard(
                      item: item,
                      onSaveTap: () => onSaveTap(item.id),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
