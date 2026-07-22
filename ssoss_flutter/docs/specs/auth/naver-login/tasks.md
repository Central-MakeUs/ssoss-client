# Task List — 네이버 로그인

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/auth-naver-login` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-07-03 |
| 관련 TDD | `tdd.md` |
| 관련 PRD | `prd.md` |

> **구현 우선순위 요약**
> - **Phase 7** — 백엔드 인증 API 연동 (소셜 로그인 / 토큰 재발급 / 로그아웃). 탈퇴 API는 제외.
> - **Phase 8** — 회원 탈퇴 API 연동 (후순위, 서버 스펙 대기).
> - 네이버 키(Client ID/Secret 등)는 **네이티브 secret 파일**로 관리되어 이미 설정 완료. `flutter_naver_login` SDK 가 네이티브 값을 직접 읽으므로 Dart/env 에 네이버 키를 두지 않는다.

---

## 사전 확인 (구현 시작 전 필수)

- [x] `docs/adr/` 목록 확인 — 관련 프로젝트 전역 기술 결정 파악
- [x] `docs/specs/auth/naver-login/prd.md` 읽기 완료 — 요구사항·범위 파악
- [x] `docs/specs/auth/naver-login/tdd.md` 읽기 완료 — 레이어별 설계 및 설계 결정 파악
- [x] `docs/architecture/overview.md` 읽기 완료 — 아키텍처 규칙 확인
- [x] `docs/architecture/feature-structure.md` 읽기 완료 — 피처 구조 확인
- [x] `docs/architecture/coding-conventions.md` 읽기 완료 — 코딩 컨벤션 확인

---

## Phase 0 — 피처 스캐폴딩 & 의존성

> 현재 `auth` 피처에는 `presentation/pages/login_page.dart` 만 존재한다. data/domain 레이어를 추가한다.

- [x] **0-1** 피처 레이어 폴더 생성 (data/domain/presentation 수동 생성)
  ```bash
  # 스크립트 사용 (login Bloc 템플릿 포함)
  ./script/create_feature.sh auth --bloc
  # 또는 이미 login_page.dart 가 있으므로 data/domain 폴더만 수동 생성
  ```
- [x] **0-2** 생성된 보일러플레이트 확인 및 불필요 파일 정리 (기존 `login_page.dart` 보존)
- [x] **0-3** `pubspec.yaml` 에 `flutter_secure_storage` 추가 후 `flutter pub get`
  - `package_info_plus` 의 `win32 ^6.0.1` 충돌로 `^9.x` 대신 **`^10.3.1`** 사용
  - `flutter_naver_login`, `flutter_bloc`, `dio`, `freezed`, `json_serializable` 은 이미 존재

---

## Phase 1 — Domain 레이어

> 외부 의존성 없이 순수 Dart 코드로만 작성한다.

### Entities

- [x] **1-1** `domain/entities/social_provider.dart` — `enum SocialProvider { naver }` (확장 지점: kakao, apple)
- [x] **1-2** `domain/entities/user.dart` — `User(id, nickname, email?, profileImageUrl?, provider)`
- [x] **1-3** `domain/entities/auth_tokens.dart` — `AuthTokens(accessToken, refreshToken, expiresAt)` + `isExpired`
- [x] **1-4** `domain/entities/auth_session.dart` — `AuthSession(user, tokens)`

### Repository 인터페이스

- [x] **1-5** `domain/repositories/auth_repository.dart`
  - `Future<AuthSession> loginWithNaver()`
  - `Future<void> logout()`
  - `Future<AuthSession?> restoreSession()`
  - `Future<AuthTokens> refreshTokens()` (백엔드 연동 시 사용, Phase 7)

### Use Cases

- [x] **1-6** `domain/usecases/login_with_naver_usecase.dart` — 출력: `Future<AuthSession>`
- [x] **1-7** `domain/usecases/logout_usecase.dart` — 출력: `Future<void>`
- [x] **1-8** `domain/usecases/restore_session_usecase.dart` — 출력: `Future<AuthSession?>`

---

## Phase 2 — Data 레이어

### Models

- [x] **2-1** `data/models/naver_account_model.dart` — 네이버 SDK 결과(accessToken, id, nickname, email?, profileImage?)
- [x] **2-2** `data/models/user_model.dart` (`@freezed`, `@JsonSerializable`) + `toEntity()`
- [x] **2-3** `data/models/auth_token_model.dart` (accessToken, refreshToken, expiresIn) + `toEntity()`
- [x] **2-4** `data/models/auth_response_model.dart` (user + token) + `toEntity()`
- [x] **2-5** `data/models/social_login_request.dart` (provider, accessToken) — 백엔드 요청용 (Phase 7)
- [x] **2-6** `build_runner.sh` 실행하여 `*.g.dart`, `*.freezed.dart` 생성
  ```bash
  ./script/build_runner.sh
  ```

### Data Sources

- [x] **2-7** `core/service/secure_storage_service.dart` — `flutter_secure_storage` 래퍼 (`SecureStorageService`)
- [x] **2-8** `data/datasources/naver_auth_datasource.dart` 인터페이스 + `naver_auth_datasource_impl.dart`
  - `flutter_naver_login` 으로 `login()`(NaverAccountModel 반환), `logout()` (연동 revoke는 서버 처리, `logoutAndDeleteToken` 미사용)
  - 사용자 취소 시 `AuthException.cancelled` throw
- [x] **2-9** `data/datasources/auth_local_datasource.dart` 인터페이스 + Impl
  - `SecureStorageService` 로 토큰 저장/조회/삭제 (`jsonEncode` 로 토큰 직렬화)
- [x] **2-10** `data/datasources/auth_remote_datasource.dart` **인터페이스만** 정의
  - `socialLogin`, `refresh`, `logout` 시그니처 (실 Dio 구현은 Phase 7)
- [x] **2-11** `data/datasources/demo_auth_remote_datasource.dart` — **데모용 구현**
  - 네이버 프로필로 로컬 `AuthResponseModel`(더미 JWT/만료시간) 생성. 백엔드 미연동 상태에서 흐름 완성용

### Repository 구현체

- [x] **2-12** `data/repositories/auth_repository_impl.dart`
  - `loginWithNaver()`: `NaverAuthDatasource.login()` → (데모) `DemoAuthRemoteDatasource` 로 세션 생성 → `AuthLocalDatasource.saveTokens()` → `AuthSession` 반환
  - `restoreSession()`: 저장 토큰 조회 → 세션 복원(없으면 null)
  - `logout()`: 로컬 토큰 삭제 + 네이버 SDK `logout()` 세션 해제 (연동 revoke 없음)
  - `refreshTokens()`: Phase 7 에서 실제 구현 (데모 단계는 미지원/스텁)

---

## Phase 3 — Presentation 레이어

### 상태 관리 (Bloc)

- [x] **3-1** `presentation/bloc/login_state.dart` (`@freezed`) — initial / loading / authenticated(User) / unauthenticated / failure(message)
- [x] **3-2** `presentation/bloc/login_event.dart` (`@freezed`) — naverLoginRequested / sessionRestoreRequested / logoutRequested
- [x] **3-3** `build_runner.sh` 실행 (freezed 재생성)
- [x] **3-4** `presentation/bloc/login_bloc.dart` 작성
  - 사용 UseCase: `LoginWithNaverUseCase`, `LogoutUseCase`, `RestoreSessionUseCase`
  - 각 이벤트에서 `try/catch` 로 예외 처리 → `failure` 상태 전환 (취소는 `unauthenticated`)

### Pages & Widgets

- [x] **3-5** `presentation/widgets/naver_login_button.dart` — 네이버 브랜드 버튼, 탭 시 `NaverLoginRequested`
- [x] **3-6** `presentation/pages/login_page.dart` 수정
  - 기존 테스트 버튼 제거 → `BlocConsumer<LoginBloc>` 로 상태 구독
  - loading 인디케이터, failure 스낵바, authenticated 시 홈 이동(라우터 `redirect` 로 처리)
  - 진입 시 `SessionRestoreRequested` 로 자동 로그인 시도(앱 스코프에서 dispatch)

---

## Phase 4 — 의존성 주입 & 라우팅

- [x] **4-1** `presentation/auth_providers.dart` — `AuthProviders.build()` (provider 패턴)
  - `NaverAuthDatasource`, `AuthLocalDatasource`, `DemoAuthRemoteDatasource`, `AuthRepository` 등록
- [x] **4-2** `lib/ssoss_app.dart` 의 `SsossAppScope` `MultiProvider` 에 `AuthProviders.build()` 추가
- [x] **4-3** `BlocProvider<LoginBloc>` 로 Bloc 주입 (UseCase 는 `context.read<AuthRepository>()` 기반 생성)
  - ⚠ 설계 변경: 라우터 `redirect` 가 인증 상태를 참조하고 `HomePage` 로그아웃도 동일 Bloc 을 써야 하므로, LoginPage 대신 **앱 스코프(`SsossAppScope`)** 에서 앱 전역으로 주입
- [x] **4-4** `lib/router/app_router.dart` 에 임시 홈 라우트 추가 + 인증 상태 기반 `redirect`
  - path: `/home` (placeholder, `HomePage`)
  - 미인증 → `/login`, 인증 완료 → `/home` (`refreshListenable` 로 Bloc stream 구독)

---

## Phase 5 — 네이티브 설정 확인 (이미 완료됨)

> 네이버 키·URL scheme 설정은 이미 완료되어 있다. 신규 작성이 아닌 **정상 동작 확인**만 수행한다.

- [x] **5-1** iOS 확인
  - `ios/Flutter/Secrets.xcconfig` 에 `NAVER_CLIENT_ID/SECRET/NAME`, `NAVER_APP_URL_SCHEME` 존재
  - `ios/Runner/Info.plist` 의 `CFBundleURLSchemes`, `NidClientID/Secret`, `LSApplicationQueriesSchemes`(naversearchapp 등) 반영 확인
- [x] **5-2** Android 확인
  - `android/secrets.properties` 값 존재
  - `android/app/build.gradle.kts` 의 `resValue(...naver_client_*)` 주입
  - `android/app/src/main/AndroidManifest.xml` 의 `com.naver.sdk.*` meta-data 확인
- [x] **5-3** 실기기/시뮬레이터에서 네이버 앱/웹 인증 진입 정상 동작 확인

## Phase 6 — 회원 탈퇴(withdraw) 우선 구현

> 소셜 연동 revoke는 서버에서 처리한다. API 연동 전에는 로컬 세션/토큰 삭제만 수행한다.

- [x] **6-1** Domain 확장
  - [x] `AuthRepository.withdraw()` 추가
  - [x] `WithdrawUseCase` 추가
- [x] **6-2** Data 확장 (데모 우선)
  - [x] `AuthRepositoryImpl.withdraw()` 구현 (로컬 토큰 삭제만. 네이버 연동 revoke는 서버 처리)
  - [x] `AuthRemoteDatasource.withdraw()` 는 시그니처만 정의하고 실제 호출은 후순위
- [x] **6-3** Presentation 확장
  - [x] `LoginEvent.withdrawRequested` 추가
  - [x] `LoginBloc` 의 withdraw 상태 전이(loading → unauthenticated/failure) 구현
  - [x] 홈/설정 진입점에 "회원 탈퇴" 액션 추가
- [x] **6-4** 수동 검증
  - [x] 회원 탈퇴 실행 시 로그인 화면 복귀
  - [x] 앱 재실행 시 자동 로그인되지 않음
  - [x] 실패 메시지 노출 확인

---

## Phase 7 — 백엔드 인증 API 연동 (login / refresh / logout)

> OpenAPI 기준. **탈퇴 API는 Phase 8** 로 분리한다. apple-login Phase 7 과 공유.

- [x] **7-1** `env/.env.*` 의 `API_BASE_URL` 확정 (`https://api.ssoss.site` 등)
- [x] **7-2** 확장 가능한 에러 코드 계층 (`ErrorResponse`, `ApiErrorCode`, Dio → `AppException` 매퍼)
- [x] **7-3** DTO·엔드포인트 OpenAPI 반영
  - `POST /v1/social-logins/{provider}` — body `{ accessToken }`
  - `POST /v1/tokens` — body `{ refreshToken }` (RTR)
  - `POST /v1/logout` — body `{ refreshToken }` (멱등 204)
