# TDD — 저장한 콘텐츠 소스

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/my-page-saved-content-sources` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-08-08 |
| 상태 | Approved |
| 관련 PRD | [`prd.md`](./prd.md) |

---

## 1. 기능 요약

마이페이지에 `SavedContentSourcesPage`를 두고, 해시태그 북마크 목록은 `hashtag` 피처 data/domain/cubit에 추가한다. 템플릿 탭은 빈 UI만 둔다.

**페이지 경로**: `lib/features/my_page/presentation/pages/saved_content_sources/`  
**해시태그 API·Cubit**: `lib/features/hashtag/`

---

## 2. 전체 데이터 흐름

```
[SavedContentSourcesPage]
  → BookmarkedHashtagBundlesCubit.load
  → ListBookmarkedHashtagBundlesUseCase
  → HashtagRepository.listBookmarkedBundles
  → GET /v1/members/me/hashtag-bundles

[북마크 해제]
  → Cubit.unbookmark (낙관적 제거)
  → UnbookmarkHashtagBundleUseCase
  → DELETE /v1/members/me/hashtag-bundles/{id}
  → 성공: info 토스트 / 실패: 복원 + error 토스트
```

---

## 3. Domain 레이어 (hashtag)

### 3.1 Entity

기존 `HashtagBundle` 재사용. 북마크 목록 응답에는 `bookmarked`가 없으므로 매핑 시 `bookmarked: true`.

### 3.2 Repository

`HashtagRepository`에 추가:

- `listBookmarkedBundles()` → `List<HashtagBundle>`

### 3.3 Use Case

- `ListBookmarkedHashtagBundlesUseCase`
- 기존 `UnbookmarkHashtagBundleUseCase` 재사용

---

## 4. Data 레이어 (hashtag)

### 4.1 Models

`BookmarkedHashtagBundleListResponseModel`:

```json
{ "bundles": [ { "id", "name", "hashtags" } ] }
```

항목 모델은 카탈로그 `HashtagBundleModel`과 동일 필드를 쓰되 `bookmarked`는 JSON에 없고 `@Default(false)` — `toEntity()` 시 `bookmarked: true`로 고정.

### 4.2 Datasource

- `GET /v1/members/me/hashtag-bundles` → `listBookmarkedBundles`

---

## 5. Presentation 레이어

### 5.1 설계 결정

| 항목 | 결정 | 이유 |
|------|------|------|
| 페이지 위치 | `my_page/.../saved_content_sources/` | 마이페이지 메뉴 소유 |
| 상태 관리 | Cubit | 목록·해제 단순 비동기 |
| 탭 | SsossTabBar + PageView | ADR-007, 추천 소스와 동일 |
| 정렬 UI | 없음 | 제품 결정 |
| 템플릿 | 빈 목록 | API 미제공 |
| 해제 | 낙관적 제거 + 실패 복원 | UX |

### 5.2 Cubit (hashtag)

`BookmarkedHashtagBundlesCubit` / `BookmarkedHashtagBundlesState`

- `load()` — 전체 목록
- `unbookmark(bundleId)` → `Future<bool>` (성공 여부; 토스트는 Page)

State: `items`, `isLoading`, `hasLoaded`, `errorMessage`, `pendingUnbookmarkIds`

### 5.3 Pages & Widgets (my_page)

| 파일 | 역할 |
|------|------|
| `saved_content_sources_page.dart` | AppBar, Tab, PageView, Cubit 연결 |
| `saved_content_sources_components.dart` | `N건` 헤더, 템플릿/해시태그 리스트 |

재사용: `TemplateCard`, `RecommendSourceHashtagSetCard` (template / recommend_source 피처 컴포넌트)

---

## 6. API 명세

| 메서드 | 엔드포인트 | 설명 |
|--------|-----------|------|
| GET | `/v1/members/me/hashtag-bundles` | 북마크 묶음 전부 (페이징 없음) |
| DELETE | `/v1/members/me/hashtag-bundles/{bundleId}` | 북마크 해제 (기존) |

---

## 7. 에러 처리

| 에러 | 처리 |
|------|------|
| 목록 실패 | Cubit `errorMessage` + 재시도 |
| 해제 실패 | 항목 복원 + Page에서 error 토스트 |
| 401/403 | 기존 Dio 인터셉터 |

---

## 8. 의존성 주입

`HashtagProviders`에 `ListBookmarkedHashtagBundlesUseCase` 등록. Cubit은 페이지 `BlocProvider`에서 생성.

---

## 9. 테스트 계획

수동: 마이페이지 진입, 탭 스와이프, 해시태그 로드·해제·토스트, 템플릿 빈 목록.
