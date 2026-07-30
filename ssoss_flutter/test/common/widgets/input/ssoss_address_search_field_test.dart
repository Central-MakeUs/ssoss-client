import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_address_search_field.dart';
import 'package:ssoss_flutter/common/widgets/input/ssoss_select_option.dart';
import 'package:ssoss_flutter/common/widgets/text/app_text.dart';
import 'package:ssoss_flutter/core/service/kakao_local_search_service.dart';

class _MockKakaoLocalSearchService extends KakaoLocalSearchService {
  _MockKakaoLocalSearchService(this.handler) : super(apiKey: 'test-key');

  final Future<List<String>> Function(
    String query, {
    CancelToken? cancelToken,
  }) handler;

  @override
  Future<List<String>> searchAddresses(
    String query, {
    CancelToken? cancelToken,
  }) {
    return handler(query, cancelToken: cancelToken);
  }
}

void main() {
  Future<void> pumpAddressSearchField(
    WidgetTester tester, {
    required KakaoLocalSearchService searchService,
    TextEditingController? controller,
    FocusNode? focusNode,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SsossAddressSearchField(
            controller: controller,
            focusNode: focusNode,
            searchService: searchService,
          ),
        ),
      ),
    );
  }

  Future<void> enterText(WidgetTester tester, String text) async {
    await tester.enterText(find.byType(TextField), text);
    await tester.pump();
  }

  testWidgets('does not call search before debounce duration', (tester) async {
    var searchCount = 0;

    await pumpAddressSearchField(
      tester,
      searchService: _MockKakaoLocalSearchService((query, {cancelToken}) async {
        searchCount += 1;
        return ['서울 마포구 동교로16길 21'];
      }),
    );

    await enterText(tester, '동교로');
    await tester.pump(const Duration(milliseconds: 999));

    expect(searchCount, 0);
    expect(find.byType(SsossSelectOption), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('shows loading indicator while searching', (tester) async {
    final completer = Completer<List<String>>();

    await pumpAddressSearchField(
      tester,
      searchService: _MockKakaoLocalSearchService((query, {cancelToken}) {
        return completer.future;
      }),
    );

    await enterText(tester, '동교로');
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    completer.complete(['서울 마포구 동교로16길 21']);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 16));

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(SsossSelectOption), findsOneWidget);
  });

  testWidgets('calls search after debounce and shows up to 5 options',
      (tester) async {
    var lastQuery = '';

    await pumpAddressSearchField(
      tester,
      searchService: _MockKakaoLocalSearchService((query, {cancelToken}) async {
        lastQuery = query;
        return List<String>.generate(
          5,
          (index) => '서울 마포구 동교로16길 ${index + 1}',
        );
      }),
    );

    await enterText(tester, '동교로');
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();

    expect(lastQuery, '동교로');
    expect(find.byType(SsossSelectOption), findsNWidgets(5));
  });

  testWidgets('shows error message and hides dropdown when search fails',
      (tester) async {
    await pumpAddressSearchField(
      tester,
      searchService: _MockKakaoLocalSearchService((query, {cancelToken}) async {
        throw DioException(
          requestOptions: RequestOptions(path: '/v2/local/search/keyword.json'),
          type: DioExceptionType.badResponse,
        );
      }),
    );

    await enterText(tester, '동교로');
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(SsossSelectOption), findsNothing);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is AppText &&
            widget.data == SsossAddressSearchField.searchErrorMessage,
      ),
      findsOneWidget,
    );
  });

  testWidgets('fills text field when option is selected', (tester) async {
    final controller = TextEditingController();
    final focusNode = FocusNode();

    addTearDown(controller.dispose);
    addTearDown(focusNode.dispose);

    await pumpAddressSearchField(
      tester,
      searchService: _MockKakaoLocalSearchService((query, {cancelToken}) async {
        return const [
          '서울 마포구 동교로16길 21',
          '서울 마포구 동교로16길 23',
        ];
      }),
      controller: controller,
      focusNode: focusNode,
    );

    await enterText(tester, '동교로');
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();

    expect(find.byType(SsossSelectOption), findsNWidgets(2));

    await tester.tap(find.byType(SsossSelectOption).first);
    await tester.pump();

    expect(controller.text, '서울 마포구 동교로16길 21');
    expect(find.byType(SsossSelectOption), findsNothing);
  });

  testWidgets('hides dropdown when query is cleared', (tester) async {
    await pumpAddressSearchField(
      tester,
      searchService: _MockKakaoLocalSearchService((query, {cancelToken}) async {
        if (query.isEmpty) {
          return const [];
        }
        return const ['서울 마포구 동교로16길 21'];
      }),
    );

    await enterText(tester, '동교로');
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();

    expect(find.byType(SsossSelectOption), findsOneWidget);

    await enterText(tester, '');
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();

    expect(find.byType(SsossSelectOption), findsNothing);
  });
}
