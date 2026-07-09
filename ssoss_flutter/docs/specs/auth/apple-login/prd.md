# PRD — 애플 로그인

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/auth-apple-login` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-07-07 |
| 상태 | Draft |
| 관련 ADR | N/A (소셜 로그인 라이브러리 결정 시 `adr-NNN-*.md` 연결 예정) |
| 관련 TDD | `tdd.md` |

> **구현 경로**: 문서는 `docs/specs/auth/apple-login/` 에 분리되어 있으나, 코드는 네이버 로그인과 동일하게 `lib/features/auth/` 피처 내에서 provider 추상화로 확장한다.

---

## 1. 배경 및 목적

**배경**

iOS 앱 스토어 정책상 타사 소셜 로그인(네이버 등)을 제공하는 앱은 **Sign in with Apple** 을 함께 제공해야 한다. 네이버 로그인이 이미 구현되어 있으므로, 애플 로그인을 추가하여 스토어 심사 요건을 충족하고 iOS 사용자에게 익숙한 Apple ID 기반 진입 경로를 제공해야 한다.

**목적**

Apple ID 기반 간편 로그인을 제공하여 iOS 사용자의 가입/로그인 마찰을 최소화한다. 네이버 로그인과 동일한 auth 피처 인프라(secure storage, LoginBloc, 라우터 가드)를 재사용하며, `SocialProvider` 추상화를 통해 소셜 provider를 확장한다.

---

## 2. 사용자 스토리

- [ ] As a **신규 사용자**, I want to **Apple ID로 별도 회원가입 없이 로그인**, so that **빠르게 서비스를 시작할 수 있다**.
- [ ] As a **기존 사용자**, I want to **앱 재실행 시 다시 로그인하지 않고 자동으로 인증 상태가 유지**, so that **매번 로그인하는 번거로움 없이 서비스를 이용할 수 있다**.
- [ ] As a **로그인한 사용자**, I want to **로그아웃**, so that **내 계정을 안전하게 보호할 수 있다**.
- [ ] As a **로그인한 사용자**, I want to **회원 탈퇴**, so that **내 계정 연결과 인증 상태를 완전히 정리할 수 있다**.

---

## 3. 요구사항

### 3.1 기능 요구사항 (Functional Requirements)

| ID | 요구사항 | 우선순위 |
|----|---------|---------|
| FR-01 | 로그인 화면에 Apple 로그인 버튼을 노출하고, 탭 시 Apple 인증 흐름을 시작한다. | Must |
| FR-02 | Apple credential(identityToken, authorizationCode)을 자체 백엔드에 전달하고, 자체 JWT(access/refresh)를 발급받는다. | Must |
| FR-03 | 발급받은 access/refresh 토큰을 secure storage에 안전하게 저장한다. | Must |
| FR-04 | 앱 재실행 시 저장된 토큰으로 자동 로그인(세션 복원)을 수행한다. | Must |
| FR-05 | 사용자가 로그아웃하면 앱의 저장 토큰만 삭제하고 로그인 화면으로 이동한다. (Apple은 클라이언트 연동 해제 API 없음) | Must |
| FR-06 | 사용자가 Apple 인증을 취소하거나 실패한 경우, 로그인 화면을 유지하고 안내 메시지를 표시한다. | Must |
| FR-07 | 어떤 API 호출이든 access 토큰 만료가 감지되면 refresh 토큰으로 재발급 후 원요청을 재시도한다. (전역 인터셉터) | Should |
| FR-08 | 소셜 로그인 provider를 추상화하여 `SocialProvider.apple` 을 추가한다. | Should |
| FR-09 | 미가입 신규 사용자의 경우 백엔드 정책에 따라 자동 회원 생성 또는 온보딩으로 분기한다. | Could |
| FR-10 | 사용자가 탈퇴를 요청하면(확인 절차 포함) 앱 세션/토큰을 즉시 폐기하고 로그인 화면으로 이동한다. | Must |
| FR-11 | 백엔드 연동 시 탈퇴 API 호출에 성공하면 서버 계정 상태를 탈퇴로 전환하고, **서버에서 Apple credential revoke** 를 수행한다. | Should |

> **우선순위 기준** — Must: 반드시 / Should: 가급적 / Could: 여유 시

> **데모 단계 참고**
> - FR-02: 백엔드 미연동 시 `DemoAuthRemoteDatasource` 패턴으로 로컬 JWT 세션 생성 (네이버 데모와 동일)
> - FR-07: 백엔드 연동(Phase 7) 후 구현
> - FR-10(데모): 로컬 세션/토큰 삭제만 수행 (Apple credential revoke 없음)
> - FR-11: 서버 처리 — 클라이언트 데모 Out of Scope

### 3.2 비기능 요구사항 (Non-functional Requirements)

| 항목 | 요구사항 |
|------|---------|
| 성능 | Apple 인증 완료 후 홈 진입까지 정상 네트워크 기준 3초 이내 (데모는 로컬 세션 생성) |
| 보안 | identityToken/authorizationCode를 로그·평문 저장소에 노출하지 않는다. access/refresh 토큰은 secure storage에 저장, 백엔드 통신은 HTTPS |
| 플랫폼 | **iOS 우선** — Xcode Sign in with Apple capability, `com.apple.developer.applesignin` entitlement 설정 필요 |
| 오프라인 | 오프라인 시 로그인 시도 불가 안내. 유효 세션이 있으면 캐시된 인증 상태로 진입 허용(정책에 따름) |
| 접근성 | Apple 로그인 버튼에 스크린 리더용 라벨 제공, 최소 터치 영역 확보 |

---

## 4. 범위 (Scope)

### In Scope (이번 구현에 포함)

- Apple 로그인 버튼 및 `sign_in_with_apple` 인증 흐름 연동
- **데모 경로**: Apple credential → `DemoAuthRemoteDatasource` 패턴으로 로컬 JWT 세션 생성
- 토큰 secure storage 저장 및 자동 로그인(세션 복원)
- 로그아웃 (로컬 토큰 삭제)
- 회원 탈퇴 UI + **데모 범위: 로컬 세션/토큰 삭제**
- 인증 취소/실패 처리
- `SocialProvider.apple` provider 추상화 추가

### Out of Scope (이번 구현에서 제외)

- **Apple credential revoke** (이유: 서버에서 Apple Revoke API 호출 예정)
- 백엔드 소셜 로그인 API 연동 (이유: 서버팀 협의 후 Phase 7, [`naver-login/tdd.md`](../naver-login/tdd.md) 와 동일 후순위)
- 토큰 refresh 전역 인터셉터 실구현 (이유: 백엔드 연동 후)
- Android Apple Sign In (이유: iOS 우선; 필요 시 후속 스펙)
- 이메일/비밀번호 로그인 및 자체 회원가입 폼 (이유: 소셜 로그인 우선 정책)
- 회원 탈퇴/계정 삭제 정책(데이터 보존·복구 정책)은 별도 Account 도메인 스펙으로 분리
- 프로필 조회/편집 (이유: 별도 기능 스펙으로 분리)

---

## 5. 화면 & UX 흐름

**화면 목록**

| 화면 이름 | 설명 | Figma 링크 |
|-----------|------|-----------|
| 로그인 화면 | 네이버·Apple 로그인 버튼을 제공하는 진입 화면 (`lib/features/auth/presentation/pages/login_page.dart`) | N/A |
| Apple 인증 화면 | iOS 시스템이 제공하는 Sign in with Apple UI (외부 제공) | N/A |
| 홈 화면 | 로그인 성공 후 이동하는 서비스 진입 화면 | N/A |

**주요 사용자 흐름**

```
[로그인 화면] → Apple 로그인 버튼 탭 → [Apple 인증 (시스템 UI)] → 인증 승인
  → Apple credential 획득
  → (데모) DemoAuthRemoteDatasource 로 로컬 JWT 세션 생성
  → (백엔드 연동) 자체 백엔드 전달 → 자체 JWT 발급
  → 토큰 secure storage 저장 → [홈 화면]

