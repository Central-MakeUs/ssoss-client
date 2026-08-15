import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/input/ssoss_select_field.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_select_option.dart';

class SsossSelectDropdown extends StatefulWidget {
  const SsossSelectDropdown({
    required this.options,
    super.key,
    this.value,
    this.placeholder = 'Value',
    this.isOpen = true,
    this.enabled = true,
    this.selectedIndex,
    this.highlightedIndex,
    this.onFieldTap,
    this.onOptionSelected,
    this.width,
    this.fieldBorderColor,
    this.fieldFillColor,
    this.fieldValueColor,
    this.fieldPlaceholderColor,
    this.fieldIconColor,
    this.optionBorderColor,
    this.optionBackgroundColor,
    this.optionTextColor,
    this.selectedOptionBackgroundColor,
    this.hoverOptionBackgroundColor,
    this.pressedOptionBackgroundColor,
    this.selectedOptionTextColor,
  });

  final List<String> options;
  final String? value;
  final String placeholder;
  final bool isOpen;
  final bool enabled;
  final int? selectedIndex;
  final int? highlightedIndex;
  final VoidCallback? onFieldTap;
  final ValueChanged<int>? onOptionSelected;
  final double? width;
  final Color? fieldBorderColor;
  final Color? fieldFillColor;
  final Color? fieldValueColor;
  final Color? fieldPlaceholderColor;
  final Color? fieldIconColor;
  final Color? optionBorderColor;
  final Color? optionBackgroundColor;
  final Color? optionTextColor;
  final Color? selectedOptionBackgroundColor;
  final Color? hoverOptionBackgroundColor;
  final Color? pressedOptionBackgroundColor;
  final Color? selectedOptionTextColor;

  static const double optionsGap = SsossSelectOptionsPanel.gap;

  @override
  State<SsossSelectDropdown> createState() => _SsossSelectDropdownState();
}

class _SsossSelectDropdownState extends State<SsossSelectDropdown> {
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _fieldKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncOverlay());
  }

  @override
  void didUpdateWidget(covariant SsossSelectDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncOverlay());
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _syncOverlay() {
    if (!mounted) {
      return;
    }

    if (widget.isOpen && widget.enabled) {
      if (_overlayEntry == null) {
        _overlayEntry = OverlayEntry(builder: _buildOverlay);
        Overlay.of(context).insert(_overlayEntry!);
      } else {
        _overlayEntry!.markNeedsBuild();
      }
      return;
    }

    _removeOverlay();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Widget _buildOverlay(BuildContext context) {
    final fieldBox = _fieldKey.currentContext?.findRenderObject() as RenderBox?;
    final fieldSize = fieldBox?.size;
    final width = widget.width ?? fieldSize?.width;
    final fieldHeight = fieldSize?.height ?? 44;

    return CompositedTransformFollower(
      link: _layerLink,
      showWhenUnlinked: false,
      offset: Offset(0, fieldHeight + SsossSelectOptionsPanel.gap),
      child: Align(
        alignment: Alignment.topLeft,
        child: Material(
          color: Colors.transparent,
          child: SizedBox(
            width: width,
            child: SsossSelectOptionsPanel(
              options: widget.options,
              selectedIndex: widget.selectedIndex,
              highlightedIndex: widget.highlightedIndex,
              width: widget.width,
              onOptionSelected: widget.onOptionSelected,
              optionBorderColor: widget.optionBorderColor,
              optionBackgroundColor: widget.optionBackgroundColor,
              optionTextColor: widget.optionTextColor,
              selectedOptionBackgroundColor:
                  widget.selectedOptionBackgroundColor,
              hoverOptionBackgroundColor: widget.hoverOptionBackgroundColor,
              pressedOptionBackgroundColor: widget.pressedOptionBackgroundColor,
              selectedOptionTextColor: widget.selectedOptionTextColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: SsossSelectField(
        key: _fieldKey,
        value: widget.value,
        placeholder: widget.placeholder,
        isOpen: widget.isOpen,
        enabled: widget.enabled,
        onTap: widget.onFieldTap,
        width: widget.width,
        borderColor: widget.fieldBorderColor,
        fillColor: widget.fieldFillColor,
        valueColor: widget.fieldValueColor,
        placeholderColor: widget.fieldPlaceholderColor,
        iconColor: widget.fieldIconColor,
      ),
    );
  }
}
