import 'dart:async';

import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_hashtag_input.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_select_dropdown.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/features/my_page/presentation/pages/store_info_management/store_info_management_components.dart';

class StoreInfoManagementPage extends StatefulWidget {
  const StoreInfoManagementPage({
    super.key,
    this.initialTab = StoreInfoTab.basic,
  });

  static const String routeName = 'store-info-management';
  static const String routePath = '/store-info-management';

  final StoreInfoTab initialTab;

  @override
  State<StoreInfoManagementPage> createState() =>
      _StoreInfoManagementPageState();
}

class _StoreInfoManagementPageState extends State<StoreInfoManagementPage> {
  late StoreInfoTab _selectedTab;
  late final TextEditingController _storeNameController;
  late final TextEditingController _addressController;
  late final TextEditingController _introController;
  late final TextEditingController _menuController;
  late final TextEditingController _storeStrengthController;
  late final TextEditingController _prohibitedContentController;
  String? _storeType;
  String _openingTime = '00:00';
  String _closingTime = '00:00';
  StoreContentTone _selectedTone = StoreContentTone.daily;
  final Set<String> _selectedDays = {};
  final List<String> _menus = [
    '크림브륄레 커피',
    '아이스 아메리카노',
    '프렌치토스트',
    '크루아상',
    '벌꿀아이스크림',
    '카페 라떼',
    '아이스티',
  ];
  final List<String> _keywords = SsossHashtagNormalizer.stripAll([
    '#을지로카페',
    '#을지로크루아상',
    '#을지로베이커리',
    '#크루아상맛집',
    '#을지로맛집',
    '#보니스커피',
    '#을지로디저트',
    '#서울카페',
    '#베이커리추천',
  ]);
  final Map<StoreFacilityType, bool> _facilities = {
    StoreFacilityType.takeout: true,
    StoreFacilityType.reservation: true,
    StoreFacilityType.parking: false,
  };

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;
    _storeNameController = TextEditingController(text: '보니스 커피');
    _addressController = TextEditingController(text: '서울 마포구 동교로16길 21');
    _introController = TextEditingController();
    _menuController = TextEditingController();
    _storeStrengthController = TextEditingController();
    _prohibitedContentController = TextEditingController();
  }

  @override
  void dispose() {
    _storeNameController.dispose();
    _addressController.dispose();
    _introController.dispose();
    _menuController.dispose();
    _storeStrengthController.dispose();
    _prohibitedContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            SsossAppBar.back(
              title: _selectedTab.managementTitle,
              onBack: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                children: [
                  _buildSelectedForm(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: SsossButton(
                label: '저장하기',
                size: SsossButtonSize.large,
                width: double.infinity,
                height: 56,
                backgroundColor: AppColors.primary400,
                foregroundColor: AppColors.white,
                textStyle: AppTextStyles.h5,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedForm() {
    switch (_selectedTab) {
      case StoreInfoTab.basic:
        return _BasicInfoForm(
          storeNameController: _storeNameController,
          addressController: _addressController,
          introController: _introController,
          storeType: _storeType,
          onStoreTypeSelected: (value) {
            setState(() => _storeType = value);
          },
        );
      case StoreInfoTab.operation:
        return _OperationInfoForm(
          selectedDays: _selectedDays,
          menuController: _menuController,
          menus: _menus,
          facilities: _facilities,
          onDayTap: _toggleDay,
          onAddMenu: _addMenu,
          onRemoveMenu: _removeMenu,
          openingTime: _openingTime,
          closingTime: _closingTime,
          onOpeningTimeTap: () {
            unawaited(_showTimePicker(isOpeningTime: true));
          },
          onClosingTimeTap: () {
            unawaited(_showTimePicker(isOpeningTime: false));
          },
          onFacilityChanged: _toggleFacility,
        );
      case StoreInfoTab.content:
        return _ContentInfoForm(
          storeStrengthController: _storeStrengthController,
          prohibitedContentController: _prohibitedContentController,
          keywords: _keywords,
          selectedTone: _selectedTone,
          onAddKeyword: _addKeyword,
          onRemoveKeyword: _removeKeyword,
          onToneChanged: (tone) {
            setState(() => _selectedTone = tone);
          },
        );
    }
  }

  void _toggleDay(String day) {
    setState(() {
      if (_selectedDays.contains(day)) {
        _selectedDays.remove(day);
      } else {
        _selectedDays.add(day);
      }
    });
  }

  void _addMenu() {
    final menu = _menuController.text.trim();
    if (menu.isEmpty || _menus.contains(menu) || _menus.length >= 10) {
      return;
    }

    setState(() {
      _menus.add(menu);
      _menuController.clear();
    });
  }

  void _removeMenu(String menu) {
    setState(() => _menus.remove(menu));
  }

  void _addKeyword(String raw) {
    if (_keywords.length >= SsossHashtagLimits.maxCount) {
      return;
    }

    final keyword = SsossHashtagNormalizer.normalize(raw);
    if (keyword == null) {
      if (raw.trim().isNotEmpty) {
        showSsossToast(
          context,
          title: '키워드는 ${SsossHashtagLimits.maxLength}자 이하로 입력해주세요',
          type: SsossToastType.warning,
        );
      }
      return;
    }
    if (_keywords.contains(keyword)) {
      showSsossToast(
        context,
        title: '이미 추가된 키워드예요',
        type: SsossToastType.warning,
      );
      return;
    }

    setState(() => _keywords.add(keyword));
  }

  void _removeKeyword(String keyword) {
    setState(() => _keywords.remove(keyword));
  }

  void _toggleFacility(StoreFacilityType type, bool value) {
    setState(() => _facilities[type] = value);
  }

  Future<void> _showTimePicker({required bool isOpeningTime}) async {
    final selectedTime = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.black.withValues(alpha: 0.3),
      builder: (context) => const StoreInfoTimePickerBottomSheet(),
    );

    if (!mounted || selectedTime == null) {
      return;
    }

    setState(() {
      if (isOpeningTime) {
        _openingTime = selectedTime;
      } else {
        _closingTime = selectedTime;
      }
    });
  }
}

extension on StoreInfoTab {
  String get managementTitle {
    switch (this) {
      case StoreInfoTab.basic:
        return '기본 정보 관리';
      case StoreInfoTab.operation:
        return '운영 정보 관리';
      case StoreInfoTab.content:
        return '콘텐츠 정보 관리';
    }
  }
}

class _ContentInfoForm extends StatelessWidget {
  const _ContentInfoForm({
    required this.storeStrengthController,
    required this.prohibitedContentController,
    required this.keywords,
    required this.selectedTone,
    required this.onAddKeyword,
    required this.onRemoveKeyword,
    required this.onToneChanged,
  });

  final TextEditingController storeStrengthController;
  final TextEditingController prohibitedContentController;
  final List<String> keywords;
  final StoreContentTone selectedTone;
  final ValueChanged<String> onAddKeyword;
  final ValueChanged<String> onRemoveKeyword;
  final ValueChanged<StoreContentTone> onToneChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StoreInfoFormField(
          label: '매장 강점',
          controller: storeStrengthController,
          hintText: '입력해주세요',
          multiline: true,
        ),
        const SizedBox(height: 32),
        StoreInfoSectionTitle(
          title: '매장 키워드',
          helperText: SsossHashtagInput.defaultLimitHint,
        ),
        const SizedBox(height: 8),
        SsossHashtagInput(
          hashtags: keywords,
          hintText: 'ex) 디저트맛집',
          onAdd: onAddKeyword,
          onRemove: onRemoveKeyword,
        ),
        const SizedBox(height: 32),
        StoreInfoFormField(
          label: '금지 내용',
          controller: prohibitedContentController,
          hintText: '입력해주세요',
          multiline: true,
        ),
        const SizedBox(height: 32),
        const StoreInfoSectionTitle(title: '콘텐츠 작성 톤'),
        const SizedBox(height: 12),
        StoreContentToneList(
          selectedTone: selectedTone,
          onChanged: onToneChanged,
        ),
      ],
    );
  }
}

