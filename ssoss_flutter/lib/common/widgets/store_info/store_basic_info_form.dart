import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/input/ssoss_select_dropdown.dart';
import 'package:ssoss_flutter/common/widgets/store_info/store_info_components.dart';
import 'package:ssoss_flutter/common/widgets/store_info/store_info_limits.dart';

class StoreBasicInfoForm extends StatefulWidget {
  const StoreBasicInfoForm({
    required this.storeNameController,
    required this.addressController,
    required this.introController,
    required this.storeType,
    required this.onStoreTypeSelected,
    this.markRequiredFields = false,
    super.key,
  });

  final TextEditingController storeNameController;
  final TextEditingController addressController;
  final TextEditingController introController;
  final String? storeType;
  final ValueChanged<String> onStoreTypeSelected;

  /// 온보딩처럼 필수/선택 표기를 붙일지 여부.
  final bool markRequiredFields;

  static const List<String> storeTypeOptions = [
    '카페',
    '디저트 카페',
    '베이커리',
    '베이커리 카페',
    '브런치 카페',
    '로스터리 카페',
    '카페·바',
  ];

  @override
  State<StoreBasicInfoForm> createState() => _StoreBasicInfoFormState();
}

class _StoreBasicInfoFormState extends State<StoreBasicInfoForm> {
  bool _isStoreTypeOpen = false;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = widget.storeType == null
        ? null
        : StoreBasicInfoForm.storeTypeOptions.indexOf(widget.storeType!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StoreInfoFormField(
          label: '매장명',
          controller: widget.storeNameController,
          hintText: '입력해주세요.',
          isRequired: widget.markRequiredFields,
          maxLength: StoreInfoLimits.storeName,
        ),
        const SizedBox(height: 32),
        StoreInfoSectionTitle(
          title: '매장 유형',
          isRequired: widget.markRequiredFields,
        ),
        const SizedBox(height: 8),
        SsossSelectDropdown(
          options: StoreBasicInfoForm.storeTypeOptions,
          value: widget.storeType,
          placeholder: '선택해주세요',
          isOpen: _isStoreTypeOpen,
          selectedIndex: selectedIndex == -1 ? null : selectedIndex,
          onFieldTap: () {
            setState(() => _isStoreTypeOpen = !_isStoreTypeOpen);
          },
          onOptionSelected: (index) {
            setState(() => _isStoreTypeOpen = false);
            widget.onStoreTypeSelected(
              StoreBasicInfoForm.storeTypeOptions[index],
            );
          },
        ),
        const SizedBox(height: 32),
        StoreInfoAddressFormField(
          label: '주소',
          controller: widget.addressController,
          hintText: '주소를 검색해주세요',
          isRequired: widget.markRequiredFields,
        ),
        const SizedBox(height: 32),
        StoreInfoFormField(
          label: '매장 한 줄 소개',
          controller: widget.introController,
          hintText: '입력해주세요.',
          helperText: widget.markRequiredFields ? '선택' : null,
          maxLength: StoreInfoLimits.introduction,
        ),
      ],
    );
  }
}
