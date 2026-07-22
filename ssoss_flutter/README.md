# 쏘쓰

카페/베이커리 사장님을 위한 네이버 플레이스 진단 기반 콘텐츠 운영 서비스, 쏘쓰 Flutter 모바일 앱 프로젝트입니다.

---

## 프로젝트 구조

이 프로젝트는 **클린 아키텍처**를 따릅니다. 의존성은 바깥쪽(presentation)에서 안쪽(domain)으로만 향합니다.

```
ssoss_flutter/
├── assets/                   # 정적 리소스 (img, icons, fonts)
├── env/                      # 환경 변수
│   └── .env.example          # env 파일 템플릿
├── script/                   # 피처·코드 생성 스크립트
├── docs/                     # 아키텍처 가이드, ADR, 기능별 스펙
└── lib/
    ├── main.dart             # 앱 진입점
    ├── ssoss_app.dart        # 루트 위젯, 전역 Provider/Bloc 설정
    ├── router/
    │   └── app_router.dart   # go_router 기반 라우팅
    ├── core/                 # 인프라, 상수, 테마, exception, service, manager
    ├── common/               # 피처 간 공용 UI 컴포넌트
    ├── utils/                # 앱 전역 유틸리티
    └── features/             # 기능 단위 모듈
        └── {feature_name}/
            ├── data/         # datasources, models, repositories(구현체)
            ├── domain/       # entities, repositories(인터페이스), usecases
            └── presentation/ # pages, widgets, bloc, cubit
```

### 레이어 역할

| 레이어 | 역할 | 주요 구성 요소 |
|--------|------|----------------|
| **presentation** | UI, 사용자 상호작용, 상태 표현 | `pages`, `widgets`, `bloc`, `cubit` |
| **domain** | 비즈니스 규칙, 앱 핵심 로직 | `entities`, `repositories`, `usecases` |
| **data** | 외부 데이터 소스 접근, domain 계약 구현 | `datasources`, `models`, `repositories` |

### 준수 사항

- 새 기능은 반드시 `lib/features/{feature}/` 아래 생성합니다.
- 레이어 의존성은 `presentation → domain → data` 방향만 허용합니다.
- `domain`은 Flutter, Riverpod, Dio 등 프레임워크·외부 라이브러리에 의존하지 않습니다.
- `data` 계층의 DTO, Model, Response 타입을 `domain` 또는 `presentation`에 노출하지 않습니다.
- 공용 컴포넌트는 `common/`, 전역 유틸은 `utils/`, 인프라 코드는 `core/`에 둡니다.
- 피처 간 직접 참조는 금지하며, 공유가 필요하면 `common` 또는 `core`로 승격합니다.

상세 구조는 [아키텍처 문서](docs/architecture/overview.md)를 참고하세요.

---

## 커밋 컨벤션

