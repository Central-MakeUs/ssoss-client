import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_template_rename_request.freezed.dart';
part 'saved_template_rename_request.g.dart';

@freezed
abstract class SavedTemplateRenameRequest with _$SavedTemplateRenameRequest {
  const factory SavedTemplateRenameRequest({
    required String title,
  }) = _SavedTemplateRenameRequest;

  factory SavedTemplateRenameRequest.fromJson(Map<String, dynamic> json) =>
      _$SavedTemplateRenameRequestFromJson(json);
}
