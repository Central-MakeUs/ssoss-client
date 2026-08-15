# ADR-011 — API 네트워크 오류는 전역 경고 토스트로 안내한다

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| ADR 번호 | 011 |
| 제목 | 앱 API 네트워크 오류 시 `SsossToast(warning)` 을 전역 인터셉터에서 표시한다 |
| 상태 | Accepted |
| 작성자 | ahndohyeon |
| 작성일 | 2026-08-09 |
| 영향 범위 | 전체 프로젝트 (`core/network`, `common` 토스트, API를 호출하는 presentation) |
| 관련 ADR | [ADR-005](adr-005-button-modal-loading-ux.md) |

---

## 1. 맥락 (Context)

화면마다 `NetworkException` 을 잡아 토스트·인라인 에러를 다르게 보여 주면 문구와 타이밍이 어긋난다. 오프라인·타임아웃은 사용자에게 동일한 안내가 필요하다.

**결정 유발 요인**

- 모든 앱 API에서 네트워크 실패 UX를 통일해야 한다.
- 스플래시 버전 체크·매장 정보 부트스트랩은 모달+재시도로 예외 처리한다.
- 화면별 catch 를 모두 고치면 누락이 반복된다.

---

## 2. 고려한 옵션 (Options Considered)

### 옵션 A — 화면별 토스트

| | 내용 |
|-|------|
| 장점 | 화면 맥락에 맞춘 문구가 가능하다. |
| 단점 | 누락·문구 불일치가 난다. |

### 옵션 B — Dio 인터셉터 + 전역 토스트 (선택)

| | 내용 |
|-|------|
| 장점 | 신규 API도 자동으로 동일 UX. |
| 단점 | 스플래시 등 특수 흐름은 skip 플래그가 필요하다. |

---

## 3. 결정 (Decision)

> **선택한 옵션**: 옵션 B

1. `NetworkErrorInterceptor` 가 연결 실패·타임아웃을 감지하면 `SsossToastType.warning` 으로 `네트워크 연결 상태를 확인해주세요.` 를 띄운다.
2. 메인 Dio · Unauthenticated Dio 모두 등록한다.
3. 스플래시(버전 조회·매장 부트스트랩)는 토스트를 생략하고 재시도 모달만 사용한다.
4. 토큰 refresh 가 인증 실패로 세션을 종료할 때는 `SsossToast(warning)` `세션이 만료되었습니다. 다시 로그인해 주세요.` 를 띄우고 로그인 화면으로 보낸다. 원요청 실패 토스트는 띄우지 않는다. refresh 중 네트워크 오류는 세션을 유지하고 네트워크 토스트만 보여 준다.

---

## 4. 결과 (Consequences)

### 긍정적 결과

- 네트워크 안내 문구·컴포넌트가 한곳으로 모인다.
- 세션 만료와 일시적 오프라인이 구분된다.

### 부정적 결과 / 감수한 트레이드오프

- 화면 커스텀 에러 토스트와 겹치면 `showSsossToast` 단일 노출 가드에 막힐 수 있다. 네트워크 안내를 우선한다.

---

## 5. 구현 준수 사항 (AI 에이전트용)

**반드시 해야 할 것**

- 앱 백엔드 Dio 에는 `NetworkErrorInterceptor` 를 유지한다.
- 스플래시 버전 체크·매장 부트스트랩처럼 별도 UX가 있으면 토스트 대신 재시도 모달을 쓴다.
- refresh 인증 실패 시 세션 만료 경고 토스트를 띄운 뒤 로그인으로 보낸다. 원요청 에러 토스트는 띄우지 않는다.

**절대 하지 말아야 할 것**

- 화면마다 네트워크 오류 토스트를 새로 조립하지 않는다.
- refresh 네트워크 실패만으로 로그아웃하지 않는다.

**참고 파일**

- `lib/core/network/interceptors/network_error_interceptor.dart`
- `lib/core/network/interceptors/auth_interceptor.dart`
- `lib/common/widgets/toast/ssoss_toast.dart`
