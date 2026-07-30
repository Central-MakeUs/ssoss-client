# ADR-009 — 공용 컴포넌트 크기·패딩은 컴포넌트 기본값을 따른다

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| ADR 번호 | 009 |
| 제목 | 버튼·텍스트필드·어코디언·드롭다운 등 공용 컴포넌트에 height를 지정하지 않고, width·padding은 레이아웃 의도에 맞게만 사용한다 |
| 상태 | Accepted |
| 작성자 | 프로젝트 팀 |
| 작성일 | 2026-07-31 |
| 영향 범위 | 전체 프로젝트 (`common` 공용 컴포넌트 사용처, `presentation` 페이지·위젯) |

---

## 1. 맥락 (Context)

`SsossButton`, `SsossTextField`, 어코디언, 드롭다운(셀렉트) 등 공용 컴포넌트는 디자인 시스템에 맞는 **내부 높이·패딩·타이포**를 이미 갖고 있다. 호출부에서 `height`를 덮어쓰거나, wrap 콘텐츠인데도 `width`를 고정하거나, 바깥에서 패딩을 중복 주면 다음 문제가 생긴다.

- 화면마다 같은 버튼·필드 높이가 달라져 디자인 일관성이 깨진다.
- Figma 스펙의 컴포넌트 패딩과 페이지 패딩이 겹쳐 여백이 과하거나 부족해진다.
- `width`/`height` 매직 넘버가 늘어 반응형·레이아웃 수정 비용이 커진다.

**결정 유발 요인**

- 공용 컴포넌트의 시각 규격은 컴포넌트 내부에서 단일 출처로 관리해야 한다.
- 호출부는 “가로로 채울지 / 내용만큼만 차지할지”만 결정하면 된다.
- 세로 크기는 컴포넌트에 정의된 padding·콘텐츠로 자연스럽게 잡혀야 한다.

---

## 2. 고려한 옵션 (Options Considered)

### 옵션 A — 호출부에서 height·width를 자유롭게 지정

**설명**: 페이지·피처 위젯이 `height: 48`, `width: 200` 등 임의 크기를 넘긴다.

| | 내용 |
|-|------|
| 장점 | 화면별 미세 조정이 쉽다. |
| 단점 | 동일 컴포넌트 높이가 화면마다 달라진다. |
| 위험 | 디자인 토큰·컴포넌트 스펙과 어긋난 매직 넘버가 확산된다. |

---

### 옵션 B — height 금지, width는 채움/`미선언`만 허용, padding은 컴포넌트 기본 (선택)

**설명**: 공용 컴포넌트 사용 시 `height`를 지정하지 않는다. 여백을 제외한 영역을 가로로 채울 때만 `width: double.infinity`를 쓰고, 내용 너비(wrap content)일 때는 `width`를 선언하지 않는다. 세로·내부 여백은 컴포넌트에 정의된 padding으로 자연스럽게 맞춘다.

| | 내용 |
|-|------|
| 장점 | 높이·패딩 일관성이 유지되고, width 의도가 명확하다. |
| 단점 | 화면별 “조금 더 큰 버튼” 같은 예외를 만들기 어렵다. |
| 위험 | 예외가 필요하면 컴포넌트 size variant를 추가하지 않고 height를 다시 넣으려 할 수 있다. |

---

## 3. 결정 (Decision)

> **선택한 옵션**: 옵션 B — height 금지, width는 채움/`미선언`, padding은 컴포넌트 기본

1. **공용 컴포넌트에 `height`를 지정하지 않는다.**  
   대상 예: 버튼, 텍스트필드, 어코디언, 드롭다운(셀렉트) 및 동등한 `common` 인터랙티브 컴포넌트.
2. **가로로 부모(여백 제외 화면·슬롯)를 채울 때만 `width: double.infinity`를 사용한다.**
3. **내용 너비(wrap content)일 때는 `width`를 선언하지 않는다.** (`null`/생략으로 콘텐츠·내부 패딩에 맡긴다.)
4. **내부 여백·터치 영역은 컴포넌트에 정의된 padding·size로 자연스럽게 잡히게 둔다.**  
   호출부에서 컴포넌트 내부 패딩을 흉내 내거나, height로 패딩을 보정하지 않는다.
