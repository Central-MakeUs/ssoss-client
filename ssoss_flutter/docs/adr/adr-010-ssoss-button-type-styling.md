# ADR-010 — SsossButton 스타일은 type으로 선택하고 색·텍스트 오버라이드를 쓰지 않는다

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| ADR 번호 | 010 |
| 제목 | `SsossButton`의 시각 스타일은 `SsossButtonType`으로만 선택하고, 호출부에서 `backgroundColor`·`foregroundColor`·`borderColor`·`textStyle`로 타입 스타일을 덮어쓰지 않는다 |
| 상태 | Accepted |
| 작성자 | ahndohyeon |
| 작성일 | 2026-08-01 |
| 영향 범위 | 전체 프로젝트 (`common` `SsossButton`, CTA·액션 버튼이 있는 `presentation` 화면) |
| 관련 ADR | [ADR-005](adr-005-button-modal-loading-ux.md) (로딩 UX), [ADR-009](adr-009-common-component-sizing.md) (height·width) |

---

## 1. 맥락 (Context)

`SsossButton`은 `SsossButtonType`(primary / secondary / outline / neutral / link / ghost)별로 배경·텍스트·보더·pressed·disabled 컬러와 size별 타이포를 이미 정의한다. 그럼에도 호출부에서 다음 패턴이 반복됐다.

- `type: outline`인데 `backgroundColor: primary50` 등으로 primary 느낌을 흉내 냄
- `type: primary`인데 `backgroundColor: primary400`, `foregroundColor: white`, `textStyle: h5`를 다시 지정
- 화면마다 같은 역할의 버튼 색·pressed 상태가 달라짐

색 오버라이드가 있으면 타입별 pressed/disabled 보간이 깨지고, 디자인 토큰 변경이 호출부에 전파되지 않는다.

**결정 유발 요인**

- 버튼 시각 규격의 단일 출처는 `SsossButton`의 type·size 매핑이어야 한다.
- Figma에서 「연한 primary 배경 CTA」「흰 배경 outline」처럼 보여도, 코드에서는 대응 type을 고르면 된다.
- 로딩(ADR-005)·크기(ADR-009)와 별도로 **스타일 선택 규칙**을 고정할 필요가 있다.

---

## 2. 고려한 옵션 (Options Considered)

### 옵션 A — 호출부에서 색·텍스트 자유 오버라이드 허용

**설명**: `backgroundColor` / `foregroundColor` / `borderColor` / `textStyle`을 화면마다 넘겨 맞춤.

| | 내용 |
|-|------|
| 장점 | 화면별 미세 조정이 즉시 가능하다. |
| 단점 | 동일 역할 버튼이 화면마다 달라지고, pressed/disabled가 어긋난다. |
| 위험 | 매직 컬러·타이포가 확산되어 디자인 시스템과 갈라진다. |

---

### 옵션 B — type으로만 스타일 선택, 오버라이드 금지 (선택)

**설명**: 역할에 맞는 `SsossButtonType`을 고른다. 타입 기본 색·타이포를 호출부에서 덮어쓰지 않는다. CTA에는 `type`을 명시한다. 정말 새 비주얼이 필요하면 type/variant를 컴포넌트에 추가한다.

| | 내용 |
|-|------|
| 장점 | 버튼 룩앤필·pressed/disabled가 프로젝트 전역에서 일치한다. |
| 단점 | 일회성 특수 색 버튼은 즉시 만들기 어렵다. |
| 위험 | 예외를 이유로 다시 오버라이드를 넣으려 할 수 있다. |

---

## 3. 결정 (Decision)

> **선택한 옵션**: 옵션 B — type으로만 스타일 선택, 오버라이드 금지

1. **`SsossButton`의 시각 스타일은 `SsossButtonType`으로만 선택한다.**
2. **호출부에서 타입 스타일을 `backgroundColor` / `foregroundColor` / `borderColor` / `textStyle`로 덮어쓰지 않는다.**  
   (타입에 이미 정의된 색·타이포를 재지정하는 패턴을 금지한다.)
3. **메인 CTA에는 `type: SsossButtonType.primary`를 명시한다.** (기본값이 primary여도 역할을 코드에서 분명히 한다.)
4. **역할별 type 매핑**

| Type | 용도 예 |
|------|---------|
| `primary` | 메인 CTA (저장, 다음, 수정하기, 확인) |
| `secondary` | 보조 CTA (연한 primary 배경 — 예: 다른 채널용으로 만들기) |
| `outline` | 약한 보조 (흰 배경 + 보더 — 예: 재활용하기) |
| `neutral` | 중립 액션 |
| `ghost` | 스킵 등 약한 텍스트형 |
| `link` | 링크형 텍스트 액션 |

