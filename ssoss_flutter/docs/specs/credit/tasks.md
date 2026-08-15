# Task List — 크레딧 잔액·내역

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/credit` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-08-02 |
| 관련 TDD | `tdd.md` |
| 관련 PRD | `prd.md` |

---

## 사전 확인

- [x] `docs/adr/` 목록 확인
- [x] `docs/specs/credit/prd.md` 읽기 완료
- [x] `docs/specs/credit/tdd.md` 읽기 완료
- [x] `docs/architecture/` 규칙 확인

---

## Phase 0 — 피처 스캐폴딩

- [x] **0-1** `./script/create_feature.sh credit --cubit`
- [x] **0-2** 불필요 보일러플레이트 정리

---

## Phase 1 — Domain

- [x] **1-1** entities: balance, ledger, ledger_page, filter, type
- [x] **1-2** `CreditRepository`
- [x] **1-3** `GetCreditBalanceUseCase`, `ListCreditLedgersUseCase`

---

## Phase 2 — Data

- [x] **2-1** freezed models + build_runner
- [x] **2-2** remote datasource + impl
- [x] **2-3** repository impl (`toEntity`)

---

## Phase 3 — Presentation

- [x] **3-1** `CreditBalanceCubit` + state, 앱 스코프 등록
- [x] **3-2** `CreditHistoryCubit` + state
- [x] **3-3** `CreditHistoryPage` + components (Figma)
- [x] **3-4** 마이페이지 balance/loading + 상세 보기 네비게이션
- [x] **3-5** 충전하기 버튼 주석 처리

---

## Phase 4 — DI

- [x] **4-1** `CreditProviders` → `SsossAppScope`

---

## Phase 5 — 검증

- [x] **5-1** analyzer 확인
