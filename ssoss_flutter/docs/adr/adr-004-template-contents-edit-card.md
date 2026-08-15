# ADR-004 — 템플릿 콘텐츠는 SsossTemplateDocument + EditCard로 편집

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| ADR 번호 | 004 |
| 제목 | 템플릿 본문 편집은 `SsossTemplateDocument`와 `SsossTemplateContentsEditCard`를 사용한다 |
| 상태 | Accepted |
| 작성자 | 프로젝트 팀 |
| 작성일 | 2026-07-19 |
| 영향 범위 | `common` 템플릿 카드, 템플릿 본문을 편집하는 `presentation` 화면 |

---

## 1. 맥락 (Context)

템플릿 본문은 전체가 자유롭게 편집 가능해야 한다. 동시에 템플릿에 원래 있던 `[플레이스홀더]`만 주황으로 강조해, 사용자가 “채워야 할 자리”를 구분할 수 있어야 한다.

단순 문자열 Set으로 원본 `[...]`을 기억하면 다음 문제가 생긴다.

- `[최초]`에서 `]`만 지운 뒤 다시 채우거나, 전부 지운 뒤 같은 텍스트를 다시 입력하면 다시 강조된다.
- 사용자가 직접 만든 `[...]`도 원본과 문자열이 같으면 강조된다.
- 초기화 시 텍스트만 되돌리고 강조 상태를 복구하지 못하면 UX가 깨진다.

**결정 유발 요인**

- 템플릿 원본 슬롯만 강조하고, 한 번 깨진 슬롯은 다시 강조하지 않아야 한다.
- 사용자가 새로 입력한 괄호 텍스트는 강조되면 안 된다.
- 초기화 버튼으로 원본 텍스트와 강조를 함께 복구할 수 있어야 한다.
- 편집 상태(`text` + 활성 슬롯 개수)를 부모가 소유하고 카드와 동기화해야 한다.

---

## 2. 고려한 옵션 (Options Considered)

### 옵션 A — 원본 플레이스홀더 문자열 `Set`으로 매칭

**설명**: `fromTemplate` 시 `[...]` 문자열을 `Set`에 넣고, 현재 본문에 동일 문자열이 있으면 주황으로 칠한다.

| | 내용 |
|-|------|
| 장점 | 구현이 단순하다. |
| 단점 | 토큰을 깨고 다시 만들면 강조가 부활한다. 사용자 입력 괄호도 문자열이 같으면 강조된다. |
| 위험 | “한 번 편집하면 일반 텍스트”라는 제품 규칙과 어긋난다. |

---

### 옵션 B — 위치(오프셋) 기반 슬롯 모델

**설명**: 각 원본 `[...]`의 시작/끝 인덱스를 추적하고, 편집 시 오프셋을 보정한다.

| | 내용 |
|-|------|
| 장점 | 인스턴스 단위로 정확히 추적할 수 있다. |
| 단점 | 줄바꿈·중간 삽입·대량 삭제 시 오프셋 보정이 복잡하고 버그 위험이 크다. |
| 위험 | 단순 `TextField` 편집과 상태 모델이 과도하게 결합된다. |

---

### 옵션 C — 활성 발생 횟수(multiset) + `reset()` (선택)

**설명**: `SsossTemplateDocument`가 `originalTemplate`과 `activePlaceholderCounts`를 가진다. 텍스트가 바뀔 때마다 활성 개수는 `min(기존, 현재 일치 개수)`로만 줄인다. 강조는 왼쪽부터 active 개수만큼만 적용한다. 초기화는 `reset()`으로 원본을 다시 만든다.

| | 내용 |
|-|------|
| 장점 | 재입력·사용자 생성 괄호 강조를 막고, 초기화 복구가 명확하다. 오프셋 추적 없이 `TextField`와 잘 맞는다. |
| 단점 | 동일 문자 토큰이 여러 개일 때 “어느 쪽을 깼는지”는 왼쪽부터 소비로만 표현된다. |
| 위험 | 부모가 `reset()` 반환값을 state에 반영하지 않으면 UI가 갱신되지 않는다. |

---

## 3. 결정 (Decision)

> **선택한 옵션**: 옵션 C — 활성 발생 횟수(multiset) + `reset()`

1. **문서 모델은 `SsossTemplateDocument`만 사용한다.**  
   - `fromTemplate(template)`로 생성한다.  
   - `originalTemplate`에 원본 문자열을 보관한다.  
   - `activePlaceholderCounts`에 아직 강조 가능한 `[...]` 토큰별 잔여 개수를 둔다.

