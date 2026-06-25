# Project Instructions

이 프로젝트는 **클린 아키텍처**를 따른다.

기능은 `lib/features/{feature}/` 아래 `data` · `domain` · `presentation` 레이어로 구성한다.

정적 리소스는 루트 `assets/` (`img`, `icons`, `fonts`) 에 둔다.

인프라·상수·디자인 시스템·예외·서비스·매니저는 `lib/core/` 에 둔다.

공용 UI는 `lib/common/`, 전역 유틸은 `lib/utils/`, 라우팅은 `lib/router/app_router.dart` 를 사용한다.

---

## 반드시 준수할 사항

- 새로운 기능은 반드시 `lib/features/{feature}/` 아래 생성한다.
- 레이어 의존성은 `presentation → domain → data` 방향만 허용한다.
- domain 은 Flutter, Riverpod, Dio, SharedPreferences 등 프레임워크 및 외부 라이브러리에 의존하지 않는다.
- data 계층의 DTO, Model, Response 타입을 domain 또는 presentation 으로 노출하지 않는다.
- 공용 컴포넌트는 `common/`, 전역 유틸은 `utils/`, 인프라 코드는 `core/` 에 배치한다.
- 새로운 파일을 생성하거나 수정할 때는 아래 아키텍처 문서를 우선 참조한다.

---

## 아키텍처 문서

- [docs/architecture/overview.md](docs/architecture/overview.md)
  - 레이어 개요
  - 프로젝트 최상위 구조
  - 상태 관리 (Bloc / Cubit)
  - 개발 스크립트 (`create_feature.sh`, `add_feature_state.sh`, `build_runner.sh`)

- [docs/architecture/common-structure.md](docs/architecture/common-structure.md)
  - common
  - utils
  - core
  - router 구조

- [docs/architecture/feature-structure.md](docs/architecture/feature-structure.md)
  - feature 내부 구조
  - data / domain / presentation 규칙

- [docs/architecture/coding-conventions.md](docs/architecture/coding-conventions.md)
  - 네이밍 규칙
  - import 규칙
  - 코드 스타일

---

## 기능 구현 전 필수 문서 확인

새로운 기능을 구현하거나 기존 기능을 수정하기 전에 다음 순서로 문서를 확인한다.

1. `docs/adr/` — 관련 프로젝트 전역 기술 결정(ADR) 파악
2. `docs/specs/{feature}/prd.md` — 요구사항과 범위 파악
3. `docs/specs/{feature}/tdd.md` — 레이어별 설계 및 기능 범위 설계 결정 파악
4. `docs/specs/{feature}/tasks.md` — 구현 순서 파악 후 체크리스트 순서대로 구현

ADR은 프레임워크·라이브러리·아키텍처 패턴 등 **프로젝트 전역 결정**만 다룬다.
기능 범위의 설계 결정(Cubit vs Bloc 선택, 캐싱 전략 등)은 `tdd.md`의 "설계 결정" 섹션에 기록한다.

해당 기능의 `docs/specs/` 문서가 존재하면 반드시 읽은 뒤 구현을 시작한다.
문서가 없는 경우 `docs/templates/` 의 템플릿을 참고하여 작성을 요청한다.

문서 작성 워크플로우 전체는 [docs/templates/README.md](docs/templates/README.md) 를 참조한다.

---

아키텍처 문서와 현재 코드 구조가 충돌할 경우, 아키텍처 문서를 우선한다.