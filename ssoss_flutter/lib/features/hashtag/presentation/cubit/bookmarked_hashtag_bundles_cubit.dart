import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/features/hashtag/domain/usecases/list_bookmarked_hashtag_bundles_usecase.dart';
import 'package:ssoss_flutter/features/hashtag/domain/usecases/unbookmark_hashtag_bundle_usecase.dart';
import 'package:ssoss_flutter/features/hashtag/presentation/cubit/bookmarked_hashtag_bundles_state.dart';

class BookmarkedHashtagBundlesCubit extends Cubit<BookmarkedHashtagBundlesState> {
  BookmarkedHashtagBundlesCubit({
    required ListBookmarkedHashtagBundlesUseCase listBookmarkedHashtagBundles,
    required UnbookmarkHashtagBundleUseCase unbookmarkHashtagBundle,
  })  : _listBookmarkedHashtagBundles = listBookmarkedHashtagBundles,
        _unbookmarkHashtagBundle = unbookmarkHashtagBundle,
        super(const BookmarkedHashtagBundlesState());

  final ListBookmarkedHashtagBundlesUseCase _listBookmarkedHashtagBundles;
  final UnbookmarkHashtagBundleUseCase _unbookmarkHashtagBundle;

  Future<void> load() async {
    if (state.isLoading) {
      return;
    }
    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
      ),
    );

    try {
      final items = await _listBookmarkedHashtagBundles();
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          items: items,
          hasLoaded: true,
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
          errorMessage: '북마크한 해시태그를 불러오지 못했습니다.',
        ),
      );
    }
  }

  Future<void> ensureLoaded() async {
    if (state.hasLoaded || state.isLoading) {
      return;
    }
    await load();
  }

  /// 낙관적으로 목록에서 제거한 뒤 DELETE 호출.
  /// 성공 시 `true`, 실패 시 복원하고 `false`.
  Future<bool> unbookmark(int bundleId) async {
    if (state.pendingUnbookmarkIds.contains(bundleId)) {
      return false;
    }

    final index = state.items.indexWhere((item) => item.id == bundleId);
    if (index < 0) {
      return false;
    }

    final previousItems = state.items;

    emit(
      state.copyWith(
        items: [
          for (final item in previousItems)
            if (item.id != bundleId) item,
        ],
        pendingUnbookmarkIds: {...state.pendingUnbookmarkIds, bundleId},
        errorMessage: null,
      ),
    );

    try {
      await _unbookmarkHashtagBundle(bundleId);
      if (isClosed) {
        return true;
      }
      emit(
        state.copyWith(
          pendingUnbookmarkIds: _withoutPending(bundleId),
        ),
      );
      return true;
    } catch (_) {
      if (isClosed) {
        return false;
      }
      emit(
        state.copyWith(
          items: previousItems,
          pendingUnbookmarkIds: _withoutPending(bundleId),
        ),
      );
      return false;
    }
  }

  Set<int> _withoutPending(int bundleId) {
    return {...state.pendingUnbookmarkIds}..remove(bundleId);
  }
}