[Conventional Commits](https://www.conventionalcommits.org/) 형식을 따릅니다.

```
<type>(<scope>): <subject>

[optional body]
```

### type

| type | 용도 |
|------|------|
| `feat` | 새 기능 추가 |
| `fix` | 버그 수정 |
| `refactor` | 동작 변경 없는 코드 구조 개선 |
| `docs` | 문서만 변경 |
| `chore` | 빌드, 설정, 의존성 등 기타 작업 |
| `test` | 테스트 추가·수정 |
| `style` | 포맷팅, 세미콜론 등 의미 없는 스타일 변경 |

### scope (선택)

변경 범위를 짧게 표기합니다. 피처 이름(`auth`, `settings`)이나 `core`, `router`, `docs` 등을 사용합니다.

### subject

- 한국어로만 작성합니다.
- 명령형, 현재형으로 씁니다. (`추가`, `수정`)
- 마침표를 붙이지 않습니다.
- **무엇을** 바꿨는지보다 **왜** 바꿨는지 드러나게 씁니다.

### 예시

```
feat(auth): 소셜 로그인 화면 추가
fix(settings): 다크 모드 토글 상태가 앱 재시작 후 유지되지 않는 문제 수정
docs(specs): auth 기능 PRD 초안 작성
refactor(core): Dio 팩토리 네트워크 설정 분리
chore: flutter_bloc 버전 업데이트
```

### 브랜치

기능 단위 작업은 `feat/{feature-name}`, 버그 수정은 `fix/{issue-description}` 형태의 브랜치에서 진행합니다.

---

## 작업 방법

### 1. 문서 확인 (구현 전 필수)

새 기능을 구현하거나 기존 기능을 수정하기 전에 아래 순서로 문서를 확인합니다.

| 순서 | 문서 | 목적 |
|------|------|------|
| 1 | `docs/adr/` | 프로젝트 전역 기술 결정(ADR) 파악 |
| 2 | `docs/specs/{feature}/prd.md` | 요구사항과 범위 파악 |
| 3 | `docs/specs/{feature}/tdd.md` | 레이어별 설계 및 기능 범위 설계 결정 파악 |
| 4 | `docs/specs/{feature}/tasks.md` | 구현 순서 파악 후 체크리스트 순서대로 구현 |

- ADR은 프레임워크·라이브러리·아키텍처 패턴 등 **프로젝트 전역 결정**만 다룹니다.
- 기능 범위 설계 결정(Cubit vs Bloc, 캐싱 전략 등)은 `tdd.md`의 "설계 결정" 섹션에 기록합니다.
- 해당 기능의 `docs/specs/` 문서가 없으면 [`docs/templates/`](docs/templates/README.md) 템플릿을 참고해 먼저 작성합니다.
- 아키텍처 문서와 코드가 충돌하면 **아키텍처 문서를 우선**합니다.

### 2. 개발 환경

이 프로젝트는 **FVM**으로 Flutter SDK 버전을 관리합니다. 전역 `flutter`/`dart` 명령 대신 `fvm flutter / fvm dart` 명령을 사용합니다.

```bash
# 의존성 설치
fvm flutter pub get
```

### 3. Flavor (환경)

앱은 **dev**, **staging**, **prod** 세 가지 Flavor로 빌드·실행합니다. Flavor마다 앱 이름과 패키지(번들) ID가 달라집니다.

| Flavor | 앱 이름 | 패키지 / 번들 ID |
|--------|---------|------------------|
| `dev` | 쏘쓰(dev) | `com.place.ssoss.dev` |
| `staging` | 쏘쓰(staging) | `com.place.ssoss.staging` |
| `prod` | 쏘쓰 | `com.place.ssoss` |

#### 실행

```bash
# Android / iOS 공통
fvm flutter run --flavor dev
fvm flutter run --flavor staging
fvm flutter run --flavor prod
```

iOS는 Xcode Scheme(`dev`, `staging`, `prod`)과 Flavor 이름이 일치합니다. IDE에서 실행할 때도 동일한 Scheme을 선택합니다.

#### 빌드

```bash
fvm flutter build apk --flavor prod
fvm flutter build appbundle --flavor prod
fvm flutter build ios --flavor prod
```

#### 동작 방식

- **Android**: `productFlavors`로 `applicationIdSuffix`와 앱 이름을 Flavor별로 설정합니다. (`android/app/build.gradle.kts`)
- **iOS**: Flavor별 `.xcconfig`와 Xcode Scheme으로 번들 ID와 앱 이름을 설정합니다. (`ios/Flutter/`, `ios/Runner.xcodeproj/xcshareddata/xcschemes/`)
- **런타임**: `FlavorReader`가 `package_info_plus`로 패키지 이름을 읽어 `AppFlavor`를 결정하고, `AppConfig`·`ApiEnvironment`에 반영합니다. (`lib/core/config/`)

### 4. 피처 생성

```bash
# Cubit 템플릿 (기본)
./script/create_feature.sh settings

# Bloc만 생성
./script/create_feature.sh order_checkout --bloc

# Cubit + Bloc 모두 생성
./script/create_feature.sh auth --all
```

생성 후 수동 작업:

1. `domain/entities`, `domain/usecases`, `data/models` 작성
2. `lib/router/app_router.dart`에 `{Feature}Page` 라우트 등록

### 5. 상태 관리 추가

기존 피처에 화면별 Cubit/Bloc을 추가할 때:

```bash
./script/add_feature_state.sh auth profile --cubit
./script/add_feature_state.sh auth login --bloc
```

| 방식 | 폴더 | 선택 기준 |
|------|------|-----------|
| **Cubit** | `presentation/cubit/` | `emit` 한 번으로 끝나는 단순 상태 변경 |
| **Bloc** | `presentation/bloc/` | 여러 이벤트, 복잡한 상태 전이, 디바운스·재시도 등 |

### 6. 코드 생성

`freezed`, `json_serializable` 등 코드 생성이 필요할 때:

```bash
./script/build_runner.sh          # 일회성 생성
./script/build_runner.sh watch    # 변경 감시
```

### 7. 구현 후 확인

- [코딩 컨벤션](docs/architecture/coding-conventions.md) — 네이밍, import, Bloc/Cubit 규칙
- `tasks.md` 체크리스트 항목을 순서대로 완료했는지 확인
- 린트 규칙은 `analysis_options.yaml`을 따릅니다

---

## 참고 문서

| 문서 | 내용 |
|------|------|
| [AGENTS.md](AGENTS.md) | AI 에이전트·개발자 공통 프로젝트 지침 |
| [docs/architecture/overview.md](docs/architecture/overview.md) | 레이어 개요, 스크립트, 상태 관리 |
| [docs/architecture/common-structure.md](docs/architecture/common-structure.md) | `common`, `utils`, `core`, `router` 구조 |
| [docs/architecture/feature-structure.md](docs/architecture/feature-structure.md) | `features/` 내부 레이어 구조 |
| [docs/architecture/coding-conventions.md](docs/architecture/coding-conventions.md) | 네이밍, import, 코드 스타일 |
| [docs/templates/README.md](docs/templates/README.md) | PRD·TDD·Task List·ADR 작성 워크플로우 |
