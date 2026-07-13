# ADR-001 — UI 텍스트는 AppText 사용

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| ADR 번호 | 001 |
| 제목 | UI 텍스트 표시 시 Flutter `Text` 대신 `AppText` 사용 |
| 상태 | Accepted |
| 작성자 | 프로젝트 팀 |
| 작성일 | 2026-07-13 |
| 영향 범위 | 전체 프로젝트 (`presentation`, `common` 레이어) |

---

## 1. 맥락 (Context)

이 앱은 한국어 콘텐츠를 중심으로 한다. Flutter 기본 `Text` 위젯은 한글 줄바꿈 시 글자 단위로 끊기는 경우가 있어, 어절(단어) 단위 줄바꿈이 필요하다.

`AppText`는 `lib/utils/korean_word_break.dart`의 `koreanWordBreak` 확장을 적용해 한국어 텍스트가 자연스럽게 줄바꿈되도록 하는 공용 텍스트 위젯이다. UI 전반에서 `Text`를 직접 쓰면 줄바꿈 동작이 화면마다 달라지고, 한글 타이포그래피 품질을 일관되게 유지하기 어렵다.

**결정 유발 요인**

- 한국어 어절 단위 줄바꿈이 앱 전역 UX 요구사항이다.
- `Text` 직접 사용 시 `koreanWordBreak` 적용을 개발자가 매번 기억해야 한다.
- 공용 UI 컴포넌트(`common/widgets/`)와 피처 화면 간 텍스트 렌더링 규칙을 통일할 필요가 있다.

---

## 2. 고려한 옵션 (Options Considered)

### 옵션 A — Flutter `Text` 위젯 직접 사용

**설명**: Flutter 기본 `Text` 위젯을 그대로 사용하고, 필요한 곳에서만 `koreanWordBreak`를 수동 적용한다.

| | 내용 |
|-|------|
| 장점 | 추가 위젯 없이 Flutter API를 그대로 사용할 수 있다. |
| 단점 | `koreanWordBreak` 적용 누락이 빈번해지고, 화면마다 줄바꿈 품질이 달라진다. |
| 위험 | 한글 UX 품질 저하, 리뷰 시점마다 동일한 실수가 반복된다. |

---

### 옵션 B — `AppText` 공용 위젯 도입 (선택)

**설명**: `lib/common/widgets/text/app_text.dart`의 `AppText`를 UI 텍스트 표시의 단일 진입점으로 사용한다. `AppText` 내부에서 `Text`와 `koreanWordBreak`를 조합한다.

| | 내용 |
|-|------|
| 장점 | 한글 줄바꿈이 자동 적용되고, `Text`와 동일한 API로 교체가 쉽다. |
| 단점 | `Text.rich` 등 일부 고급 사용처는 별도 위젯이 필요할 수 있다. |
| 위험 | `AppText` 내부 구현을 제외하고 `Text`를 직접 쓰는 코드가 혼재할 수 있다. |

---

## 3. 결정 (Decision)

> **선택한 옵션**: 옵션 B — `AppText` 공용 위젯 도입

**선택 근거**

UI에서 문자열을 표시할 때는 Flutter `Text` 대신 `AppText`를 사용한다. `AppText`는 `Text`와 동일한 주요 파라미터(`style`, `textAlign`, `maxLines`, `overflow` 등)를 지원하므로 기존 `Text` 호출을 거의 그대로 대체할 수 있다.

`Text.rich`처럼 `AppText`로 대체하기 어려운 경우는 예외로 두되, 일반 문자열 표시에는 `AppText`를 기본으로 한다.

---

## 4. 결과 (Consequences)

### 긍정적 결과

- 앱 전역에서 한국어 어절 단위 줄바꿈이 일관되게 적용된다.
- 새 화면·컴포넌트 작성 시 텍스트 처리 규칙이 명확해진다.
- `Text` → `AppText` 치환이 단순해 유지보수 비용이 낮다.

### 부정적 결과 / 감수한 트레이드오프

- `Text` 대비 한 단계의 위젯 래핑이 추가된다.
- `Text.rich` 등 복합 텍스트는 `AppText` 범위 밖이므로 별도 처리가 필요할 수 있다.

### 후속 조치 필요 사항

- [x] `AppText` 공용 위젯 구현 (`lib/common/widgets/text/app_text.dart`)
- [ ] 기존 `Text` 직접 사용 코드를 `AppText`로 점진적 마이그레이션

---

## 5. 구현 준수 사항 (AI 에이전트용)

> 이 ADR을 읽는 AI 에이전트가 구현 시 반드시 준수해야 할 규칙을 명시한다.

**반드시 해야 할 것**

- UI에서 텍스트를 표시할 때는 Flutter `Text` 대신 `AppText`(`lib/common/widgets/text/app_text.dart`)를 사용한다.
- `AppText` import: `import 'package:ssoss_flutter/common/widgets/text/app_text.dart';`
- `Text`와 동일하게 첫 번째 인자에 문자열을 전달한다. 예: `AppText('제목', style: AppTextStyles.h4)`

**절대 하지 말아야 할 것**

- `presentation`·`common` 위젯에서 `Text` 위젯을 직접 사용하지 않는다. (`AppText` 내부 구현은 예외)
- 문자열에 `koreanWordBreak`를 수동 적용한 뒤 `Text`로 렌더링하지 않는다. (`AppText`가 처리한다)

**참고 파일**

- `lib/common/widgets/text/app_text.dart` — 공용 텍스트 위젯
- `lib/utils/korean_word_break.dart` — 어절 단위 줄바꿈 확장
- `lib/common/widgets/modal/ssoss_modal.dart` — `AppText` 사용 예시
- `lib/features/home/presentation/widgets/home_tab_pages.dart` — `AppText` 사용 예시

---

## 6. 관련 링크

- 공식 문서: N/A
- 참고 자료: N/A
