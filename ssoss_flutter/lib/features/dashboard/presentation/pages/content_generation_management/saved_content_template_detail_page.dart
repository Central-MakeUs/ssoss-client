import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_template_contents_card.dart';
import 'package:ssoss_flutter/common/widgets/card/template/ssoss_template_document.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/recommended_content_template_detail/recommended_content_template_detail_components.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/recommended_content_templates/recommended_content_templates_components.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_generation_management/content_generation_management_components.dart';

class SavedContentTemplateDetailPage extends StatelessWidget {
  const SavedContentTemplateDetailPage({
    required this.item,
    super.key,
  });

  final SavedContentTemplateManagementItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            SsossAppBar.back(
              title: '',
              onBack: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: SavedContentTemplateDetailBody(item: item),
            ),
          ],
        ),
      ),
    );
  }
}

class SavedContentTemplateDetailBody extends StatelessWidget {
  const SavedContentTemplateDetailBody({
    required this.item,
    super.key,
  });

  final SavedContentTemplateManagementItem item;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(15, 12, 16, 40),
      children: [
        _SavedTemplateDetailHeader(item: item),
        const SizedBox(height: 24),
        const Divider(height: 1, color: AppColors.neutral200),
        const SizedBox(height: 24),
        _SavedTemplateBodySection(body: item.body),
        const SizedBox(height: 24),
        const ContentTemplateNoticeBox(),
      ],
    );
  }
}

class _SavedTemplateDetailHeader extends StatelessWidget {
  const _SavedTemplateDetailHeader({required this.item});

  final SavedContentTemplateManagementItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContentTemplateCategoryTag(category: item.category),
        const SizedBox(height: 8),
        AppText(
          item.title,
          style: AppTextStyles.h4.copyWith(color: AppColors.neutral800),
        ),
        const SizedBox(height: 2),
        AppText(
          item.description,
          style: AppTextStyles.b4.copyWith(color: AppColors.black),
        ),
        const SizedBox(height: 10),
        ContentTemplateRecommendedChannels(channels: item.channels),
      ],
    );
  }
}

class _SavedTemplateBodySection extends StatelessWidget {
  const _SavedTemplateBodySection({required this.body});

  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: AppText(
                '본문',
                style: AppTextStyles.h5.copyWith(color: AppColors.black),
              ),
            ),
            SizedBox.square(
              dimension: 32,
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.icEdit2,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.neutral500,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SsossTemplateContentsCard(
          width: double.infinity,
          document: SsossTemplateDocument.fromTemplate(body),
          emptySlotColor: AppColors.primary300,
        ),
      ],
    );
  }
}
