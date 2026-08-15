# TDD — 콘텐츠 생성 API 연동

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/content-generation-api` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-07-27 |
| 상태 | Approved |
| 관련 PRD | [`prd.md`](./prd.md) |

---

## 1. 기능 요약

기존 `lib/features/content/`를 확장해 `/v1/generations`(POST·GET 폴링), `/v1/contents`(POST 저장)를 연동한다. Demo datasource를 제거하고 `ContentGeneratingPage`에 Cubit을 연결한다. 채널별 글자 상한은 domain `ContentChannelLimits`로 관리한다.

**피처 경로**: `lib/features/content/`

---

## 2. 전체 데이터 흐름

```
ContentCreatePage / ContentOtherChannelCreatePage
    ↓ ContentGenerationArgs
ContentGeneratingPage + ContentGeneratingCubit
    ↓ RunGenerationUseCase
    ├─ StartGenerationUseCase → POST /v1/generations
    └─ PollGenerationUseCase   → GET /v1/generations/{id}
    ↓ SUCCEEDED
ContentResultPage (GenerationDetail → ContentResultDraft)
    ├─ ContentEditPage (해당 채널 로컬 draft만, ContentChannelLimits)
    └─ SaveContentUseCase → POST /v1/contents
         (generationId + 전 채널 각각 title?/body/hashtags 완전체)
ContentSaveCompletePage
```

PUT 채널 편집은 [`../edit/tdd.md`](../edit/tdd.md) / ContentDetailPage.
---

## 3. Domain

### 3.1 Entities / Enums

| 파일 | 설명 |
|------|------|
| `generation_status.dart` | `inProgress`, `succeeded`, `failed` |
| `generation_detail.dart` | generationId, status, purpose, tone, keywords, results |
| `generation_channel_result.dart` | channel, title?, body, hashtags |
| `saved_content.dart` | contentId, channels (contentChannelId, channel) |
| `content_channel_limits.dart` | 채널별 title/body max (PRD §4) |

```dart
class ContentChannelLimits {
  static int? titleMaxLength(UploadChannel channel);
  static int bodyMaxLength(UploadChannel channel);
  static void validateChannelResult(GenerationChannelResult result);
}
```

### 3.2 Repository

```dart
abstract class ContentRepository {
  Future<int> startGeneration(ContentCreateInput input);
  Future<GenerationDetail> getGeneration(int generationId);
  Future<SavedContent> saveContent({
    required int generationId,
    required List<GenerationChannelResult> channels,
  });
  void cancelGeneration();
}
```

기존 `createContent` / `cancelCreate` → 위 메서드로 **교체**.

### 3.3 Use Cases

| UseCase | 역할 |
|---------|------|
| `StartGenerationUseCase` | 입력 검증 + POST |
| `PollGenerationUseCase` | GET 폴링 (2.5s 간격, 65s 상한) |
| `RunGenerationUseCase` | start + poll |
| `SaveContentUseCase` | `ContentChannelLimits.validate` + POST |

---

## 4. Data

### 4.1 Models

| Model | API |
|-------|-----|
| `GenerationStartRequest` | channels, purpose, tone, **emphasis**, forbidden?, keywords, **photoGuideChecked** |
| `GenerationStartResponse` | generationId |
| `GenerationDetailModel` | GET response |
| `ContentSaveRequest` | generationId, **contents[]** (채널마다 title?/body/hashtags 완전체, title omit 규칙) |
| `ContentSaveResponseModel` | contentId, contents[] |

[`ContentCreateApiMapper`](../../../lib/features/content/data/mappers/content_create_api_mapper.dart) 재사용 + 역매핑.

### 4.2 Datasource

`ContentRemoteDatasourceImpl(Dio)` — Auth 패턴, `mapDioError`, `CancelToken`.

Paths: `/v1/generations`, `/v1/generations/{id}`, `/v1/contents`.

### 4.3 Photo-guide 파서

`utils/photo_guide_parser.dart` (또는 `data/mappers/`):

- 입력: API body 문자열
- 출력: displayBody (태그 제거), `List<PhotoGuideSegment>` (title, description, index)
- 패턴: `<photo-guide title="..." description="..."/>`

---

## 5. Presentation

### 5.1 ContentGeneratingCubit / State

```dart
loading() | success(GenerationDetail detail) | failure(String? message)
```

- `start(input)`: RunGenerationUseCase
- `cancel()`: cancelGeneration
- FAILED status → failure()

### 5.2 ContentGeneratingPage

- BlocProvider + BlocListener
- success → `ContentResultPage` (extra: args + detail)
- failure → `ContentGenerationFailureView`
- 나가기 모달 + cancel

### 5.3 ContentGenerationFailureView

Figma 1543:8009 — 닫기(홈), 다시 시도하기, 크레딧 안내.

### 5.4 ContentResultPage

- `ContentResultDraft.fromGenerationDetail(detail)`
- 편집: **해당 채널** draft만 갱신 (필드 일부만 서버로 보내지 않음)
- `_save()` → `toGenerationChannelResults()` → SaveContentUseCase
  - POST `contents[]`는 **작업의 전 채널**을 포함
  - 각 원소는 채널 단위 완전체 (title?/body/hashtags)
  - 블로그만 title 전송, 빈/공백·비블로그 title은 omit
- generationId state 보관

### 5.5 ContentEditCubit

- `maxLength` → `ContentChannelLimits`
- `canSubmit` → dirty && 길이 ≤ 상한

---

## 6. API 명세

| 메서드 | 엔드포인트 | 설명 |
|--------|-----------|------|
| POST | `/v1/generations` | 생성 작업 시작 → generationId |
| GET | `/v1/generations/{generationId}` | 상태·결과 조회 |
| POST | `/v1/contents` | generationId + **전 채널** 채널 단위 완전체 저장 |

`PUT /v1/contents/{contentId}/channels/{contentChannelId}` — [`../edit/tdd.md`](../edit/tdd.md) 로 이동.

---

## 7. 에러 처리

| 상황 | 처리 |
|------|------|
| status FAILED | 실패 화면 |
| CR0002, CT0001 등 | toast 또는 실패 화면 (message) |
| CancelledException | UI 전이 없음 |
| ValidationException (상한 초과) | toast |

---

## 8. DI

```dart
ProxyProvider<Dio, ContentRemoteDatasource>(
  update: (_, dio, __) => ContentRemoteDatasourceImpl(dio),
),
// RunGenerationUseCase, SaveContentUseCase
```

---

## 9. 설계 결정

| 결정 | 선택 | 근거 |
|------|------|------|
| 구 createContent | generations 2-step | 서버 비동기 생성 모델 |
| POST contents | 채널 단위 완전체 × 전 채널 | CT0010 방지 + 화면 값 그대로 |
| PUT 편집 | [`../edit/`](../edit/) | ContentDetailPage 수정하기 |
| 글자 상한 | domain ContentChannelLimits | create/edit/save 공유 |
| 폴링 | 2.5s, 65s cap | 서버 60s + 여유 |

---

## 10. 관련 문서

- [`../create/tdd.md`](../create/tdd.md) — UI 위저드 (구 API §6 deprecated)
- [`../edit/tdd.md`](../edit/tdd.md) — 로컬 편집, §5.6 상한 동기화
