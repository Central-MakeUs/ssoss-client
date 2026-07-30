import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:ssoss_flutter/core/config/env_loader.dart';
import 'package:ssoss_flutter/core/network/interceptors/api_logging_interceptor.dart';

/// 카카오 로컬 API 키워드 장소 검색 서비스.
class KakaoLocalSearchService {
  KakaoLocalSearchService({
    Dio? dio,
    String? apiKey,
  })  : _dio = dio ?? _createDio(),
        _apiKey = apiKey ?? EnvLoader.require(EnvLoader.kakaoRestApiKeyKey);

  static const _baseUrl = 'https://dapi.kakao.com';
  static const _searchPath = '/v2/local/search/keyword.json';
  static const _defaultSize = 5;

  final Dio _dio;
  final String _apiKey;

  Future<List<String>> searchAddresses(
    String query, {
    CancelToken? cancelToken,
  }) async {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) {
      return const [];
    }

    final response = await _dio.get<Map<String, dynamic>>(
      _searchPath,
      queryParameters: {
        'query': trimmedQuery,
        'size': _defaultSize,
      },
      options: Options(
        headers: {
          'Authorization': 'KakaoAK $_apiKey',
        },
      ),
      cancelToken: cancelToken,
    );

    final documents = response.data?['documents'];
    if (documents is! List) {
      return const [];
    }

    return documents
        .whereType<Map<String, dynamic>>()
        .map(_resolveAddress)
        .where((address) => address.isNotEmpty)
        .toSet()
        .toList(growable: false);
  }

  static String _resolveAddress(Map<String, dynamic> document) {
    final roadAddress = document['road_address_name'];
    if (roadAddress is String && roadAddress.isNotEmpty) {
      return roadAddress;
    }

    final address = document['address_name'];
    if (address is String) {
      return address;
    }

    return '';
  }

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 30),
        headers: const {
          'Accept': 'application/json',
        },
      ),
    );

    if (!kReleaseMode) {
      dio.interceptors.add(const ApiLoggingInterceptor());
    }

    return dio;
  }
}
