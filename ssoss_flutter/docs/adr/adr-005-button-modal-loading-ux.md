# ADR-005 — API 호출 버튼·확인 모달 로딩 UX

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| ADR 번호 | 005 |
| 제목 | API 호출 버튼과 확인 모달의 로딩 상태를 공용 컴포넌트로 통일한다 |
| 상태 | Accepted |
| 작성자 | ahndohyeon |
| 작성일 | 2026-07-22 |
| 영향 범위 | 전체 프로젝트 (`common` 레이어 `SsossButton`·`SsossModal`, API 호출 CTA가 있는 presentation 화면) |

---

## 1. 맥락 (Context)

로그아웃, 탈퇴, 회원가입 등 API를 호출하는 버튼을 탭한 뒤 서버 응답을 기다리는 동안 진행 표시가 없었다. 사용자는 탭이 반영되지 않았다고 느끼거나 중복 탭을 시도할 수 있었고, `showSsossModal`은 primary 버튼 탭 직후 모달이 닫혀 API 진행 상태를 알 수 없었다. 화면마다 `CircularProgressIndicator`를 개별 배치하거나 `onPressed: null`만으로 처리하면 UX·구현이 분산된다.

**결정 유발 요인**

- API 호출 CTA는 공통적으로 "처리 중" 피드백과 중복 제출 방지가 필요하다.
- 확인 모달에서 destructive 액션(로그아웃·탈퇴)은 모달을 유지한 채 로딩을 보여야 한다.
- 디자인 시스템 공용 컴포넌트(`SsossButton`, `SsossModal`)에 규칙을 모아 일관성을 유지해야 한다.

---

## 2. 고려한 옵션 (Options Considered)

### 옵션 A — 화면별 로딩 UI 개별 구현

**설명**: 각 화면에서 `isSubmitting` 상태에 따라 버튼 옆에 `CircularProgressIndicator`를 직접 배치하거나 `Stack`으로 감싼다.

| | 내용 |
|-|------|
| 장점 | 화면마다 세밀한 커스터마이징이 가능하다. |
| 단점 | 위치·색·disabled 규칙이 화면마다 달라진다. |
| 위험 | 중복 탭 방지 누락, 모달 즉시 닫힘 등 버그가 반복된다. |

---

### 옵션 B — 전역 로딩 오버레이

**설명**: API 호출 시 화면 전체를 덮는 로딩 오버레이를 표시한다.

| | 내용 |
|-|------|
| 장점 | 구현 지점이 한곳으로 모인다. |
| 단점 | 확인 모달·하단 CTA 맥락과 맞지 않고, 사용자가 어떤 액션이 진행 중인지 알기 어렵다. |
| 위험 | 짧은 API에서도 화면 전체가 막혀 UX가 무겁다. |

---

### 옵션 C — `SsossButton.isLoading` + `showSsossModal.onPrimaryPressedAsync` (선택)

**설명**: 공용 버튼에 `isLoading`을 추가해 라벨 왼쪽에 인디케이터를 표시하고 버튼을 비활성화한다. 확인 모달은 비동기 primary 콜백을 지원해 API 완료까지 모달을 유지하고, 로딩 중 secondary·닫기(X)도 비활성화한다.

| | 내용 |
|-|------|
| 장점 | CTA 맥락 안에서 진행 상태를 보여주고, 중복 제출을 컴포넌트 수준에서 막는다. |
| 단점 | `SsossButton`·`SsossModal` API가 확장된다. |
| 위험 | 기존 sync 모달 API와 혼용 시 잘못된 콜백 선택 가능. |

---

## 3. 결정 (Decision)

> **선택한 옵션**: 옵션 C

API를 호출하는 CTA는 가능한 한 `SsossButton`의 `isLoading`으로 로딩 상태를 표현한다. 확인 모달에서 API를 호출하는 경우 `showSsossModal`의 `onPrimaryPressedAsync`를 사용해 모달을 유지한 채 primary 버튼에만 로딩을 표시하고, 로딩 중에는 secondary·닫기(X)를 비활성화한다.

**세부 규칙**

