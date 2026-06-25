# 아키텍처 개요

이 프로젝트는 **클린 아키텍처(Clean Architecture)** 를 기반으로 구성한다. 의존성은 항상 바깥쪽(presentation)에서 안쪽(domain)으로 향하며, domain 레이어는 다른 레이어에 의존하지 않는다.

## 레이어 구조

```
presentation  →  domain  →  (외부 시스템)
     ↓
    data
```

| 레이어 | 역할 | 주요 구성 요소 |
|--------|------|----------------|
| **presentation** | UI, 사용자 상호작용, 상태 표현 | `pages`, `widgets`, `bloc`, `cubit` |
| **domain** | 비즈니스 규칙, 앱 핵심 로직 | `entities`, `repositories`(인터페이스), `usecases` |
| **data** | 외부 데이터 소스 접근, domain 계약 구현 | `datasources`, `models`, `repositories`(구현체) |

## 프로젝트 최상위 구조

```
프로젝트 루트/
├── assets/                   # 정적 리소스
│   ├── img/                  # 일반 이미지
│   ├── icons/                # 아이콘
│   └── fonts/                # 커스텀 폰트
├── env/                      # 환경 변수
│   └── .env.example          # env 파일 템플릿
├── script/                   # 피처·코드 생성 스크립트
└── lib/
    ├── main.dart             # 앱 진입점
    ├── ssoss_app.dart        # 루트 위젯, 전역 Provider/Bloc 설정
    ├── router/
    │   └── app_router.dart   # go_router 기반 라우팅 정의 (참조 진입점)
    ├── core/                 # 인프라, 상수, 컬러, 테마, exception, service, manager
    ├── common/               # 피처 간 공용 컴포넌트 (역할별 분류)
    ├── utils/                # 앱 전역 유틸리티
    └── features/             # 기능 단위 모듈
        └── {feature_name}/
            ├── data/
            ├── domain/
            └── presentation/
```

## `assets/` — 정적 리소스

프로젝트 **루트**의 `assets/` 폴더에서 이미지·아이콘·폰트를 타입별로 관리한다.

```
assets/
├── img/              # 일반 이미지 (PNG, JPG, WebP, SVG 등)
├── icons/            # 아이콘 에셋 (탭 바, 버튼 아이콘, 로고 마크 등)
└── fonts/            # 커스텀 폰트 파일 (TTF, OTF)
```

| 폴더 | 넣는 것 | 예시 |
|------|---------|------|
| `img/` | 일러스트, 배너, 온보딩 이미지, 배경 | `onboarding_01.png` |
| `icons/` | UI 아이콘, 로고 마크 | `ic_home.svg`, `logo_mark.png` |
| `fonts/` | `ThemeData` 에 등록할 폰트 파일 | `Pretendard-Regular.otf` |

### 규칙

1. 리소스 경로는 코드에 문자열을 직접 쓰지 않고 `lib/core/constants/assets.dart` 등 **상수**로 관리한다.
2. 파일명은 `snake_case` 를 사용한다.
3. 피처 전용 리소스가 많아지면 `assets/img/{feature}/` 처럼 하위 폴더로 구분할 수 있다.
4. `pubspec.yaml` 에 폴더 단위로 등록한다.

## `env/` — 환경 변수

API Base URL 등 환경마다 달라지는 값은 코드에 하드코딩하지 않고 env 파일로 관리한다.

```
env/
└── .env.example          # env 파일 템플릿
```

| 파일 | 설명 |
|------|------|
| `.env.example` | env 파일 형식·키 이름 참고용 템플릿 |

### 규칙

1. 로컬에서 `.env.example`을 복사해 env 파일을 만든다.
2. `pubspec.yaml`의 `assets`에 env 파일을 등록한다.
3. 앱 시작 시 `main.dart`에서 `EnvLoader`로 로드하고, `lib/core/config/env_loader.dart`를 통해 값을 읽는다.
4. env 키 이름은 `EnvLoader`에 상수로 정의하고, 코드 전역에 문자열 리터럴을 흩뿌리지 않는다.

## 의존성 규칙

