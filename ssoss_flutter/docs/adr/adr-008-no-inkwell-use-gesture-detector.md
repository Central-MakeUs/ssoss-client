# ADR-008 — InkWell 사용 금지, 탭은 GestureDetector로 처리

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| ADR 번호 | 008 |
| 제목 | 탭 인터랙션에 `InkWell`을 쓰지 않고 `GestureDetector`를 사용한다 |
| 상태 | Accepted |
| 작성자 | 프로젝트 팀 |
| 작성일 | 2026-07-31 |
| 영향 범위 | 전체 프로젝트 (`presentation`, `common` 레이어의 인터랙티브 위젯) |
| 관련 ADR | [ADR-002](adr-002-no-material-ink-splash.md)를 Supersede |

---

## 1. 맥락 (Context)

[ADR-002](adr-002-no-material-ink-splash.md)는 Material ink splash를 숨기는 것을 목표로 했고, 신규 위젯은 `GestureDetector`를 권장하되 불가피하면 `InkWell` + `NoSplash`를 허용했다. 실제로는 `Material` + `InkWell` 조합이 남아 터치 이펙트·오버레이가 다시 노출되거나, splash 속성 누락으로 리플이 되살아나는 경우가 반복된다.

터치 피드백은 디자인 토큰 기반 상태(선택색·보더 등)로만 표현하고, Ink 레이어 자체를 쓰지 않는 편이 규칙이 단순하다.

**결정 유발 요인**

- `InkWell`의 터치 이펙트(리플·하이라이트·overlay)가 디자인 스펙과 맞지 않는다.
- `NoSplash` 예외를 두면 속성 누락으로 이펙트가 재발하기 쉽다.
- 탭 핸들러를 `GestureDetector`로 통일하면 화면·컴포넌트 간 규칙이 명확해진다.

---

## 2. 고려한 옵션 (Options Considered)

### 옵션 A — ADR-002 유지 (`InkWell` + NoSplash 허용)

**설명**: 리플만 끄고 `InkWell` 사용은 계속 허용한다.

| | 내용 |
|-|------|
| 장점 | 기존 `InkWell` 코드 변경이 적다. |
| 단점 | overlay/`splashFactory` 누락 시 터치 이펙트가 다시 보인다. |
| 위험 | “리플만 끄면 된다”는 예외가 남용된다. |

---

### 옵션 B — `InkWell` 전면 금지, `GestureDetector` 필수 (선택)

**설명**: 탭 가능한 UI에 `InkWell` / `InkResponse`를 쓰지 않는다. 탭은 `GestureDetector`(또는 동등한 비-Ink 제스처)로 처리하고, 시각 피드백은 상태 색·보더로만 표현한다.

| | 내용 |
|-|------|
| 장점 | Ink 터치 이펙트가 원천적으로 발생하지 않는다. 규칙이 단순하다. |
| 단점 | 기존 `InkWell` 사용처를 `GestureDetector`로 옮겨야 한다. |
| 위험 | `Material`+`InkWell` 패턴으로 되돌아갈 수 있어 리뷰·문서 준수가 필요하다. |

---

## 3. 결정 (Decision)

> **선택한 옵션**: 옵션 B — `InkWell` 전면 금지, `GestureDetector` 필수

1. **탭 가능한 UI에 `InkWell` / `InkResponse`를 사용하지 않는다.** (터치 이펙트·리플·하이라이트 방지)
2. **탭·프레스 처리는 `GestureDetector`를 사용한다.** (`onTap` 등)
3. **시각 피드백은 selected/pressed/disabled 등 디자인 토큰 기반 상태로만 표현한다.**
4. 이 ADR은 [ADR-002](adr-002-no-material-ink-splash.md)를 대체한다. ADR-002의 “`InkWell` + NoSplash 허용”은 더 이상 기본 규칙이 아니다.

**선택 근거**

splash를 끄는 예외보다 Ink 위젯을 쓰지 않는 쪽이 재발을 막고, 에이전트·개발자 모두 “탭 = GestureDetector”로 일관되게 구현할 수 있다.

---

## 4. 결과 (Consequences)

### 긍정적 결과

- Material 터치 이펙트가 의도치 않게 노출되지 않는다.
- 탭 인터랙션 구현 규칙이 `GestureDetector` 하나로 고정된다.
- ADR-002의 NoSplash 보일러플레이트·속성 누락 리스크가 사라진다.

### 부정적 결과 / 감수한 트레이드오프

- 기존 `InkWell` 사용처는 `GestureDetector`로 마이그레이션이 필요하다.
- Material Ink semantics 편의는 직접 보완해야 할 수 있다.

### 후속 조치 필요 사항

- [ ] 기존 `InkWell` / `InkResponse` 사용처를 `GestureDetector`로 교체
- [ ] `SsossButton` 등 공용 컴포넌트의 `InkWell` 잔존 여부를 점검하고 이 ADR에 맞게 정리

---

## 5. 구현 준수 사항 (AI 에이전트용)

> 이 ADR을 읽는 AI 에이전트가 구현 시 반드시 준수해야 할 규칙을 명시한다.

**반드시 해야 할 것**

- 탭 가능한 UI는 `GestureDetector`로 `onTap`(및 필요 시 다른 제스처)을 처리한다.
- 시각 피드백은 선택·비활성 등 상태 색·보더·텍스트 색으로만 표현한다.

**절대 하지 말아야 할 것**

- `InkWell` / `InkResponse`를 사용하지 않는다. (`NoSplash`로 감싸는 것도 신규 코드에서는 허용하지 않는다.)
- `Material` + `InkWell` 조합으로 기본 터치 이펙트(리플·하이라이트·overlay)가 보이게 두지 않는다.
- 디자인 스펙에 없는 Android Material 리플·프레스 오버레이를 추가하지 않는다.

**참고 파일**

- `lib/common/widgets/selection/ssoss_square_selection_button.dart` — `GestureDetector` 예시
- `lib/features/content/presentation/widgets/create/content_create_step_content.dart` — 톤 옵션 타일 예시
- [ADR-002](adr-002-no-material-ink-splash.md) — 이전 결정(Superseded)

---

## 6. 관련 링크

- 공식 문서: https://api.flutter.dev/flutter/widgets/GestureDetector-class.html
- 참고 자료: https://api.flutter.dev/flutter/material/InkWell-class.html
