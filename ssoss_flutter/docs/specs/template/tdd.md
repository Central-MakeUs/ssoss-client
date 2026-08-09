# TDD — 추천 템플릿 목록·상세·적용·저장

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/template-catalog` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-08-08 |
| 상태 | Approved |
| 관련 PRD | [`prd.md`](./prd.md) |

---

## 1. 기능 요약

기존 `template` 피처에 추천 템플릿 목록·상세·적용·저장 data/domain을 두고, 추천 콘텐츠 소스 템플릿 탭과 상세·적용 화면에 Cubit을 연결한다. 생성 관리 템플릿 탭에서 저장한 글 목록·상세·본문 편집·제목 수정·삭제를 조회·변경한다. 카탈로그·상세에서 북마크 PUT/DELETE를 낙관적으로 토글한다.

**피처 경로**: `lib/features/template/` (data/domain/catalog cubit), 저장 내역 Cubit·UI는 `lib/features/dashboard/`, 카탈로그 목록 UI는 `lib/features/recommend_source/`

---

## 2. 전체 데이터 흐름

```
[템플릿 탭 진입] → TemplateCatalogCubit.loadInitial(category)
[분류 칩] → Cubit.selectCategory → page=0 재조회
[검색] → Cubit.search(keyword) → page=0 재조회
[하단 스크롤] → Cubit.loadMore
[북마크 아이콘] → Cubit.toggleBookmark → PUT/DELETE /v1/members/me/templates/{id}
[카드 탭] → TemplateDetailCubit.load(templateId)
[상세 북마크] → TemplateDetailCubit.toggleBookmark → 동일 PUT/DELETE
[적용하기] → GetAppliedTemplate → TemplateApplyArgs
[저장하기] → SaveTemplateUseCase → 완료 페이지
[생성 관리 템플릿 탭] → SavedTemplateManagementCubit.loadInitial
[정렬/스크롤] → toggleSort / loadMore
[카드 탭] → SavedTemplateDetailCubit.load(savedTemplateId)
[상세 편집] → PUT /v1/saved-templates/{id} (body)
[이름 수정] → PUT /v1/saved-templates/{id}/title
[삭제] → DELETE /v1/saved-templates/{id}
    ↓
UseCase → TemplateRepository → TemplateRemoteDatasource → Dio
    ↓
Model.toEntity() → State
```

---

## 3. Domain 레이어

### 3.1 Entities

| 파일 | 클래스 | 설명 |
|------|--------|------|
| `domain/entities/recommended_template_category.dart` | `RecommendedTemplateCategory` | NEW_MENU / EVENT / STORE_INTRO / NOTICE |
| `domain/entities/recommended_template.dart` | `RecommendedTemplate` | 목록 카드 1건 |
| `domain/entities/recommended_template_list_page.dart` | `RecommendedTemplateListPage` | 페이지 응답 |
| `domain/entities/recommended_template_detail.dart` | `RecommendedTemplateDetail` | 상세 |
| `domain/entities/applied_template.dart` | `AppliedTemplate` | 적용 본문 |
| `domain/entities/saved_template.dart` | `SavedTemplate` | 저장 결과 |
| `domain/entities/saved_template_sort.dart` | `SavedTemplateSort` | LATEST / OLDEST |
| `domain/entities/saved_template_list_item.dart` | `SavedTemplateListItem` | 저장 내역 카드 1건 |
| `domain/entities/saved_template_list_page.dart` | `SavedTemplateListPage` | 저장 내역 페이지 응답 |
| `domain/entities/saved_template_detail.dart` | `SavedTemplateDetail` | 저장 내역 상세 |

```dart
class RecommendedTemplate {
  final int id;
  final RecommendedTemplateCategory category;
  final String title;
  final String description;
  final List<String> recommendedChannels; // API 코드
  final bool bookmarked;
}

class RecommendedTemplateListPage {
  final int totalCount;
  final int page;
  final int size;
  final bool hasNext;
  final List<RecommendedTemplate> templates;
}

class RecommendedTemplateDetail {
  final int id;
  final RecommendedTemplateCategory category;
  final String title;
  final String description;
  final String body;
  final String exampleBody;
  final List<String> recommendedChannels;
  final bool bookmarked;
}

class AppliedTemplate {
  final int id;
  final String body;
}

class SavedTemplate {
  final int savedTemplateId;
}

class SavedTemplateListItem {
  final int savedTemplateId;
  final RecommendedTemplateCategory category;
  final String title;
  final String description;
  final DateTime savedAt;
}

class SavedTemplateListPage {
  final int totalCount;
  final int page;
  final int size;
  final bool hasNext;
  final List<SavedTemplateListItem> savedTemplates;
}

