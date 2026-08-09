import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/features/hashtag/domain/entities/hashtag_bundle.dart';
import 'package:ssoss_flutter/features/hashtag/domain/usecases/bookmark_hashtag_bundle_usecase.dart';
import 'package:ssoss_flutter/features/hashtag/domain/usecases/list_hashtag_bundles_usecase.dart';
import 'package:ssoss_flutter/features/hashtag/domain/usecases/unbookmark_hashtag_bundle_usecase.dart';
import 'package:ssoss_flutter/features/hashtag/presentation/cubit/hashtag_catalog_state.dart';

class HashtagCatalogCubit extends Cubit<HashtagCatalogState> {
  HashtagCatalogCubit({
    required ListHashtagBundlesUseCase listHashtagBundles,
    required BookmarkHashtagBundleUseCase bookmarkHashtagBundle,
    required UnbookmarkHashtagBundleUseCase unbookmarkHashtagBundle,
  })  : _listHashtagBundles = listHashtagBundles,
        _bookmarkHashtagBundle = bookmarkHashtagBundle,
        _unbookmarkHashtagBundle = unbookmarkHashtagBundle,
        super(const HashtagCatalogState());

  static const int pageSize = 20;

  final ListHashtagBundlesUseCase _listHashtagBundles;
  final BookmarkHashtagBundleUseCase _bookmarkHashtagBundle;
  final UnbookmarkHashtagBundleUseCase _unbookmarkHashtagBundle;

  Future<void> loadInitial() async {
    if (state.isLoading) {
      return;
    }
    await _load(page: 0, replace: true);
  }

  Future<void> refresh() {
    if (state.isLoading) {
      return Future.value();
    }
    return _load(page: 0, replace: true, keepRefreshing: true);
  }

  Future<void> ensureLoaded() async {
    if (state.hasLoaded || state.isLoading) {
      return;
    }
    await loadInitial();
  }

  Future<void> loadMore() async {
    if (!state.hasNext || state.isLoadingMore || state.isLoading) {
      return;
    }
    emit(state.copyWith(isLoadingMore: true, errorMessage: null));
    await _load(page: state.page + 1, replace: false);
  }

  Future<void> search(String keyword) async {
    final trimmed = keyword.trim();
    if (trimmed == state.keyword && state.hasLoaded) {
      return;
    }
    emit(state.copyWith(keyword: trimmed));
    await _load(page: 0, replace: true);
  }

  Future<bool> toggleBookmark(int bundleId) async {
    if (state.pendingBookmarkIds.contains(bundleId)) {
      return false;
    }

    final index = state.items.indexWhere((item) => item.id == bundleId);
    if (index < 0) {
      return false;
    }

    final current = state.items[index];
    final nextBookmarked = !current.bookmarked;
    final previousItems = state.items;

    emit(
      state.copyWith(
        items: _replaceItem(
          previousItems,
          current.copyWith(bookmarked: nextBookmarked),
        ),
        pendingBookmarkIds: {...state.pendingBookmarkIds, bundleId},
        errorMessage: null,
      ),
    );

    try {
      if (nextBookmarked) {
        await _bookmarkHashtagBundle(bundleId);
      } else {
        await _unbookmarkHashtagBundle(bundleId);
      }
      if (isClosed) {
        return true;
      }
      emit(
        state.copyWith(
          pendingBookmarkIds: _withoutPending(bundleId),
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
          pendingBookmarkIds: _withoutPending(bundleId),
        ),
      );
      return false;
    }
  }

  Set<int> _withoutPending(int bundleId) {
    return {...state.pendingBookmarkIds}..remove(bundleId);
  }

  Future<void> _load({
    required int page,
    required bool replace,
    bool keepRefreshing = false,
  }) async {
    if (replace && !keepRefreshing) {
      emit(
        state.copyWith(
          isLoading: true,
          errorMessage: null,
        ),
      );
    }

    try {
      final keyword = state.keyword.isEmpty ? null : state.keyword;
      final result = await _listHashtagBundles(
        keyword: keyword,
        page: page,
        size: pageSize,
      );
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          items: replace ? result.bundles : [...state.items, ...result.bundles],
          page: result.page,
          hasNext: result.hasNext,
          hasLoaded: true,
          isLoading: false,
          isLoadingMore: false,
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
          isLoadingMore: false,
          errorMessage: '해시태그 묶음을 불러오지 못했습니다.',
        ),
      );
    }
  }

  List<HashtagBundle> _replaceItem(
    List<HashtagBundle> items,
    HashtagBundle updated,
  ) {
    return [
      for (final item in items)
        if (item.id == updated.id) updated else item,
    ];
  }
}
