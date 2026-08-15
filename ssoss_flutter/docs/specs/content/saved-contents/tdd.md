# TDD — 저장 콘텐츠 목록·상세·삭제

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/content-saved-contents` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-07-29 |
| 상태 | Approved |
| 관련 PRD | [`prd.md`](./prd.md) |

---

## 1. 기능 요약

저장 콘텐츠의 목록·상세·삭제를 content 피처 data/domain에 추가하고, 홈(size=3)·생성 관리(size=10 페이지네이션)·상세를 실 API에 연결한다. 편집은 기존 PUT을 쓰고, 변경 후 목록을 재조회한다.

**피처 경로**: `lib/features/content/` (data/domain), presentation은 content 홈 + `lib/features/dashboard/` 관리·상세

---

## 2. 전체 데이터 흐름

```
[ContentRecentCubit] ──ListContents(size:3)──► ContentRepository
[ContentGenerationManagementCubit] ──ListContents(size:10,page)──►
[ContentDetailCubit] ──GetContent(id)──►
[ManagementCubit] ──DeleteContent(id)──►
[ContentEditPage put] ──EditContentChannel──► (기존)
```

---

## 3. Domain 레이어

### 3.1 Entities

| 파일 | 클래스 | 설명 |
|------|--------|------|
| `domain/entities/content_list_item.dart` | `ContentListItem` | 목록 카드 1건 |
| `domain/entities/content_list_page.dart` | `ContentListPage` | 페이지 응답 |
| `domain/entities/content_detail.dart` | `ContentDetail` | 상세 (채널 본문 포함) |

```dart
class ContentListItem {
  final int contentId;
  final DateTime savedAt;
  final List<UploadChannel> channels;
  final UploadPurpose purpose;
  final ContentTone tone;
  final String title;
  final List<String> hashtags;
}

class ContentListPage {
  final int totalCount;
  final int page;
  final int size;
  final bool hasNext;
  final List<ContentListItem> contents;
}

class ContentDetail {
  final int contentId;
  final UploadPurpose purpose;
  final ContentTone tone;
  final List<String> keywords;
  final List<ContentChannelContent> contents; // 기존 entity
}
```

### 3.2 Repository

`ContentRepository`에 추가:

- `listContents({UploadChannel? channel, int page, int size})` → `ContentListPage`
- `getContent(int contentId)` → `ContentDetail`
- `deleteContent(int contentId)` → `void`

### 3.3 Use Cases

- `ListContentsUseCase`
- `GetContentUseCase`
- `DeleteContentUseCase`

---

## 4. Data 레이어

### 4.1 Models

- `ContentListResponseModel` / `ContentListItemModel`
- `ContentDetailResponseModel` (channels: 기존 `ContentChannelResponseModel` 재사용)

### 4.2 DataSource

- `GET /v1/contents`
- `GET /v1/contents/{contentId}`
- `DELETE /v1/contents/{contentId}`

채널·purpose·tone 매핑: `ContentCreateApiMapper`

---

## 5. Presentation 레이어

### 5.1 설계 결정

| 항목 | 결정 | 이유 |
|------|------|------|
| 상태 관리 | Cubit | 목록·상세 단순 비동기 |
| 홈 size | 3 | API 가이드 |
| 관리 size | 10 | 요구사항 |
| 정렬 UI | 최신순 고정, 토글 제거 | API 정렬 파라미터 없음 |
| 필터 | 서버 `channel` | 페이지네이션과 일치 |
| 카드 단위 | 저장 1회 = 1카드 | API 계약 |
| 제목 절단 | 서버 그대로 | 클라이언트 재절단 금지 |
| 상세 다중 채널 | Tab + PageView, index 0 | 결과 화면과 동일 UX |
| invalidate | pop(didMutate) / refresh | 편집·삭제 후 목록 동기화 |
| sticky | SliverPersistentHeader pinned | 필터·n건 고정 |
| refresh | RefreshIndicator | pull-to-refresh |

### 5.2 Cubits

| Cubit | 위치 |
|-------|------|
| `ContentRecentCubit` | `content/presentation/cubit/` |
| `ContentGenerationManagementCubit` | `dashboard/presentation/cubit/` (use case 주입) |
| `ContentDetailCubit` | `dashboard/presentation/cubit/` 또는 detail 폴더 |

### 5.3 UI 모델

- `ContentRecentItem` ← `ContentListItem` 매핑 (`contentId`를 id로)
- `ContentManagementItem` ← 저장 단위(다채널 `channels` 리스트)

---

## 6. API 명세

| 메서드 | 엔드포인트 | 설명 |
|--------|-----------|------|
| GET | `/v1/contents` | 목록 (`channel`, `page`, `size`) |
| GET | `/v1/contents/{contentId}` | 상세 |
| DELETE | `/v1/contents/{contentId}` | 삭제 (204) |
| PUT | `/v1/contents/{contentId}/channels/{contentChannelId}` | 편집 (기존) |

---

## 7. 에러 처리

| 에러 | 처리 |
|------|------|
| 네트워크 / 5xx | Cubit errorMessage / 토스트 |
| 401/403 | 기존 Dio 인터셉터 |
| 404 CT0005 | 상세 에러 UI |
| 400 C0001 | 토스트 |

---

## 8. 로컬 상태 & 캐싱

캐시 없음. 화면 진입·refresh·mutate 후 재조회.

---

## 9. 의존성 주입

`ContentProviders`에 List/Get/Delete UseCase 등록. dashboard Cubit은 `context.read`로 주입.

---

## 10. 테스트 계획

수동: 홈 3건, 관리 lazy load, 필터, refresh, 상세 첫 채널, PUT 반영, DELETE.
