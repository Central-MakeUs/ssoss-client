import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_max_length_formatter.dart';

void main() {
  TextEditingValue value(
    String text, {
    int? offset,
    TextRange? composing,
  }) {
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: offset ?? text.length),
      composing: composing ?? TextRange.empty,
    );
  }

  test('allows text within maxLength', () {
    final formatter = SsossMaxLengthFormatter(5);
    expect(
      formatter.formatEditUpdate(value('12'), value('123')),
      value('123'),
    );
  });

  test('truncates paste that exceeds maxLength', () {
    final formatter = SsossMaxLengthFormatter(5);
    final next = formatter.formatEditUpdate(value('12'), value('123456'));
    expect(next.text, '12345');
    expect(next.selection, const TextSelection.collapsed(offset: 5));
  });

  test('notifies when paste is truncated', () async {
    var notified = false;
    final formatter = SsossMaxLengthFormatter(
      5,
      onTruncatedPaste: () => notified = true,
    );

    formatter.formatEditUpdate(value('12'), value('123456789'));
    await Future<void>.delayed(Duration.zero);

    expect(notified, isTrue);
  });

  test('does not notify when a single extra character is blocked', () async {
    var notified = false;
    final formatter = SsossMaxLengthFormatter(
      5,
      onTruncatedPaste: () => notified = true,
    );

    formatter.formatEditUpdate(value('12345'), value('123456'));
    await Future<void>.delayed(Duration.zero);

    expect(notified, isFalse);
  });

  test('does not notify for short keyboard bursts over the limit', () async {
    var notified = false;
    final formatter = SsossMaxLengthFormatter(
      5,
      onTruncatedPaste: () => notified = true,
    );

    // 빠른 타이핑으로 2~3글자가 한 번에 들어온 경우
    formatter.formatEditUpdate(value('1234'), value('123456'));
    await Future<void>.delayed(Duration.zero);

    expect(notified, isFalse);
  });

  test('does not notify during IME composing updates', () async {
    var notified = false;
    final formatter = SsossMaxLengthFormatter(
      5,
      onTruncatedPaste: () => notified = true,
    );

    formatter.formatEditUpdate(
      value('12', composing: const TextRange(start: 2, end: 2)),
      value(
        '123456789',
        composing: const TextRange(start: 2, end: 9),
      ),
    );
    await Future<void>.delayed(Duration.zero);

    expect(notified, isFalse);
  });

  test('blocks additional input when already at maxLength', () {
    final formatter = SsossMaxLengthFormatter(5);
    expect(
      formatter.formatEditUpdate(value('12345'), value('123456')),
      value('12345'),
    );
  });

  test('allows deletion when already over maxLength', () {
    final formatter = SsossMaxLengthFormatter(5);
    expect(
      formatter.formatEditUpdate(value('1234567'), value('123456')),
      value('123456'),
    );
  });

  test('does not limit when maxLength is not positive', () {
    final unlimited = SsossMaxLengthFormatter(0);
    expect(
      unlimited.formatEditUpdate(value('12'), value('123456')),
      value('123456'),
    );
  });
}
