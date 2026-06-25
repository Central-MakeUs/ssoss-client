# TDD — [기능 이름] 기술 설계 문서

> **사용 방법**: `TODO:` 항목을 채운 뒤 이 안내 블록을 삭제한다.
> 이 문서는 클린 아키텍처 레이어별로 **무엇을 어떻게 만드는지** 설계하는 문서다.
> 구현 전 이 문서를 완성하고, AI 에이전트가 이 문서를 읽고 구현을 시작해야 한다.

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `TODO: feature/xxx` |
| 작성자 | `TODO: 이름` |
| 작성일 | `TODO: YYYY-MM-DD` |
| 상태 | `TODO: Draft / Review / Approved` |
| 관련 PRD | `TODO: prd.md` |

---

## 1. 기능 요약

TODO: 이 기능이 무엇을 하는지 2~4문장으로 요약한다.

**피처 경로**: `lib/features/TODO:feature_name/`

---

## 2. 전체 데이터 흐름

> 사용자 액션부터 서버 응답까지의 흐름을 서술한다.

```
[사용자 액션]
    ↓
[Page / Widget]  →  Event / Method 호출
    ↓
[Bloc / Cubit]   →  UseCase 호출
    ↓
[UseCase]        →  Repository 인터페이스 호출
    ↓
[Repository 구현체]  →  DataSource 호출
    ↓
[DataSource]     →  API 또는 로컬 DB 호출
    ↓
[응답]           →  Model → Entity 변환 → 역방향으로 전파
```

TODO: 위 다이어그램을 기능에 맞게 수정한다.

---

## 3. Domain 레이어

> domain 레이어는 Flutter, Riverpod, Dio, SharedPreferences 등 외부 라이브러리에 의존하지 않는다.
> 순수 Dart 코드만 허용한다.

### 3.1 Entities

| 파일 경로 | 클래스명 | 설명 |
|-----------|---------|------|
| `domain/entities/TODO:entity.dart` | `TODO:EntityName` | TODO: 설명 |

**Entity 필드 목록**

```dart
// TODO: entity.dart 예시
class TODO:EntityName {
  final String id;
  // TODO: 필드 추가
}
```

### 3.2 Repository 인터페이스

| 파일 경로 | 인터페이스명 | 메서드 |
|-----------|------------|--------|
| `domain/repositories/TODO:repository.dart` | `TODO:RepositoryName` | TODO: 메서드 목록 |

```dart
// TODO: repository 인터페이스 예시
abstract class TODO:RepositoryName {
  Future<Either<Failure, TODO:EntityName>> TODO:methodName(TODO:params);
  // TODO: 메서드 추가
}
```

### 3.3 Use Cases

| 파일 경로 | 클래스명 | 입력 | 출력 |
|-----------|---------|------|------|
| `domain/usecases/TODO:use_case.dart` | `TODO:UseCaseName` | `TODO:Input` | `Future<Either<Failure, TODO:Output>>` |

---

## 4. Data 레이어

> data 레이어의 Model/DTO 타입을 domain 또는 presentation 으로 노출하지 않는다.

### 4.1 Models (DTO)

| 파일 경로 | 클래스명 | 대응 Entity | 직렬화 방식 |
|-----------|---------|------------|-----------|
| `data/models/TODO:model.dart` | `TODO:ModelName` | `TODO:EntityName` | `@JsonSerializable` / `@freezed` |

**Model → Entity 변환 메서드**

```dart
// TODO: toEntity() 메서드 예시
TODO:EntityName toEntity() => TODO:EntityName(
  id: id,
  // TODO: 필드 매핑
);
```

### 4.2 Data Sources

| 파일 경로 | 클래스명 | 종류 | 설명 |
|-----------|---------|------|------|
| `data/datasources/TODO:datasource.dart` | `TODO:DataSourceName` | Remote / Local | TODO: 설명 |

### 4.3 Repository 구현체

| 파일 경로 | 클래스명 | 구현 인터페이스 |
|-----------|---------|--------------|
| `data/repositories/TODO:repository_impl.dart` | `TODO:RepositoryImpl` | `TODO:RepositoryName` |

---

