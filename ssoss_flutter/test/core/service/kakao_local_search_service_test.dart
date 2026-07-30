import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ssoss_flutter/core/service/kakao_local_search_service.dart';

void main() {
  test('searchAddresses removes duplicate addresses', () async {
    final dio = Dio();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.resolve(
            Response<Map<String, dynamic>>(
              requestOptions: options,
              data: {
                'documents': [
                  {'road_address_name': '서울 마포구 동교로16길 21'},
                  {'road_address_name': '서울 마포구 동교로16길 21'},
                  {'road_address_name': '서울 마포구 동교로16길 23'},
                  {'address_name': '서울 마포구 동교로16길 21'},
                ],
              },
            ),
          );
        },
      ),
    );

    final service = KakaoLocalSearchService(
      dio: dio,
      apiKey: 'test-key',
    );

    final results = await service.searchAddresses('동교로');

    expect(results, [
      '서울 마포구 동교로16길 21',
      '서울 마포구 동교로16길 23',
    ]);
  });
}
