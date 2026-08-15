import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/features/content/presentation/bloc/content_event.dart';
import 'package:ssoss_flutter/features/content/presentation/bloc/content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  ContentBloc() : super(const ContentState.initial()) {
    on<ContentStarted>(_onStarted);
  }

  Future<void> _onStarted(
    ContentStarted event,
    Emitter<ContentState> emit,
  ) async {
    // TODO: 이벤트 처리
  }
}
