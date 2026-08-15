import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ssoss_flutter/common/widgets/button/ssoss_button.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/common/widgets/toast/ssoss_toast.dart';
import 'package:ssoss_flutter/core/colors/app_colors.dart';
import 'package:ssoss_flutter/core/theme/app_text_styles.dart';
import 'package:ssoss_flutter/utils/store_time_format.dart';

class SsossTimePickerBottomSheet extends StatefulWidget {
  const SsossTimePickerBottomSheet({
    required this.isOpeningTime,
    this.openingTime,
    this.closingTime,
    super.key,
  });

  /// 오픈 시간 선택 여부. false면 마감 시간 선택.
  final bool isOpeningTime;

  /// 현재 저장된 오픈 시간 (`HH:mm` 또는 `오전/오후 hh:mm`).
  final String? openingTime;

  /// 현재 저장된 마감 시간 (`HH:mm` 또는 `오전/오후 hh:mm`).
  final String? closingTime;

  static Future<String?> show(
    BuildContext context, {
    required bool isOpeningTime,
    String? openingTime,
    String? closingTime,
  }) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.black.withValues(alpha: 0.3),
      builder: (context) => SsossTimePickerBottomSheet(
        isOpeningTime: isOpeningTime,
        openingTime: openingTime,
        closingTime: closingTime,
      ),
    );
  }

  @override
  State<SsossTimePickerBottomSheet> createState() =>
      _SsossTimePickerBottomSheetState();
}

class _SsossTimePickerBottomSheetState
    extends State<SsossTimePickerBottomSheet> {
  static const List<String> _periods = ['오전', '오후'];
  static const List<int> _hours = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
  static const List<int> _minutes = [0, 10, 20, 30, 40, 50];

  late int _periodIndex;
  late int _hourIndex;
  late int _minuteIndex;

  @override
  void initState() {
    super.initState();
    final source =
        widget.isOpeningTime ? widget.openingTime : widget.closingTime;
    _setIndicesFromTime(source);
  }

  void _setIndicesFromTime(String? raw) {
    if (raw == null || StoreTimeFormat.isUnset(raw)) {
      // 미선택 시 오픈/마감 각각 일반적인 기본값.
      if (widget.isOpeningTime) {
        _periodIndex = 0; // 오전
        _hourIndex = _hours.indexOf(9); // 09:00
        _minuteIndex = 0;
      } else {
        _periodIndex = 1; // 오후
        _hourIndex = _hours.indexOf(6); // 18:00
        _minuteIndex = 0;
      }
      return;
    }

    final api = StoreTimeFormat.toApi(raw);
    final parts = api.split(':');
    if (parts.length != 2) {
      _setIndicesFromTime(null);
      return;
    }

    final hour24 = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts[1]) ?? 0;

    _periodIndex = hour24 < 12 ? 0 : 1;
    final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final hourIdx = _hours.indexOf(hour12);
    _hourIndex = hourIdx >= 0 ? hourIdx : 0;

    final snapped = ((minute + 5) ~/ 10 * 10) % 60;
    final minuteIdx = _minutes.indexOf(snapped);
    _minuteIndex = minuteIdx >= 0 ? minuteIdx : 0;
  }

  String get _selectedTime {
    final period = _periods[_periodIndex];
    final hour = _hours[_hourIndex].toString().padLeft(2, '0');
    final minute = _minutes[_minuteIndex].toString().padLeft(2, '0');
    return '$period $hour:$minute';
  }

  void _onConfirm() {
    final selected = _selectedTime;
    final opening = widget.isOpeningTime ? selected : widget.openingTime;
    final closing = widget.isOpeningTime ? widget.closingTime : selected;

    if (!StoreTimeFormat.isValidRange(opening, closing)) {
      showSsossToast(
        context,
        title: '유효하지 않은 영업 시간입니다.',
        type: SsossToastType.warning,
      );
      return;
    }

    Navigator.of(context).pop(selected);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFDEDEDE),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _SsossTimePickerWheel(
                periods: _periods,
                hours: _hours,
                minutes: _minutes,
                periodIndex: _periodIndex,
                hourIndex: _hourIndex,
                minuteIndex: _minuteIndex,
                onPeriodChanged: (index) {
                  setState(() => _periodIndex = index);
                },
                onHourChanged: (index) {
                  setState(() => _hourIndex = index);
                },
                onMinuteChanged: (index) {
                  setState(() => _minuteIndex = index);
                },
              ),
            ),
            const SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SsossButton(
                label: '확인',
                size: SsossButtonSize.large,
                width: double.infinity,
                height: 56,
                onPressed: _onConfirm,
                backgroundColor: AppColors.primary400,
                foregroundColor: AppColors.white,
                textStyle: AppTextStyles.h5,
              ),
            ),
            const SizedBox(height: 34),
          ],
        ),
      ),
    );
  }
}

