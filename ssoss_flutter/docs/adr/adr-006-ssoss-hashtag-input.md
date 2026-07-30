# ADR-006 — 해시태그·키워드·칩 목록 입력은 SsossHashtagInput으로 통일한다

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| ADR 번호 | 006 |
| 제목 | 해시태그·키워드·대표 메뉴 등 「입력 + 추가하기 + 칩 목록」 UI는 `SsossHashtagInput`으로 통일한다 |
| 상태 | Accepted |
| 작성자 | ahndohyeon |
| 작성일 | 2026-07-24 |
| 최종 개정 | 2026-07-31 |
| 영향 범위 | 전체 프로젝트 (`common` 해시태그 입력, content·my_page 등 칩 목록 추가 UI가 있는 presentation 화면) |

---

## 1. 맥락 (Context)

콘텐츠 생성(주요 키워드), 콘텐츠 편집(해시태그), 가게 정보 관리(매장 키워드·대표 메뉴)에서 동일하게 「텍스트 입력 필드 + 추가하기 버튼 + 삭제 가능한 칩 목록」 UI가 필요하다. 화면마다 `TextField`·버튼·`Wrap`을 따로 구현하면 한도(최대 10개·30자), `#` 정규화, 줄바꿈 칩 레이아웃이 어긋난다.

Figma MCP·디자인 컨텍스트·레이아웃 스케치가 들어올 때도 같은 패턴이 자주 보이는데, 그때마다 커스텀 Row/Chip을 새로 짜면 공용 컴포넌트와 어긋난다.

**결정 유발 요인**

- 해시태그/키워드/칩 목록 UX·검증 규칙이 피처를 가로질러 동일해야 한다.
- `#` 저장 형식·표시 형식을 한곳에서 고정해야 한다.
- `common` 승격 기준(두 개 이상 피처 재사용)에 해당한다.
- 디자인·레이아웃 컨텍스트에서 패턴을 인식하면 즉시 `SsossHashtagInput`으로 매핑할 수 있어야 한다.

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

**설명**: 입력·추가·칩을 `SsossHashtagInput`으로 묶고, 한도·정규화는 `SsossHashtagLimits` / `SsossHashtagNormalizer`에 둔다. 도메인 라벨이 「해시태그」「키워드」「대표 메뉴」여도 UI 패턴이 같으면 동일 컴포넌트를 쓴다.

| | 내용 |
|-|------|
| 장점 | UX·규칙이 통일되고 피처 간 의존이 없다. |
| 단점 | 공용 API가 확장되면 여러 화면이 함께 영향을 받는다. |
| 위험 | 부모가 정규화·한도 검증을 빠뜨리면 중복·초과가 남을 수 있다. |

---

## 3. 결정 (Decision)

> **선택한 옵션**: 옵션 C — `SsossHashtagInput`

1. **「텍스트 입력 + 추가하기 + 삭제 가능 칩 목록」 UI는 `SsossHashtagInput`만 사용한다.**  
   입력 필드, `추가하기`, 칩 목록을 화면에서 다시 조립하지 않는다.  
   적용 예: 해시태그, 매장/콘텐츠 키워드, 대표 메뉴 등 **같은 인터랙션 패턴**.

2. **저장 값은 `#` 없이 관리한다.**  
   - 추가·검증: `SsossHashtagNormalizer.normalize`  
   - 목록 정제: `SsossHashtagNormalizer.stripAll`  
   - 표시: `SsossHashtagNormalizer.display` 또는 `SsossHashtagChip`

3. **한도는 `SsossHashtagLimits`를 따른다.**  
   - 최대 개수: `maxCount` (10)  
   - 최대 글자 수( `#` 제외 ): `maxLength` (30)

4. **섹션 제목·헬퍼 문구는 화면이 소유한다.**  
   편집 화면처럼 컴포넌트 내부 헤더가 필요하면 `showHeader: true`와 `title` / `limitHint`를 사용한다.  
   생성·가게 정보처럼 바깥 `StoreInfoSectionTitle` 등으로 라벨을 그릴 때는 `showHeader: false`(기본)로 둔다.

5. **삭제 가능한 칩만 따로 필요할 때도 `SsossHashtagChip`을 쓴다.**  
   입력 행 없이 칩만 그리는 경우에도 칩 UI를 새로 만들지 않는다.

**선택 근거**

동일 UX를 여러 피처·도메인 라벨에서 쓰므로 `common`이 맞고, 정규화·한도를 컴포넌트와 같은 모듈에 두면 규칙이 흩어지지 않는다. Figma·레이아웃에서 패턴만 보이면 컴포넌트 매핑이 가능하다.

---

## 4. 결과 (Consequences)

### 긍정적 결과

- content·my_page 등에서 입력 UX와 한도가 일치한다.
- `#` 유무로 인한 중복·표시 불일치를 줄인다.
- 칩 줄바꿈·입력 길이 제한이 한곳에서 유지된다.
- 디자인/레이아웃 컨텍스트에서 패턴 인식 → 공용 컴포넌트 적용이 명확하다.

### 부정적 결과 / 감수한 트레이드오프

- 부모가 `onAdd`에서 한도·중복·normalize 실패를 처리해야 한다(토스트 등).
- 읽기 전용 해시태그 나열(복사·추천 템플릿 카드 등)은 이 컴포넌트의 범위가 아니다. 편집·추가가 없는 표시는 기존 카드/칩 UI를 유지한다.

### 후속 조치 필요 사항

