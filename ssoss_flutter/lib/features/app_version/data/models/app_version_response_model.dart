import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ssoss_flutter/features/app_version/domain/entities/app_version_check.dart';

part 'app_version_response_model.freezed.dart';
part 'app_version_response_model.g.dart';

@freezed
abstract class AppVersionResponseModel with _$AppVersionResponseModel {
  const factory AppVersionResponseModel({
    required String minimumVersion,
    required bool updateRequired,
  }) = _AppVersionResponseModel;

  factory AppVersionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AppVersionResponseModelFromJson(json);
}

extension AppVersionResponseModelX on AppVersionResponseModel {
  AppVersionCheck toEntity() => AppVersionCheck(
        minimumVersion: minimumVersion,
        updateRequired: updateRequired,
      );
}
