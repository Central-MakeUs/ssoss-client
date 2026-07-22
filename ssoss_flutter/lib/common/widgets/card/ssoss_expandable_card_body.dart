import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/assets.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';

/// 콘텐츠 높이가 [maxCollapsedHeight] 이상일 때 접기/더 보기를 제공하는 카드 본문.
///
/// 접힌 상태에서는 내부 스크롤 없이 [maxCollapsedHeight]로 클립한다.
class SsossExpandableCardBody extends StatefulWidget {
  const SsossExpandableCardBody({
    required this.child,
    super.key,
    this.maxCollapsedHeight = 480,
  });

  final Widget child;
  final double maxCollapsedHeight;

  @override
  State<SsossExpandableCardBody> createState() =>
      _SsossExpandableCardBodyState();
}

class _SsossExpandableCardBodyState extends State<SsossExpandableCardBody> {
  bool _isExpanded = false;
  bool _canToggle = false;

  void _onContentSize(Size size) {
    final canToggle = size.height >= widget.maxCollapsedHeight;
    if (canToggle == _canToggle) {
      return;
    }
    setState(() {
      _canToggle = canToggle;
      if (!canToggle) {
        _isExpanded = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 측정 전에도 접힌 maxHeight를 적용해 긴 콘텐츠의 첫 프레임 깜빡임을 막는다.
    // (짧은 콘텐츠는 maxHeight만으로는 강제 확대되지 않음)
    final isCollapsed = !_isExpanded;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight:
                isCollapsed ? widget.maxCollapsedHeight : double.infinity,
          ),
          child: SingleChildScrollView(
            // 접힌 상태에서 넘치는 텍스트가 있어도 내부 스크롤을 막는다.
            physics: const NeverScrollableScrollPhysics(),
            child: _MeasureSize(
              onChange: _onContentSize,
              child: widget.child,
            ),
          ),
        ),
        if (_canToggle) ...[
          const SizedBox(height: 4),
          _ExpandToggleButton(
            isExpanded: _isExpanded,
            onTap: () => setState(() => _isExpanded = !_isExpanded),
          ),
        ],
      ],
    );
  }
}

class _ExpandToggleButton extends StatelessWidget {
  const _ExpandToggleButton({
    required this.isExpanded,
    required this.onTap,
  });

  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: Center(
                child: SvgPicture.asset(
                  isExpanded ? AppAssets.icChevronUp : AppAssets.icChevronDown,
                  width: 10,
                  height: 5,
                  colorFilter: const ColorFilter.mode(
                    AppColors.neutral500,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 2),
            AppText(
              isExpanded ? '접기' : '더 보기',
              style: AppTextStyles.b5.copyWith(
                color: AppColors.neutral500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MeasureSize extends StatefulWidget {
  const _MeasureSize({
    required this.onChange,
    required this.child,
  });

  final ValueChanged<Size> onChange;
  final Widget child;

  @override
  State<_MeasureSize> createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<_MeasureSize> {
  Size? _lastSize;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      final size = context.size;
      if (size == null || size == _lastSize) {
        return;
      }
      _lastSize = size;
      widget.onChange(size);
    });
    return widget.child;
  }
}
