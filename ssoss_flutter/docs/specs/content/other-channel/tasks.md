# Task List — 다른 채널용 콘텐츠 생성

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/content-other-channel` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-07-18 |
| 관련 TDD | [`tdd.md`](./tdd.md) |
| 관련 PRD | [`prd.md`](./prd.md) |

---

## Phase 1 — 모델·공통 카드

- [x] **1-1** `ContentCreateFlow` / `ContentSaveCompleteArgs` / `ContentGenerationArgs`
- [x] **1-2** `SsossContentsCard` blocks 전용 + 호출부 마이그레이션

## Phase 2 — 다른 채널 선택

- [x] **2-1** Cubit + OtherChannelCreatePage + 뒤로가기 홈 모달
- [x] **2-2** 라우터 등록

## Phase 3 — 플로우 연결

- [x] **3-1** SaveComplete continue CTA → other-channel
- [x] **3-2** Generating/Result otherChannel 모드 + remake → generating
- [x] **3-3** Result save → finalSave / continueAvailable + previousInput