## 5. Presentation 레이어

### 5.1 상태 관리 방식

| 구분 | 선택 | 이유 |
|------|------|------|
| 방식 | `TODO: Cubit / Bloc` | TODO: 선택 근거 |
| 폴더 | `TODO: presentation/cubit/ 또는 presentation/bloc/` | |

> 선택 기준: 단순 상태 변경 → Cubit / 복잡한 이벤트·재시도·디바운스 → Bloc

### 5.2 Cubit / Bloc

| 파일 경로 | 클래스명 | 상태 클래스 | 이벤트 클래스 (Bloc만) |
|-----------|---------|-----------|---------------------|
| `presentation/cubit/TODO:cubit.dart` | `TODO:CubitName` | `TODO:State` | N/A |

**State 정의**

```dart
// TODO: state 예시 (@freezed 사용)
@freezed
class TODO:State with _$TODO:State {
  const factory TODO:State.initial() = _Initial;
  const factory TODO:State.loading() = _Loading;
  const factory TODO:State.success(TODO:EntityName data) = _Success;
  const factory TODO:State.failure(String message) = _Failure;
}
```

### 5.3 Pages & Widgets

| 파일 경로 | 클래스명 | 역할 |
|-----------|---------|------|
| `presentation/pages/TODO:page.dart` | `TODO:PageName` | TODO: 역할 |
| `presentation/widgets/TODO:widget.dart` | `TODO:WidgetName` | TODO: 역할 |

### 5.4 라우팅

| 경로 (path) | 페이지 클래스 | 파라미터 |
|-------------|------------|---------|
| `/TODO:path` | `TODO:PageName` | TODO: 파라미터 또는 없음 |

`lib/router/app_router.dart` 에 다음과 같이 등록한다.

```dart
// TODO: 라우트 등록 예시
GoRoute(
  path: '/TODO:path',
  builder: (context, state) => const TODO:PageName(),
),
```

---

## 6. API 명세

> 백엔드 API 엔드포인트 정보를 기록한다.

| 메서드 | 엔드포인트 | 설명 | 인증 필요 |
|--------|-----------|------|---------|
| `TODO: GET/POST/PUT/DELETE` | `TODO: /api/v1/...` | TODO: 설명 | `TODO: Y / N` |

**Request Body 예시**

```json
{
  "TODO: key": "TODO: value"
}
```

**Response Body 예시**

```json
{
  "TODO: key": "TODO: value"
}
```

---

## 7. 에러 처리 전략

| 에러 종류 | 발생 위치 | 처리 방법 |
|----------|----------|---------|
| 네트워크 오류 | DataSource | `NetworkFailure` 반환 후 Cubit/Bloc에서 에러 상태로 전환 |
| 서버 에러 (4xx/5xx) | DataSource | `ServerFailure(statusCode)` 반환 |
| TODO: 도메인 에러 | UseCase | TODO: 처리 방법 |

> `core/exception/` 에 정의된 `Failure` 타입을 사용한다.

---

## 8. 로컬 상태 & 캐싱 전략

| 항목 | 전략 | 저장소 |
|------|------|--------|
| TODO: 데이터 | TODO: 캐싱 여부 및 방법 | TODO: SharedPreferences / Hive / 없음 |

---

## 9. 의존성 주입

> `core/di/` 또는 각 피처의 DI 설정 파일에 등록할 항목을 나열한다.

```dart
// TODO: DI 등록 예시
..registerLazySingleton<TODO:RepositoryName>(
    () => TODO:RepositoryImpl(datasource: sl()),
  )
..registerFactory(() => TODO:CubitName(useCase: sl()))
```

---

## 10. 테스트 계획

| 대상 | 테스트 종류 | 주요 시나리오 |
|------|-----------|------------|
| `TODO:UseCaseName` | Unit Test | TODO: 정상 케이스, 실패 케이스 |
| `TODO:RepositoryImpl` | Unit Test | TODO: Mock DataSource 사용 |
| `TODO:CubitName` | Unit Test (bloc_test) | TODO: 상태 전이 검증 |
| `TODO:PageName` | Widget Test | TODO: 렌더링, 인터랙션 |