| 항목 | 규칙 |
|------|------|
| 인디케이터 위치 | 라벨 **왼쪽** (`CircularProgressIndicator` + gap + label) |
| 인디케이터 색 | `loadingIndicatorColor` 미지정 시 버튼 foreground color (primary → 흰색) |
| 로딩 중 버튼 | `isLoading == true` → 비활성 + 탭 무시 (`showLeftIcon`보다 로딩 우선) |
| 모달 로딩 | primary만 `isLoading`, secondary·X 모두 disabled |
| 모달 닫힘 | `onPrimaryPressedAsync` 성공 후 pop; 실패 시 로딩 해제·모달 유지 |
| sync 모달 | 기존 `onPrimaryPressed` / `onSecondaryPressed`는 즉시 dismiss 동작 유지 |

Bloc에서 모달이 await할 수 있도록 `LoginBloc.performLogout()` / `performWithdraw()` 같은 public Future API를 제공한다 (Completer + 이벤트 패턴).

---

## 4. 결과 (Consequences)

### 긍정적 결과

- API CTA의 로딩·중복 탭 방지 규칙이 공용 컴포넌트로 통일된다.
- 확인 모달에서 destructive 액션 진행 상태를 명확히 보여준다.
- 신규 화면은 `isLoading`만 전달하면 동일 UX를 재사용할 수 있다.

### 부정적 결과 / 감수한 트레이드오프

- content 등 기존 화면은 개별 adoption이 필요하다 (일괄 마이그레이션 범위 밖).
- `onPrimaryPressedAsync`와 sync `onPrimaryPressed`를 동시에 쓰지 않도록 호출부에서 주의해야 한다.
- Bloc 8+ 제약으로 `emit`은 이벤트 핸들러 내부에서만 호출하고, 모달 await용 public 메서드는 Completer 패턴을 사용한다.

### 후속 조치 필요 사항

- [x] `SsossButton` `isLoading` / `loadingIndicatorColor` 추가
- [x] `showSsossModal` `onPrimaryPressedAsync` 추가
- [x] 설정 화면 로그아웃 확인 모달 + 로그아웃·탈퇴 로딩 적용
- [x] 회원가입 약관 `다음` 버튼 로딩 적용
- [ ] content 등 다른 feature API 버튼에 필요 시 `isLoading` adoption

---

## 5. 구현 준수 사항 (AI 에이전트용)

**반드시 해야 할 것**

- API 호출 CTA에 로딩이 필요하면 `SsossButton(isLoading: true, enabled: ...)`를 사용한다. 화면마다 인디케이터를 따로 그리지 않는다.
- `isLoading`이 `true`이면 버튼을 비활성화하고 중복 탭을 막는다.
- 확인 모달에서 API를 호출할 때는 `onPrimaryPressedAsync`를 사용한다. primary 탭 후 모달을 즉시 닫지 않는다.
- 모달 로딩 중 primary에만 인디케이터를 표시하고, secondary·닫기(X)는 비활성화한다.
- 모달에서 Bloc 작업을 await할 때는 `performLogout()` 등 public Future API를 사용한다. `emit`을 이벤트 핸들러 밖에서 직접 호출하지 않는다.

**절대 하지 말아야 할 것**

- API 진행 중에도 모달을 즉시 `Navigator.pop`하지 않는다 (`onPrimaryPressedAsync` 사용 시).
- 로딩 중 secondary·닫기 버튼을 활성 상태로 두지 않는다.
- `isLoading` 없이 `onPressed: null`만으로 로딩 UX를 대체하지 않는다 (시각적 피드백 누락).

**참고 파일**

- `lib/common/widgets/button/ssoss_button.dart` — `isLoading` 구현
- `lib/common/widgets/modal/ssoss_modal.dart` — `onPrimaryPressedAsync` 구현
- `lib/features/my_page/presentation/pages/settings/settings_page.dart` — 로그아웃·탈퇴 모달 적용 예시
- `lib/features/auth/presentation/pages/signup/signup_terms_page.dart` — 하단 CTA `isLoading` 예시
- `lib/features/auth/presentation/bloc/login_bloc.dart` — `performLogout` / `performWithdraw` Completer 패턴

---

## 6. 관련 링크

- 공식 문서: https://api.flutter.dev/flutter/material/CircularProgressIndicator-class.html
- 참고 자료: N/A
