import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/recommended_content_template_detail/recommended_content_template_detail_components.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/recommended_content_templates/recommended_content_templates_components.dart';

class RecommendedContentTemplateDetailPage extends StatefulWidget {
  const RecommendedContentTemplateDetailPage({
    required this.item,
    super.key,
  });

  static const String routeName = 'recommended-content-template-detail';
  static const String routePath = '/recommended-content-template-detail';

  final RecommendedContentTemplateItem item;

  @override
  State<RecommendedContentTemplateDetailPage> createState() =>
      _RecommendedContentTemplateDetailPageState();
}

class _RecommendedContentTemplateDetailPageState
    extends State<RecommendedContentTemplateDetailPage> {
  late bool _isSaved = widget.item.isSaved;
  bool _isExampleOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SsossAppBar.back(
        title: '템플릿 미리보기',
        onBack: () => Navigator.of(context).pop(),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(15, 12, 16, 40),
          children: [
            ContentTemplateDetailHeader(item: widget.item),
            const SizedBox(height: 24),
            const Divider(height: 1, color: AppColors.neutral200),
            const SizedBox(height: 24),
            ContentTemplatePreviewSection(
              previewText: _previewText,
              isExampleOpen: _isExampleOpen,
              onExampleTap: () {
                setState(() => _isExampleOpen = !_isExampleOpen);
              },
            ),
            const SizedBox(height: 24),
            const ContentTemplateNoticeBox(),
          ],
        ),
      ),
      bottomNavigationBar: ContentTemplateDetailBottomBar(
        isSaved: _isSaved,
        onSaveTap: () {
          setState(() => _isSaved = !_isSaved);
        },
        onApplyTap: () {},
      ),
    );
  }
}

const String _previewText = '''
[가게명]에 새 메뉴가 출시되었습니다!

✨ 신메뉴: [메뉴명]
💰 가격: [가격]원

[메뉴 설명을 입력해주세요]

신선한 재료로 정성껏 만들었습니다.
많은 사랑 부탁드립니다 🙏

📍 [주소]
⏰ 영업시간: [영업시간]
📞 [전화번호]
''';
