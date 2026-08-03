import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/common/widgets/app_bar/ssoss_app_bar.dart';
import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_hashtag_input.dart';
import 'package:ssoss_flutter/common/widgets/picker/ssoss_time_picker_bottom_sheet.dart';
import 'package:ssoss_flutter/common/widgets/store_info/store_basic_info_form.dart';
import 'package:ssoss_flutter/common/widgets/store_info/store_content_info_form.dart';
import 'package:ssoss_flutter/common/widgets/store_info/store_info_components.dart';
import 'package:ssoss_flutter/common/widgets/store_info/store_operation_info_form.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/constants/writing_tone.dart';
import 'package:ssoss_flutter/core/exception/app_exception.dart';
import 'package:ssoss_flutter/features/store/domain/entities/store_info.dart';
import 'package:ssoss_flutter/features/store/presentation/cubit/store_cubit.dart';
import 'package:ssoss_flutter/utils/store_time_format.dart';

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
  late final TextEditingController _storeStrengthController;
  late final TextEditingController _prohibitedContentController;
  String? _storeType;
  String _openingTime = '00:00';
  String _closingTime = '00:00';
  WritingTone _selectedTone = WritingTone.daily;
  final Set<String> _selectedDays = {};
  final List<String> _menus = [];
  final List<String> _keywords = [];
  final Map<StoreFacilityType, bool> _facilities = {
    StoreFacilityType.takeout: true,
    StoreFacilityType.reservation: true,
    StoreFacilityType.parking: false,
  };

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;
    final info = context.read<StoreCubit>().state.info;
    _storeNameController = TextEditingController(text: info.basic.name ?? '');
    _addressController = TextEditingController(text: info.basic.address ?? '');
    _introController =
        TextEditingController(text: info.basic.introduction ?? '');
    _storeStrengthController =
        TextEditingController(text: info.content.strength ?? '');
    _prohibitedContentController =
        TextEditingController(text: info.content.forbidden ?? '');
    _storeType = info.basic.type?.label;
    _openingTime = info.operation.openTime ?? '00:00';
    _closingTime = info.operation.closeTime ?? '00:00';
    _selectedDays.addAll(info.operation.businessDays.map((day) => day.label));
    _menus.addAll(info.operation.signatureMenus);
    _keywords.addAll(info.content.keywords);
    _facilities[StoreFacilityType.takeout] = info.operation.takeoutAvailable;
    _facilities[StoreFacilityType.reservation] =
        info.operation.reservationAvailable;
    _facilities[StoreFacilityType.parking] = info.operation.parkingAvailable;
    _selectedTone = info.content.tone ?? WritingTone.daily;
  }

  @override
  void dispose() {
    _storeNameController.dispose();
    _addressController.dispose();
    _introController.dispose();
    _storeStrengthController.dispose();
    _prohibitedContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storeState = context.watch<StoreCubit>().state;
    final isSaving = switch (_selectedTab) {
      StoreInfoTab.basic => storeState.isSavingBasic,
      StoreInfoTab.operation => storeState.isSavingOperation,
      StoreInfoTab.content => storeState.isSavingContent,
    };

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
                type: SsossButtonType.primary,
                isLoading: isSaving,
                onPressed: () => unawaited(_saveSelectedTab()),
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
        return StoreBasicInfoForm(
          storeNameController: _storeNameController,
          addressController: _addressController,
          introController: _introController,
          storeType: _storeType,
          onStoreTypeSelected: (value) {
            setState(() => _storeType = value);
          },
        );
      case StoreInfoTab.operation:
        return StoreOperationInfoForm(
          selectedDays: _selectedDays,
          menus: _menus,
          facilities: _facilities,
          onDayTap: _toggleDay,
          onAddMenu: _addMenu,
          onRemoveMenu: _removeMenu,
          openingTime: StoreTimeFormat.toDisplay(_openingTime),
          closingTime: StoreTimeFormat.toDisplay(_closingTime),
          onOpeningTimeTap: () {
            unawaited(_showTimePicker(isOpeningTime: true));
          },
          onClosingTimeTap: () {
            unawaited(_showTimePicker(isOpeningTime: false));
          },
          onFacilityChanged: _toggleFacility,
        );
      case StoreInfoTab.content:
        return StoreContentInfoForm(
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

  void _addMenu(String menu) {
    setState(() => _menus.add(menu));
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
    final selectedTime = await SsossTimePickerBottomSheet.show(
      context,
      isOpeningTime: isOpeningTime,
      openingTime: _openingTime,
      closingTime: _closingTime,
    );

    if (!mounted || selectedTime == null) {
      return;
    }

    final apiTime = StoreTimeFormat.toApi(selectedTime);
    setState(() {
      if (isOpeningTime) {
        _openingTime = apiTime;
      } else {
        _closingTime = apiTime;
      }
    });
  }

  Future<void> _saveSelectedTab() async {
    try {
      switch (_selectedTab) {
        case StoreInfoTab.basic:
          final type = StoreType.fromLabel(_storeType);
          if (type == null) {
            showSsossToast(
              context,
              title: '매장 유형을 선택해 주세요',
              type: SsossToastType.warning,
            );
            return;
          }
          await context.read<StoreCubit>().saveBasic(
                StoreBasicInfoInput(
                  name: _storeNameController.text,
                  type: type,
                  address: _addressController.text,
                  introduction: _introController.text,
                ),
              );
          break;
        case StoreInfoTab.operation:
          await context.read<StoreCubit>().saveOperation(
                StoreOperationInfoInput(
                  businessDays: [
                    for (final day in _selectedDays)
                      if (BusinessDay.fromLabel(day) != null)
                        BusinessDay.fromLabel(day)!,
                  ],
                  openTime: _openingTime == '00:00' ? null : _openingTime,
                  closeTime: _closingTime == '00:00' ? null : _closingTime,
                  signatureMenus: _menus,
                  takeoutAvailable:
                      _facilities[StoreFacilityType.takeout] ?? false,
                  reservationAvailable:
                      _facilities[StoreFacilityType.reservation] ?? false,
                  parkingAvailable:
                      _facilities[StoreFacilityType.parking] ?? false,
                ),
              );
          break;
        case StoreInfoTab.content:
          await context.read<StoreCubit>().saveContent(
                StoreContentInfoInput(
                  strength: _storeStrengthController.text,
                  keywords: _keywords,
                  forbidden: _prohibitedContentController.text,
                  tone: _selectedTone,
                ),
              );
          break;
      }
      if (!mounted) return;
      Navigator.of(context).pop();
    } on AppException catch (e) {
      if (!mounted) return;
      showSsossToast(
        context,
        title: e.message,
        type: SsossToastType.warning,
      );
    } catch (_) {
      if (!mounted) return;
      showSsossToast(
        context,
        title: '매장 정보를 저장하지 못했습니다.',
        type: SsossToastType.warning,
      );
    }
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