5. 페이지 바깥 여백(예: `Padding(horizontal: 16)`)과 컴포넌트 내부 padding은 역할을 분리한다. 바깥은 레이아웃 거터, 안은 컴포넌트 스펙이다.

**선택 근거**

크기의 단일 출처를 컴포넌트에 두면 디자인 일관성과 수정 비용이 좋아진다. width는 “채움 vs wrap” 두 의도만 표현하면 충분하고, height 오버라이드는 그 계약을 깨뜨린다.

---

## 4. 결과 (Consequences)

### 긍정적 결과

- 버튼·필드 등 공용 UI의 높이가 화면마다 동일하다.
- wrap / full-width 의도가 코드에서 바로 읽힌다.
- 패딩·터치 영역 변경 시 컴포넌트만 고치면 된다.

### 부정적 결과 / 감수한 트레이드오프

- 특수 화면에서 임의 높이가 필요하면 호출부 예외가 아니라 컴포넌트 size variant(또는 디자인 스펙 갱신)로 풀어야 한다.
- 기존 `height:` 지정 호출부는 점진적으로 제거해야 한다.

### 후속 조치 필요 사항

- [ ] 공용 컴포넌트 사용처의 불필요한 `height` 지정 제거
- [ ] wrap content인데 `width`가 고정된 호출부를 정리
- [ ] 높이 예외가 필요하면 컴포넌트 API(size 등)로 수용할지 디자인과 합의

---

## 5. 구현 준수 사항 (AI 에이전트용)

> 이 ADR을 읽는 AI 에이전트가 구현 시 반드시 준수해야 할 규칙을 명시한다.

**반드시 해야 할 것**

- 버튼, 텍스트필드, 어코디언, 드롭다운 등 공용 컴포넌트 사용 시 **`height`를 넘기지 않는다.**
- 여백을 제외한 가로 영역을 채울 때는 **`width: double.infinity`** 를 사용한다.

```dart
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16),
  child: SsossButton(
    width: double.infinity, // 여백 제외 화면을 채움
    // height 지정 금지
    onPressed: onSubmit,
    child: const Text('확인'),
  ),
);
```

- 내용만큼만 차지할 때는 **`width`를 선언하지 않는다.**

```dart
SsossButton(
  // width 생략 = wrap content
  onPressed: onCancel,
  child: const Text('취소'),
);
```

- 세로 크기·내부 여백은 컴포넌트에 정의된 padding·size에 맡긴다.

**절대 하지 말아야 할 것**

- `SsossButton` / `SsossTextField` / 어코디언 / 드롭다운 등에 `height: 48` 같은 고정 높이를 지정하지 않는다.
- wrap content인데 `width: 120`처럼 임의 너비를 고정하지 않는다. (디자인상 고정 너비가 명시된 특수 케이스는 컴포넌트·스펙을 먼저 확인한다.)
- 컴포넌트 내부 padding을 맞추려고 호출부에서 height를 키우거나, 동일 패딩을 바깥에 중복으로 넣지 않는다.
- 높이 예외를 만들려고 공용 컴포넌트를 우회한 raw `Container`+임의 padding으로 대체하지 않는다. 필요 시 컴포넌트 variant를 확장한다.

**참고 파일**

- `lib/common/widgets/button/ssoss_button.dart` — size/padding 기반 높이
- `lib/common/widgets/input/ssoss_text_field.dart` — 입력 필드
- `lib/common/widgets/accordion/ssoss_accordion.dart` — 어코디언
- `lib/common/widgets/input/ssoss_select_dropdown.dart` — 드롭다운
- `lib/common/widgets/input/ssoss_select_field.dart` — 셀렉트 필드

---

## 6. 관련 링크

- 공식 문서: https://api.flutter.dev/flutter/widgets/SizedBox-class.html
- 참고 자료: N/A
