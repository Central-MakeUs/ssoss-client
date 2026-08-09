# Task List — 추천 템플릿 목록·상세·적용·저장

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/template-catalog` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-08-08 |
| 관련 TDD | [`tdd.md`](./tdd.md) |
| 관련 PRD | [`prd.md`](./prd.md) |

---

## 사전 확인 (구현 시작 전 필수)

- [x] `docs/adr/` 목록 확인
- [x] `docs/specs/template/prd.md` 읽기 완료
- [x] `docs/specs/template/tdd.md` 읽기 완료
- [x] `docs/architecture/overview.md` 읽기 완료
- [x] `docs/architecture/feature-structure.md` 읽기 완료
- [x] `docs/architecture/coding-conventions.md` 읽기 완료

---

## Phase 0 — 피처 스캐폴딩

- [x] **0-1** 기존 `template` 피처 사용 (`create_feature.sh` 생략)
- [x] **0-2** `./script/add_feature_state.sh template catalog --cubit` 후 `TemplateCatalogCubit`으로 정리
- [x] **0-3** `TemplateDetailCubit`
- [x] **0-4** `TemplateApplyCubit`

---

## Phase 1 — Domain 레이어

- [x] **1-1** category / template / list / detail / applied / saved entity
- [x] **1-2** `TemplateRepository` 인터페이스
- [x] **1-3** List / Get / GetApplied / Save usecase

---

## Phase 2 — Data 레이어

- [x] **2-1** freezed 모델 + `toEntity()`
- [x] **2-2** `TemplateRemoteDatasource` / Impl
- [x] **2-3** `TemplateRepositoryImpl`
- [x] **2-4** `build_runner` 실행
- [x] **2-5** `TemplateProviders` + `SsossApp` 등록

---

## Phase 3 — Presentation

- [x] **3-1** `TemplateCatalogCubit` + 추천 소스 템플릿 탭
- [x] **3-2** `TemplateDetailCubit` + 상세·적용하기
- [x] **3-3** `TemplateApplyCubit` + 저장 + 클라 치환 제거
- [x] **3-4** `HomeRouteExtra` + 생성 관리 템플릿 탭 진입
- [x] **3-5** 라우터 extra 타입 갱신 (`templateId`, `TemplateApplyArgs`)

---

## Phase 4 — 통합 검증

- [x] **4-1** 목록·상세·적용·저장·완료 진입 코드 연동
- [x] **4-2** `dart analyze` 통과 (생성 파일 trailing comma info 제외)

---

## Phase 5 — 저장 내역 목록·상세

- [x] **5-1** SavedTemplateSort / ListItem / ListPage / Detail entity + repository + usecase
- [x] **5-2** list/detail 모델·datasource·repository impl + `build_runner` + providers
- [x] **5-3** `SavedTemplateManagementCubit` + 생성 관리 템플릿 탭 연동 (정렬·페이징·메뉴 UI)
- [x] **5-4** `SavedTemplateDetailCubit` + 상세 페이지 `savedTemplateId` 조회
- [x] **5-5** `dart analyze` 통과 (생성 파일 trailing comma info 제외)

---

## Phase 6 — 저장 내역 편집·삭제

- [x] **6-1** Edit / Rename / Delete usecase + request 모델 + datasource
- [x] **6-2** 목록 삭제 모달 로딩 + 제목 PUT + 2~20자 공용 다이얼로그
- [x] **6-3** `TemplateEditPage` 저장 템플릿 body PUT + ADR-005 로딩
- [x] **6-4** `dart analyze` 통과 (생성 파일 trailing comma info 제외)

---

## Phase 7 — 추천 템플릿 북마크

- [x] **7-1** `bookmarkTemplate` / `unbookmarkTemplate` / `listBookmarkedTemplates` repository + usecase
- [x] **7-2** Bookmarked list 모델 + datasource PUT/DELETE/GET + `build_runner` + providers
- [x] **7-3** `TemplateCatalogCubit.toggleBookmark` + 추천 소스 카드 연동
- [x] **7-4** `TemplateDetailCubit.toggleBookmark` + 상세 하단 버튼
- [x] **7-5** `BookmarkedTemplatesCubit` (마이페이지 저장 소스에서 사용)
- [x] **7-6** `dart analyze` 통과 (생성 파일 trailing comma info 제외)

---

## 완료 기준 (Definition of Done)

- [x] PRD Must FR-01~FR-10 구현 완료 (FR-09는 Phase 7에서 갱신)
- [x] PRD Must FR-11~FR-12 구현 완료
- [x] PRD Must FR-13~FR-14 구현 완료
- [x] PRD Must FR-09 북마크 PUT/DELETE 구현 완료
- [x] DI 등록 완료
- [x] analyze 에러 없음 (이번 변경 범위)
