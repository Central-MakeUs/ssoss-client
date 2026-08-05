import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/features/content/domain/entities/upload_channel.dart';
import 'package:ssoss_flutter/features/new_style/presentation/cubit/new_style_channel_state.dart';

class NewStyleChannelCubit extends Cubit<NewStyleChannelState> {
  NewStyleChannelCubit() : super(const NewStyleChannelState());

  void toggleChannel(UploadChannel channel) {
    final current = List<UploadChannel>.of(state.channels);
    if (current.contains(channel)) {
      current.remove(channel);
    } else {
      current.add(channel);
    }
    emit(state.copyWith(channels: current));
  }
}
