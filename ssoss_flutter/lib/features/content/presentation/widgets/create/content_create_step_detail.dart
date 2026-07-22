import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/selection/ssoss_checkbox.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/content/presentation/cubit/content_create_cubit.dart';
import 'package:ssoss_flutter/features/content/presentation/widgets/create/content_keyword_chip.dart';

class ContentCreateStepDetail extends StatefulWidget {
  const ContentCreateStepDetail({
    required this.highlight,
    required this.forbidden,
    required this.keywords,
    required this.photoGuideEnabled,
    required this.onHighlightChanged,
    required this.onForbiddenChanged,
    required this.onAddKeyword,
    required this.onRemoveKeyword,
    required this.onTogglePhotoGuide,
    super.key,
  });

  final String highlight;
  final String forbidden;
  final List<String> keywords;
  final bool photoGuideEnabled;
  final ValueChanged<String> onHighlightChanged;
  final ValueChanged<String> onForbiddenChanged;
  final ValueChanged<String> onAddKeyword;
  final ValueChanged<String> onRemoveKeyword;
  final VoidCallback onTogglePhotoGuide;

  @override
  State<ContentCreateStepDetail> createState() =>
      _ContentCreateStepDetailState();
}

class _ContentCreateStepDetailState extends State<ContentCreateStepDetail> {
  static const double _keywordRowHeight = 44;

  late final TextEditingController _highlightController;
  late final TextEditingController _forbiddenController;
  late final TextEditingController _keywordController;
  late final FocusNode _keywordFocusNode;

  @override
  void initState() {
    super.initState();
    _highlightController = TextEditingController(text: widget.highlight);
    _forbiddenController = TextEditingController(text: widget.forbidden);
    _keywordController = TextEditingController();
    _keywordFocusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant ContentCreateStepDetail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.highlight != _highlightController.text) {
      _highlightController.text = widget.highlight;
    }
    if (widget.forbidden != _forbiddenController.text) {
      _forbiddenController.text = widget.forbidden;
    }
  }

  @override
  void dispose() {
    _highlightController.dispose();
    _forbiddenController.dispose();
    _keywordController.dispose();
    _keywordFocusNode.dispose();
    super.dispose();
  }

  void _submitKeyword() {
    if (widget.keywords.length >= ContentCreateCubit.maxKeywords) {
      showSsossToast(
        context,
        title: '키워드는 최대 ${ContentCreateCubit.maxKeywords}개까지만 추가할 수 있어요',
        type: SsossToastType.warning,
      );
      return;
    }
    widget.onAddKeyword(_keywordController.text);
    _keywordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppText(
              '강조 내용',
              style: AppTextStyles.h5.copyWith(color: AppColors.neutral700),
            ),
            const SizedBox(width: 2),
            AppText(
              '*',
              style: AppTextStyles.h5.copyWith(color: AppColors.primary600),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _MultilineInput(
          controller: _highlightController,
          hintText: '콘텐츠에 들어갈 내용을 작성해주세요.',
          onChanged: widget.onHighlightChanged,
        ),
        const SizedBox(height: 36),
        Row(
          children: [
            AppText(
              '금지 내용',
              style: AppTextStyles.h5.copyWith(color: AppColors.neutral700),
            ),
            const SizedBox(width: 8),
            AppText(
              '선택',
              style: AppTextStyles.b6.copyWith(color: AppColors.neutral400),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _MultilineInput(
          controller: _forbiddenController,
          hintText: '콘텐츠에 들어가면 안되는 내용을 작성해주세요.',
          onChanged: widget.onForbiddenChanged,
        ),
        const SizedBox(height: 36),
        Row(
          children: [
            AppText(
              '주요 키워드',
              style: AppTextStyles.h5.copyWith(color: AppColors.neutral700),
            ),
            const SizedBox(width: 8),
            AppText(
              '선택, 최대 ${ContentCreateCubit.maxKeywords}개',
              style: AppTextStyles.b6.copyWith(color: AppColors.neutral400),
            ),
          ],
        ),
        const SizedBox(height: 4),
        AppText(
          '가게 정보와 저장된 키워드를 참고해 콘텐츠를 생성해요',
          style: AppTextStyles.b5.copyWith(color: AppColors.neutral400),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: _keywordRowHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: AnimatedBuilder(
                  animation: _keywordFocusNode,
                  builder: (context, _) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _keywordFocusNode.hasFocus
                              ? AppColors.primary400
                              : AppColors.neutral200,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Center(
                          child: TextField(
                            controller: _keywordController,
                            focusNode: _keywordFocusNode,
                            style: AppTextStyles.b4.copyWith(
                              color: AppColors.neutral800,
                            ),
                            cursorColor: AppColors.primary400,
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: 'ex) 디저트맛집',
                              hintStyle: AppTextStyles.b4.copyWith(
                                color: AppColors.neutral400,
                              ),
                              contentPadding: EdgeInsets.zero,
                            ),
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => _submitKeyword(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              SsossButton(
                label: '추가하기',
                size: SsossButtonSize.small,
                height: _keywordRowHeight,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                textStyle: AppTextStyles.h8,
                onPressed: _submitKeyword,
              ),
            ],
          ),
        ),
        if (widget.keywords.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final keyword in widget.keywords)
                ContentKeywordChip(
                  keyword: keyword,
                  onRemove: () => widget.onRemoveKeyword(keyword),
                ),
            ],
          ),
        ],
        const SizedBox(height: 36),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppText(
                        '사진 첨부 가이드',
                        style: AppTextStyles.h5.copyWith(
                          color: AppColors.neutral700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      AppText(
                        '선택',
                        style: AppTextStyles.b6.copyWith(
                          color: AppColors.neutral400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  AppText(
                    '해당 글에 어울리는 사진 가이드를 드려요.',
                    style: AppTextStyles.b5.copyWith(
                      color: AppColors.neutral400,
                    ),
                  ),
                ],
              ),
            ),
            SsossCheckbox(
              isChecked: widget.photoGuideEnabled,
              iconSize: 24,
              onTap: widget.onTogglePhotoGuide,
            ),
          ],
        ),
      ],
    );
  }
}

class _MultilineInput extends StatelessWidget {
  const _MultilineInput({
    required this.controller,
    required this.hintText,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        style: AppTextStyles.b4.copyWith(color: AppColors.neutral800),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.b4.copyWith(color: AppColors.neutral400),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.neutral200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.primary400),
          ),
        ),
      ),
    );
  }
}
