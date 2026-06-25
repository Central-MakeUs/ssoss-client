# Task List — [기능 이름]

> **사용 방법**: `TODO:` 항목을 채운 뒤 이 안내 블록을 삭제한다.
> 이 문서는 구현 순서를 정의하는 체크리스트다.
> AI 에이전트는 이 문서의 태스크를 **순서대로** 수행하고, 완료 시 `- [x]` 로 체크한다.

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `TODO: feature/xxx` |
| 작성자 | `TODO: 이름` |
| 작성일 | `TODO: YYYY-MM-DD` |
| 관련 TDD | `TODO: tdd.md` |
| 관련 PRD | `TODO: prd.md` |

---

## 사전 확인 (구현 시작 전 필수)

> AI 에이전트는 아래 문서를 **반드시** 읽은 후 구현을 시작한다.

- [ ] `docs/adr/` 목록 확인 — 관련 프로젝트 전역 기술 결정 파악
- [ ] `docs/specs/TODO:feature/prd.md` 읽기 완료 — 요구사항·범위 파악
- [ ] `docs/specs/TODO:feature/tdd.md` 읽기 완료 — 레이어별 설계 및 설계 결정 파악
- [ ] `docs/architecture/overview.md` 읽기 완료 — 아키텍처 규칙 확인
- [ ] `docs/architecture/feature-structure.md` 읽기 완료 — 피처 구조 확인
- [ ] `docs/architecture/coding-conventions.md` 읽기 완료 — 코딩 컨벤션 확인

---

## Phase 0 — 피처 스캐폴딩

> 스크립트로 기본 구조를 생성한다.

- [ ] **0-1** `create_feature.sh` 로 피처 폴더 생성
  ```bash
  # TODO: 옵션 선택 (--cubit / --bloc / --all)
  ./script/create_feature.sh TODO:feature_name --TODO:option
  ```
- [ ] **0-2** 생성된 파일 목록 확인 및 불필요한 보일러플레이트 제거

---

## Phase 1 — Domain 레이어

> 외부 의존성 없이 순수 Dart 코드로만 작성한다.

### Entities

- [ ] **1-1** `domain/entities/TODO:entity.dart` 작성
  - `TODO: 필드 및 설명`

### Repository 인터페이스

- [ ] **1-2** `domain/repositories/TODO:repository.dart` 작성
  - `TODO: 메서드 목록`

### Use Cases

- [ ] **1-3** `domain/usecases/TODO:use_case.dart` 작성
  - 입력: `TODO:`
  - 출력: `Future<Either<Failure, TODO:>>`
- [ ] **1-4** _(필요 시)_ `domain/usecases/TODO:use_case_2.dart` 작성

---

## Phase 2 — Data 레이어

### Models

- [ ] **2-1** `data/models/TODO:model.dart` 작성 (`@freezed`, `@JsonSerializable`)
  - `TODO: Entity` 와 매핑되는 DTO
- [ ] **2-2** `build_runner.sh` 실행하여 `*.g.dart`, `*.freezed.dart` 생성
  ```bash
  ./script/build_runner.sh
  ```

### Data Sources

- [ ] **2-3** `data/datasources/TODO:datasource.dart` 인터페이스 작성
- [ ] **2-4** `data/datasources/TODO:datasource_impl.dart` 구현체 작성
  - API 엔드포인트: `TODO:`
  - 사용하는 Dio 클라이언트: `TODO:`

### Repository 구현체

- [ ] **2-5** `data/repositories/TODO:repository_impl.dart` 작성
  - 구현 인터페이스: `TODO:RepositoryName`
  - DataSource → Entity 변환 포함

---

## Phase 3 — Presentation 레이어

### 상태 관리 (Cubit / Bloc)

- [ ] **3-1** State 클래스 작성 (`@freezed`)
  - `TODO: 상태 케이스 목록 (initial / loading / success / failure)`
- [ ] **3-2** `build_runner.sh` 실행 (freezed 재생성)
- [ ] **3-3** `TODO:CubitName` / `TODO:BlocName` 작성
  - 사용 UseCase: `TODO:`

### Pages & Widgets

- [ ] **3-4** `presentation/pages/TODO:page.dart` 작성
  - BlocBuilder / BlocConsumer 로 상태 구독
- [ ] **3-5** `presentation/widgets/TODO:widget.dart` 작성 _(필요 시)_
- [ ] **3-6** _(추가 위젯이 있는 경우)_ `TODO:` 작성

---

## Phase 4 — 의존성 주입 & 라우팅

- [ ] **4-1** DI 등록 (`core/di/` 또는 피처 DI 파일)
  - Repository, UseCase, Cubit/Bloc 등록
- [ ] **4-2** `lib/router/app_router.dart` 에 라우트 등록
  - path: `TODO:`
  - 파라미터: `TODO:`

---

## Phase 5 — 통합 검증

- [ ] **5-1** 앱 실행 후 주요 사용자 흐름 수동 테스트
  - [ ] PRD의 사용자 스토리 FR-01 동작 확인
  - [ ] PRD의 사용자 스토리 FR-02 동작 확인
  - [ ] TODO: 추가 시나리오
- [ ] **5-2** 엣지 케이스 확인
  - [ ] 네트워크 오류 시 에러 상태 노출
  - [ ] 빈 목록 / 빈 상태 UI 표시
  - [ ] TODO: 추가 엣지 케이스
- [ ] **5-3** 린트 에러 없음 확인 (`flutter analyze`)
- [ ] **5-4** 빌드 에러 없음 확인

---

## Phase 6 — 테스트 작성 (선택)

> 팀 정책에 따라 수행한다.

- [ ] **6-1** UseCase Unit Test
- [ ] **6-2** Repository Unit Test (Mock DataSource)
- [ ] **6-3** Cubit / Bloc Unit Test (`bloc_test`)
- [ ] **6-4** Widget Test (주요 Page)

---

## 완료 기준 (Definition of Done)

> 아래 항목을 모두 충족해야 이 Task List가 완료된 것으로 간주한다.

- [ ] PRD의 모든 Must 요구사항(FR) 구현 완료
- [ ] `flutter analyze` 경고·에러 없음
- [ ] `build_runner` 생성 파일 최신 상태
- [ ] 라우팅 등록 완료
- [ ] DI 등록 완료
- [ ] 코드 리뷰 완료 (팀 정책에 따라)

---

## 메모 & 이슈

> 구현 중 발견한 문제, 결정 변경, 블로커를 기록한다.

| 날짜 | 내용 | 처리 상태 |
|------|------|---------|
| TODO: YYYY-MM-DD | TODO: 내용 | Open / Resolved |
