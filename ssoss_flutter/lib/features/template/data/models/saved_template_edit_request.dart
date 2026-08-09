import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_template_edit_request.freezed.dart';
part 'saved_template_edit_request.g.dart';

@freezed
abstract class SavedTemplateEditRequest with _$SavedTemplateEditRequest {
  const factory SavedTemplateEditRequest({
    required String body,
  }) = _SavedTemplateEditRequest;

  factory SavedTemplateEditRequest.fromJson(Map<String, dynamic> json) =>
      _$SavedTemplateEditRequestFromJson(json);
}
