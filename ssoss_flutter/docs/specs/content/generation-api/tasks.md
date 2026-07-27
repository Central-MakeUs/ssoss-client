# Task List — 콘텐츠 생성 API 연동

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/content-generation-api` |
| 작성일 | 2026-07-27 |
| 관련 TDD | [`tdd.md`](./tdd.md) |
| 관련 PRD | [`prd.md`](./prd.md) |

---

## 사전 확인

- [x] `docs/specs/content/generation-api/prd.md` 읽기
- [x] `docs/specs/content/generation-api/tdd.md` 읽기
- [x] 아키텍처 문서 숙지

---

## Phase 0 — 스펙

- [x] **0-1** `generation-api/prd.md`, `tdd.md`, `tasks.md` 작성
- [ ] **0-2** [`../edit/tdd.md`](../edit/tdd.md) §5.6 상한 표 동기화
- [ ] **0-3** [`../create/tasks.md`](../create/tasks.md) Phase 7 cross-link

---

## Phase 1 — Domain

- [ ] **1-1** `content_channel_limits.dart`
- [ ] **1-2** `generation_status.dart`, `generation_detail.dart`, `generation_channel_result.dart`, `saved_content.dart`
- [ ] **1-3** `ContentRepository` 확장 (startGeneration, getGeneration, saveContent, cancelGeneration)
- [ ] **1-4** UseCases: StartGeneration, PollGeneration, RunGeneration, SaveContent

---

## Phase 2 — Data

- [ ] **2-1** Generation/Save models + build_runner
- [ ] **2-2** `ContentRemoteDatasourceImpl`
- [ ] **2-3** `photo_guide_parser.dart`
- [ ] **2-4** `ContentRepositoryImpl` 갱신

---

## Phase 3 — Generating UI

- [ ] **3-1** `ContentGeneratingState` / Cubit 개편
- [ ] **3-2** `ContentGenerationFailureView`
- [ ] **3-3** `ContentGeneratingPage` Cubit 연동

---

## Phase 4 — Result & Save & Limits

- [ ] **4-1** `ContentResultDraft.fromGenerationDetail`, `toSaveChannels`
- [ ] **4-2** `ContentResultPage` API draft + save
- [ ] **4-3** `ContentEditCubit` → ContentChannelLimits
- [ ] **4-4** `ContentGenerationArgs` 확장

---

## Phase 5 — DI & 검증

- [ ] **5-1** `ContentProviders` — Dio impl + UseCases
- [ ] **5-2** `flutter analyze` + build_runner
- [ ] **5-3** 수동 플로우 검증 (생성·실패·저장·상한)

---

## 완료 기준

- [ ] POST/GET generations 실연동
- [ ] 실패 화면 (닫기/재시도)
- [ ] POST contents 저장 (수정본)
- [ ] 채널별 글자 상한 검증
- [x] PUT 편집 API — [`../edit/`](../edit/) 에서 구현
