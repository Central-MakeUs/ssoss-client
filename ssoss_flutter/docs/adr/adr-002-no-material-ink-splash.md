# ADR-002 — 탭 인터랙션에 Material Ink Splash 사용 금지

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| ADR 번호 | 002 |
| 제목 | 탭 가능한 UI에 Android Material Ink Splash(리플)를 표시하지 않는다 |
| 상태 | Accepted |
| 작성자 | 프로젝트 팀 |
| 작성일 | 2026-07-15 |
| 영향 범위 | 전체 프로젝트 (`presentation`, `common` 레이어의 인터랙티브 위젯) |

---

## 1. 맥락 (Context)

Flutter의 `InkWell` / `InkResponse`는 기본적으로 Material Design의 ink splash(물결처럼 퍼지는 리플)를 그린다. 이 앱의 UI는 커스텀 디자인 시스템을 따르며, 선택·탭 피드백은 선택 색 변경 등 명시적 상태로 표현한다. Material 기본 리플은 Figma 스펙과 맞지 않고, Android 플랫폼 느낌이 과도하게 드러난다.

**결정 유발 요인**

- 디자인 시스템은 Material 기본 리플을 요구하지 않는다.
- `InkWell` 기본 동작으로 화면마다 의도치 않은 리플이 노출된다.
- `SsossButton` 등 일부 공용 컴포넌트는 이미 splash를 비활성화하고 있어 규칙을 문서화할 필요가 있다.

---

## 2. 고려한 옵션 (Options Considered)

### 옵션 A — `InkWell` 기본 splash 유지

**설명**: Material `InkWell`을 그대로 사용해 플랫폼 기본 리플을 허용한다.

| | 내용 |
|-|------|
| 장점 | Flutter 기본 API만 쓰면 되어 구현이 단순하다. |
| 단점 | 디자인 스펙과 불일치하고, Android Material 느낌이 과도하게 드러난다. |
| 위험 | 화면·컴포넌트마다 피드백 품질이 제각각이 된다. |

---

### 옵션 B — `InkWell`을 쓰되 splash만 비활성화

**설명**: `InkWell`을 유지하되 `splashFactory: NoSplash.splashFactory`, `splashColor` / `highlightColor` / `overlayColor`를 투명 처리한다. (`SsossButton` 기존 패턴)

| | 내용 |
|-|------|
| 장점 | 기존 `InkWell` 구조를 유지하면서 리플만 막을 수 있다. |
| 단점 | Material/`InkWell` 보일러플레이트가 남을 수 있다. |
| 위험 | overlay 관련 속성을 빠뜨리면 Material 3에서 리플이 다시 보일 수 있다. |

---

### 옵션 C — `GestureDetector` 등 비-Ink 탭 핸들러 사용 (선택)

**설명**: 리플이 필요 없는 선택·탭 UI는 `GestureDetector`(또는 동등한 비-Ink 제스처)로 처리하고, 시각 피드백은 selected/pressed 상태·색상으로만 표현한다.

| | 내용 |
|-|------|
| 장점 | Ink 레이어 자체가 없어 리플이 원천적으로 발생하지 않는다. |
| 단점 | Material semantics/Ink 관련 편의는 직접 구현해야 할 수 있다. |
| 위험 | `InkWell`을 다시 쓰면 ADR을 위반할 수 있다. |

---

## 3. 결정 (Decision)

> **선택한 옵션**: 옵션 C를 기본으로 하되, 기존에 `InkWell`이 불가피한 공용 컴포넌트는 옵션 B로 splash를 완전히 끈다.

탭 가능한 UI에서 Material ink splash(리플)를 표시하지 않는다. 신규 선택·탭 위젯은 가능하면 `GestureDetector` 등 비-Ink 방식으로 구현한다. `InkWell`을 유지해야 하는 경우 `NoSplash` 및 투명 overlay로 리플을 반드시 비활성화한다.

시각적 피드백은 선택 색·보더·텍스트 색 등 디자인 토큰 기반 상태로만 표현한다.

---

## 4. 결과 (Consequences)

### 긍정적 결과

- 탭 피드백이 디자인 시스템과 일관된다.
- Android Material 리플이 의도치 않게 노출되지 않는다.
- `SsossButton`과 신규 선택 위젯의 동작 규칙이 문서화된다.

### 부정적 결과 / 감수한 트레이드오프

- `InkWell`에 의존하던 코드는 `GestureDetector` 또는 splash 비활성화로 수정이 필요하다.
- 프레스 시 미세한 Material 하이라이트에 익숙한 사용자는 즉시적인 물결 피드백이 없다. (선택 상태 변화로 대체)

### 후속 조치 필요 사항

- [x] 콘텐츠 생성 2단계 톤 타일·사각 선택 버튼에서 리플 제거
- [x] 기존 `InkWell` 사용처를 점진적으로 비-Ink 또는 NoSplash 패턴으로 정리

---

## 5. 구현 준수 사항 (AI 에이전트용)

> 이 ADR을 읽는 AI 에이전트가 구현 시 반드시 준수해야 할 규칙을 명시한다.

**반드시 해야 할 것**

- 탭 가능한 UI를 구현할 때 Material ink splash가 보이지 않게 한다.
- 신규 선택·탭 위젯은 가능하면 `GestureDetector`(또는 동등한 비-Ink 제스처)를 사용한다.
- `InkWell` / `InkResponse`를 써야 하면 아래에 준해 splash를 끈다.
  - `splashFactory: NoSplash.splashFactory`
  - `splashColor` / `highlightColor`를 `Colors.transparent`로 설정
  - Material 3에서는 `overlayColor`도 투명 처리
- 시각 피드백은 selected/disabled 등 상태 색·보더로만 표현한다.

**절대 하지 말아야 할 것**

- 기본 splash가 남는 `Material` + `InkWell` 조합을 그대로 두지 않는다.
- 디자인 스펙에 없는 Android Material 리플 애니메이션을 의도적으로 추가하지 않는다.

**참고 파일**

- `lib/common/widgets/button/ssoss_button.dart` — `InkWell` + splash 비활성화 예시
- `lib/common/widgets/selection/ssoss_square_selection_button.dart` — `GestureDetector` 예시
- `lib/features/content/presentation/widgets/create/content_create_step_content.dart` — 톤 옵션 타일 예시

---

## 6. 관련 링크

- 공식 문서: https://api.flutter.dev/flutter/material/InkWell-class.html
- 참고 자료: https://api.flutter.dev/flutter/material/NoSplash-class.html