class _BasicInfoForm extends StatefulWidget {
  const _BasicInfoForm({
    required this.storeNameController,
    required this.addressController,
    required this.introController,
    required this.storeType,
    required this.onStoreTypeSelected,
  });

  final TextEditingController storeNameController;
  final TextEditingController addressController;
  final TextEditingController introController;
  final String? storeType;
  final ValueChanged<String> onStoreTypeSelected;

  @override
  State<_BasicInfoForm> createState() => _BasicInfoFormState();
}

class _BasicInfoFormState extends State<_BasicInfoForm> {
  bool _isStoreTypeOpen = false;

  static const List<String> _storeTypeOptions = [
    '카페',
    '디저트 카페',
    '베이커리',
    '베이커리 카페',
    '브런치 카페',
    '로스터리 카페',
    '카페·바',
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = widget.storeType == null
        ? null
        : _storeTypeOptions.indexOf(widget.storeType!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StoreInfoFormField(
          label: '매장명',
          controller: widget.storeNameController,
          hintText: '입력해주세요.',
        ),
        const SizedBox(height: 32),
        AppText(
          '매장 유형',
          style: AppTextStyles.h5.copyWith(color: AppColors.black),
        ),
        const SizedBox(height: 8),
        SsossSelectDropdown(
          options: _storeTypeOptions,
          value: widget.storeType,
          placeholder: '선택해주세요',
          isOpen: _isStoreTypeOpen,
          selectedIndex: selectedIndex == -1 ? null : selectedIndex,
          onFieldTap: () {
            setState(() => _isStoreTypeOpen = !_isStoreTypeOpen);
          },
          onOptionSelected: (index) {
            setState(() => _isStoreTypeOpen = false);
            widget.onStoreTypeSelected(_storeTypeOptions[index]);
          },
        ),
        const SizedBox(height: 32),
        StoreInfoFormField(
          label: '주소',
          controller: widget.addressController,
          hintText: '주소를 검색해주세요',
          showSearchIcon: true,
          readOnly: true,
          onTap: () {},
        ),
        const SizedBox(height: 32),
        StoreInfoFormField(
          label: '매장 한 줄 소개',
          controller: widget.introController,
          hintText: '입력해주세요.',
        ),
      ],
    );
  }
}

