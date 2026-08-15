import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/features/content/presentation/cubit/content_state.dart';

class ContentCubit extends Cubit<ContentState> {
  ContentCubit() : super(const ContentState.initial());
}