2. **편집 UI는 `SsossTemplateContentsEditCard`를 사용한다.**  
   - `document`와 `onDocumentChanged`로 부모 state를 갱신한다.  
   - 카드가 `copyWith(text:)`를 호출하면 active 개수는 자동으로 줄어든다.

3. **초기화는 `document.reset()` 결과를 부모 state에 다시 넣는다.**  
   - `reset()`은 새 문서를 반환하므로, 호출만 하고 버리면 UI가 바뀌지 않는다.

4. **읽기 전용 표시는 `SsossTemplateContentsCard` + 동일 `SsossTemplateDocument`를 사용한다.**

**선택 근거**

오프셋 추적 없이도 “깨지면 다시 안 켜짐 / 초기화로만 복구”를 만족한다. 공용 카드와 문서 모델에 규칙을 모아 두면 화면마다 강조 로직을 다시 구현하지 않아도 된다.

---

## 4. 결과 (Consequences)

### 긍정적 결과

- 템플릿 원본 슬롯만 주황으로 표시되고, 깨진 슬롯·사용자 입력 괄호는 기본 색을 유지한다.
- 초기화 시 텍스트와 강조가 함께 복구된다.
- 편집/표시 카드가 같은 문서 모델을 공유한다.

### 부정적 결과 / 감수한 트레이드오프

- 동일 토큰이 여러 개일 때 인스턴스 identity는 없고, 개수(multiset)만 관리한다.
- 부모가 document state와 `onDocumentChanged` / `reset()` 반영을 빠뜨리면 동기화가 깨진다.

### 후속 조치 필요 사항

- [x] `SsossTemplateDocument` active count / `reset()` 구현
- [x] `SsossTemplateContentsEditCard` sync (텍스트·active 복구)
- [ ] 실제 편집 페이지에서 초기화 CTA를 `document.reset()` state 반영으로 연결

---

## 5. 구현 준수 사항 (AI 에이전트용)

> 이 ADR을 읽는 AI 에이전트가 구현 시 반드시 준수해야 할 규칙을 명시한다.

**반드시 해야 할 것**

- 템플릿 본문 편집에는 `SsossTemplateContentsEditCard`를 사용한다.
- 문서는 반드시 `SsossTemplateDocument.fromTemplate(...)`로 만든다.
- 부모(또는 Cubit)가 document를 소유하고, `onDocumentChanged`로 갱신한다.
- 초기화 시 `setState` / emit 등으로 **`document = document.reset()` 결과를 반영**한 뒤 카드에 다시 넘긴다.

기본 사용 패턴:

```dart
class _ExampleState extends State<_Example> {
  late SsossTemplateDocument document = SsossTemplateDocument.fromTemplate(
    '고정 문구\n가격: [가격]원\n뒤',
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SsossTemplateContentsEditCard(
          document: document,
          onDocumentChanged: (value) {
            setState(() => document = value);
          },
        ),
        ElevatedButton(
          onPressed: () {
            setState(() => document = document.reset());
          },
          child: const Text('초기화'),
        ),
      ],
    );
  }
}
```

강조 규칙:

- 원본 `[...]`만 주황(`emptySlotColor`, 기본 `AppColors.primary300`).
- 원본 토큰이 본문에서 사라지거나 개수가 줄면 active가 감소하며, 이후 같은 문자열을 다시 만들어도 강조하지 않는다.
- 사용자가 새로 입력한 `[...]`는 active를 늘리지 않으므로 강조하지 않는다.
- `reset()`으로만 원본 텍스트·강조를 복구한다.

**절대 하지 말아야 할 것**

- `document.reset()` 반환값을 버리고 호출만 하지 않는다.
- 원본 강조를 위해 화면에서 `RegExp(r'\[[^\]]*\]')`로 직접 칠하지 않는다. (`SsossTemplateDocument.buildStyledSpans` / 카드에 맡긴다)
- active 개수를 편집 중 임의로 증가시키지 않는다.
- 일반 자유 작성 본문에 템플릿 편집 카드를 쓰지 않는다. (일반 편집은 `SsossContentsEditCard`)

**참고 파일**

- `lib/common/widgets/card/template/ssoss_template_document.dart` — 문서 모델·강조·`reset()`
- `lib/common/widgets/card/ssoss_template_contents_edit_card.dart` — 편집 카드
- `lib/common/widgets/card/ssoss_template_contents_card.dart` — 읽기 전용 카드
- `test/common/widgets/card/template/ssoss_template_document_test.dart` — 강조/초기화 규칙 테스트
- `test/common/widgets/card/ssoss_template_contents_edit_card_test.dart` — 편집·reset sync 테스트

---

## 6. 관련 링크

- 공식 문서: N/A
- 참고 자료: N/A
