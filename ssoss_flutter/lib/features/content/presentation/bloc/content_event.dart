import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_event.freezed.dart';

@freezed
abstract class ContentEvent with _$ContentEvent {
  const factory ContentEvent.started() = ContentStarted;
}