- [x] **7-4** `auth_remote_datasource_impl.dart` — Dio 로 login / refresh / logout 구현
- [x] **7-5** `AuthRepositoryImpl` · DI: Demo → 실 `AuthRemoteDatasource` 전환
  - 로그인 성공 시 access/refresh 를 secure storage 에 저장
  - 유저 프로필은 SDK 응답으로 로컬 유지 (로그인 API 응답에 user 없음)
  - 로그아웃 시 서버 logout 후 로컬 토큰 삭제
- [x] **7-6** Dio 전역 인증 인터셉터
  - **7-6-1** `Authorization: Bearer` 주입 (auth 경로 제외)
  - **7-6-2** 401 시 refresh 단일 flight → 성공 시 원요청 재시도 / 실패 시 세션 만료
  - **7-6-3** RTR: refresh 응답의 access+refresh 모두 교체 저장
- [x] **7-7** 세션 만료 UX
  - 로그인 후 화면에서 refresh 실패 시 `SsossModal` ("세션이 만료되었습니다. 다시 로그인해 주세요.") → 확인 시 `/login`
  - 콜드 스타트·로그인 화면에서는 모달 없이 redirect
- [x] **7-8** `DemoAuthRemoteDatasource` 를 DI 에서 실구현으로 교체 (코드는 격리 유지 가능)
- [ ] **7-9** FR-02·FR-07 동작 검증 (실기기/스테이징 수동 검증)

