# TDD — 크레딧 잔액·내역 기술 설계 문서

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/credit` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-08-02 |
| 상태 | Approved |
| 관련 PRD | `prd.md` |

---

## 1. 기능 요약

가입 회원의 크레딧 잔액(`balance`)과 변동 원장을 조회한다. 잔액은 앱 스코프 Cubit으로 공유하고, 내역은 페이지 스코프 Cubit에서 필터·페이지네이션한다.

**피처 경로**: `lib/features/credit/`

---

## 2. 설계 결정

| 결정 | 선택 | 이유 |
|------|------|------|
| 상태 관리 | Cubit | 단순 load/filter/pagination |
| 잔액 공유 | `CreditBalanceCubit` 앱 스코프 (`SsossAppScope`) | 마이페이지·내역 동기화 |
| 내역 상태 | `CreditHistoryCubit` 페이지 스코프 | 필터·페이지는 화면 전용 |
| 라우팅 | `Navigator.push` | my_page 하위 화면 기존 패턴 |
| 필터 API | `ALL` / `USE` / `GAIN` | OpenAPI `type` 쿼리 |

---

## 3. 전체 데이터 흐름

```
[MyPage / CreditHistoryPage]
    ↓
[CreditBalanceCubit.load|refresh] → GetCreditBalanceUseCase → GET /v1/credits/me
[CreditHistoryCubit.load|selectFilter|loadMore] → ListCreditLedgersUseCase → GET /v1/credits/me/ledgers
    ↓
Model → Entity → UI
```

---

## 4. Domain 레이어

### 4.1 Entities

| 파일 | 클래스 | 설명 |
|------|--------|------|
| `domain/entities/credit_balance.dart` | `CreditBalance` | `balance: int` |
| `domain/entities/credit_ledger.dart` | `CreditLedger` | 원장 한 행 |
| `domain/entities/credit_ledger_page.dart` | `CreditLedgerPage` | 페이지 응답 |
| `domain/entities/credit_ledger_filter.dart` | `CreditLedgerFilter` | all / use / gain |
| `domain/entities/credit_ledger_type.dart` | `CreditLedgerType` | deduct / grant / unknown |

```dart
class CreditBalance {
  const CreditBalance({required this.balance});
  final int balance;
}

class CreditLedger {
  const CreditLedger({
    required this.ledgerId,
    required this.type,
    required this.description,
    required this.amount,
    required this.occurredAt,
  });
  final int ledgerId;
  final CreditLedgerType type;
  final String description;
  final int amount;
  final DateTime occurredAt;
}
```

### 4.2 Repository / UseCases

| 파일 | 메서드 |
|------|--------|
| `CreditRepository` | `getBalance()`, `listLedgers({filter, page, size})` |
| `GetCreditBalanceUseCase` | → `CreditBalance` |
| `ListCreditLedgersUseCase` | → `CreditLedgerPage` |

---

## 5. Data 레이어

| Model | 필드 |
|-------|------|
| `CreditBalanceResponseModel` | `balance` |
| `CreditLedgerModel` | `ledgerId`, `type`, `description`, `amount`, `occurredAt` |
| `CreditLedgerListResponseModel` | `totalCount`, `page`, `size`, `hasNext`, `ledgers` |

Datasource paths: `/v1/credits/me`, `/v1/credits/me/ledgers` + `mapDioError`.

필터 → query: `all→ALL`, `use→USE`, `gain→GAIN`.

---

## 6. Presentation 레이어

### 6.1 Cubits

**CreditBalanceCubit** (앱 스코프)

- state: `isLoading`, `balance?`, `errorMessage?`
- `load()` / `refresh()`

**CreditHistoryCubit** (페이지 스코프)

- state: `filter`, `items`, `page`, `hasNext`, `isLoading`, `isLoadingMore`, `errorMessage?`
- `loadInitial` / `selectFilter` / `loadMore` / `refresh`
- pageSize: 20

### 6.2 Pages

| 파일 | 역할 |
|------|------|
| `presentation/pages/credit_history/credit_history_page.dart` | 내역 화면 |
| `presentation/pages/credit_history/credit_history_components.dart` | 잔액행·필터·리스트·이용안내 |

마이페이지는 기존 `my_page` UI를 `CreditBalanceCubit`에 연결한다.

### 6.3 표시 규칙

- 금액: `amount >= 0` → `+{n}개` (primary500), else `-{|n|}개` (neutral600)
- 라벨: `DEDUCT` → 사용, 그 외 → 지급
- 날짜: `yyyy.MM.dd` (로컬)

---

## 7. API 명세

| 메서드 | 엔드포인트 | 설명 |
|--------|-----------|------|
| GET | `/v1/credits/me` | 잔액 (`balance`) |
| GET | `/v1/credits/me/ledgers` | 원장 (`type`, `page`, `size`) |

---

## 8. 의존성 주입

`CreditProviders.build()` → Dio → Datasource → Repository → UseCases.

`SsossAppScope`에 providers + `BlocProvider<CreditBalanceCubit>` 등록.

---

## 9. 에러 처리

| 에러 | 처리 |
|------|------|
| Dio/서버 | `mapDioError` → Cubit `errorMessage` |
| 401/403 | AuthInterceptor 기존 흐름 |
