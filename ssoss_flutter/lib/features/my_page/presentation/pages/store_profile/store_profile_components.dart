import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

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
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.black,
            borderColor: AppColors.neutral200,
            textStyle: AppTextStyles.h8,
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
              const Icon(
                Icons.lightbulb_outline,
                size: 20,
                color: AppColors.primary700,
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
        const Icon(
          Icons.edit_outlined,
          size: 20,
          color: AppColors.primary400,
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
    super.key,
  });

  final StoreProfileStatus status;

  @override
  Widget build(BuildContext context) {
    final isCompleted = status == StoreProfileStatus.completed;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          '보니스 커피',
          style: AppTextStyles.h3.copyWith(color: AppColors.black),
        ),
        const SizedBox(height: 12),
        const _IconTextRow(
          icon: Icons.storefront_outlined,
          text: '베이커리',
        ),
        const SizedBox(height: 4),
        _IconTextRow(
          icon: Icons.location_on_outlined,
          text: isCompleted ? '서울 마포구 동교로16길 21' : '',
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
                isCompleted ? '을지로 베이커리 보니스 커피입니다 :)' : '입력된 소개가 없습니다',
                style: AppTextStyles.b4.copyWith(
                  color:
                      isCompleted ? AppColors.neutral800 : AppColors.neutral400,
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
    super.key,
  });

  final StoreProfileStatus status;

  @override
  Widget build(BuildContext context) {
    final isCompleted = status == StoreProfileStatus.completed;

    return Column(
      children: [
        const StoreProfileInfoRow(
          label: '영업 시간',
          value: '수, 목, 금, 토, 일\n오전 9:00 - 오후 20:00',
        ),
        const SizedBox(height: 16),
        StoreProfileInfoRow(
          label: '대표 메뉴',
          value: isCompleted
              ? '크림브륄레 커피, 아이스 아메리카노,\n프렌치토스트, 크루아상, 벌꿀아이스크림,\n카페 라떼, 아이스티'
              : '',
        ),
        const SizedBox(height: 16),
        StoreProfileFacilityRow(
          icon: Icons.shopping_bag_outlined,
          label: '포장',
          value: isCompleted ? '가능' : '불가',
        ),
        const SizedBox(height: 8),
        StoreProfileFacilityRow(
          icon: Icons.calendar_today_outlined,
          label: '예약',
          value: isCompleted ? '가능' : '불가',
        ),
        const SizedBox(height: 8),
        const StoreProfileFacilityRow(
          icon: Icons.local_parking_outlined,
          label: '주차',
          value: '불가',
        ),
      ],
    );
  }
}

class StoreContentInfoBlock extends StatelessWidget {
  const StoreContentInfoBlock({
    required this.status,
    super.key,
  });

  final StoreProfileStatus status;

  @override
  Widget build(BuildContext context) {
    final isCompleted = status == StoreProfileStatus.completed;

    return Column(
      children: [
        StoreProfileInfoRow(
          label: '매장 강점',
          value: isCompleted
              ? '혼자 방문해도 편한 좌석과 차분한 공간,\n조용히 머물기 좋은 아늑한 매장 분위기'
              : '',
        ),
        const SizedBox(height: 29),
        if (isCompleted)
          const StoreProfileTagRow(
            label: '매장 키워드',
            tags: [
              '크림브륄레 커피',
              '아이스 아메리카노',
              '프렌치토스트',
              '크루아상',
              '벌꿀아이스크림',
              '카페 라떼',
              '아이스티',
            ],
          )
        else
          const StoreProfileInfoRow(label: '매장 키워드', value: ''),
        const SizedBox(height: 29),
        const StoreProfileInfoRow(
          label: '금지 표현',
          value: '과장된 맛 표현 사용 금지,\n가격 중심의 홍보 문구 지양,\n지나치게 가벼운 유행어',
        ),
        const SizedBox(height: 29),
        const StoreProfileInfoRow(
          label: '콘텐츠\n작성 톤',
          value: '일상형\n자연스럽고 편안한 말투',
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
    required this.icon,
    required this.label,
    required this.value,
    super.key,
  });

  final IconData icon;
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
              Icon(icon, size: 16, color: AppColors.neutral400),
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
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.neutral800),
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
