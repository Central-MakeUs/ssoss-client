import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ssoss_flutter/features/dashboard/presentation/cubit/content_generation_management_state.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_generation_management/content_generation_management_api.dart';
import 'package:ssoss_flutter/features/dashboard/presentation/pages/content_generation_management/content_generation_management_components.dart';

class ContentGenerationManagementCubit
    extends Cubit<ContentGenerationManagementState> {
  ContentGenerationManagementCubit({
    ContentGenerationManagementApi? api,
  })  : _api = api ?? const ContentGenerationManagementApi(),
        super(
          const ContentGenerationManagementState(items: _initialItems),
        );

  final ContentGenerationManagementApi _api;

  static const List<ContentManagementItem> _initialItems = [
    ContentManagementItem(
      id: 'content-blog-1',
      date: '26.09.01',
      channel: '블로그',
      category: '정보성',
      tone: '일상형',
      title: '을지로 크루아상 맛집 | 겹겹이 살아있는 결, 보니스커피',
      tags: ['#을지로카페', '#을지로크루아상'],
    ),
    ContentManagementItem(
      id: 'content-blog-2',
      date: '26.08.23',
      channel: '블로그',
      category: '이벤트/할인',
      tone: '일상형',
      title: '신메뉴 앙버터 토스트 출시! 선착순 이벤트',
      tags: ['#을지로카페', '#을지로토스트'],
    ),
    ContentManagementItem(
      id: 'content-instagram-1',
      date: '26.08.20',
      channel: '인스타그램',
      category: '정보성',
      tone: '감성형',
      title: '겹겹이 살아있는 결 🥐 매일 아침 직접 구워내는 을지로 크루아상',
      tags: ['#을지로카페', '#을지로크루아상', '#베이커리추천'],
    ),
    ContentManagementItem(
      id: 'content-carrot-1',
      date: '26.08.15',
      channel: '당근',
      category: '신메뉴/홍보',
      tone: '홍보형',
      title: '을지로에서 크루아상 찾으신다면 저희 가게로 오세요 🥐',
      tags: ['#을지로맛집', '#보니스커피'],
    ),
    ContentManagementItem(
      id: 'content-thread-1',
      date: '26.08.10',
      channel: '스레드',
      category: '정보성',
      tone: '정보형',
      title: '매일 새벽부터 만드는 버터 크루아상, 오늘도 오전에 완판됐어요',
      tags: ['#을지로디저트', '#서울카페'],
    ),
  ];

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
