# Task List — 저장한 콘텐츠 소스

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/my-page-saved-content-sources` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-08-08 |
| 관련 TDD | [`tdd.md`](./tdd.md) |
| 관련 PRD | [`prd.md`](./prd.md) |

---

## 사전 확인

- [x] `docs/adr/` 확인
- [x] `prd.md` / `tdd.md` 작성
- [x] architecture 문서 준수

---

## Phase 1 — Hashtag Domain / Data

- [x] **1-1** Repository에 `listBookmarkedBundles` 추가
- [x] **1-2** `ListBookmarkedHashtagBundlesUseCase`
- [x] **1-3** Bookmarked list response model + toEntity (`bookmarked: true`)
- [x] **1-4** Datasource GET 구현
- [x] **1-5** RepositoryImpl + Providers 등록
- [x] **1-6** build_runner

## Phase 2 — Cubit

- [x] **2-1** `BookmarkedHashtagBundlesState` / `BookmarkedHashtagBundlesCubit`
- [x] **2-2** load + 낙관적 unbookmark

## Phase 3 — My Page UI

- [x] **3-1** `saved_content_sources_page.dart` (Tab + PageView)
- [x] **3-2** `saved_content_sources_components.dart` (건수, 리스트)
- [x] **3-3** 해시태그 연동·토스트
- [x] **3-4** 템플릿 빈 목록
- [x] **3-5** `my_page_page.dart` import

## Phase 4 — Cleanup

- [x] **4-1** analyze 확인

## Phase 5 — 템플릿 북마크 목록

- [x] **5-1** `BookmarkedTemplatesCubit` 연결 + 목업 제거
- [x] **5-2** 템플릿 리스트 로딩·에러·재시도 UI
- [x] **5-3** 낙관적 해제 + 토스트
- [x] **5-4** analyze 확인

---

## 완료 기준

- [x] FR-01~07, FR-09 Must 구현
- [x] FR-08 템플릿 북마크 목록·해제
- [x] 페이지가 `my_page` 피처 아래
- [x] DI 등록 완료
