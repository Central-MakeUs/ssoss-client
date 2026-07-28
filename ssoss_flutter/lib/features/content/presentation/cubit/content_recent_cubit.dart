import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/features/content/domain/entities/content_list_item.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/list_contents_usecase.dart';
import 'package:ssoss_flutter/features/content/presentation/cubit/content_recent_state.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_label_mapper.dart';
import 'package:ssoss_flutter/features/content/presentation/models/content_recent_item.dart';

class ContentRecentCubit extends Cubit<ContentRecentState> {
  ContentRecentCubit({
    required ListContentsUseCase listContents,
  })  : _listContents = listContents,
        super(const ContentRecentState());

  static const int pageSize = 3;

  final ListContentsUseCase _listContents;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final page = await _listContents(page: 0, size: pageSize);
      if (isClosed) {
        return;
      }
      emit(
        ContentRecentState(
          items: page.contents.map(_toRecentItem).toList(growable: false),
          isLoading: false,
        ),
      );
    } catch (_) {
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: '최근 콘텐츠를 불러오지 못했습니다.',
        ),
      );
    }
  }

  static ContentRecentItem _toRecentItem(ContentListItem item) {
    final ordered = ContentLabelMapper.orderedChannels(item.channels);
    return ContentRecentItem(
      id: item.contentId.toString(),
      title: item.title,
      createdAt: item.savedAt,
      channels: ordered.map(ContentLabelMapper.channel).toList(growable: false),
      firstChannel: ordered.isEmpty ? null : ordered.first,
    );
  }
}
