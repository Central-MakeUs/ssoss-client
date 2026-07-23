import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

/// 해시태그/키워드 개수·글자 수 한도.
class SsossHashtagLimits {
  const SsossHashtagLimits._();

  static const int maxCount = 10;
  static const int maxLength = 30;
}

/// 해시태그/키워드 정규화.
///
/// 저장 값은 `#` 없이 관리하고, 표시 시에만 `#`을 붙인다.
class SsossHashtagNormalizer {
  const SsossHashtagNormalizer._();

  /// `#` 제거·trim. 비어 있거나 [SsossHashtagLimits.maxLength] 초과면 null.
  static String? normalize(String raw) {
    var text = raw.trim();
    if (text.startsWith('#')) {
      text = text.substring(1).trim();
    }
    if (text.isEmpty) {
      return null;
    }
    if (text.length > SsossHashtagLimits.maxLength) {
      return null;
    }
    return text;
  }

  static List<String> stripAll(List<String> values) {
    return [
      for (final value in values)
        if (normalize(value) case final normalized?) normalized,
    ];
  }

  static String display(String value) =>
      value.startsWith('#') ? value : '#$value';
}

/// 삭제 가능한 해시태그 칩.
class SsossHashtagChip extends StatelessWidget {
  const SsossHashtagChip({
    required this.keyword,
    required this.onRemove,
    super.key,
  });

  /// `#` 없는 키워드.
  final String keyword;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.neutral100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              SsossHashtagNormalizer.display(keyword),
              style: AppTextStyles.b5.copyWith(color: AppColors.neutral500),
              softWrap: true,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            behavior: HitTestBehavior.opaque,
            child: const Icon(
              Icons.close,
              size: 12,
              color: AppColors.neutral500,
            ),
          ),
        ],
      ),
    );
  }
}

/// 해시태그 입력 필드 + 추가하기 + 칩 목록.
///
/// [hashtags]는 `#` 없이 관리한다.
class SsossHashtagInput extends StatefulWidget {
  const SsossHashtagInput({
    required this.hashtags,
    required this.onAdd,
    required this.onRemove,
    this.hintText = '입력해주세요',
    this.title,
    this.limitHint,
    this.showHeader = false,
    super.key,
  });

  final List<String> hashtags;
  final ValueChanged<String> onAdd;
  final ValueChanged<String> onRemove;
  final String hintText;
  final String? title;
  final String? limitHint;
  final bool showHeader;

  static const double inputRowHeight = 44;

  static String get defaultLimitHint => '최대 ${SsossHashtagLimits.maxCount}개, '
      '${SsossHashtagLimits.maxLength}자 제한';

  @override
  State<SsossHashtagInput> createState() => _SsossHashtagInputState();
}

class _SsossHashtagInputState extends State<SsossHashtagInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_canAdd) {
      return;
    }
    widget.onAdd(_controller.text);
    _controller.clear();
  }

  bool get _canAdd =>
      widget.hashtags.length < SsossHashtagLimits.maxCount;

  @override
  Widget build(BuildContext context) {
    final title = widget.title ?? '해시태그 편집';
    final limitHint = widget.limitHint ?? SsossHashtagInput.defaultLimitHint;
    final canAdd = _canAdd;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showHeader) ...[
          Row(
            children: [
              AppText(
                title,
                style: AppTextStyles.h5.copyWith(color: AppColors.neutral700),
              ),
              const SizedBox(width: 10),
              AppText(
                limitHint,
                style: AppTextStyles.b6.copyWith(color: AppColors.neutral400),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        SizedBox(
          height: SsossHashtagInput.inputRowHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: AnimatedBuilder(
                  animation: _focusNode,
                  builder: (context, _) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _focusNode.hasFocus
                              ? AppColors.primary400
                              : AppColors.neutral200,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Center(
                          child: TextField(
                            controller: _controller,
                            focusNode: _focusNode,
                            style: AppTextStyles.b4.copyWith(
                              color: AppColors.neutral800,
                            ),
                            cursorColor: AppColors.primary400,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                SsossHashtagLimits.maxLength,
                              ),
                            ],
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: widget.hintText,
                              hintStyle: AppTextStyles.b4.copyWith(
                                color: AppColors.neutral400,
                              ),
                              contentPadding: EdgeInsets.zero,
                            ),
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => _submit(),
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
                height: SsossHashtagInput.inputRowHeight,
                enabled: canAdd,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                textStyle: AppTextStyles.h8,
                onPressed: canAdd ? _submit : null,
              ),
            ],
          ),
        ),
        if (widget.hashtags.isNotEmpty) ...[
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final tag in widget.hashtags)
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: constraints.maxWidth,
                      ),
                      child: SsossHashtagChip(
                        keyword: tag,
                        onRemove: () => widget.onRemove(tag),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ],
    );
  }
}
