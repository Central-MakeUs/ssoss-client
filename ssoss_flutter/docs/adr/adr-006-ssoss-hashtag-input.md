# ADR-006 — 해시태그·키워드 입력은 SsossHashtagInput으로 통일한다

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| ADR 번호 | 006 |
| 제목 | 해시태그·키워드 입력은 `SsossHashtagInput`으로 통일한다 |
| 상태 | Accepted |
| 작성자 | ahndohyeon |
| 작성일 | 2026-07-24 |
| 영향 범위 | 전체 프로젝트 (`common` 레이어 해시태그 입력, content·my_page 등 해시태그/키워드 UI가 있는 presentation 화면) |

---

## 1. 맥락 (Context)

콘텐츠 생성(주요 키워드), 콘텐츠 편집(해시태그), 가게 정보 관리(매장 키워드)에서 동일하게 「입력 필드 + 추가하기 + 칩 목록」 UI가 필요하다. 화면마다 `TextField`·버튼·`Wrap`을 따로 구현하면 한도(최대 10개·30자), `#` 정규화, 줄바꿈 칩 레이아웃이 어긋난다.

**결정 유발 요인**

- 해시태그/키워드 UX·검증 규칙이 피처를 가로질러 동일해야 한다.
- `#` 저장 형식·표시 형식을 한곳에서 고정해야 한다.
- `common` 승격 기준(두 개 이상 피처 재사용)에 해당한다.

---

## 2. 고려한 옵션 (Options Considered)

### 옵션 A — 화면별 입력 UI 개별 구현

**설명**: content·my_page 각각에서 입력 행과 칩 `Wrap`을 직접 작성한다.

| | 내용 |
|-|------|
| 장점 | 화면별 문구·레이아웃을 즉시 바꿀 수 있다. |
| 단점 | 한도·정규화·칩 줄바꿈이 화면마다 달라진다. |
| 위험 | 버그·UX 불일치가 반복된다. |

---

### 옵션 B — 피처 전용 위젯만 공유 (예: content 내부)

**설명**: content feature 위젯을 my_page가 import해 재사용한다.

| | 내용 |
|-|------|
| 장점 | 구현을 한곳으로 모을 수 있다. |
| 단점 | 피처 간 직접 의존이 생긴다. |
| 위험 | 레이어·피처 경계가 깨진다. |

---

### 옵션 C — `common`의 `SsossHashtagInput` (+ Limits·Normalizer·Chip) (선택)

**설명**: 입력·추가·칩을 `SsossHashtagInput`으로 묶고, 한도·정규화는 `SsossHashtagLimits` / `SsossHashtagNormalizer`에 둔다.

| | 내용 |
|-|------|
| 장점 | UX·규칙이 통일되고 피처 간 의존이 없다. |
| 단점 | 공용 API가 확장되면 여러 화면이 함께 영향을 받는다. |
| 위험 | 부모가 정규화·한도 검증을 빠뜨리면 중복·초과가 남을 수 있다. |

---

## 3. 결정 (Decision)

> **선택한 옵션**: 옵션 C — `SsossHashtagInput`

1. **해시태그/키워드 입력 UI는 `SsossHashtagInput`만 사용한다.**  
   입력 필드, `추가하기`, 칩 목록을 화면에서 다시 조립하지 않는다.

2. **저장 값은 `#` 없이 관리한다.**  
   - 추가·검증: `SsossHashtagNormalizer.normalize`  
   - 목록 초기: `SsossHashtagNormalizer.stripAll`  
   - 표시: `SsossHashtagNormalizer.display` 또는 `SsossHashtagChip`

3. **한도는 `SsossHashtagLimits`를 따른다.**  
   - 최대 개수: `maxCount` (10)  
   - 최대 글자 수( `#` 제외 ): `maxLength` (30)

4. **섹션 제목·헬퍼 문구는 화면이 소유한다.**  
   편집 화면처럼 헤더가 필요하면 `showHeader: true`와 `title` / `limitHint`를 사용한다. 생성 플로우처럼 「선택」만 보여줄 때는 헤더를 끄고 바깥에서 라벨을 그린다.