5. **새 비주얼이 필요하면** 호출부 오버라이드가 아니라 `SsossButton` type/size(또는 디자인 스펙) 확장을 먼저 논의한다.
6. **크기·로딩은 기존 ADR을 따른다.** height/width → ADR-009, `isLoading`·모달 → ADR-005.

**선택 근거**

스타일의 단일 출처를 type에 두면 pressed/disabled/loading과 함께 일관되고, Figma의 「연한 primary / outline」도 secondary·outline type으로 매핑하면 된다.

---

## 4. 결과 (Consequences)

### 긍정적 결과

- 동일 역할 버튼의 색·타이포·pressed 상태가 화면 간 일치한다.
- 디자인 토큰 변경 시 `SsossButton`만 수정하면 된다.
- 리뷰에서 type 미사용·색 오버라이드를 명확히 지적할 수 있다.

### 부정적 결과 / 감수한 트레이드오프

- 일회성 특수 색 버튼은 컴포넌트/디자인 합의 없이 만들기 어렵다.
- 기존 오버라이드 호출부는 점진적으로 제거해야 한다.

### 후속 조치 필요 사항

- [x] 온보딩·콘텐츠 상세·편집 등 CTA에서 커스텀 색·textStyle 오버라이드 제거 및 type 정리
- [ ] 잔여 `SsossButton` 색/textStyle 오버라이드 호출부 점검·제거
- [ ] 디자인에 없는 새 버튼 룩이 필요하면 type/variant 확장 여부 합의

---

## 5. 구현 준수 사항 (AI 에이전트용)

> 이 ADR을 읽는 AI 에이전트가 구현 시 반드시 준수해야 할 규칙을 명시한다.

**반드시 해야 할 것**

- 버튼 스타일은 **`SsossButtonType`으로만** 고른다. Figma에 연한 primary 배경이면 `secondary`, 흰 배경+보더면 `outline`을 쓴다.
- 메인 CTA에는 `type: SsossButtonType.primary`를 명시한다.
- 가로는 ADR-009대로 `width: double.infinity`(채움) 또는 미선언(wrap). `height`는 지정하지 않는다.
- API 진행 표시가 필요하면 ADR-005대로 `isLoading`을 사용한다.

```dart
// ✅ 메인 CTA
SsossButton(
  label: '다음',
  size: SsossButtonSize.large,
  type: SsossButtonType.primary,
  width: double.infinity,
  onPressed: onPrimaryTap,
);

// ✅ 연한 primary 보조 CTA
SsossButton(
  label: '다른 채널용으로 만들기',
  size: SsossButtonSize.large,
  type: SsossButtonType.secondary,
  width: double.infinity,
  onPressed: onCreateOtherChannel,
);

// ✅ 흰 배경 outline
SsossButton(
  label: '재활용하기',
  size: SsossButtonSize.large,
  type: SsossButtonType.outline,
  width: double.infinity,
  onPressed: onReuse,
);
```

**절대 하지 말아야 할 것**

- `type`과 함께 `backgroundColor` / `foregroundColor` / `borderColor` / `textStyle`로 타입 기본 스타일을 덮어쓰지 않는다.

```dart
// ❌ 금지 — outline에 primary 색을 덧씌움
SsossButton(
  label: '다른 채널용으로 만들기',
  type: SsossButtonType.outline,
  backgroundColor: AppColors.primary50,
  foregroundColor: AppColors.primary500,
  borderColor: AppColors.primary300,
  textStyle: AppTextStyles.h5,
  onPressed: onCreateOtherChannel,
);

// ❌ 금지 — primary인데 색·타이포를 다시 지정
SsossButton(
  label: '다음',
  type: SsossButtonType.primary,
  backgroundColor: AppColors.primary400,
  foregroundColor: AppColors.white,
  textStyle: AppTextStyles.h5,
  onPressed: onPrimaryTap,
);
```

- 새 룩을 만들려고 `Container`+`GestureDetector`로 버튼을 재구현하지 않는다. 필요 시 `SsossButton`을 확장한다.
- 로딩 UX를 `onPressed: null`만으로 대체하지 않는다 (ADR-005).

**참고 파일**

- `lib/common/widgets/button/ssoss_button.dart` — type·size·pressed/disabled 매핑
- `lib/features/onboarding/presentation/pages/onboarding_components.dart` — primary / ghost CTA
- `lib/features/dashboard/presentation/pages/content_detail/content_detail_components.dart` — secondary / outline
- `lib/features/content/presentation/widgets/edit/content_edit_bottom_bar.dart` — primary CTA 명시

---

## 6. 관련 링크

- 공식 문서: N/A
- 참고 자료: N/A
- 관련 ADR: [ADR-005](adr-005-button-modal-loading-ux.md), [ADR-009](adr-009-common-component-sizing.md)
