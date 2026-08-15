import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/features/content/domain/entities/content_channel_content.dart';
import 'package:ssoss_flutter/features/content/domain/entities/content_detail.dart';
import 'package:ssoss_flutter/features/content/domain/usecases/get_content_usecase.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/cubit/content_detail_state.dart';

class ContentDetailCubit extends Cubit<ContentDetailState> {
  ContentDetailCubit({
    required GetContentUseCase getContent,
    required this.contentId,
  })  : _getContent = getContent,
        super(const ContentDetailState());

  final GetContentUseCase _getContent;
  final int contentId;

  Future<void> load() async {
    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
      ),
    );
    try {
      final detail = await _getContent(contentId);
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          detail: detail,
          isLoading: false,
          errorMessage: null,
        ),
      );
    } catch (_) {
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: '콘텐츠를 불러오지 못했습니다.',
        ),
      );
    }
  }

  void applyChannelEdit(ContentChannelContent updated) {
    final detail = state.detail;
    if (detail == null) {
      return;
    }
    final nextContents = detail.contents.map((item) {
      if (item.contentChannelId == updated.contentChannelId) {
        return updated;
      }
      return item;
    }).toList(growable: false);
    emit(
      state.copyWith(
        detail: ContentDetail(
          contentId: detail.contentId,
          name: detail.name,
          purpose: detail.purpose,
          tone: detail.tone,
          keywords: detail.keywords,
          contents: nextContents,
        ),
        didMutate: true,
      ),
    );
  }
}