**선택 근거**

동일 UX를 여러 피처에서 쓰므로 `common`이 맞고, 정규화·한도를 컴포넌트와 같은 모듈에 두면 규칙이 흩어지지 않는다.

---

## 4. 결과 (Consequences)

### 긍정적 결과

- content·my_page 등에서 입력 UX와 한도가 일치한다.
- `#` 유무로 인한 중복·표시 불일치를 줄인다.
- 칩 줄바꿈·입력 길이 제한이 한곳에서 유지된다.

### 부정적 결과 / 감수한 트레이드오프

- 부모가 `onAdd`에서 한도·중복·normalize 실패를 처리해야 한다(토스트 등).
- 메뉴 태그처럼 「해시태그가 아닌」칩 목록은 이 컴포넌트를 쓰지 않는다.

### 후속 조치 필요 사항

- [x] `SsossHashtagInput` / Limits / Normalizer / Chip 구현
- [x] 콘텐츠 생성·편집, 가게 정보 관리 적용
- [ ] 신규 해시태그/키워드 화면은 이 ADR을 따라 적용

---

## 5. 구현 준수 사항 (AI 에이전트용)

**반드시 해야 할 것**

- 해시태그·키워드 「입력 + 추가 + 칩」 UI에는 `SsossHashtagInput`을 사용한다.
- 리스트 상태는 `#` 없는 문자열로 보관한다. 표시만 `display` / 칩에 맡긴다.
- 추가는 `SsossHashtagNormalizer.normalize` 결과를 기준으로 하고, `maxCount`·중복을 검사한다.
- 입력 길이는 `LengthLimitingTextInputFormatter(SsossHashtagLimits.maxLength)`와 normalize의 길이 검사를 함께 지킨다.
- 긴 칩이 한 줄을 넘기면 `Wrap`으로 다음 줄에 배치되도록 공용 컴포넌트 레이아웃을 유지한다.

기본 사용 패턴:

```dart
SsossHashtagInput(
  hashtags: keywords, // '#' 없음
  hintText: 'ex) 디저트맛집',
  onAdd: (raw) {
    if (keywords.length >= SsossHashtagLimits.maxCount) {
      // 토스트 등
      return;
    }
    final normalized = SsossHashtagNormalizer.normalize(raw);
    if (normalized == null || keywords.contains(normalized)) {
      return;
    }
    // state에 normalized 추가
  },
  onRemove: (tag) {
    // state에서 tag 제거
  },
)
```

헤더가 필요한 경우(편집 화면):

```dart
SsossHashtagInput(
  hashtags: hashtags,
  showHeader: true,
  title: '해시태그 편집',
  limitHint: SsossHashtagInput.defaultLimitHint,
  onAdd: onAdd,
  onRemove: onRemove,
)
```

**절대 하지 말아야 할 것**

- 화면에서 `TextField` + `추가하기` + 칩 `Wrap`을 새로 조립하지 않는다.
- 저장 리스트에 `#`을 붙여 두지 않는다 (`#태그`와 `태그`가 다른 항목으로 취급된다).
- 피처 전용 해시태그 입력 위젯을 다시 만들지 않는다. 확장이 필요하면 `common`의 `SsossHashtagInput`을 수정한다.
- 메뉴명 등 일반 태그 목록에 `SsossHashtagInput`을 억지로 쓰지 않는다.

**참고 파일**

- `lib/common/widgets/input/ssoss_hashtag_input.dart` — Limits·Normalizer·Chip·Input
- `lib/features/content/presentation/widgets/create/content_create_step_detail.dart` — 생성 키워드
- `lib/features/content/presentation/pages/content_edit_page.dart` — 해시태그 편집
- `lib/features/my_page/presentation/pages/store_info_management/store_info_management_page.dart` — 매장 키워드

---

## 6. 관련 링크

- 공식 문서: N/A
- 참고 자료: [`docs/specs/content/edit/prd.md`](../specs/content/edit/prd.md) (해시태그 한도 FR)
