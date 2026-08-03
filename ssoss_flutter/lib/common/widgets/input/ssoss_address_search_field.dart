import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/input/ssoss_select_option.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_text_field.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/service/kakao_local_search_service.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/utils/debouncer.dart';

class SsossAddressSearchField extends StatefulWidget {
  const SsossAddressSearchField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText = '주소를 검색해주세요',
    this.enabled = true,
    this.width,
    this.initialValue,
    this.searchService,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hintText;
  final bool enabled;
  final double? width;
  final String? initialValue;
  final KakaoLocalSearchService? searchService;

  static const String searchErrorMessage = '주소 검색에 실패했습니다.';

  @override
  State<SsossAddressSearchField> createState() =>
      _SsossAddressSearchFieldState();
}

class _SsossAddressSearchFieldState extends State<SsossAddressSearchField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  late final KakaoLocalSearchService _searchService;
  late final Debouncer _debouncer;
  late final bool _ownsController;
  late final bool _ownsFocusNode;

  final LayerLink _layerLink = LayerLink();
  final GlobalKey _fieldKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  CancelToken? _cancelToken;
  List<String> _addresses = const [];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _ownsFocusNode = widget.focusNode == null;
    _controller = widget.controller ?? TextEditingController();
    if (widget.initialValue != null && _controller.text.isEmpty) {
      _controller.text = widget.initialValue!;
    }
    _focusNode = widget.focusNode ?? FocusNode();
    _searchService = widget.searchService ?? KakaoLocalSearchService();
    _debouncer = Debouncer();
    _focusNode.addListener(_handleFocusChange);
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncOverlay());
  }

  @override
  void dispose() {
    _removeOverlay();
    _debouncer.dispose();
    _cancelToken?.cancel();
    _focusNode.removeListener(_handleFocusChange);
    if (_ownsFocusNode) {
      _focusNode.dispose();
    }
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus) {
      _removeOverlay();
      if (mounted) {
        setState(() {});
      }
      return;
    }

    if (mounted) {
      setState(() {});
    }
    _syncOverlay();
  }

  void _scheduleSyncOverlay() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncOverlay());
  }

  void _syncOverlay() {
    if (!mounted) {
      return;
    }

    if (_showDropdown) {
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
    final fieldHeight = fieldSize?.height ?? SsossTextField.defaultHeight;

    return CompositedTransformFollower(
      link: _layerLink,
      showWhenUnlinked: false,
      offset: Offset(0, fieldHeight + SsossSelectOptionsPanel.gap),
      child: Align(
        alignment: Alignment.topLeft,
        child: TextFieldTapRegion(
          child: Material(
            color: Colors.transparent,
            child: SizedBox(
              width: width,
              child: SsossSelectOptionsPanel(
                options: List<String>.of(_addresses),
                width: widget.width,
                onOptionSelected: (index) {
                  final addresses = List<String>.of(_addresses);
                  if (index < 0 || index >= addresses.length) {
                    return;
                  }
                  _handleOptionSelected(addresses[index]);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleChanged(String value) {
    _debouncer.run(() => _search(value));
  }

  Future<void> _search(String query) async {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) {
      _cancelToken?.cancel();
      _cancelToken = null;

      if (!mounted) {
        return;
      }

      setState(() {
        _addresses = const [];
        _isLoading = false;
        _errorMessage = null;
      });
      _scheduleSyncOverlay();
      return;
    }

    _cancelToken?.cancel();
    final cancelToken = CancelToken();
    _cancelToken = cancelToken;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _addresses = const [];
    });
    _scheduleSyncOverlay();

    try {
      final results = await _searchService.searchAddresses(
        trimmedQuery,
        cancelToken: cancelToken,
      );

      if (!mounted || !identical(_cancelToken, cancelToken)) {
        return;
      }

      setState(() {
        _addresses = results;
        _isLoading = false;
        _errorMessage = null;
      });
      _scheduleSyncOverlay();
    } on DioException catch (e) {
      if (CancelToken.isCancel(e) ||
          !mounted ||
          !identical(_cancelToken, cancelToken)) {
        return;
      }

      setState(() {
        _addresses = const [];
        _isLoading = false;
        _errorMessage = SsossAddressSearchField.searchErrorMessage;
      });
      _scheduleSyncOverlay();
    } catch (_) {
      if (!mounted || !identical(_cancelToken, cancelToken)) {
        return;
      }

      setState(() {
        _addresses = const [];
        _isLoading = false;
        _errorMessage = SsossAddressSearchField.searchErrorMessage;
      });
      _scheduleSyncOverlay();
    }
  }

  void _handleOptionSelected(String address) {
    _debouncer.cancel();
    _cancelToken?.cancel();
    _cancelToken = null;

    _controller.value = TextEditingValue(
      text: address,
      selection: TextSelection.collapsed(offset: address.length),
    );

    setState(() {
      _addresses = const [];
      _isLoading = false;
      _errorMessage = null;
    });
    _removeOverlay();
    _focusNode.unfocus();
  }

  bool get _showDropdown {
    return widget.enabled &&
        _focusNode.hasFocus &&
        _addresses.isNotEmpty &&
        _errorMessage == null;
  }

  @override
  Widget build(BuildContext context) {
    final hasError = _errorMessage != null;

    return CompositedTransformTarget(
      link: _layerLink,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SsossTextField(
            key: _fieldKey,
            controller: _controller,
            focusNode: _focusNode,
            hintText: widget.hintText,
            showSearchIcon: true,
            showLoadingIndicator: _isLoading,
            hasError: hasError,
            enabled: widget.enabled,
            width: widget.width,
            onChanged: _handleChanged,
          ),
          if (hasError) ...[
            const SizedBox(height: 6),
            AppText(
              _errorMessage!,
              style: AppTextStyles.b6.copyWith(
                color: AppColors.error500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
