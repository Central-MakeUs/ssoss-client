import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/store/domain/entities/store_info.dart';

enum StoreProfileStatus {
  empty,
  partial,
  completed,
}

class StoreProfileEmptyCard extends StatelessWidget {
  const StoreProfileEmptyCard({
    super.key,
    this.onInputTap,
  });

  final VoidCallback? onInputTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 194,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.neutral100,
        border: Border.all(color: AppColors.neutral200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            '아직 매장 정보가 입력되지 않았어요',
            textAlign: TextAlign.center,
            style: AppTextStyles.h4.copyWith(color: AppColors.neutral500),
          ),
          const SizedBox(height: 8),
          AppText(
            '가게 정보를 입력하면\nAI가 더 정확한 콘텐츠를 만들 수 있습니다',
            textAlign: TextAlign.center,
            style: AppTextStyles.b5.copyWith(color: AppColors.neutral400),
          ),
          const SizedBox(height: 24),
          SsossButton(
            label: '매장 정보 입력하기',
            size: SsossButtonSize.medium,
            type: SsossButtonType.outline,
            height: 40,
            onPressed: onInputTap,
          ),
        ],
      ),
    );
  }
}

class StoreProfileTipCard extends StatelessWidget {
  const StoreProfileTipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AppAssets.icBulb,
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  AppColors.primary700,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
              AppText(
                'Tip',
                style: AppTextStyles.h5.copyWith(
                  color: AppColors.primary700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          AppText(
            '정보를 상세히 입력할 수록 콘텐츠가 더 정확해져요',
            style: AppTextStyles.b4.copyWith(color: AppColors.black),
          ),
        ],
      ),
    );
  }
}

class StoreProfileSection extends StatelessWidget {
  const StoreProfileSection({
    required this.title,
    required this.children,
    super.key,
    this.onEditTap,
  });

  final String title;
  final List<Widget> children;
  final VoidCallback? onEditTap;

  @override
  Widget build(BuildContext context) {
    final header = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(
          title,
          style: AppTextStyles.h5.copyWith(color: AppColors.black),
        ),
        const SizedBox(width: 8),
        SvgPicture.asset(
          AppAssets.icEdit2,
          width: 20,
          height: 20,
          colorFilter:
              const ColorFilter.mode(AppColors.primary400, BlendMode.srcIn),
        ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (onEditTap == null)
          header
        else
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onEditTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: header,
            ),
          ),
        const SizedBox(height: 20),
        ...children,
      ],
    );
  }
}

class StoreBasicInfoBlock extends StatelessWidget {
  const StoreBasicInfoBlock({
    required this.status,
    required this.info,
    super.key,
  });

  final StoreProfileStatus status;
  final StoreBasicInfo info;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          info.name ?? '매장 정보 입력 전',
          style: AppTextStyles.h3.copyWith(color: AppColors.black),
        ),
        const SizedBox(height: 12),
        _IconTextRow(
          iconPath: AppAssets.icStore,
          text: info.type?.label ?? '입력 전',
        ),
        const SizedBox(height: 4),
        _IconTextRow(
          iconPath: AppAssets.icLocation,
          text: info.address ?? '',
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.neutral50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                '한 줄 소개',
                style: AppTextStyles.h6.copyWith(
                  color: AppColors.neutral400,
                ),
              ),
              const SizedBox(height: 4),
              AppText(
                info.introduction?.isNotEmpty == true
                    ? info.introduction!
                    : '입력된 소개가 없습니다',
                style: AppTextStyles.b4.copyWith(
                  color: info.introduction?.isNotEmpty == true
                      ? AppColors.neutral800
                      : AppColors.neutral400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StoreOperationInfoBlock extends StatelessWidget {
  const StoreOperationInfoBlock({
    required this.status,
    required this.info,
    super.key,
  });

  final StoreProfileStatus status;
  final StoreOperationInfo info;

  @override
  Widget build(BuildContext context) {
    final days = info.businessDays.map((day) => day.label).join(', ');
    final time = info.openTime != null && info.closeTime != null
        ? '${info.openTime} - ${info.closeTime}'
        : '';
    final businessHours = [
      if (days.isNotEmpty) days,
      if (time.isNotEmpty) time,
    ].join('\n');

    return Column(
      children: [
        StoreProfileInfoRow(
          label: '영업 시간',
          value: businessHours,
        ),
        const SizedBox(height: 16),
        StoreProfileInfoRow(
          label: '대표 메뉴',
          value: info.signatureMenus.join(', '),
        ),
        const SizedBox(height: 16),
        StoreProfileFacilityRow(
          iconPath: AppAssets.icBag,
          label: '포장',
          value: info.takeoutAvailable ? '가능' : '불가',
        ),
        const SizedBox(height: 8),
        StoreProfileFacilityRow(
          iconPath: AppAssets.icCalendar,
          label: '예약',
          value: info.reservationAvailable ? '가능' : '불가',
        ),
        const SizedBox(height: 8),
        StoreProfileFacilityRow(
          iconPath: AppAssets.icParking,
          label: '주차',
          value: info.parkingAvailable ? '가능' : '불가',
        ),
      ],
    );
  }
}

class StoreContentInfoBlock extends StatelessWidget {
  const StoreContentInfoBlock({
    required this.status,
    required this.info,
    super.key,
  });

  final StoreProfileStatus status;
  final StoreContentInfo info;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StoreProfileInfoRow(
          label: '매장 강점',
          value: info.strength ?? '',
        ),
        const SizedBox(height: 29),
        if (info.keywords.isNotEmpty)
          StoreProfileTagRow(
            label: '매장 키워드',
            tags: info.keywords,
          )
        else
          const StoreProfileInfoRow(label: '매장 키워드', value: ''),
        const SizedBox(height: 29),
        StoreProfileInfoRow(
          label: '금지 표현',
          value: info.forbidden ?? '',
        ),
        const SizedBox(height: 29),
        StoreProfileInfoRow(
          label: '콘텐츠\n작성 톤',
          value: info.tone?.label ?? '',
          emphasizeFirstLine: true,
        ),
      ],
    );
  }
}

