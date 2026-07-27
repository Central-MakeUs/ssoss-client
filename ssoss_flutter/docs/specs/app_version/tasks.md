# Task List — 앱 버전 강제 업데이트

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/app-version` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-07-28 |
| 관련 TDD | `tdd.md` |
| 관련 PRD | `prd.md` |

---

## 사전 확인 (구현 시작 전 필수)

- [x] `docs/adr/` 목록 확인
- [x] `docs/specs/app_version/prd.md` 읽기 완료
- [x] `docs/specs/app_version/tdd.md` 읽기 완료
- [x] `docs/architecture/` 규칙 확인

---

## Phase 0 — 피처 스캐폴딩

- [x] **0-1** `./script/create_feature.sh app_version --cubit`
- [x] **0-2** 불필요한 page 보일러플레이트 정리

---

## Phase 1 — Domain 레이어

- [x] **1-1** `domain/entities/app_version_check.dart`
- [x] **1-2** `domain/repositories/app_version_repository.dart`
- [x] **1-3** `domain/usecases/check_app_version_usecase.dart`

---

## Phase 2 — Data 레이어

- [x] **2-1** `data/models/app_version_response_model.dart` + build_runner
- [x] **2-2** `data/datasources/app_info_datasource.dart`
- [x] **2-3** `data/datasources/app_version_remote_datasource.dart`
- [x] **2-4** `data/repositories/app_version_repository_impl.dart`

---

## Phase 3 — Presentation 레이어

- [x] **3-1** `AppVersionCubit` + state (`checking` / `updateRequired` / `allowed`)
- [x] **3-2** `AppVersionProviders`
- [x] **3-3** `SsossModal`에 `showCloseButton` 추가
- [x] **3-4** `AppUrls` 스토어 URL 추가
- [x] **3-5** `SsossAppScope` / `SsossApp` 부트스트랩 연동

---

## Phase 4 — 검증

- [x] **4-1** analyzer / lint 확인
