import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/features/content/presentation/models/content_generation_preview_data.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/cubit/content_generation_management_state.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_generation_management/content_generation_management_api.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_generation_management/content_generation_management_components.dart';

class ContentGenerationManagementCubit
    extends Cubit<ContentGenerationManagementState> {
  ContentGenerationManagementCubit({
    ContentGenerationManagementApi? api,
  })  : _api = api ?? const ContentGenerationManagementApi(),
        super(
          ContentGenerationManagementState(
            items: contentManagementPreviewItems,
          ),
        );

  final ContentGenerationManagementApi _api;

  /// API 연동 진입점. 백엔드 계약 확정 후 [_api]로 목록을 로드한다.
  Future<void> loadItems() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      await _api.fetchItems();
      if (isClosed) {
        return;
      }
      // API 미연동: 더미 목록 유지.
      emit(state.copyWith(isLoading: false));
    } catch (_) {
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: '콘텐츠 목록을 불러오지 못했습니다.',
        ),
      );
    }
  }

  void selectFilter(String filter) {
    emit(
      state.copyWith(
        selectedFilter: filter,
        openedMenuItemId: null,
      ),
    );
  }

  void toggleSort() {
    emit(
      state.copyWith(
        isLatestFirst: !state.isLatestFirst,
        openedMenuItemId: null,
      ),
    );
  }

  void toggleDeleteMenu(String itemId) {
    emit(
      state.copyWith(
        openedMenuItemId:
            state.openedMenuItemId == itemId ? null : itemId,
      ),
    );
  }

  void closeDeleteMenu() {
    emit(state.copyWith(openedMenuItemId: null));
  }

  Future<void> deleteItem(ContentManagementItem item) async {
    emit(state.copyWith(openedMenuItemId: null));
    try {
      await _api.deleteItem(item.id);
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          items: state.items
              .where((content) => content.id != item.id)
              .toList(growable: false),
        ),
      );
    } catch (_) {
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          errorMessage: '콘텐츠 삭제에 실패했습니다.',
        ),
      );
    }
  }
}
