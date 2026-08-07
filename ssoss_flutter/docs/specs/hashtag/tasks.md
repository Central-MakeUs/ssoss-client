# Task List — 해시태그 묶음 카탈로그·북마크

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/hashtag-catalog` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-08-06 |
| 관련 TDD | [`tdd.md`](./tdd.md) |
| 관련 PRD | [`prd.md`](./prd.md) |

---

## 사전 확인 (구현 시작 전 필수)

- [x] `docs/adr/` 목록 확인
- [x] `docs/specs/hashtag/prd.md` 읽기 완료
- [x] `docs/specs/hashtag/tdd.md` 읽기 완료
- [x] `docs/architecture/overview.md` 읽기 완료
- [x] `docs/architecture/feature-structure.md` 읽기 완료
- [x] `docs/architecture/coding-conventions.md` 읽기 완료

---

## Phase 0 — 피처 스캐폴딩

- [x] **0-1** `./script/create_feature.sh hashtag --cubit`
- [x] **0-2** 불필요한 보일러플레이트 정리

---

## Phase 1 — Domain 레이어

- [x] **1-1** `HashtagBundle`, `HashtagBundleListPage` entity
- [x] **1-2** `HashtagRepository` 인터페이스
- [x] **1-3** `ListHashtagBundlesUseCase`
- [x] **1-4** `BookmarkHashtagBundleUseCase` / `UnbookmarkHashtagBundleUseCase`

---

## Phase 2 — Data 레이어

- [x] **2-1** freezed 모델 + `toEntity()`
- [x] **2-2** `build_runner` 실행
- [x] **2-3** `HashtagRemoteDatasource` / Impl
- [x] **2-4** `HashtagRepositoryImpl`

---

## Phase 3 — Presentation

- [x] **3-1** `HashtagCatalogState` / `HashtagCatalogCubit`
- [x] **3-2** `HashtagProviders` + app MultiProvider 등록
- [x] **3-3** 추천 화면 해시태그 탭 연동 (목록·검색·lazy load)
- [x] **3-4** 북마크 토글 연동

---

## Phase 4 — 통합 검증

- [x] **4-1** 목록·검색·페이지네이션·북마크 코드 연동
- [x] **4-2** `dart analyze` 통과 (생성 파일 trailing comma info 제외)

---

## 완료 기준 (Definition of Done)

- [x] PRD Must FR 구현 완료
- [x] DI 등록 완료
- [x] analyze 에러 없음 (이번 변경 범위)
