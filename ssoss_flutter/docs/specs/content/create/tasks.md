# Task List — AI 콘텐츠 생성

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/content-create` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-07-15 |
| 관련 TDD | [`tdd.md`](./tdd.md) |
| 관련 PRD | [`prd.md`](./prd.md) |

> **구현 우선순위 요약**
> - 기존 `lib/features/content/` 를 확장한다. (스캐폴딩 재생성 불필요)
> - UI·위저드·생성 중 화면을 먼저 완성하고, 백엔드 미확정 시 Datasource는 **스텁/지연 응답**으로 흐름을 검증한다.
> - 결과 화면·GIF 로딩 에셋은 Out of Scope (PRD).

---

## 사전 확인 (구현 시작 전 필수)

> AI 에이전트는 아래 문서를 **반드시** 읽은 후 구현을 시작한다.

- [x] `docs/adr/` 목록 확인 — 관련 프로젝트 전역 기술 결정 파악
- [x] `docs/specs/content/create/prd.md` 읽기 완료 — 요구사항·범위 파악
- [x] `docs/specs/content/create/tdd.md` 읽기 완료 — 레이어별 설계 및 설계 결정 파악
- [x] `docs/architecture/overview.md` 읽기 완료 — 아키텍처 규칙 확인
- [x] `docs/architecture/feature-structure.md` 읽기 완료 — 피처 구조 확인
- [x] `docs/architecture/coding-conventions.md` 읽기 완료 — 코딩 컨벤션 확인

---

## Phase 0 — 피처 정리 & 선행 작업

> `content` 피처는 이미 존재한다. create 플로우용 파일을 추가하고 스텁을 정리한다.

- [x] **0-1** 기존 구조 확인
  - `lib/features/content/` data·domain·presentation 폴더
  - `ContentChannel` (`content_channel_shortcuts.dart`) → domain `UploadChannel` 이전 대상 확인
- [x] **0-2** `core/exception/app_exception.dart` 에 예외 추가
  - `ValidationException`
  - `CancelledException`
- [x] **0-3** (선택) 스텁 정리 계획 확정
  - 기존 `content_datasource.dart` / `ContentRepository` TODO 를 create API 방향으로 확장

---

## Phase 1 — Domain 레이어

> 외부 의존성 없이 순수 Dart 코드로만 작성한다.

### Entities / Enums

- [x] **1-1** `domain/entities/upload_channel.dart` — `blog` / `thread` / `carrot` / `instagram`
- [x] **1-2** `domain/entities/upload_purpose.dart` — `informative` / `eventDiscount` / `newMenuPromo`
- [x] **1-3** `domain/entities/content_tone.dart` — `daily` / `emotional` / `informational` / `promotional`
- [x] **1-4** `domain/entities/content_create_input.dart` — channel, purpose, tone, highlight, forbidden?, keywords, photoGuideEnabled
- [x] **1-5** `domain/entities/create_content_result.dart` — `contentId`

### Repository 인터페이스

- [x] **1-6** `domain/repositories/content_repository.dart` 갱신
  - `Future<CreateContentResult> createContent(ContentCreateInput input)`
  - `void cancelCreate()`

### Use Cases

- [x] **1-7** `domain/usecases/create_content_usecase.dart`
  - 입력: `ContentCreateInput`
  - 출력: `Future<CreateContentResult>`
  - highlight trim 검증 실패 시 `ValidationException`

---

## Phase 2 — Data 레이어

### Mapper & Models

- [x] **2-1** `data/mappers/content_create_api_mapper.dart` — enum → API 문자열
- [x] **2-2** `data/models/create_content_request.dart` (`@freezed`, `@JsonSerializable`) + `fromEntity`
- [x] **2-3** `data/models/create_content_result_model.dart` (`@freezed`, `@JsonSerializable`) + `toEntity()`
- [x] **2-4** `build_runner.sh` 실행하여 `*.g.dart`, `*.freezed.dart` 생성
  ```bash
  ./script/build_runner.sh
  ```

### Data Sources

- [x] **2-5** `data/datasources/content_remote_datasource.dart` 인터페이스
  - `createContent(CreateContentRequest, {CancelToken?})`
- [x] **2-6** `data/datasources/content_remote_datasource_impl.dart` (또는 데모 스텁)
  - 실연동: `POST /api/v1/contents` (인증 Dio)
  - 백엔드 미확정 시: 지연 후 더미 `contentId` 반환하는 스텁 허용
- [x] **2-7** 기존 `content_datasource.dart` 스텁을 remote 구조로 정리·대체

### Repository 구현체

- [x] **2-8** `data/repositories/content_repository_impl.dart`
  - `createContent`: Request 변환 → Remote 호출 → `toEntity()`
  - `cancelCreate`: `CancelToken` 취소
  - `DioException` → `NetworkException` / `ServerException` / `CancelledException` 매핑

---

## Phase 3 — Presentation 레이어 (상태)

### Cubit & State

- [x] **3-1** `presentation/cubit/content_create_state.dart` (`@freezed`)
  - `step`: channel / content / detail
  - `phase`: editing / generating
  - form 필드 + `canGoNextFromChannel` / `canGoNextFromContent` / `canSubmit`
- [x] **3-2** `build_runner.sh` 실행 (freezed 재생성)
- [x] **3-3** `presentation/cubit/content_create_cubit.dart`
  - 선택·스텝·키워드·토글·`createContent`·`exitGenerating`
  - 키워드: trim, `#` 제거, 공백 거부, 중복 무시
  - 사용: `CreateContentUseCase`, `ContentRepository.cancelCreate`

