import 'package:flutter/material.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_hashtag_input.dart';
import 'package:ssoss_flutter/common/widgets/selection/ssoss_checkbox.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/content/presentation/cubit/content_create_cubit.dart';

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
  late final TextEditingController _highlightController;
  late final TextEditingController _forbiddenController;

  @override
  void initState() {
    super.initState();
    _highlightController = TextEditingController(text: widget.highlight);
    _forbiddenController = TextEditingController(text: widget.forbidden);
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
    super.dispose();
  }

  void _onAddKeyword(String raw) {
    if (widget.keywords.length >= ContentCreateCubit.maxKeywords) {
      return;
    }
    final normalized = SsossHashtagNormalizer.normalize(raw);
    if (normalized == null) {
      if (raw.trim().isNotEmpty) {
        showSsossToast(
          context,
          title: '키워드는 ${ContentCreateCubit.maxKeywordLength}자 이하로 입력해주세요',
          type: SsossToastType.warning,
        );
      }
      return;
    }
    widget.onAddKeyword(raw);
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
              '선택',
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
        SsossHashtagInput(
          hashtags: widget.keywords,
          hintText: 'ex) 디저트맛집',
          onAdd: _onAddKeyword,
          onRemove: widget.onRemoveKeyword,
        ),
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
