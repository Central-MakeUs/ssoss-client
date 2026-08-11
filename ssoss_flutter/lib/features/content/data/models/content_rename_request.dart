import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_rename_request.freezed.dart';
part 'content_rename_request.g.dart';

@freezed
abstract class ContentRenameRequest with _$ContentRenameRequest {
  const factory ContentRenameRequest({
    required String name,
  }) = _ContentRenameRequest;

  factory ContentRenameRequest.fromJson(Map<String, dynamic> json) =>
      _$ContentRenameRequestFromJson(json);
}