---

## Phase 4 — Presentation 레이어 (UI)

### Widgets

- [x] **4-1** `presentation/widgets/content_create_progress_bar.dart` — 01 채널 / 02 콘텐츠 / 03 세부
- [x] **4-2** `presentation/widgets/content_create_step_channel.dart` — 업로드 채널 단일 선택
- [x] **4-3** `presentation/widgets/content_create_step_content.dart` — 목적·톤 선택 (톤 보조 문구 포함)
- [x] **4-4** `presentation/widgets/content_create_step_detail.dart` — 강조/금지/키워드/사진 가이드
- [x] **4-5** `presentation/widgets/content_keyword_chip.dart` — `#키워드` + X 삭제
- [x] **4-6** `presentation/widgets/content_generating_view.dart`
  - 로딩 **플레이스홀더 Container** (GIF 자리)
  - 카피: `콘텐츠 발행 중이에요` + 크레딧 안내
  - 하단 CTA **없음**

### Page

- [x] **4-7** `presentation/pages/content_create_page.dart`
  - `BlocProvider<ContentCreateCubit>` + `BlocConsumer`
  - editing: 앱바 back + 타이틀 + progress + step + 하단 CTA (활성/비활성)
  - generating: 앱바 back 제거 + 우측 `나가기` + generating view
  - `PopScope`: generating 중 → 나가기와 동일(홈). editing → `goBack`/pop
  - failure → 스낵바 + detail 스텝 유지

### 채널 enum 마이그레이션

- [x] **4-8** `content_channel_shortcuts.dart` 의 `ContentChannel` 제거 → `UploadChannel` 사용
- [x] **4-9** 채널 바로가기 탭 시 `/content/create` 로 `extra: UploadChannel` 전달

---

## Phase 5 — 의존성 주입 & 라우팅

- [x] **5-1** `presentation/content_providers.dart` — `ContentProviders.build()`
  - `ContentRemoteDatasource`, `ContentRepository`, `CreateContentUseCase`
- [x] **5-2** `SsossAppScope` `MultiProvider` 에 `ContentProviders.build()` 추가
- [x] **5-3** `lib/router/app_router.dart` 에 라우트 등록
  - path: `/content/create` (`ContentCreatePage.routePath`)
  - `extra`: `UploadChannel?`
