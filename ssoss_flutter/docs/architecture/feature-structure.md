# 피처 구조

각 기능은 `lib/features/{feature_name}/` 아래에 **data · domain · presentation** 세 레이어로 구성한다.

## 피처 전체 트리

```
lib/features/{feature_name}/
├── data/
│   ├── datasources/          # API, 로컬 DB 등 외부 데이터 접근
│   ├── models/               # JSON 직렬화 등 데이터 전송 객체 (DTO)
│   └── repositories/         # domain repository 인터페이스 구현체
├── domain/
│   ├── entities/             # 비즈니스 핵심 객체
│   ├── repositories/         # repository 추상 인터페이스
│   └── usecases/             # 단일 책임 비즈니스 로직
└── presentation/
    ├── bloc/                 # Bloc + Event + State
    ├── cubit/                # Cubit + State
    ├── pages/                # 화면(라우트 단위) 위젯
    ├── widgets/              # 해당 피처 전용 UI 컴포넌트
    └── util/                 # 해당 피처에서만 쓰는 유틸 (선택)
```

## 레이어별 상세

### data

| 폴더 | 설명 | 예시 |
|------|------|------|
| `datasources/` | API 호출, 캐시, DB 접근 | `auth_datasource.dart` |
| `models/` | API 응답·요청 모델. `freezed` + `json_serializable` 사용 | `user_model.dart` |
| `repositories/` | domain의 repository 인터페이스 구현. model → entity 변환 | `auth_repository_impl.dart` |

```
data/
├── datasources/
│   └── auth_datasource.dart
├── models/
│   └── user_model.dart
└── repositories/
    └── auth_repository_impl.dart
```

### domain

| 폴더 | 설명 | 예시 |
|------|------|------|
| `entities/` | 프레임워크에 무관한 순수 비즈니스 객체 | `user.dart` |
| `repositories/` | data 레이어가 구현할 추상 계약 | `auth_repository.dart` |
| `usecases/` | 하나의 유스케이스 = 하나의 클래스 | `login_usecase.dart` |

```
domain/
├── entities/
│   └── user.dart
├── repositories/
│   └── auth_repository.dart
└── usecases/
    ├── login_usecase.dart
    └── logout_usecase.dart
```

### presentation

| 폴더 | 설명 | 예시 |
|------|------|------|
| `bloc/` | 이벤트 기반 상태 관리. Bloc, Event, State 파일 | `login_bloc.dart`, `login_event.dart`, `login_state.dart` |
| `cubit/` | 단순 상태 관리. Cubit, State 파일 | `profile_cubit.dart`, `profile_state.dart` |
| `pages/` | 라우트에 연결되는 최상위 화면 위젯 | `login_page.dart` |
| `widgets/` | 해당 피처 내부에서만 재사용하는 UI 조각 | `login_form.dart` |
| `util/` | 피처 전용 헬퍼·포맷터·확장 (앱 전역이 아닐 때) | `password_validator.dart` |

```
presentation/
├── bloc/
│   ├── login_bloc.dart
│   ├── login_event.dart
│   └── login_state.dart
├── pages/
│   └── login_page.dart
├── widgets/
│   └── login_form.dart
└── util/
    └── password_validator.dart
```

## 새 피처 추가 체크리스트

1. `./script/create_feature.sh {feature_name}` 로 스캐폴딩 생성 (`--bloc` 은 필요할 때만)
2. domain: entity → repository 인터페이스 → usecase 순으로 정의
3. data: datasource → model → repository 구현체 작성
4. presentation: 화면별로 cubit 또는 bloc → page → widgets 구성
5. `lib/router/app_router.dart` 에 라우트 등록
6. `@freezed`·`@JsonSerializable` 파일을 추가·수정했으면 `build_runner.sh` 실행
7. 피처 전용 유틸은 `presentation/util/`, 공용으로 승격 시 `lib/utils/` 또는 `lib/common/`

## 관련 문서

- [공용 구조](./common-structure.md) — `common`, `utils`, `core`, `router`
- [아키텍처 개요](./overview.md) — 레이어·의존성·상태 관리·개발 스크립트
- [코딩 컨벤션](./coding-conventions.md) — 네이밍, import 규칙