[앱 재실행] → 저장 토큰 확인
  → 유효 → 세션 복원 → [홈 화면]
  → 만료/없음 → [로그인 화면]

[홈/설정] → 로그아웃 → 로컬 토큰 삭제 → [로그인 화면]

[홈/설정] → 회원 탈퇴 탭 → 확인 다이얼로그(되돌릴 수 없음)
  → (데모) 로컬 세션/토큰 삭제 → [로그인 화면]
  → (백엔드 연동) 탈퇴 API 성공 시 서버 계정 탈퇴 + 서버에서 Apple credential revoke
```

**네이버 로그인과의 흐름 차이**

| 구분 | 네이버 | Apple |
|------|--------|-------|
| SDK | `flutter_naver_login` | `sign_in_with_apple` |
| 로그아웃 | 로컬 토큰 삭제 + 네이버 SDK 세션 해제 (연동 유지) | 로컬 토큰만 삭제 (클라이언트 연동 해제 API 없음) |
| 탈퇴(데모) | **로컬 삭제만** | **로컬 삭제만** |
| 탈퇴(백엔드) | withdraw API + **서버에서 네이버 revoke** | withdraw API + **서버에서 Apple revoke** |
| 이메일 | 항상 제공 가능 | Hide My Email 가능, **최초 로그인 시에만 이름 제공** |

---

## 6. 엣지 케이스 & 에러 처리

| 케이스 | 기대 동작 |
|--------|----------|
| 사용자 인증 취소 | 로그인 화면 유지, 별도 에러 없이 원상 복귀 |
| Hide My Email | relay 이메일 또는 null로 User 저장, 서비스 정책에 따름 |
| 재로그인 시 이름 미제공 | 저장된 nickname 유지 또는 기본값(예: "Apple 사용자") 표시 |
| iOS capability 미설정 | 개발 빌드 실패/인증 불가 — 네이티브 설정 선행 조건으로 문서화 |
| 네트워크 오류 (백엔드 연동 후) | 토스트/스낵바로 오류 안내 후 재시도 가능 상태 유지 |
| Apple credential 무효 | Apple 재인증 유도 |
| 백엔드 JWT 발급 실패 | 오류 안내 후 로그인 화면 유지, 재시도 제공 |
| access 토큰 만료 | 전역 인터셉터가 refresh API 호출 후 원요청 재시도, 갱신 실패 시 로그아웃 처리 후 로그인 화면 이동 |
| refresh 토큰 만료·무효 | 세션 종료, 로그인 화면으로 이동 |
| 미가입 신규 사용자 | 백엔드 정책에 따라 자동 가입 또는 온보딩 분기 |
| 탈퇴 API 실패(백엔드) | 오류 안내 후 현재 화면 유지, 재시도 또는 고객센터 경로 제공 |
| 탈퇴 처리 중 앱 종료 | 앱 재실행 시 세션 상태 재검증. 탈퇴 완료 시 로그인 화면 강제 이동 |

---

## 7. 성공 지표 (Success Metrics)

- Apple 로그인 시도 대비 성공률이 목표치(예: 95%) 이상이다.
- 유효 세션 보유 사용자의 자동 로그인(세션 복원) 성공률이 99% 이상이다.
- 인증 취소/실패 시 앱이 크래시 없이 로그인 화면으로 안전하게 복귀한다.
- 탈퇴 요청 성공 시 로컬 세션 잔존율(토큰 미삭제) 0%를 유지한다.

---

## 8. 의존성 & 선행 조건

- **패키지**: `sign_in_with_apple` (이미 `pubspec.yaml` 에 추가됨)
- **네이티브**: iOS Sign in with Apple capability, `Runner.entitlements` 에 `com.apple.developer.applesignin` 설정, Apple Developer Console 앱 등록
- **API (백엔드 연동 후)**: 소셜 로그인 인증 엔드포인트(Apple credential 수신 → 자체 JWT 발급), 토큰 갱신·탈퇴 엔드포인트. Apple credential revoke 는 **서버**에서 처리
- **선행 기능**: 네이버 로그인으로 구축된 auth 피처 인프라 — secure storage, `LoginBloc`, 라우터 가드(`lib/router/app_router.dart`), `DemoAuthRemoteDatasource`
- **관련 스펙**: [`naver-login/prd.md`](../naver-login/prd.md) — 공통 auth 피처 구조 및 데모/백엔드 연동 정책 참조