- [x] **5-4** 나가기: `context.go(HomePage.routePath)` (`/home`)

---

## Phase 6 — 통합 검증

- [x] **6-1** 주요 사용자 흐름 수동 테스트
  - [x] FR-01~02: 3단계 + 진행 바
  - [x] FR-03: 1단계 채널 미선택 시 `다음` 비활성
  - [x] FR-04: 2단계 목적·톤 미선택 시 `다음` 비활성
  - [x] FR-05~06: 강조 내용만으로 `콘텐츠 생성하기` 활성
  - [x] FR-08~10: 키워드 추가(`#` 칩)·X 삭제·공백 거부
  - [x] FR-11: 사진 첨부 가이드 토글
  - [x] FR-12~13: 생성 요청 및 enum 매핑 포함 payload
  - [x] FR-14~18: 생성 중 UI (back 없음, 나가기→홈, 플레이스홀더, 하단 버튼 없음)
  - [x] FR-19: 1~3단계 앱바 back
- [x] **6-2** 엣지 케이스
  - [x] 네트워크/서버 오류 시 스낵바 + 3단계 복귀
  - [x] 생성 중 나가기 시 요청 취소 + 홈 이동
  - [x] Android 시스템 back (generating) = 나가기와 동일
  - [x] 중복 키워드 무시
- [x] **6-3** `flutter analyze` 경고·에러 없음
- [x] **6-4** 빌드 에러 없음

---

## Phase 7 — 백엔드 연동 (후순위)

> API 스펙 확정 시 `tdd.md` 6장을 갱신한 뒤 진행한다.

- [ ] **7-1** 실 `ContentRemoteDatasourceImpl` 로 스텁 교체 (`POST /api/v1/contents`)
- [ ] **7-2** `ContentCreateApiMapper` 문자열을 서버 확정값에 맞게 조정
- [ ] **7-3** 인증 헤더·에러 코드 매핑 검증
- [ ] **7-4** FR-12·FR-13 실서버 검증

---

## Phase 8 — 테스트 작성 (선택)

- [ ] **8-1** `CreateContentUseCase` Unit Test
- [ ] **8-2** `ContentCreateApiMapper` Unit Test
- [ ] **8-3** `ContentRepositoryImpl` Unit Test (Mock Datasource + cancel)
- [ ] **8-4** `ContentCreateCubit` Unit Test (`bloc_test`) — CTA 조건·키워드·생성 전이
- [ ] **8-5** `ContentCreatePage` Widget Test — 비활성 버튼·generating 앱바

---

## 완료 기준 (Definition of Done)

> 백엔드 미연동 단계의 완료 기준이다. 실 API는 Phase 7.

- [x] PRD Must FR 구현: **FR-01 ~ FR-19** (결과 화면 FR-20 Should / Out of Scope 제외)
- [x] GIF 로딩은 플레이스홀더 Container 로 대체 (FR-16)
- [x] `flutter analyze` 경고·에러 없음
- [x] `build_runner` 생성 파일 최신 상태
- [x] 라우팅(`/content/create`) 등록 완료
- [x] DI(`ContentProviders`) 등록 완료
- [x] `ContentChannel` → `UploadChannel` 마이그레이션 완료
- [ ] 코드 리뷰 완료 (팀 정책에 따라)

---

## 메모 & 이슈

| 날짜 | 내용 | 처리 상태 |
|------|------|---------|
| 2026-07-15 | 1단계 hi-fi [397:5254](https://www.figma.com/design/I1DrEdPSi6LA8Skaz8flsS/CMC?node-id=397-5254&m=dev) 반영 — 진행 바 `01 채널 선택` | Resolved |
| 2026-07-15 | 생성 완료 결과 화면은 Out of Scope. 성공 시 `contentId` State 보관만 | Open |
| 2026-07-15 | 백엔드 엔드포인트·enum 문자열은 서버 스펙 확정 후 Phase 7 에서 조정 | Open |
