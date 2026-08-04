# Task List — 이 스타일로 새로 만들기

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/new-style` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-08-05 |
| 관련 TDD | [`tdd.md`](./tdd.md) |
| 관련 PRD | [`prd.md`](./prd.md) |

---

## 사전 확인

- [x] `docs/adr/` 관련 ADR 확인
- [x] `prd.md` / `tdd.md` 읽기
- [x] architecture 문서 확인

---

## Phase 1 — Args · Cubit · UI

- [x] **1-1** `NewStyleArgs`
- [x] **1-2** `NewStyleState` (freezed) + Cubit
- [x] **1-3** `NewStyleReferenceSection` + truncate util
- [x] **1-4** `NewStyleChannelPage` / `NewStyleDetailPage` (스택 push, 생성 버튼 액션 없음)

## Phase 2 — 라우터 · 진입

- [x] **2-1** `app_router` `/new-style`, `/new-style/detail` 등록
- [x] **2-2** 상세 `onReuse` 모달 → push
- [x] **2-3** 생성 관리 `onReuseTap` 모달 → push
