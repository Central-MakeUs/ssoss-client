# 코딩 컨벤션

프로젝트 전반에 적용하는 네이밍·파일·레이어 규칙이다. 린트 설정은 `analysis_options.yaml` 을 따른다.

## 파일·클래스 네이밍

| 대상 | 규칙 | 예시 |
|------|------|------|
| 파일 | `snake_case` | `login_usecase.dart` |
| 클래스 | `PascalCase` | `LoginUseCase` |
| 변수·함수 | `lowerCamelCase` | `fetchUser` |
| 상수 | `lowerCamelCase` (프로젝트 린트 기준) | `defaultTimeout` |
| private | `_` 접두사 | `_repository` |

## 레이어별 접미사

| 레이어 | 종류 | 접미사 | 예시 |
|--------|------|--------|------|
| data | Datasource | `Datasource` | `AuthDatasource` |
| data | Model | `Model` | `UserModel` |
| data | Repository 구현 | `RepositoryImpl` | `AuthRepositoryImpl` |
| domain | Entity | (접미사 없음) | `User` |
| domain | Repository 인터페이스 | `Repository` | `AuthRepository` |
| domain | Usecase | `UseCase` | `LoginUseCase` |
| presentation | Page | `Page` | `LoginPage` |
| presentation | Bloc | `Bloc` | `LoginBloc` |
| presentation | Cubit | `Cubit` | `ThemeCubit` |
| presentation | Event | `Event` | `LoginEvent` |
| presentation | State | `State` | `LoginState` |
| core | Colors | — | `AppColors` |
| core | Theme | — | `AppTheme` |
| core | Exception | `Exception` | `NetworkException` |
| core | Service | `Service` | `SecureStorageService` |
| core | Manager | `Manager` | `PushNotificationManager` |

## import 규칙

1. Dart SDK → 패키지 → 프로젝트(`package:ssoss_flutter/...`) 순
2. 레이어 역방향 import 금지 (domain → data/presentation 불가)
3. 피처 간 직접 import 지양 — `common`, `core`, `router` 경유

```dart
// ✅ presentation → domain
import 'package:ssoss_flutter/features/auth/domain/usecases/login_usecase.dart';

// ❌ domain → data
import 'package:ssoss_flutter/features/auth/data/models/user_model.dart';
```

## Model ↔ Entity 변환

- **Model**: `data/models/` — JSON, API 스키마에 맞춤
- **Entity**: `domain/entities/` — 앱 비즈니스 관점의 객체
- 변환은 repository 구현체 또는 model/extension 에서 수행

```dart
// data/models/user_model.dart
extension UserModelX on UserModel {
  User toEntity() => User(id: id, name: name);
}
```

## Bloc / Cubit

- Bloc 관련 파일은 `presentation/bloc/` 에 한 세트로 둔다.
- Cubit 관련 파일은 `presentation/cubit/` 에 둔다.
- State는 `freezed` 사용을 권장한다 (불변, `copyWith`, 패턴 매칭).
- Page에서는 `BlocProvider` / `BlocBuilder` (또는 `BlocListener`) 로 연결한다.

## 주석·문서

- 비즈니스 의도가 드러나지 않는 코드에만 주석을 단다.
- public API( repository, usecase )에는 간단한 `///` 문서 주석을 권장한다.

## 코드 생성

- 불변 모델·상태: `freezed` + `json_serializable`
- 실행 방법은 [아키텍처 개요 — 개발 스크립트](./overview.md#개발-스크립트)를 참고한다.

## 관련 문서

- [공용 구조](./common-structure.md) — `router`, `utils`, `common`, `core` 배치
- [피처 구조](./feature-structure.md) — `features/` 내부 구조
- [아키텍처 개요](./overview.md) — 레이어·의존성·상태 관리·개발 스크립트
