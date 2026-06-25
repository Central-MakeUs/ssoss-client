# 공용 구조

피처에 속하지 않는 **앱 전역 모듈**의 폴더 구조와 배치 기준이다. 피처 간 공유가 필요할 때 이 문서를 기준으로 `common`, `utils`, `core`, `router` 에 추가한다.

## 전체 트리

```
lib/
├── main.dart
├── ssoss_app.dart
├── router/
│   ├── app_router.dart       # GoRouter 단일 진입점 (필수 참조)
│   └── routes/               # 경로 상수 분리 (선택)
├── core/                     # 인프라 (네트워크, 설정, DI 등)
├── common/                   # 역할별 공용 컴포넌트
└── utils/                    # 앱 전역 유틸리티
```

## `lib/common/` — 역할별 공용 컴포넌트

두 개 이상의 피처에서 재사용하는 코드를 **역할(role)** 별 하위 폴더로 나눠 둔다.

```
lib/common/
├── widgets/          # 공용 UI (버튼, 로딩, 에러 뷰, 다이얼로그 등)
└── extensions/       # Dart/Flutter 확장 메서드
```

| 폴더 | 넣는 것 | 넣지 않는 것 |
|------|---------|--------------|
| `widgets/` | 여러 화면에서 쓰는 Stateless/Stateful 위젯 | 특정 피처 전용 폼·카드 |
| `extensions/` | `String`, `DateTime`, `BuildContext` 확장 | 비즈니스 로직 |

### 승격 기준

- **피처 `presentation/widgets/`** → 두 번째 피처에서도 쓰이면 `common/widgets/` 로 이동
- **피처 `presentation/util/`** → 순수 함수이고 앱 전역에서 쓰이면 `lib/utils/` 로 이동
- domain 레이어에 직접 의존하지 않도록 유지 (필요 시 presentation에서 조합)

## `lib/utils/` — 앱 전역 유틸리티

프레임워크·UI와 무관한 **순수 함수·헬퍼 클래스**를 둔다.

```
lib/utils/
├── date_formatter.dart
├── debouncer.dart
└── validators.dart
```

| 위치 | 조건 |
|------|------|
| `lib/utils/` | 앱 어디서든 재사용 가능한 순수 유틸 |
| `features/{feature}/presentation/util/` | 해당 피처에서만 쓰는 유틸 |

- UI 위젯은 `utils`가 아니라 `common/widgets/` 에 둔다.
- 네트워크·설정 등 인프라성 코드는 `core/` 에 둔다.

## `lib/core/` — 인프라 · 디자인 토큰

앱 전역 **인프라**, **공용 상수**, **컬러·테마**, **예외**, **서비스**, **매니저**를 포함한다. 피처 비즈니스 로직은 넣지 않는다.

```
lib/core/
├── config/           # Flavor, AppConfig, env 로드, 환경 초기화
├── constants/        # 앱 전역 상수 (에셋 경로, 스토리지 키, API 키 이름 등)
├── colors/           # 앱 전역 컬러 토큰
├── theme/            # ThemeData, 타이포그래피, 간격
├── exception/        # 공용 예외·실패(Failure) 타입
├── service/          # 로컬 저장소 등 단일 책임 인프라 래퍼
├── manager/          # 푸시 알림 등 플랫폼 기능 오케스트레이션
└── network/          # Dio, ApiEnvironment, NetworkProviders
```

| 폴더 | 넣는 것 | 예시 |
|------|---------|------|
| `config/` | Flavor, env 로드, 환경별 설정 초기화 | `app_config.dart`, `env_loader.dart` |
| `constants/` | 앱 전역에서 참조하는 불변 값 | `assets.dart`, `storage_keys.dart` |
| `colors/` | 디자인 시스템 컬러 팔레트 | `app_colors.dart` |
| `theme/` | `ThemeData` 조합, 텍스트 스타일, 간격 | `app_theme.dart`, `app_text_styles.dart` |
| `exception/` | 앱·피처 공통 예외·`Failure` 타입 | `app_exception.dart`, `auth_exception.dart` |
| `service/` | 저장소·단일 인프라 API 래퍼 | `shared_preferences_service.dart`, `secure_storage_service.dart` |
| `manager/` | 초기화·권한·이벤트 흐름을 조율하는 컴포넌트 | `push_notification_manager.dart` |
| `network/` | HTTP 클라이언트, API 환경 | `dio_factory.dart`, `api_environment.dart` |


### Service vs Manager

| 구분 | Service | Manager |
|--------|--------|--------|
| 역할 | 외부 SDK 래퍼 | 여러 Service 조합 |
| 상태 | 최소 | 보유 가능 |
| 책임 | 단일 책임 | 흐름 조율 |
| 예시 | SharedPreferencesService | PushNotificationManager |

- manager → service 의존 허용
- service → manager 의존 금지
- service 는 단일 책임 유지
- manager 는 여러 service 를 조합하여 동작한다

### 예외 규칙

- 예외 타입은 `core/exception/` 에만 정의한다. 피처 전용 예외도 `core/exception/auth_exception.dart` 처럼 여기에 둔다.
- data 는 API·저장소 오류를 `core/exception/` 으로 변환한다.
- 상위 레이어는 예외를 적절한 UI 상태로 변환한다.

### domain과의 경계

- domain 은 `core/exception/` 을 참조하지 않는다.
- repository·usecase 는 Domain Entity 또는 Dart 기본 타입만 반환한다.
- DTO, Response, Model 등 data 계층 타입은 domain 밖으로 노출하지 않는다.

### 컬러 · 테마 규칙

1. 컬러 값은 `core/colors/` 에만 정의하고, 위젯·피처 코드에 hex를 직접 쓰지 않는다.
2. `ThemeData` 는 `core/theme/app_theme.dart` 에서 `AppColors` 를 참조해 조합한다.
3. `MaterialApp` / `MaterialApp.router` 에는 `core/theme/` 의 테마를 적용한다.
4. 피처별 일회성 스타일만 해당 피처 `presentation/widgets/` 에 둔다.

## `lib/router/` — 라우팅

**go_router** 기반. 모든 라우트는 `app_router.dart` 를 단일 진입점으로 참조한다.

```
lib/router/
├── app_router.dart   # GoRouter 인스턴스 및 라우트 트리
└── routes/           # (선택) 경로 상수·라우트 모듈 분리
    └── app_routes.dart
```

### 규칙

1. 새 화면 추가 시 `app_router.dart` 에 라우트를 등록한다.
2. `GoRouter` 인스턴스는 앱에서 **하나**만 유지한다 (`ssoss_app.dart` 에서 참조).
3. 경로 문자열은 `router/routes/` 또는 피처 `presentation/` 에 상수로 분리할 수 있다.

## 관련 문서

- [아키텍처 개요](./overview.md) — 레이어·의존성 규칙
- [피처 구조](./feature-structure.md) — `features/` 내부 구조
- [코딩 컨벤션](./coding-conventions.md) — 네이밍, import 규칙
