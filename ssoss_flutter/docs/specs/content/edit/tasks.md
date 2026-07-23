# Task List — 콘텐츠 편집

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/content-edit` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-07-23 |
| 관련 TDD | [`tdd.md`](./tdd.md) |
| 관련 PRD | [`prd.md`](./prd.md) |

---

## 사전 확인 (구현 시작 전 필수)

- [x] `docs/adr/` 목록 확인
- [x] `docs/specs/content/edit/prd.md` 읽기 완료
- [x] `docs/specs/content/edit/tdd.md` 읽기 완료
- [x] 아키텍처 문서 숙지

---

## Phase 0 — Domain / Data

- [x] **0-1** 신규 Domain/Data 없음 (로컬 편집만)

---

## Phase 1 — Models & Cubit

- [x] **1-1** `ContentEditTarget`, `ContentEditArgs`, `ContentEditResult`, draft 모델
- [x] **1-2** `ContentEditState` + `ContentEditCubit`
- [x] **1-3** freezed 생성 (`build_runner`)

---

## Phase 2 — Edit UI

- [x] **2-1** `ContentEditPage` + bottom bar
- [x] **2-2** 해시태그 에디터 (10개/30자)
- [x] **2-3** 라우트 등록

---

## Phase 3 — Result 연결

- [x] **3-1** Result draft state
- [x] **3-2** 섹션 `onEdit` → push/pop 반영

---

## Phase 4 — 키워드 제한 통일

- [x] **4-1** 생성 플로우 키워드 30자 제한 + 해시태그 에디터 재사용

---

## 완료 기준

- [x] FR Must 구현
- [x] `flutter analyze` 통과 (신규 코드)
- [x] 라우트 등록

---

## 메모 & 이슈

| 날짜 | 내용 | 처리 상태 |
|------|------|---------|
| 2026-07-23 | API 미연동, pop result로 draft 반영 | Resolved |
