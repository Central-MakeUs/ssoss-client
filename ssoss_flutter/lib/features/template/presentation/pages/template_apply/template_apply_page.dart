import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/card/template/ssoss_template_document.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/features/store/domain/entities/store_info.dart';
import 'package:ssoss_flutter/features/store/presentation/cubit/store_cubit.dart';
import 'package:ssoss_flutter/features/template/presentation/pages/template_apply/template_apply_components.dart';
import 'package:ssoss_flutter/features/template/presentation/pages/template_edit/template_edit_page.dart';
import 'package:ssoss_flutter/features/template/presentation/pages/template_save_complete/template_save_complete_page.dart';
import 'package:ssoss_flutter/features/template/presentation/widgets/template_models.dart';

class TemplateApplyPage extends StatefulWidget {
  const TemplateApplyPage({
    required this.item,
    super.key,
  });

  static const String routeName = 'template-apply';
  static const String routePath = '/template-apply';

  final TemplateItem item;

  @override
  State<TemplateApplyPage> createState() => _TemplateApplyPageState();
}

class _TemplateApplyPageState extends State<TemplateApplyPage> {
  late SsossTemplateDocument _document;
  late bool _hasStoreInfo;

  @override
  void initState() {
    super.initState();
    final storeInfo = context.read<StoreCubit>().state.info;
    _hasStoreInfo = storeInfo.basic.status.isCompleted;
    _document = SsossTemplateDocument.fromTemplate(
      _templateTextFor(widget.item, storeInfo),
    );
  }

  Future<void> _openEdit() async {
    final result = await context.push<SsossTemplateDocument>(
      TemplateEditPage.routePath,
      extra: TemplateEditArgs(document: _document),
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
              child: TemplateApplyBody(
                document: _document,
                hasStoreInfo: _hasStoreInfo,
                onDocumentChanged: (document) {
                  setState(() => _document = document);
                },
                onEditTap: () => unawaited(_openEdit()),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: TemplateApplyBottomBar(
        onSaveTap: () {
          context.go(TemplateSaveCompletePage.routePath);
        },
      ),
    );
  }
}

String _templateTextFor(TemplateItem item, StoreInfo info) {
  final storeName = _nonEmptyOr(info.basic.name, '[매장명]');
  final address = _nonEmptyOr(info.basic.address, '[주소]');
  final hours = _businessHoursLabel(info.operation);
  final menuName = info.operation.signatureMenus
          .where((menu) => menu.trim().isNotEmpty)
          .map((menu) => menu.trim())
          .firstOrNull ??
      '[메뉴명]';

  switch (item.category) {
    case TemplateCategory.newMenu:
      return _newMenuTemplate(
        storeName: storeName,
        menuName: menuName,
        address: address,
        hours: hours,
      );
    case TemplateCategory.event:
      return _eventTemplate(
        storeName: storeName,
        address: address,
        hours: hours,
      );
    case TemplateCategory.storeIntro:
      return _storeIntroTemplate(
        storeName: storeName,
        address: address,
        hours: hours,
      );
    case TemplateCategory.notice:
      return _noticeTemplate(
        storeName: storeName,
        address: address,
        hours: hours,
      );
    case TemplateCategory.all:
      return _newMenuTemplate(
        storeName: storeName,
        menuName: menuName,
        address: address,
        hours: hours,
      );
  }
}

String _nonEmptyOr(String? value, String fallback) {
  final trimmed = value?.trim();
  return trimmed == null || trimmed.isEmpty ? fallback : trimmed;
}

String _businessHoursLabel(StoreOperationInfo info) {
  final days = info.businessDays.map((day) => day.label).join(', ');
  final openTime = info.openTime?.trim();
  final closeTime = info.closeTime?.trim();
  if (days.isEmpty ||
      openTime == null ||
      openTime.isEmpty ||
      closeTime == null ||
      closeTime.isEmpty) {
    return '[영업시간]';
  }
  return '$days $openTime ~ $closeTime';
}

String _newMenuTemplate({
  required String storeName,
  required String menuName,
  required String address,
  required String hours,
}) =>
    '''
$storeName에 새 메뉴가 출시되었습니다!

✨ 신메뉴: $menuName
💰 가격: [가격]원

[메뉴 설명을 입력해주세요]

신선한 재료로 정성껏 만들었습니다. 많은 사랑 부탁드립니다 🙏

📍 $address
⏰ 영업시간: $hours
📞 [전화 번호]''';

String _eventTemplate({
  required String storeName,
  required String address,
  required String hours,
}) =>
    '''
$storeName에서 특별 이벤트를 진행합니다!

🎁 이벤트: [이벤트명]
📅 기간: [이벤트 기간]

[이벤트 내용을 입력해주세요]

많은 관심과 참여 부탁드립니다.

📍 $address
⏰ 영업시간: $hours
📞 [전화 번호]''';

String _storeIntroTemplate({
  required String storeName,
  required String address,
  required String hours,
}) =>
    '''
$storeName을 소개합니다!

[매장 분위기와 장점을 입력해주세요]

편안한 공간에서 좋은 시간을 보내실 수 있도록 정성껏 준비하고 있어요.

📍 $address
⏰ 영업시간: $hours
📞 [전화 번호]''';

String _noticeTemplate({
  required String storeName,
  required String address,
  required String hours,
}) =>
    '''
$storeName에서 안내드립니다.

📢 공지: [공지 제목]

[공지 내용을 입력해주세요]

이용에 참고 부탁드립니다.

📍 $address
⏰ 영업시간: $hours
📞 [전화 번호]''';
