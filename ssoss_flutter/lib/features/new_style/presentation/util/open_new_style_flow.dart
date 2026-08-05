import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ssoss_flutter/common/widgets/modal/ssoss_modal.dart';
import 'package:ssoss_flutter/features/new_style/presentation/models/new_style_args.dart';
import 'package:ssoss_flutter/features/new_style/presentation/pages/new_style_channel_page.dart';

/// 확인 모달 후 이 스타일로 새로 만들기 채널 선택 화면으로 이동한다.
Future<void> openNewStyleFlow(
  BuildContext context, {
  required NewStyleArgs args,
}) async {
  final result = await showSsossModal(
    context,
    title: '이 글의 스타일을 참고해\n새 콘텐츠를 생성할까요?',
    message: '이 글의 말투와 구성을 참고해 새 콘텐츠를 만들어요\n필요한 내용만 추가해 주세요',
    primaryButtonLabel: '생성하러 가기',
    secondaryButtonLabel: '취소',
    showButtonIcons: false,
  );

  if (result != SsossModalResult.primary || !context.mounted) {
    return;
  }

  await context.push(NewStyleChannelPage.routePath, extra: args);
}
