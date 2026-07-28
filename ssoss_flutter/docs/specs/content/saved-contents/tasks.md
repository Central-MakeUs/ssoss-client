# Task List — 저장 콘텐츠 목록·상세·삭제

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/content-saved-contents` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-07-29 |
| 관련 TDD | [`tdd.md`](./tdd.md) |
| 관련 PRD | [`prd.md`](./prd.md) |

---

## 사전 확인

- [x] `docs/adr/` 확인
- [x] `prd.md` / `tdd.md` 작성
- [x] architecture 문서 준수

---

## Phase 1 — Domain

- [x] **1-1** `ContentListItem`, `ContentListPage`, `ContentDetail` entity
- [x] **1-2** `ContentRepository`에 list/get/delete 추가
- [x] **1-3** `ListContentsUseCase`, `GetContentUseCase`, `DeleteContentUseCase`

## Phase 2 — Data

- [x] **2-1** list/detail response models + toEntity
- [x] **2-2** RemoteDatasource + Impl GET/DELETE
- [x] **2-3** RepositoryImpl 구현
- [x] **2-4** build_runner
- [x] **2-5** ContentProviders 등록

## Phase 3 — Home

- [x] **3-1** `ContentRecentCubit` / state
- [x] **3-2** `ContentPage` 연동, size=3, 빈 상태, 상세 진입

## Phase 4 — Generation management

- [x] **4-1** Cubit: pagination, filter, refresh, delete
- [x] **4-2** Page: sticky header, RefreshIndicator, lazy load indicator
- [x] **4-3** `ContentManagementItem` 저장 단위로 변경
- [x] **4-4** stub API 제거

## Phase 5 — Detail + edit sync

- [x] **5-1** `ContentDetailCubit` GET by id
- [x] **5-2** 다중 채널 Tab+PageView (index 0)
- [x] **5-3** PUT 후 로컬 갱신 + pop(didMutate) → 목록 refresh

## Phase 6 — Cleanup

- [x] **6-1** 더미 기본 경로 제거
- [x] **6-2** analyze / build_runner 확인

---

## 완료 기준

- [x] FR-01~08 Must 구현
- [x] DI 등록 완료
- [x] 더미가 홈/관리/상세 기본 경로에 쓰이지 않음