class _SsossTimePickerWheel extends StatelessWidget {
  const _SsossTimePickerWheel({
    required this.periods,
    required this.hours,
    required this.minutes,
    required this.periodIndex,
    required this.hourIndex,
    required this.minuteIndex,
    required this.onPeriodChanged,
    required this.onHourChanged,
    required this.onMinuteChanged,
  });

  final List<String> periods;
  final List<int> hours;
  final List<int> minutes;
  final int periodIndex;
  final int hourIndex;
  final int minuteIndex;
  final ValueChanged<int> onPeriodChanged;
  final ValueChanged<int> onHourChanged;
  final ValueChanged<int> onMinuteChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 162,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 33,
            decoration: BoxDecoration(
              color: AppColors.neutral100,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 58,
                child: _SsossPickerColumn(
                  values: periods,
                  selectedIndex: periodIndex,
                  onSelectedItemChanged: onPeriodChanged,
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(width: 44),
              SizedBox(
                width: 28,
                child: _SsossPickerColumn(
                  values: [for (final hour in hours) '$hour'],
                  selectedIndex: hourIndex,
                  onSelectedItemChanged: onHourChanged,
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(
                width: 24,
                child: Center(
                  child: AppText(
                    ':',
                    style: AppTextStyles.h4.copyWith(color: AppColors.black),
                  ),
                ),
              ),
              SizedBox(
                width: 32,
                child: _SsossPickerColumn(
                  values: [
                    for (final minute in minutes)
                      minute.toString().padLeft(2, '0'),
                  ],
                  selectedIndex: minuteIndex,
                  onSelectedItemChanged: onMinuteChanged,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SsossPickerColumn extends StatefulWidget {
  const _SsossPickerColumn({
    required this.values,
    required this.selectedIndex,
    required this.onSelectedItemChanged,
    required this.textAlign,
  });

  final List<String> values;
  final int selectedIndex;
  final ValueChanged<int> onSelectedItemChanged;
  final TextAlign textAlign;

  @override
  State<_SsossPickerColumn> createState() => _SsossPickerColumnState();
}

class _SsossPickerColumnState extends State<_SsossPickerColumn> {
  late final FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = FixedExtentScrollController(
      initialItem: widget.selectedIndex,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker.builder(
      scrollController: _scrollController,
      itemExtent: 33,
      diameterRatio: 1.4,
      magnification: 1,
      squeeze: 1,
      useMagnifier: false,
      selectionOverlay: const SizedBox.shrink(),
      onSelectedItemChanged: widget.onSelectedItemChanged,
      childCount: widget.values.length,
      itemBuilder: (context, index) {
        return Align(
          alignment: widget.textAlign == TextAlign.right
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: AppText(
            widget.values[index],
            textAlign: widget.textAlign,
            style: _styleFor(index),
          ),
        );
      },
    );
  }

  TextStyle _styleFor(int index) {
    if (index == widget.selectedIndex) {
      return AppTextStyles.h4.copyWith(color: AppColors.black);
    }

    final distance = (index - widget.selectedIndex).abs();
    return (distance == 1 ? AppTextStyles.h5 : AppTextStyles.h6).copyWith(
      color: AppColors.neutral300,
    );
  }
}