class StoreProfileTagRow extends StatelessWidget {
  const StoreProfileTagRow({
    required this.label,
    required this.tags,
    super.key,
  });

  final String label;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 76,
          child: AppText(
            label,
            style: AppTextStyles.h6.copyWith(color: AppColors.neutral400),
          ),
        ),
        Expanded(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final tag in tags)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.neutral100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: AppText(
                    tag,
                    style: AppTextStyles.b5.copyWith(
                      color: AppColors.neutral600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class StoreProfileInfoRow extends StatelessWidget {
  const StoreProfileInfoRow({
    required this.label,
    required this.value,
    super.key,
    this.emphasizeFirstLine = false,
  });

  final String label;
  final String value;
  final bool emphasizeFirstLine;

  @override
  Widget build(BuildContext context) {
    final lines = value.split('\n');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 76,
          child: AppText(
            label,
            style: AppTextStyles.h6.copyWith(color: AppColors.neutral400),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var index = 0; index < lines.length; index++)
                AppText(
                  lines[index],
                  style: (emphasizeFirstLine && index == 0
                          ? AppTextStyles.h6
                          : index == 1 && emphasizeFirstLine
                              ? AppTextStyles.b5
                              : AppTextStyles.b4)
                      .copyWith(
                    color: index == 1 && emphasizeFirstLine
                        ? AppColors.neutral600
                        : AppColors.neutral800,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class StoreProfileFacilityRow extends StatelessWidget {
  const StoreProfileFacilityRow({
    required this.iconPath,
    required this.label,
    required this.value,
    super.key,
  });

  final String iconPath;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 76,
          child: Row(
            children: [
              SvgPicture.asset(
                iconPath,
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(
                  AppColors.neutral400,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
              AppText(
                label,
                style: AppTextStyles.h6.copyWith(
                  color: AppColors.neutral400,
                ),
              ),
            ],
          ),
        ),
        AppText(
          value,
          style: AppTextStyles.b4.copyWith(color: AppColors.neutral800),
        ),
      ],
    );
  }
}

class StoreProfileDivider extends StatelessWidget {
  const StoreProfileDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(height: 1, color: AppColors.neutral200);
  }
}

class _IconTextRow extends StatelessWidget {
  const _IconTextRow({
    required this.iconPath,
    required this.text,
  });

  final String iconPath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
          width: 18,
          height: 18,
          colorFilter: const ColorFilter.mode(
            AppColors.neutral800,
            BlendMode.srcIn,
          ),
        ),
        if (text.isNotEmpty) ...[
          const SizedBox(width: 8),
          AppText(
            text,
            style: AppTextStyles.b4.copyWith(color: AppColors.neutral800),
          ),
        ],
      ],
    );
  }
}
