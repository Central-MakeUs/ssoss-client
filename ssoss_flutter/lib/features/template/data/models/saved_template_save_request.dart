import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_template_save_request.freezed.dart';
part 'saved_template_save_request.g.dart';

@freezed
abstract class SavedTemplateSaveRequest with _$SavedTemplateSaveRequest {
  const factory SavedTemplateSaveRequest({
    required int templateId,
    required String body,
  }) = _SavedTemplateSaveRequest;

  factory SavedTemplateSaveRequest.fromJson(Map<String, dynamic> json) =>
      _$SavedTemplateSaveRequestFromJson(json);
}
