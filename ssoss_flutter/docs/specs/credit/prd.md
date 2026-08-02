# PRD — 크레딧 잔액·내역

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/credit` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-08-02 |
| 상태 | Approved |
| 관련 ADR | adr-003-page-app-bar-safe-area.md, adr-010-ssoss-button-type-styling.md |
| 관련 TDD | `tdd.md` |

---

## 1. 배경 및 목적

**배경**

마이페이지 크레딧이 하드코딩되어 있어 실제 잔액·변동 내역을 확인할 수 없다. 가입 회원은 잔액 조회·내역 필터링이 필요하다.

**목적**

`GET /v1/credits/me`로 잔액을 표시하고, 상세 보기에서 필터 가능한 크레딧 내역 화면을 제공한다. 마이페이지와 내역 화면의 잔액은 동기화된다.

---

## 2. 사용자 스토리

- [ ] As a **가입 회원**, I want to **마이페이지에서 현재 크레딧 잔액을 보고**, so that **가용 크레딧을 알 수 있다**.
- [ ] As a **가입 회원**, I want to **상세 보기에서 크레딧 변동 내역을 필터로 보고**, so that **사용·지급 이력을 확인할 수 있다**.

---

## 3. 요구사항

### 3.1 기능 요구사항 (Functional Requirements)

| ID | 요구사항 | 우선순위 |
|----|---------|---------|
| FR-01 | 마이페이지에서 `GET /v1/credits/me`의 `balance`를 표시한다 | Must |
| FR-02 | 잔액 조회 중 크레딧 숫자 영역에 `CircularProgressIndicator`를 표시한다 | Must |
| FR-03 | `상세 보기` 탭 시 크레딧 내역 페이지로 이동한다 | Must |
| FR-04 | 내역 페이지 상단 잔액도 동일 API·공유 상태를 사용한다 | Must |
| FR-05 | `SsossFilterChip`으로 전체/사용/지급 필터 (`ALL`/`USE`/`GAIN`)를 적용한다 | Must |
| FR-06 | `GET /v1/credits/me/ledgers`로 내역을 최신순·페이지네이션 조회한다 | Must |
| FR-07 | 충전하기 버튼은 UI를 두되 주석 처리하여 노출하지 않는다 | Must |
| FR-08 | 하단에 크레딧 이용안내 문구를 표시한다 | Must |

### 3.2 비기능 요구사항 (Non-functional Requirements)

| 항목 | 요구사항 |
|------|---------|
| 성능 | 목록은 페이지 단위(기본 size 20)로 로드 |
| 보안 | ACTIVE accessToken 전용 API |
| 오프라인 | 조회 실패 시 에러 상태 표시 |
| 접근성 | 기존 앱바·버튼 패턴 준수 |

---

## 4. 범위 (Scope)

### In Scope

- 잔액 조회 API 연동 및 공유 Cubit
- 크레딧 내역 페이지 (필터·목록·이용안내)
- 마이페이지 카드 연동 및 네비게이션

### Out of Scope

- 크레딧 충전 플로우 (이유: 추후 활성화)
- GoRouter 등록 (이유: my_page Navigator.push 패턴)
- 매장 정보 API 연동

---

## 5. 화면 & UX 흐름

| 화면 이름 | 설명 | Figma 링크 |
|-----------|------|-----------|
| 마이페이지 카드 | 잔액 + 상세 보기 | — |
| 크레딧 내역 (전체) | 잔액·필터·목록 | [1935:13827](https://www.figma.com/design/I1DrEdPSi6LA8Skaz8flsS/CMC?node-id=1935-13827) |
| 크레딧 내역 (사용) | 사용 필터 | [1935:13983](https://www.figma.com/design/I1DrEdPSi6LA8Skaz8flsS/CMC?node-id=1935-13983) |
| 크레딧 내역 (지급) | 지급 필터 | [1935:14138](https://www.figma.com/design/I1DrEdPSi6LA8Skaz8flsS/CMC?node-id=1935-14138) |

```
[마이페이지] → 상세 보기 → [크레딧 내역]
  ├─ 필터 칩 (전체/사용/지급) → 내역 재조회
  └─ 뒤로가기 → [마이페이지] (공유 잔액 유지)
```

---

## 6. 엣지 케이스 & 에러 처리

| 케이스 | 기대 동작 |
|--------|----------|
| 잔액 조회 중 | 숫자 자리에 CircularProgressIndicator |
| 내역 빈 목록 | 빈 리스트 + 이용안내 유지 |
| 네트워크/서버 오류 | 에러 메시지 상태 (목록은 기존 유지 가능) |
| 401/403 | 기존 AuthInterceptor·세션 만료 흐름 |

---

## 7. 성공 지표

- 마이페이지와 내역 페이지의 잔액이 동일 소스를 반영한다.
- 필터 전환 시 해당 탭 API 결과가 표시된다.

---

## 8. 의존성 & 선행 조건

- **API**: `GET /v1/credits/me`, `GET /v1/credits/me/ledgers`
- **권한**: ACTIVE 회원 accessToken
- **선행 기능**: 로그인·세션 복원
