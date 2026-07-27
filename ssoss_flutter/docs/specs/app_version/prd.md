# PRD — 앱 버전 강제 업데이트

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/app-version` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-07-28 |
| 상태 | Approved |
| 관련 ADR | — |
| 관련 TDD | `tdd.md` |

---

## 1. 배경 및 목적

**배경**

최소 지원 버전보다 낮은 앱을 계속 사용하면 API·기능 호환성 문제가 발생할 수 있다. 서버가 OS별 최소 지원 버전을 관리하므로, 앱 실행 시 현재 버전이 이용 가능한지 확인해야 한다.

**목적**

앱 콜드 스타트(스플래시)에서 현재 OS·버전을 서버에 조회하고, 업데이트가 필요하면 스토어로만 유도하는 강제 업데이트 모달을 표시한다. 조회 실패 시에는 사용자를 막지 않는다.

---

## 2. 사용자 스토리

- [x] As a **앱 사용자**, I want to **최소 지원 버전 미만일 때 업데이트를 안내받고**, so that **원활한 서비스를 이용할 수 있다**.
- [x] As a **앱 사용자**, I want to **버전 조회가 실패해도 앱을 계속 사용할 수 있고**, so that **일시적 네트워크 문제로 앱이 막히지 않는다**.

---

## 3. 요구사항

### 3.1 기능 요구사항 (Functional Requirements)

| ID | 요구사항 | 우선순위 |
|----|---------|---------|
| FR-01 | 스플래시에서 로그인/세션 복원 전에 `GET /v1/app-versions/{os}?version=` 를 호출한다 (인증 불필요) | Must |
| FR-02 | iOS는 `CFBundleShortVersionString`, Android는 `versionName` (`PackageInfo.version`)을 보낸다 | Must |
| FR-03 | `updateRequired == true`이면 강제 업데이트 모달을 표시하고 앱 이용을 차단한다 | Must |
| FR-04 | 모달 제목: `업데이트 필요`, 내용: `원활한 서비스 이용을 위해 최신 버전으로 업데이트해 주세요.`, 버튼: `업데이트 하기`만 | Must |
| FR-05 | `업데이트 하기` 탭 시 OS별 스토어 URL로 이동한다. 모달은 닫지 않는다 | Must |
| FR-06 | 조회 실패 시 강제 업데이트 없이 기존 세션 복원 흐름을 진행한다 | Must |

### 3.2 비기능 요구사항 (Non-functional Requirements)

| 항목 | 요구사항 |
|------|---------|
| 성능 | 버전 체크는 스플래시 최소 표시 시간(세션 복원 측 2초)과 별도로, 체크 완료 후 세션 복원을 시작한다 |
| 보안 | 비인증 API (`skipAuth`) |
| 오프라인 | 조회 실패(네트워크 포함) 시 앱 이용을 허용한다 |
| 접근성 | 모달 닫기(X)·배리어 탭으로 해제할 수 없다 |

---

## 4. 범위 (Scope)

### In Scope (이번 구현에 포함)

- 앱 버전 조회 API 연동 및 Cubit
- 스플래시 부트스트랩에서 세션 복원 게이트
- 강제 업데이트 SsossModal (단일 버튼, 닫기 숨김)
- iOS/Android 스토어 URL 상수 및 `url_launcher` 이동

### Out of Scope (이번 구현에서 제외)

- Soft update(선택 업데이트) 안내
- 스토어 미배포 상태에서의 설치 가능 여부 검증
- 백그라운드 복귀 시 재검사

---

## 5. UX 흐름

1. 앱 실행 → 스플래시
2. 버전 조회
3-a. `updateRequired == false` 또는 실패 → 세션 복원 → 로그인/홈
3-b. `updateRequired == true` → 강제 모달 → `업데이트 하기` → 스토어 이동 (앱은 스플래시+모달 유지)

---

## 6. 스토어 URL

| 플랫폼 | 식별자 | URL |
|--------|--------|-----|
| iOS | Apple ID `6788269957` | `https://apps.apple.com/app/id6788269957` |
| Android | package `com.ssoss.app` | `https://play.google.com/store/apps/details?id=com.ssoss.app` |
