import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/card/template/ssoss_template_document.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/recommended_content_template_apply/recommended_content_template_apply_components.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/recommended_content_template_edit/recommended_content_template_edit_page.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/recommended_content_template_save_complete/recommended_content_template_save_complete_page.dart';
import 'package:ssoss_flutter/features/content/presentation/pages/recommended_content_templates/recommended_content_templates_components.dart';

class RecommendedContentTemplateApplyPage extends StatefulWidget {
  const RecommendedContentTemplateApplyPage({
    required this.item,
    super.key,
  });

  static const String routeName = 'recommended-content-template-apply';
  static const String routePath = '/recommended-content-template-apply';

  final RecommendedContentTemplateItem item;

  @override
  State<RecommendedContentTemplateApplyPage> createState() =>
      _RecommendedContentTemplateApplyPageState();
}

class _RecommendedContentTemplateApplyPageState
    extends State<RecommendedContentTemplateApplyPage> {
  late SsossTemplateDocument _document = SsossTemplateDocument.fromTemplate(
    _templateTextFor(widget.item),
  );

  Future<void> _openEdit() async {
    final result = await context.push<SsossTemplateDocument>(
      RecommendedContentTemplateEditPage.routePath,
      extra: RecommendedContentTemplateEditArgs(document: _document),
    );
    if (result == null || !mounted) {
      return;
    }
    setState(() => _document = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            SsossAppBar.backWithLabel(
              title: '템플릿 적용',
              label: '닫기',
              onBack: () => context.pop(),
              onDone: () => context.pop(),
            ),
            Expanded(
              child: RecommendedContentTemplateApplyBody(
                document: _document,
                onDocumentChanged: (document) {
                  setState(() => _document = document);
                },
                onEditTap: () => unawaited(_openEdit()),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: RecommendedContentTemplateApplyBottomBar(
        onSaveTap: () {
          context.go(RecommendedContentTemplateSaveCompletePage.routePath);
        },
      ),
    );
  }
}

String _templateTextFor(RecommendedContentTemplateItem item) {
  switch (item.category) {
    case ContentTemplateCategory.newMenu:
      return _newMenuTemplate;
    case ContentTemplateCategory.event:
      return _eventTemplate;
    case ContentTemplateCategory.storeIntro:
      return _storeIntroTemplate;
    case ContentTemplateCategory.notice:
      return _noticeTemplate;
    case ContentTemplateCategory.all:
      return _newMenuTemplate;
  }
}

const String _newMenuTemplate = '''
보니스 커피에 새 메뉴가 출시되었습니다!

✨ 신메뉴: 크림브륄레 커피
💰 가격: [가격]원

[메뉴 설명을 입력해주세요]

신선한 재료로 정성껏 만들었습니다. 많은 사랑 부탁드립니다 🙏

📍 서울 마포구 동교로16길 21
⏰ 영업시간: 수, 목, 금, 토, 일 오전 9:00 ~ 오후 8:00
📞 [전화 번호]''';

const String _eventTemplate = '''
보니스 커피에서 특별 이벤트를 진행합니다!

🎁 이벤트: [이벤트명]
📅 기간: [이벤트 기간]

[이벤트 내용을 입력해주세요]

많은 관심과 참여 부탁드립니다.

📍 서울 마포구 동교로16길 21
⏰ 영업시간: 수, 목, 금, 토, 일 오전 9:00 ~ 오후 8:00
📞 [전화 번호]''';

const String _storeIntroTemplate = '''
보니스 커피를 소개합니다!

[매장 분위기와 장점을 입력해주세요]

편안한 공간에서 좋은 시간을 보내실 수 있도록 정성껏 준비하고 있어요.

📍 서울 마포구 동교로16길 21
⏰ 영업시간: 수, 목, 금, 토, 일 오전 9:00 ~ 오후 8:00
📞 [전화 번호]''';

const String _noticeTemplate = '''
보니스 커피에서 안내드립니다.

📢 공지: [공지 제목]

[공지 내용을 입력해주세요]

이용에 참고 부탁드립니다.

📍 서울 마포구 동교로16길 21
⏰ 영업시간: 수, 목, 금, 토, 일 오전 9:00 ~ 오후 8:00
📞 [전화 번호]''';
