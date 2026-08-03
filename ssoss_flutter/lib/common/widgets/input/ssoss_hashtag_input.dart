import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_text_field.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';

import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
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

  /// [showHashPrefix]가 false면 `#` 없이 원문만 반환한다.
  static String display(
    String value, {
    bool showHashPrefix = true,
  }) {
    if (!showHashPrefix) {
      return value.startsWith('#') ? value.substring(1) : value;
    }
    return value.startsWith('#') ? value : '#$value';
  }
}

/// 삭제 가능한 해시태그 칩.
class SsossHashtagChip extends StatelessWidget {
  const SsossHashtagChip({
    required this.keyword,
    required this.onRemove,
    this.showHashPrefix = true,
    super.key,
  });

  /// `#` 없는 키워드.
  final String keyword;
  final VoidCallback onRemove;
  final bool showHashPrefix;

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
              SsossHashtagNormalizer.display(
                keyword,
                showHashPrefix: showHashPrefix,
              ),
              style: AppTextStyles.b5.copyWith(color: AppColors.neutral500),
              softWrap: true,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            behavior: HitTestBehavior.opaque,
            child: SvgPicture.asset(
              AppAssets.icClose,
              width: 12,
              height: 12,
              colorFilter: const ColorFilter.mode(
                AppColors.neutral500,
                BlendMode.srcIn,
              ),
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
    this.showHashPrefix = true,
    super.key,
  });

  final List<String> hashtags;
  final ValueChanged<String> onAdd;
  final ValueChanged<String> onRemove;
  final String hintText;
  final String? title;
  final String? limitHint;
  final bool showHeader;

  /// 칩에 `#` 접두사를 표시할지 여부. 기본값 true.
  final bool showHashPrefix;

  static const double inputRowHeight = 44;

  static String get defaultLimitHint => '최대 ${SsossHashtagLimits.maxCount}개, '
      '${SsossHashtagLimits.maxLength}자 제한';

  @override
  State<SsossHashtagInput> createState() => _SsossHashtagInputState();
}

class _SsossHashtagInputState extends State<SsossHashtagInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_canAdd) {
      return;
    }
    widget.onAdd(_controller.text);
    _controller.clear();
  }

  bool get _canAdd => widget.hashtags.length < SsossHashtagLimits.maxCount;

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
        Row(
          children: [
            Expanded(
              child: SsossTextField(
                controller: _controller,
                hintText: widget.hintText,
                height: SsossHashtagInput.inputRowHeight,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(
                    SsossHashtagLimits.maxLength,
                  ),
                ],
                onSubmitted: (_) => _submit(),
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
                        showHashPrefix: widget.showHashPrefix,
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
