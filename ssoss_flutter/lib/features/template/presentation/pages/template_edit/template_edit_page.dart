import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/card/ssoss_template_contents_edit_card.dart';
import 'package:ssoss_flutter/common/widgets/card/template/ssoss_template_document.dart';
import 'package:ssoss_flutter/common/widgets/modal/ssoss_modal.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/edit/content_edit_bottom_bar.dart';

class TemplateEditArgs {
  const TemplateEditArgs({
    required this.document,
  });

  final SsossTemplateDocument document;
}

class TemplateEditPage extends StatefulWidget {
  const TemplateEditPage({
    required this.args,
    super.key,
  });

  static const String routeName = 'template-edit';
  static const String routePath = '/template-edit';
  static const int maxBodyLength = 1000;

  final TemplateEditArgs args;

  @override
  State<TemplateEditPage> createState() => _TemplateEditPageState();
}

class _TemplateEditPageState extends State<TemplateEditPage> {
  late final SsossTemplateDocument _originalDocument = widget.args.document;
  late SsossTemplateDocument _document = widget.args.document;

  bool get _isDirty => _document != _originalDocument;
  bool get _canSubmit =>
      _document.plainText.trim().isNotEmpty &&
      _document.textLength <= TemplateEditPage.maxBodyLength;

  Future<void> _onBack() async {
    if (!_isDirty) {
      context.pop();
      return;
    }

    final result = await showSsossModal(
      context,
      title: '수정한 내용이 저장되지 않았어요',
      message: '지금 나가면 수정한 내용은 저장되지 않아요',
      primaryButtonLabel: '계속 수정하기',
      secondaryButtonLabel: '나가기',
      showButtonIcons: false,
    );
    if (result != SsossModalResult.secondary || !mounted) {
      return;
    }
    context.pop();
  }

  Future<void> _onReset() async {
    final result = await showSsossModal(
      context,
      title: '수정한 내용을 초기화하시겠어요?',
      message: '초기화하면 변경한 내용이 모두 사라지고\n초안으로 돌아가요',
      primaryButtonLabel: '초기화하기',
      secondaryButtonLabel: '취소',
      showButtonIcons: false,
    );
    if (result != SsossModalResult.primary || !mounted) {
      return;
    }
    setState(() => _document = _originalDocument);
  }

  void _onSubmit() {
    if (!_canSubmit) {
      return;
    }
    context.pop(_document);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          return;
        }
        unawaited(_onBack());
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              SsossAppBar.back(
                title: '콘텐츠 편집',
                onBack: () => unawaited(_onBack()),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  child: TemplateEditBody(
                    document: _document,
                    onDocumentChanged: (document) {
                      setState(() => _document = document);
                    },
                  ),
                ),
              ),
              ContentEditBottomBar(
                canSubmit: _canSubmit,
                onReset: () => unawaited(_onReset()),
                onSubmit: _onSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TemplateEditBody extends StatelessWidget {
  const TemplateEditBody({
    required this.document,
    required this.onDocumentChanged,
    super.key,
  });

  final SsossTemplateDocument document;
  final ValueChanged<SsossTemplateDocument> onDocumentChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          '본문 편집',
          style: AppTextStyles.h5.copyWith(color: AppColors.black),
        ),
        const SizedBox(height: 8),
        SsossTemplateContentsEditCard(
          document: document,
          width: double.infinity,
          maxLength: TemplateEditPage.maxBodyLength,
          onDocumentChanged: onDocumentChanged,
          emptySlotColor: AppColors.primary300,
        ),
      ],
    );
  }
}