class _OperationInfoForm extends StatelessWidget {
  const _OperationInfoForm({
    required this.selectedDays,
    required this.menuController,
    required this.menus,
    required this.facilities,
    required this.onDayTap,
    required this.onAddMenu,
    required this.onRemoveMenu,
    required this.openingTime,
    required this.closingTime,
    required this.onOpeningTimeTap,
    required this.onClosingTimeTap,
    required this.onFacilityChanged,
  });

  final Set<String> selectedDays;
  final TextEditingController menuController;
  final List<String> menus;
  final Map<StoreFacilityType, bool> facilities;
  final ValueChanged<String> onDayTap;
  final VoidCallback onAddMenu;
  final ValueChanged<String> onRemoveMenu;
  final String openingTime;
  final String closingTime;
  final VoidCallback onOpeningTimeTap;
  final VoidCallback onClosingTimeTap;
  final void Function(StoreFacilityType type, bool value) onFacilityChanged;

  static const List<String> _days = ['월', '화', '수', '목', '금', '토', '일'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const StoreInfoSectionTitle(title: '영업 시간'),
        const SizedBox(height: 12),
        Row(
          children: [
            for (final day in _days) ...[
              Expanded(
                child: StoreInfoDayButton(
                  label: day,
                  isSelected: selectedDays.contains(day),
                  onTap: () => onDayTap(day),
                ),
              ),
              if (day != _days.last) const SizedBox(width: 8),
            ],
          ],
        ),
        const SizedBox(height: 12),
        StoreInfoTimeRangeField(
          openingTime: openingTime,
          closingTime: closingTime,
          onOpeningTimeTap: onOpeningTimeTap,
          onClosingTimeTap: onClosingTimeTap,
        ),
        const SizedBox(height: 32),
        const StoreInfoSectionTitle(
          title: '대표 메뉴',
          helperText: '최대 10개',
        ),
        const SizedBox(height: 8),
        StoreInfoMenuInputRow(
          controller: menuController,
          onAdd: onAddMenu,
        ),
        const SizedBox(height: 12),
        StoreInfoMenuTagWrap(
          menus: menus,
          onRemove: onRemoveMenu,
        ),
        const SizedBox(height: 32),
        const StoreInfoSectionTitle(title: '편의 시설'),
        const SizedBox(height: 12),
        StoreInfoFacilityRow(
          type: StoreFacilityType.takeout,
          isEnabled: facilities[StoreFacilityType.takeout] ?? false,
          onChanged: (value) => onFacilityChanged(
            StoreFacilityType.takeout,
            value,
          ),
        ),
        const SizedBox(height: 12),
        StoreInfoFacilityRow(
          type: StoreFacilityType.reservation,
          isEnabled: facilities[StoreFacilityType.reservation] ?? false,
          onChanged: (value) => onFacilityChanged(
            StoreFacilityType.reservation,
            value,
          ),
        ),
        const SizedBox(height: 12),
        StoreInfoFacilityRow(
          type: StoreFacilityType.parking,
          isEnabled: facilities[StoreFacilityType.parking] ?? false,
          onChanged: (value) => onFacilityChanged(
            StoreFacilityType.parking,
            value,
          ),
        ),
      ],
    );
  }
}
