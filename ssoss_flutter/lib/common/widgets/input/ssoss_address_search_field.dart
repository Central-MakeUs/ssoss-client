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

  final GlobalKey _dropdownKey = GlobalKey();

  CancelToken? _cancelToken;
  List<String> _addresses = const [];
  bool _hasFocus = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _ownsFocusNode = widget.focusNode == null;
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _searchService = widget.searchService ?? KakaoLocalSearchService();
    _debouncer = Debouncer();
    _hasFocus = _focusNode.hasFocus;
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
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
    if (_hasFocus == _focusNode.hasFocus) {
      return;
    }

    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
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

      if (results.isNotEmpty) {
        _ensureDropdownVisible();
      }
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
    } catch (_) {
      if (!mounted || !identical(_cancelToken, cancelToken)) {
        return;
      }

      setState(() {
        _addresses = const [];
        _isLoading = false;
        _errorMessage = SsossAddressSearchField.searchErrorMessage;
      });
    }
  }

  void _handleOptionSelected(String address) {
    _controller.text = address;
    _controller.selection = TextSelection.collapsed(offset: address.length);

    setState(() {
      _addresses = const [];
      _isLoading = false;
      _errorMessage = null;
    });
  }

  void _ensureDropdownVisible() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted || !_showDropdown) {
        return;
      }

      final dropdownContext = _dropdownKey.currentContext;
      if (dropdownContext == null) {
        return;
      }

      await Scrollable.ensureVisible(
        dropdownContext,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
      );
    });
  }

  bool get _showDropdown {
    return _hasFocus && _addresses.isNotEmpty && _errorMessage == null;
  }

  @override
  Widget build(BuildContext context) {
    final hasError = _errorMessage != null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SsossTextField(
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
        if (_showDropdown) ...[
          Container(
            key: _dropdownKey,
            margin: const EdgeInsets.only(top: 6, bottom: 6),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.neutral200,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _buildOptions(),
            ),
          ),
        ],
      ],
    );
  }

  List<Widget> _buildOptions() {
    return List<Widget>.generate(_addresses.length, (index) {
      return Padding(
        padding: EdgeInsets.only(top: index == 0 ? 0 : 8),
        child: SsossSelectOption(
          value: _addresses[index],
          width: widget.width,
          onTap: () => _handleOptionSelected(_addresses[index]),
        ),
      );
    });
  }
}