---

## Phase 8 — 회원 탈퇴·복구·status API 연동

> OpenAPI: `DELETE /v1/members/me`, `POST /v1/members/me/recovery`, 소셜 로그인 응답 `status`.

- [x] **8-1** 탈퇴·복구·status DTO 를 `tdd.md` 에 반영
- [x] **8-2** `SocialLoginResponseModel` (`status` + tokens) · `MemberStatus` 추가
- [x] **8-3** `AuthRemoteDatasource.withdraw()` — `DELETE /v1/members/me`
- [x] **8-4** `AuthRemoteDatasource.recover()` — `POST /v1/members/me/recovery`
- [x] **8-5** `AuthRepositoryImpl.withdraw()` — remote → local clear (+ naver SDK logout)
- [x] **8-6** 로그인 시 `status == WITHDRAWN` → recover → ACTIVE 토큰으로 세션 저장
- [x] **8-7** 설정 화면 로그아웃/탈퇴 연동 (탈퇴: 모달 `"탈퇴하시겠어요?"` → API, 실패 시 `SsossToast`)
- [x] **8-8** 서버에서 네이버 연동 revoke 수행 (클라이언트 `logoutAndDeleteToken` 미사용)
- [ ] **8-9** FR-11 동작 검증 (실기기/스테이징 수동 검증)