class SavedTemplateDetail {
  final int savedTemplateId;
  final RecommendedTemplateCategory category;
  final String title;
  final String description;
  final String body;
  final List<String> recommendedChannels;
  final DateTime savedAt;
}
```

### 3.2 Repository

`TemplateRepository`:

- `listTemplates({RecommendedTemplateCategory? category, String? keyword, int page, int size})` → `RecommendedTemplateListPage`
- `getTemplate(int templateId)` → `RecommendedTemplateDetail`
- `getAppliedTemplate(int templateId)` → `AppliedTemplate`
- `saveTemplate({required int templateId, required String body})` → `SavedTemplate`
- `listSavedTemplates({SavedTemplateSort sort, int page, int size})` → `SavedTemplateListPage`
- `getSavedTemplate(int savedTemplateId)` → `SavedTemplateDetail`
- `editSavedTemplate({required int savedTemplateId, required String body})` → `SavedTemplateDetail`
- `renameSavedTemplate({required int savedTemplateId, required String title})` → `SavedTemplateDetail`
- `deleteSavedTemplate(int savedTemplateId)` → `void`
- `bookmarkTemplate(int templateId)` → `void`
- `unbookmarkTemplate(int templateId)` → `void`
- `listBookmarkedTemplates()` → `List<RecommendedTemplate>`

### 3.3 Use Cases

- `ListTemplatesUseCase`
- `GetTemplateUseCase`
- `GetAppliedTemplateUseCase`
- `SaveTemplateUseCase`
- `ListSavedTemplatesUseCase`
- `GetSavedTemplateUseCase`
- `EditSavedTemplateUseCase`
- `RenameSavedTemplateUseCase`
- `DeleteSavedTemplateUseCase`
- `BookmarkTemplateUseCase`
- `UnbookmarkTemplateUseCase`
- `ListBookmarkedTemplatesUseCase`

---

## 4. Data 레이어

### 4.1 Models

- `RecommendedTemplateModel` / `RecommendedTemplateListResponseModel`
- `RecommendedTemplateDetailResponseModel`
- `AppliedTemplateResponseModel`
- `SavedTemplateSaveRequest` / `SavedTemplateSaveResponseModel`
- `SavedTemplateListItemModel` / `SavedTemplateListResponseModel`
- `SavedTemplateDetailResponseModel`
- `SavedTemplateEditRequest` `{ body }`
- `SavedTemplateRenameRequest` `{ title }`
- `BookmarkedTemplateListResponseModel` `{ templates }` — 항목에 `bookmarked` 없음. `toEntity()` 시 `bookmarked: true`

freezed + json_serializable + `toEntity()`.

### 4.2 DataSource

- `GET /v1/templates` — query: category?, keyword?, page, size
- `GET /v1/templates/{templateId}`
- `GET /v1/templates/{templateId}/applied`
- `POST /v1/saved-templates` — 201 `{ savedTemplateId }`
- `GET /v1/saved-templates` — query: sort?, page, size
- `GET /v1/saved-templates/{savedTemplateId}`
- `PUT /v1/saved-templates/{savedTemplateId}` — `{ body }`
- `PUT /v1/saved-templates/{savedTemplateId}/title` — `{ title }`
- `DELETE /v1/saved-templates/{savedTemplateId}` — 204
- `PUT /v1/members/me/templates/{templateId}` — 204
- `DELETE /v1/members/me/templates/{templateId}` — 204
- `GET /v1/members/me/templates` — `{ templates }` 페이징 없음

### 4.3 Repository 구현체

`TemplateRepositoryImpl` — model → entity, category·channel 매핑, `mapDioError` 전파.

---

## 5. Presentation 레이어

### 5.1 설계 결정

| 구분 | 선택 | 이유 |
|------|------|------|
| 상태 관리 | Cubit | 목록·상세·저장이 단순 비동기 |
| pageSize | 20 | API 기본값 |
| 전체 탭 | category 쿼리 생략 | API 계약 |
| 템플릿 검색 | `keyword` + 디바운스 | 해시태그 카탈로그와 동일. category와 함께 적용 |
| 북마크 토글 | 낙관적 아이콘 + 실패 복원 | 해시태그 카탈로그와 동일 |
| 북마크 목록 Cubit | `BookmarkedTemplatesCubit` | 마이페이지 저장 소스 템플릿 탭 |
| 채널 배지 | template presentation 매퍼 | content 피처 비의존 |
| 적용하기 | 상세 CTA에서 API 후 이동 | ADR-005 버튼 로딩 |
| 적용 본문 | `SsossTemplateDocument.fromTemplate` | ADR-004 |
| 저장 검증 | 공백/2000자 클라이언트 선검증 | C0001 예방 |
| 저장 내역 진입 | `HomeRouteExtra` + 템플릿 탭 index | 기존 dashboard extra 호환 |
| 저장 내역 pageSize | 10 | 생성 콘텐츠 탭과 동일 |
| 저장 내역 필터 | 없음 | API에 채널·분류 쿼리 없음 |
| 저장 내역 Cubit | 콘텐츠 Cubit과 분리 | 피처·필터 축이 다름 |
| 점 3개 메뉴 | 제목 PUT / 삭제 DELETE | 모달 로딩 ADR-005 |
| 본문 편집 | `TemplateEditPage` + body PUT | 적용 플로우는 document pop 유지 |
| 제목 한도 | 2~20자 | 콘텐츠 탭과 동일. `SsossTextField.isWithinLength` |

### 5.2 Cubits

| Cubit | 위치 |
|-------|------|
| `TemplateCatalogCubit` | `template/presentation/cubit/` |
| `TemplateDetailCubit` | 동일 |
| `TemplateApplyCubit` | 동일 |
| `BookmarkedTemplatesCubit` | 동일 |
| `SavedTemplateManagementCubit` | `dashboard/presentation/cubit/` |
| `SavedTemplateDetailCubit` | 동일 |

### 5.3 UI 모델

- `TemplateItem.id` → `int`
- `TemplateCategory` (presentation, `all` 포함) ↔ `RecommendedTemplateCategory`
- 채널 API 코드 → 한글 라벨 (당근/인스타그램/블로그/스레드)

### 5.4 라우팅 extra

| 경로 | extra |
|------|------|
| `/template-detail` | `int templateId` |
| `/template-apply` | `TemplateApplyArgs(templateId, body)` |
| `/home` | `SsossNavigationItem` 또는 `HomeRouteExtra` |
| `/template-edit` | `TemplateEditArgs(document, savedTemplateId?)` |

---

## 6. API 명세

| 메서드 | 엔드포인트 | 설명 | 인증 |
|--------|-----------|------|------|
| GET | `/v1/templates` | 목록 (category?, keyword?, page, size) | Y |
| GET | `/v1/templates/{templateId}` | 상세 | Y |
| GET | `/v1/templates/{templateId}/applied` | 매장 정보 치환 본문 | Y |
| POST | `/v1/saved-templates` | 저장 | Y |
| GET | `/v1/saved-templates` | 저장 내역 목록 (sort?, page, size) | Y |
| GET | `/v1/saved-templates/{savedTemplateId}` | 저장 내역 상세 | Y |
| PUT | `/v1/saved-templates/{savedTemplateId}` | 본문 편집 | Y |
| PUT | `/v1/saved-templates/{savedTemplateId}/title` | 제목 수정 | Y |
| DELETE | `/v1/saved-templates/{savedTemplateId}` | 삭제 | Y |
| PUT | `/v1/members/me/templates/{templateId}` | 북마크 저장 | Y |
| DELETE | `/v1/members/me/templates/{templateId}` | 북마크 해제 | Y |
| GET | `/v1/members/me/templates` | 내 북마크 목록 | Y |

**저장 Request**

```json
{
  "templateId": 8,
  "body": "보니스커피에 새 메뉴가 출시되었습니다!..."
}
```

**저장 Response (201)**

```json
{
  "savedTemplateId": 1
}
```

---

## 7. 에러 처리 전략

| 에러 | 처리 |
|------|------|
| 목록 네트워크/서버 오류 | Cubit `errorMessage`, 다시 시도 |
| 상세 오류 | Cubit `errorMessage` |
| 적용/저장 실패 | `AppException.message` 토스트 |
| 저장 내역 목록 오류 | Cubit `errorMessage` + 토스트 |
| 저장 상세 오류 | Cubit `errorMessage` + 다시 시도 |
| 본문·제목 수정/삭제 실패 | `AppException.message` 토스트, 모달·화면 유지 |
| 북마크 토글 실패 | 이전 상태 복원 + error 토스트 「북마크 변경에 실패했습니다」 |
| 401/403 | 기존 Dio 인터셉터 |

---

## 8. 로컬 상태 & 캐싱

캐시 없음. Cubit 인메모리만 유지.

---

## 9. 의존성 주입

`TemplateProviders.build()` → `SsossApp` MultiProvider. Cubit은 페이지 `BlocProvider`.

---

## 10. 테스트 계획

수동 검증 우선. Unit/Widget test는 선택.