1. **presentation** → domain, common, core, utils, router
2. **data** → domain (repository 인터페이스 구현), core
3. **domain** → 의존 없음 (순수 Dart).
4. **common**, **utils** → domain에 직접 의존하지 않도록 주의 (필요 시 presentation에서 조합)
5. **core/exception/** → 앱·피처 공통 예외 타입의 단일 위치. `data`·`presentation`에서 참조
6. **core/service**, **core/manager** → 피처 `domain` 비즈니스 로직 포함하지 않음
7. 피처 간 직접 참조 금지 — 공유가 필요하면 `common` 또는 `core`로 승격

## 상태 관리

**flutter_bloc** 패키지를 사용한다. **화면·흐름마다** Cubit과 Bloc 중 적합한 방식을 선택하며, 한 피처 안에서 둘 다 사용할 수 있다.

| 방식 | 폴더 | 선택 기준 |
|------|------|-----------|
| **Cubit** | `presentation/cubit/` | `emit` 한 번으로 끝나는 단순 상태 변경 |
| **Bloc** | `presentation/bloc/` | 여러 종류의 이벤트, 복잡한 상태 전이, 디바운스·재시도 등 |

### Cubit이 적합한 경우

- 설정 화면 토글 (다크 모드, 알림 허용)
- 탭·필터 인덱스 전환
- 단순 목록/상세 조회 (로딩 → 성공/실패)

### Bloc이 적합한 경우

- 검색어 입력(디바운스), 검색 실행, 더보기, 초기화
- 주문 확인 → 결제 → 성공/실패 → 재시도/취소
- 로그인 제출, 유효성 실패, 토큰 갱신, 로그아웃

파일 배치·네이밍 규칙은 [코딩 컨벤션](./coding-conventions.md#bloc--cubit)을 따른다.

## 개발 스크립트

반복 작업은 프로젝트 루트(`ssoss_flutter/`)의 `script/` 에서 실행한다. 모든 스크립트는 **FVM** 프로젝트 SDK(`.fvmrc`)를 사용하므로, 전역 `dart`/`flutter` 명령 대신 스크립트를 쓴다.

### 피처 생성 — `create_feature.sh`

Clean Architecture 레이어 구조와 기본 보일러플레이트를 만든다. 생성이 끝나면 `build_runner.sh`를 자동 실행해 freezed 코드도 생성한다.

```bash
# Cubit 템플릿 (기본)
./script/create_feature.sh settings

# Bloc만 생성
./script/create_feature.sh order_checkout --bloc

# Cubit + Bloc 모두 생성
./script/create_feature.sh auth --all
```

| 옵션 | 설명 |
|------|------|
| `<feature_name>` | `snake_case` 피처 이름 (필수) |
| `--cubit` | Cubit 템플릿 생성 (기본) |
| `--bloc` | Bloc(Event/State) 템플릿 생성 |
| `--all` | Cubit + Bloc 템플릿 모두 생성 |
| `-h`, `--help` | 도움말 출력 |

생성 후 수동 작업:

1. `domain/entities`, `domain/usecases`, `data/models` 작성
2. `lib/router/app_router.dart`에 `{Feature}Page` 라우트 등록

### 상태 관리 추가 — `add_feature_state.sh`

기존 피처에 화면별 Cubit/Bloc을 추가한다. 동일한 `name`으로 이미 존재하는 템플릿은 생성할 수 없다.

```bash
# auth 피처에 profile Cubit 추가
./script/add_feature_state.sh auth profile --cubit

# auth 피처에 login Bloc 추가
./script/add_feature_state.sh auth login --bloc

# auth 피처에 session Cubit + Bloc 추가
./script/add_feature_state.sh auth session --all
```

| 인자/옵션 | 설명 |
|-----------|------|
| `<feature_name>` | 대상 피처 (`snake_case`) |
| `<name>` | 파일 접두사 (`login` → `login_cubit.dart`, `login_bloc.dart`) |
| `--cubit` | Cubit 추가 (기본) |
| `--bloc` | Bloc 추가 |
| `--all` | Cubit + Bloc 추가 |

### 코드 생성 — `build_runner.sh`

`freezed`, `json_serializable` 등 코드 생성이 필요할 때 실행한다.

```bash
./script/build_runner.sh          # 일회성 생성
./script/build_runner.sh watch    # 변경 감시
```

실행 시점:

- 피처 생성 직후 — `create_feature.sh`·`add_feature_state.sh`가 자동 실행
- `@freezed`·`@JsonSerializable` 파일을 추가·수정한 뒤

## 관련 문서

- [공용 구조](./common-structure.md) — `common`, `utils`, `core`, `router` 폴더 상세
- [피처 구조](./feature-structure.md) — `features/` 내부 레이어·폴더 구조
- [코딩 컨벤션](./coding-conventions.md) — 네이밍, import, Bloc/Cubit 파일 규칙