- [x] `SsossHashtagInput` / Limits / Normalizer / Chip 구현
- [x] 콘텐츠 생성·편집, 가게 정보 관리(키워드·대표 메뉴) 적용
- [ ] 신규 「입력 + 추가 + 칩」 화면은 이 ADR을 따라 적용

---

## 5. 구현 준수 사항 (AI 에이전트용)

> Figma MCP(`get_design_context` / 스크린샷), 레이아웃 스케치, 피처 코드에 **아래 시그니처가 보이면** 이 ADR을 확인하고 `SsossHashtagInput`을 적용한다. 화면 제목이 「메뉴」「키워드」여도 패턴이 같으면 동일하다.

### 5.1 패턴 인식 — 이 컴포넌트를 쓸 때

다음 중 **둘 이상**이 보이면 `SsossHashtagInput` 후보로 본다.

| 시그니처 | Figma / 디자인에서 | 레이아웃·코드에서 |
|----------|-------------------|-------------------|
| 입력 + CTA | 한 줄에 텍스트 필드와 「추가하기」(또는 Add) 버튼 | `Row(TextField, Button('추가하기'))` |
| 칩 목록 | `#` 접두 또는 둥근 pill/chip, 옆에 X/닫기 아이콘 | `Wrap` + `Chip` / 커스텀 pill + `icClose` |
| 한도 문구 | 「최대 N개」, 「N자 제한」 헬퍼 | `helperText` / `최대 10개` |
| 도메인 라벨 | 해시태그, 키워드, 태그, 대표 메뉴, 강점 키워드 등 | `hashtags` / `keywords` / `menus` 리스트 state |
| 편집 흐름 | 항목 추가·삭제 가능한 태그 에디터 | `onAdd` / `onRemove` 콜백이 필요한 UI |

**즉시 적용 규칙**

1. 위 패턴이면 `TextField` + `SsossButton` + `Wrap`을 **새로 조립하지 않는다** → `SsossHashtagInput` 사용.
2. 섹션 타이틀(「매장 키워드」「대표 메뉴」「해시태그 편집」)은 페이지/부모에 두고, 입력·칩만 컴포넌트에 맡긴다.
3. Figma에 `#태그`로 그려져 있어도 **state에는 `#` 없이** 저장하고, 표시는 Normalizer/Chip에 맡긴다.
4. 높이·내부 패딩·칩 radius는 컴포넌트 기본값을 따르고, 호출부에서 입력 행을 다시 그리지 않는다. (관련: ADR-009)

### 5.2 패턴 제외 — 이 컴포넌트를 쓰지 않을 때

- **읽기 전용** 해시태그 나열(복사 버튼만 있는 추천 세트, 결과 카드 본문 블록 등) — 추가/삭제 입력이 없음.
- 단일 줄 일반 `SsossTextField`(칩·추가하기 없음).
- 필터/검색용 선택 칩(토글만 있고 자유 텍스트 추가가 없음).

### 5.3 반드시 해야 할 것

- 「입력 + 추가 + 삭제 가능 칩」 UI에는 `SsossHashtagInput`을 사용한다.
- 리스트 상태는 `#` 없는 문자열로 보관한다. 표시만 `display` / 칩에 맡긴다.
- 추가는 `SsossHashtagNormalizer.normalize` 결과를 기준으로 하고, `maxCount`·중복을 검사한다.
- 입력 길이는 컴포넌트 내부 formatter와 normalize의 길이 검사를 함께 지킨다.
- 긴 칩이 한 줄을 넘기면 `Wrap`으로 다음 줄에 배치되도록 공용 컴포넌트 레이아웃을 유지한다.

기본 사용 패턴 (섹션 타이틀은 바깥):

```dart
StoreInfoSectionTitle(
  title: '매장 키워드', // 또는 '대표 메뉴' 등
  helperText: SsossHashtagInput.defaultLimitHint,
),
const SizedBox(height: 8),
SsossHashtagInput(
  hashtags: keywords, // '#' 없음 — menus 등도 동일
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

헤더가 컴포넌트 안에 필요한 경우(편집 화면):

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

### 5.4 절대 하지 말아야 할 것

- 화면에서 `TextField` + `추가하기` + 칩 `Wrap`을 새로 조립하지 않는다.
- Figma에 필드·추가 버튼·칩이 그려져 있다고 해서 픽셀 단위로 커스텀 Row를 재구현하지 않는다.
- 저장 리스트에 `#`을 붙여 두지 않는다 (`#태그`와 `태그`가 다른 항목으로 취급된다).
- 피처 전용 해시태그/키워드/메뉴 입력 위젯을 다시 만들지 않는다. 확장이 필요하면 `common`의 `SsossHashtagInput`을 수정한다.
- 읽기 전용 표시에 편집용 `SsossHashtagInput`을 억지로 쓰지 않는다.

### 5.5 참고 파일

- `lib/common/widgets/input/ssoss_hashtag_input.dart` — Limits·Normalizer·Chip·Input
- `lib/features/content/presentation/widgets/create/content_create_step_detail.dart` — 생성 키워드
- `lib/features/content/presentation/pages/content_edit_page.dart` — 해시태그 편집
- `lib/features/my_page/presentation/pages/store_info_management/store_info_management_page.dart` — 매장 키워드·대표 메뉴

---

## 6. 관련 링크

- 공식 문서: N/A
- 참고 자료: [`docs/specs/content/edit/prd.md`](../specs/content/edit/prd.md) (해시태그 한도 FR)
- 관련 ADR: [`adr-009-common-component-sizing.md`](adr-009-common-component-sizing.md)
