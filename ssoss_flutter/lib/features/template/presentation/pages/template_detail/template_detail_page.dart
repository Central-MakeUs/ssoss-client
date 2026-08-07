import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/template/presentation/pages/template_apply/template_apply_page.dart';
import 'package:ssoss_flutter/features/template/presentation/pages/template_detail/template_detail_components.dart';
import 'package:ssoss_flutter/features/template/presentation/widgets/template_models.dart';

class TemplateDetailPage extends StatefulWidget {
  const TemplateDetailPage({
    required this.item,
    super.key,
    this.onSavedChanged,
  });

  static const String routeName = 'template-detail';
  static const String routePath = '/template-detail';

  final TemplateItem item;

  /// 저장/해제 버튼 탭 직후 호출. `true`면 저장, `false`면 해제.
  final ValueChanged<bool>? onSavedChanged;

  @override
  State<TemplateDetailPage> createState() => _TemplateDetailPageState();
}

class _TemplateDetailPageState extends State<TemplateDetailPage> {
  late bool _isSaved = widget.item.isSaved;
  bool _isExampleOpen = false;

  void _onSaveTap() {
    final nextSaved = !_isSaved;
    setState(() => _isSaved = nextSaved);
    widget.onSavedChanged?.call(nextSaved);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            SsossAppBar.back(
              title: '템플릿 미리보기',
              onBack: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: TemplateDetailBody(
                item: widget.item,
                previewText: _previewText,
                isExampleOpen: _isExampleOpen,
                onExampleTap: () {
                  setState(() => _isExampleOpen = !_isExampleOpen);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: TemplateDetailBottomBar(
        isSaved: _isSaved,
        onSaveTap: _onSaveTap,
        onApplyTap: () {
          unawaited(
            context.push(
              TemplateApplyPage.routePath,
              extra: widget.item,
            ),
          );
        },
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