---

## Follow-up — 탈퇴 확인 페이지

> 현재는 설정에서 `SsossModal`(`탈퇴하시겠어요?`)로 확인한다. 추후 전용 페이지로 교체한다.

- [ ] **F-1** 탈퇴 확인 전용 페이지 추가 (`my_page` 또는 `auth`)
- [ ] **F-2** 설정 「탈퇴 하기」→ 확인 페이지 이동 → 최종 확인 후 `withdrawRequested`
- [ ] **F-3** 모달 확인 UX 제거

---

## Phase 10 — PENDING 회원가입 플로우

- [x] **10-1** `SignupRequestModel` · `POST /v1/signup` API
- [x] **10-2** `StoredAuthCacheModel.memberStatus` · `AuthSession.memberStatus`
- [x] **10-3** `LoginState.pendingSignup` / `signupComplete` · 라우터 `/signup/terms`, `/signup/complete`
- [x] **10-4** `SignupTermsPage` + `SignupTermsCubit` (Figma 약관 UI)
- [x] **10-5** `SignupCompletePage` (Figma 완료 UI, 2초 후 홈)
- [ ] **10-6** 실기기/스테이징 수동 검증

---

## Phase 9 — 테스트 작성 (선택)

- [ ] **9-1** `LoginWithNaverUseCase` Unit Test
- [ ] **9-2** `AuthRepositoryImpl` Unit Test (Mock DataSource)
- [ ] **9-3** `LoginBloc` Unit Test (`bloc_test`) — 상태 전이 검증
- [ ] **9-4** `LoginPage` Widget Test
- [ ] **9-5** `WithdrawUseCase` Unit Test
- [ ] **9-6** `withdrawRequested` 이벤트 상태 전이 테스트
- [ ] **9-7** Dio Auth Interceptor — 401 → refresh → retry / refresh 실패 → 세션 만료

---

## 완료 기준 (Definition of Done)

> Phase 0–6(데모) + Phase 7(인증 API) + Phase 8(탈퇴·복구·status) 완료 기준.

- [x] PRD Must FR 중 데모 가능 항목 구현: **FR-01, FR-03, FR-04, FR-05, FR-06**
- [x] 탈퇴 최소 요건(데모): **FR-10**
- [x] FR-02(백엔드 JWT 발급), FR-07(토큰 갱신) — **Phase 7**
- [x] FR-11(서버 탈퇴 처리) — **Phase 8** (수동 검증은 8-9)
- [x] `flutter analyze` 경고·에러 없음
- [x] `build_runner` 생성 파일 최신 상태
- [x] 라우팅(`/login`, `/home` redirect) 등록 완료
- [x] DI(`AuthProviders`) 등록 완료
- [ ] 코드 리뷰 완료 (팀 정책에 따라)

---

## 메모 & 이슈

| 날짜 | 내용 | 처리 상태 |
|------|------|---------|
| 2026-07-03 | 네이버 키는 iOS/Android 네이티브 secret 파일로 관리(설정 완료). Dart/env 에 네이버 키 불필요 | Resolved |
| 2026-07-07 | 탈퇴 시 네이버 연동 revoke는 서버 처리. 클라이언트는 로컬 세션 삭제만 (`logoutAndDeleteToken` 제거) | Resolved |
| 2026-07-15 | OpenAPI 확정: `/v1/social-logins/{provider}`, `/v1/tokens`, `/v1/logout`. 탈퇴는 Phase 8 분리 | Resolved |
| 2026-07-22 | Phase 10: PENDING signup 플로우, Apple 이메일 SharedPreferences | Open |
