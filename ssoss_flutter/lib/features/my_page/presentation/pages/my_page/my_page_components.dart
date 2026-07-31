import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/tag/ssoss_tag.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

class MyPageStoreSummaryCard extends StatelessWidget {
  const MyPageStoreSummaryCard({
    required this.storeName,
    required this.storeType,
    required this.credit,
    super.key,
    this.description,
    this.onStoreTap,
    this.onChargeTap,
  });

  final String storeName;
  final String storeType;
  final String? description;
  final int credit;
  final VoidCallback? onStoreTap;
  final VoidCallback? onChargeTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: onStoreTap,
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        storeName,
                        style: AppTextStyles.h5.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      AppText(
                        storeType,
                        style: AppTextStyles.h8.copyWith(
                          color: AppColors.neutral400,
                        ),
                      ),
                      if (description != null) ...[
                        const SizedBox(height: 4),
                        AppText(
                          description!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.b5.copyWith(
                            color: AppColors.neutral500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                SvgPicture.asset(
                  AppAssets.icChevronRight,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.neutral400,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(height: 1, color: AppColors.neutral200),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppAssets.icCoins,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColors.neutral500,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 6),
                AppText(
                  '크레딧',
                  style: AppTextStyles.h6.copyWith(
                    color: AppColors.neutral500,
                  ),
                ),
                const Spacer(),
                AppText(
                  '$credit',
                  style: AppTextStyles.h4.copyWith(
                    color: AppColors.primary500,
                  ),
                ),
                const SizedBox(width: 4),
                SvgPicture.asset(
                  AppAssets.icCredit,
                  width: 16,
                  height: 16,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary500,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 12),
                SsossButton(
                  label: '충전하기',
                  size: SsossButtonSize.small,
                  type: SsossButtonType.outline,
                  onPressed: onChargeTap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StoreInfoManagementSection extends StatelessWidget {
  const StoreInfoManagementSection({
    required this.items,
    super.key,
  });

  final List<StoreInfoManagementItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          '매장 정보 관리',
          style: AppTextStyles.h5.copyWith(color: AppColors.black),
        ),
        const SizedBox(height: 4),
        AppText(
          '해당 정보를 바탕으로 콘텐츠를 생성해요',
          style: AppTextStyles.b4.copyWith(color: AppColors.neutral500),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.neutral200),
          ),
          child: Column(
            children: [
              for (final item in items) ...[
                StoreInfoManagementTile(item: item),
                if (item != items.last)
                  Container(height: 1, color: AppColors.neutral100),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class StoreInfoManagementItem {
  const StoreInfoManagementItem({
    required this.title,
    required this.description,
    required this.iconPath,
    this.statusLabel = '입력 전',
    this.isCompleted = false,
    this.onTap,
  });

  final String title;
  final String description;
  final String iconPath;
  final String statusLabel;
  final bool isCompleted;
  final VoidCallback? onTap;
}

class StoreInfoManagementTile extends StatelessWidget {
  const StoreInfoManagementTile({
    required this.item,
    super.key,
  });

  final StoreInfoManagementItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SvgPicture.asset(
                item.iconPath,
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  AppColors.primary300,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: AppText(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.h6.copyWith(
                            color: AppColors.neutral600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SsossTag(
                        label: item.statusLabel,
                        type: SsossTagType.gray,
                        showLeftIcon: false,
                        showRightIcon: false,
                        backgroundColor: item.isCompleted
                            ? AppColors.primary50
                            : AppColors.neutral100,
                        foregroundColor: item.isCompleted
                            ? AppColors.primary500
                            : AppColors.neutral500,
                        textStyle: AppTextStyles.h9,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  AppText(
                    item.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.b5.copyWith(
                      color: AppColors.neutral500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            SvgPicture.asset(
              AppAssets.icChevronRight,
              width: 20,
              height: 20,
              colorFilter: const ColorFilter.mode(
                AppColors.neutral400,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyPageMenuList extends StatelessWidget {
  const MyPageMenuList({
    required this.items,
    super.key,
  });

  final List<MyPageMenuItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final item in items)
          GestureDetector(
            onTap: item.onTap,
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              height: 56,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AppText(
                    item.label,
                    style: AppTextStyles.h5.copyWith(
                      color: AppColors.neutral500,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class MyPageMenuItem {
  const MyPageMenuItem({
    required this.label,
    this.onTap,
  });

  final String label;
  final VoidCallback? onTap;
}
