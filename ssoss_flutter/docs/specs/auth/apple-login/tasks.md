# Task List — 애플 로그인

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/auth-apple-login` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-07-07 |
| 관련 TDD | `tdd.md` |
| 관련 PRD | `prd.md` |

> **구현 우선순위 요약**
> - 백엔드 연동은 **후순위**(서버팀 협의 후 진행, Phase 7). 그 전까지는 **데모 경로**로 로그인 흐름 전체가 동작해야 한다.
> - `sign_in_with_apple` 패키지는 이미 `pubspec.yaml` 에 추가됨 (`^8.1.0`). 추가 설치 불필요.
> - Apple 로그인 버튼은 **iOS에서만** 노출한다 (`Platform.isIOS`). Android는 Out of Scope.
> - 코드는 별도 피처 폴더 없이 `lib/features/auth/` 내 provider 추상화로 확장한다 (네이버 로그인과 동일).

---

## 사전 확인 (구현 시작 전 필수)

- [x] `docs/adr/` 목록 확인 — 관련 프로젝트 전역 기술 결정 파악
- [x] `docs/specs/auth/apple-login/prd.md` 읽기 완료 — 요구사항·범위 파악
- [x] `docs/specs/auth/apple-login/tdd.md` 읽기 완료 — 레이어별 설계 및 설계 결정 파악
- [x] `docs/architecture/overview.md` 읽기 완료 — 아키텍처 규칙 확인
- [x] `docs/architecture/feature-structure.md` 읽기 완료 — 피처 구조 확인
- [x] `docs/architecture/coding-conventions.md` 읽기 완료 — 코딩 컨벤션 확인

---

## Phase 0 — 선행 조건 & 의존성

> `auth` 피처는 네이버 로그인으로 이미 구축되어 있다. `create_feature.sh` 스캐폴딩은 **불필요**하다.

- [x] **0-1** `sign_in_with_apple` 패키지 존재 확인 (`pubspec.yaml` — 이미 `^8.1.0`)
- [x] **0-2** 기존 `auth` 피처 인프라 확인
  - 네이버 로그인 data/domain/presentation 레이어
  - `LoginBloc`, `AuthProviders`, 라우터 인증 `redirect`

---

## Phase 1 — Domain 레이어

> 외부 의존성 없이 순수 Dart 코드로만 작성한다.

### Entities

- [x] **1-1** `domain/entities/social_provider.dart` — `enum SocialProvider { naver, apple }` (`apple` 추가)

### Repository 인터페이스

- [x] **1-2** `domain/repositories/auth_repository.dart` — `Future<AuthSession> loginWithApple()` 추가

### Use Cases

- [x] **1-3** `domain/usecases/login_with_apple_usecase.dart` 신규 작성
  - 입력: 없음
  - 출력: `Future<AuthSession>` (`AuthRepository.loginWithApple()` 위임)

---

## Phase 2 — Data 레이어

### Models

- [x] **2-1** `data/models/apple_account_model.dart` — plain class
  - 필드: `userIdentifier`, `identityToken?`, `authorizationCode?`, `email?`, `givenName?`, `familyName?`
  - `nickname` getter: 이름 없으면 `'Apple 사용자'`
- [x] **2-2** `data/models/stored_auth_cache_model.dart` — `@freezed` + `@JsonSerializable`
  - 필드: `token`(AuthTokenModel), `provider`(`'naver'` \| `'apple'`), `userId`, `nickname`, `email?`
  - `toEntity()` extension: provider → `SocialProvider` 매핑
- [x] **2-3** `data/models/user_model.dart` — `toEntity(SocialProvider provider)` 시그니처 변경
- [x] **2-4** `data/models/auth_response_model.dart` — `toEntity(SocialProvider provider)` 시그니처 변경
- [x] **2-5** `data/models/social_login_request.dart` — Apple credential 필드 확장 (`identityToken`, `authorizationCode`) — **Phase 7** 백엔드 연동용
- [x] **2-6** `build_runner.sh` 실행하여 `*.g.dart`, `*.freezed.dart` 생성
  ```bash
  ./script/build_runner.sh
  ```

### Data Sources

- [x] **2-7** `data/datasources/apple_auth_datasource.dart` 인터페이스 + `apple_auth_datasource_impl.dart`
  - `SignInWithApple.getAppleIDCredential(scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName])`
  - 사용자 취소 → `AuthException.cancelled` throw
  - 기타 실패 → `AuthException.socialFailed` throw
  - `identityToken` / `authorizationCode` **로그 출력 금지** (PRD 보안 요구)
  - `logout`/`revoke` 메서드 없음 — Apple SDK 미제공
- [x] **2-8** `data/datasources/demo_auth_remote_datasource.dart` — `createSessionFromApple(AppleAccountModel)` 추가
  - Apple 프로필로 로컬 `AuthResponseModel`(더미 JWT/만료시간) 생성
- [x] **2-9** `data/datasources/auth_local_datasource.dart` + Impl — `saveSession`/`readSession`으로 교체
  - 저장 키: `auth_tokens` → `auth_session` (마이그레이션)
  - `StoredAuthCacheModel` JSON 직렬화 (`SecureStorageService` 사용)

### Repository 구현체

- [x] **2-10** `data/repositories/auth_repository_impl.dart` — `loginWithApple()` 구현
  - `AppleAuthDatasource.login()` → `DemoAuthRemoteDatasource.createSessionFromApple()` → `AuthLocalDatasource.saveSession()` → `AuthSession` 반환
- [x] **2-11** `loginWithNaver()` 리팩터 — `saveSession` + `toEntity(SocialProvider.naver)` 적용
- [x] **2-12** `restoreSession()` 리팩터 — `StoredAuthCacheModel` 기반 provider별 복원, `_restoredDemoUser` 하드코딩 제거
- [x] **2-13** `logout()` — provider가 apple이면 로컬 clear만 (Apple SDK logout 없음). naver는 기존 동작 유지 (로컬 clear + SDK `logout()`)

---

## Phase 3 — Presentation 레이어

### 상태 관리 (Bloc)

- [x] **3-1** `presentation/bloc/login_event.dart` (`@freezed`) — `appleLoginRequested` 이벤트 추가
- [x] **3-2** `build_runner.sh` 실행 (freezed 재생성)
- [x] **3-3** `presentation/bloc/login_bloc.dart` — `_onAppleLoginRequested` 핸들러 작성
  - 사용 UseCase: `LoginWithAppleUseCase`
  - `_isLoginInProgress` 가드로 중복 인증 방지
  - `try/catch` 로 예외 처리 → `failure` 상태 전환 (네이버와 동일 정책)

### Pages & Widgets

- [x] **3-4** `presentation/widgets/apple_login_button.dart` — Apple 브랜드 로그인 버튼
  - **iOS에서만** 노출 (`Platform.isIOS`)
  - 탭 시 `AppleLoginRequested` dispatch
  - 스크린 리더용 접근성 라벨, 최소 터치 영역 확보
- [x] **3-5** `presentation/pages/login_page.dart` 수정
  - `AppleLoginButton` 추가
  - 안내 문구 수정 (네이버·Apple 로그인 안내)

---

## Phase 4 — 의존성 주입 & 라우팅

- [x] **4-1** `presentation/auth_providers.dart` — `AuthProviders.build()` 확장
  - `AppleAuthDatasource` 등록
  - `ProxyProvider4` 로 `AuthRepositoryImpl` 갱신 (naver + apple + demoRemote + local)
- [x] **4-2** `lib/ssoss_app.dart` 의 `SsossAppScope` — `LoginBloc`에 `LoginWithAppleUseCase` 주입
- [x] **4-3** `lib/router/app_router.dart` — **변경 없음** (provider 무관 인증 `redirect` 동작)

---

## Phase 5 — iOS 네이티브 설정

> Apple 인증은 iOS capability·entitlement 설정이 선행되어야 한다.

- [x] **5-1** Xcode → Signing & Capabilities → **Sign in with Apple** 추가 (`Runner.entitlements` 반영)
- [x] **5-2** `ios/Runner/Runner.entitlements` 생성
  - `com.apple.developer.applesignin` → `Default`
- [x] **5-3** `ios/Runner.xcodeproj/project.pbxproj` 에 `CODE_SIGN_ENTITLEMENTS` 연결
- [ ] **5-4** Apple Developer Console — App ID에 Sign in with Apple 활성화
- [ ] **5-5** iOS 시뮬레이터/실기기에서 Apple 인증 진입 정상 동작 확인

---

## Phase 6 — 통합 검증 (수동)

- [ ] **6-1** FR-01: iOS 로그인 화면에 Apple 버튼 노출, 탭 시 Apple 인증 흐름 시작
- [ ] **6-2** FR-03 / FR-04: 로그인 성공 후 secure storage 저장, 앱 재실행 시 `SocialProvider.apple` 세션 복원
- [ ] **6-3** FR-05: 로그아웃 시 로컬 토큰 삭제 후 로그인 화면 이동 (Apple SDK 연동 해제 없음)
- [ ] **6-4** FR-06: Apple 인증 취소/실패 시 로그인 화면 유지 + 안내 메시지
- [ ] **6-5** FR-08: `SocialProvider.apple` 이 User·세션에 정상 반영
- [ ] **6-6** FR-10: 회원 탈퇴 시 로컬 세션/토큰 삭제 후 로그인 화면 이동 (기존 withdraw 흐름 재사용)
- [ ] **6-7** 엣지 케이스 확인
  - [ ] Hide My Email (email null) — nickname 기본값 `'Apple 사용자'` 로 User 생성
  - [ ] 재로그인 시 이름 미제공 — 저장된 nickname 유지 또는 기본값 표시
- [ ] **6-8** Android에서 Apple 버튼 **미노출** 확인
- [ ] **6-9** `flutter analyze` 경고·에러 없음 확인
- [ ] **6-10** 빌드 에러 없음 확인

---

## Phase 7 — 백엔드 연동 (후순위)

> 서버팀 협의 후 진행한다. [`naver-login/tasks.md`](../naver-login/tasks.md) Phase 7 과 공유 항목이 많다.

- [ ] **7-1** `env/.env.*` 의 `API_BASE_URL` 확정 (`EnvLoader`/`ApiEnvironment` 는 기존 구성 사용)
- [ ] **7-2** `data/datasources/auth_remote_datasource_impl.dart` — Dio 로 `POST /api/v1/auth/social/login`, `/api/v1/auth/token/refresh`, `/api/v1/auth/logout`, `/api/v1/auth/withdraw` 구현
- [ ] **7-3** `AuthRepositoryImpl` 의 데모 경로 → 실제 `AuthRemoteDatasource` 호출로 전환 (네이버·Apple 공통)
- [ ] **7-4** `refreshTokens()` 실구현 + Dio 토큰 인터셉터(access 만료 시 refresh, 실패 시 로그아웃)
- [ ] **7-4-1** 전역 인증 인터셉터 구성: 어떤 API 호출이든 401/만료 감지 시 refresh API 호출
- [ ] **7-4-2** refresh 성공 시 원요청 자동 재시도, 실패 시 로컬 세션 정리 + 로그인 화면 이동
- [ ] **7-5** `loginWithApple()` — `AuthRemoteDatasource.socialLogin(provider: apple, identityToken, authorizationCode)` 전환
- [ ] **7-6** `withdraw()` 에 API 호출 연결. **서버에서 Apple credential revoke** 수행 (클라이언트 미처리)
- [ ] **7-7** `DemoAuthRemoteDatasource` 제거 또는 개발 flavor 전용으로 격리
- [ ] **7-8** FR-02 · FR-07 · FR-11 동작 검증

---

## Phase 8 — 테스트 작성 (선택)

> 팀 정책에 따라 수행한다. TDD 10장 기준.

- [ ] **8-1** `LoginWithAppleUseCase` Unit Test — 정상 로그인, 취소 예외 전파, credential 실패 예외 전파
- [ ] **8-2** `AuthRepositoryImpl` Unit Test (Mock DataSource)
  - `loginWithApple()` — Apple DS → Demo DS → Local saveSession 호출 순서 검증
  - `restoreSession()` — apple/naver 캐시 각각 올바른 `SocialProvider` 로 복원
- [ ] **8-3** `LoginBloc` Unit Test (`bloc_test`) — `AppleLoginRequested` → loading → authenticated / failure
- [ ] **8-4** `AppleLoginButton` Widget Test — iOS에서 렌더링, 탭 시 이벤트 발생
- [ ] **8-5** `LoginPage` Widget Test — iOS에서 Apple 버튼 노출, Android에서 미노출

---

## 완료 기준 (Definition of Done)

> 백엔드 미연동 단계의 완료 기준이다. 백엔드 의존 항목은 Phase 7 에서 충족한다.

- [ ] PRD Must FR 중 데모 가능 항목 구현: **FR-01, FR-03, FR-04, FR-05, FR-06, FR-08, FR-10**
- [ ] FR-02(백엔드 JWT 발급), FR-07(토큰 갱신), FR-11(서버 탈퇴·Apple revoke)은 Phase 7 로 이관 명시
- [ ] `flutter analyze` 경고·에러 없음
- [ ] `build_runner` 생성 파일 최신 상태
- [ ] 라우팅(`/login`, `/home` redirect) 등록 완료 (기존 유지)
- [ ] DI(`AuthProviders`) 등록 완료
- [ ] iOS Sign in with Apple 네이티브 설정 완료
- [ ] 코드 리뷰 완료 (팀 정책에 따라)

---

## 메모 & 이슈

| 날짜 | 내용 | 처리 상태 |
|------|------|---------|
| 2026-07-07 | 백엔드 연동은 서버팀 협의 후 Phase 7. 그 전까지 데모 경로(`DemoAuthRemoteDatasource`)로 로그인 흐름 동작 | Open |
| 2026-07-07 | `StoredAuthCacheModel` 도입으로 네이버 `restoreSession` 하드코딩(`_restoredDemoUser`) 제거 — 네이버·Apple 공통 마이그레이션 | Resolved |
| 2026-07-07 | Apple credential revoke는 서버 처리. 클라이언트 `logoutAndDeleteToken` 미사용 (Out of Scope) | Open |
| 2026-07-07 | Apple 로그인 버튼은 iOS 전용. Android Apple Sign In은 후속 스펙 | Open |
