# TDD — 해시태그 묶음 카탈로그·북마크

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/hashtag-catalog` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-08-06 |
| 상태 | Approved |
| 관련 PRD | [`prd.md`](./prd.md) |

---

## 1. 기능 요약

독립 `hashtag` 피처에 카탈로그 조회·북마크 저장·해제 data/domain을 두고, 추천 콘텐츠 소스 해시태그 탭에 `HashtagCatalogCubit`을 연결한다. 이후 북마크 전용 목록 화면에서도 동일 usecase를 재사용할 수 있다.

**피처 경로**: `lib/features/hashtag/` (data/domain/cubit), UI는 `lib/features/content/.../recommended_content_templates/`

---

## 2. 전체 데이터 흐름

```
[해시태그 탭 진입] → HashtagCatalogCubit.loadInitial
[검색어] → Debouncer → Cubit.search(keyword)
[하단 스크롤] → Cubit.loadMore
[북마크 탭] → Cubit.toggleBookmark → PUT 또는 DELETE
    ↓
UseCase → HashtagRepository → HashtagRemoteDatasource → Dio
    ↓
Model.toEntity() → State.items
```

---

## 3. Domain 레이어

### 3.1 Entities

| 파일 | 클래스 | 설명 |
|------|--------|------|
| `domain/entities/hashtag_bundle.dart` | `HashtagBundle` | 카드 1건 |
| `domain/entities/hashtag_bundle_list_page.dart` | `HashtagBundleListPage` | 페이지 응답 |

```dart
class HashtagBundle {
  final int id;
  final String name;
  final List<String> hashtags;
  final bool bookmarked;
}

class HashtagBundleListPage {
  final int totalCount;
  final int page;
  final int size;
  final bool hasNext;
  final List<HashtagBundle> bundles;
}
```

### 3.2 Repository

`HashtagRepository`:

- `listBundles({String? keyword, int page, int size})` → `HashtagBundleListPage`
- `bookmarkBundle(int bundleId)` → `void`
- `unbookmarkBundle(int bundleId)` → `void`

### 3.3 Use Cases

- `ListHashtagBundlesUseCase`
- `BookmarkHashtagBundleUseCase`
- `UnbookmarkHashtagBundleUseCase`

---

## 4. Data 레이어

### 4.1 Models

- `HashtagBundleModel` / `HashtagBundleListResponseModel` (freezed + json_serializable + `toEntity()`)

### 4.2 DataSource

- `GET /v1/hashtag-bundles` — query: keyword?, page, size
- `PUT /v1/members/me/hashtag-bundles/{bundleId}` — 204
- `DELETE /v1/members/me/hashtag-bundles/{bundleId}` — 204

### 4.3 Repository 구현체

`HashtagRepositoryImpl` — model → entity, `mapDioError` 전파

---

## 5. Presentation 레이어

### 5.1 설계 결정

| 구분 | 선택 | 이유 |
|------|------|------|
| 상태 관리 | Cubit | 목록·검색·토글 메서드 호출이 단순 |
| pageSize | 20 | API 기본값 |
| 검색 | `Debouncer` (1초) 후 page=0 재조회 | 서버 keyword |
| 북마크 | 낙관적 토글 + 실패 롤백 | UX |
| 탭 로딩 | 해시태그 탭 첫 진입 시 `loadInitial` | 템플릿 탭과 분리 |

### 5.2 Cubit

`HashtagCatalogCubit` / `HashtagCatalogState`

State 필드: `items`, `keyword`, `page`, `hasNext`, `isLoading`, `isLoadingMore`, `hasLoaded`, `errorMessage`, `pendingBookmarkIds`

### 5.3 Pages & Widgets

기존 `RecommendedContentTemplatesPage` + `RecommendedHashtagSetList` 연동. 신규 라우트 없음.

---

## 6. API 명세

| 메서드 | 엔드포인트 | 설명 | 인증 |
|--------|-----------|------|------|
| GET | `/v1/hashtag-bundles` | 카탈로그 (keyword, page, size) | Y |
| PUT | `/v1/members/me/hashtag-bundles/{bundleId}` | 북마크 저장 | Y |
| DELETE | `/v1/members/me/hashtag-bundles/{bundleId}` | 북마크 해제 | Y |

**Response 예시 (목록)**

```json
{
  "totalCount": 3,
  "page": 0,
  "size": 20,
  "hasNext": false,
  "bundles": [
    {
      "id": 2,
      "name": "이벤트/할인 홍보",
      "hashtags": ["#오픈이벤트"],
      "bookmarked": true
    }
  ]
}
```

---

## 7. 에러 처리 전략

| 에러 | 처리 |
|------|------|
| 목록 네트워크/서버 오류 | Cubit `errorMessage`, UI 표시 |
| 북마크 실패 | bookmarked 롤백 + 토스트 |
| 401/403 | 기존 Dio 인터셉터 |

---

## 8. 로컬 상태 & 캐싱

캐시 없음. Cubit 인메모리 목록만 유지.

---

## 9. 의존성 주입

`HashtagProviders.build()` → `SsossApp` MultiProvider에 등록. Cubit은 페이지에서 `BlocProvider`로 생성.

---

## 10. 테스트 계획

수동 검증 우선. Unit/Widget test는 선택.
