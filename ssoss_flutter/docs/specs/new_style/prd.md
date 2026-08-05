# PRD — 이 스타일로 새로 만들기

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/new-style` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-08-05 |
| 상태 | Approved |
| 관련 ADR | adr-003-page-app-bar-safe-area.md, adr-006-ssoss-hashtag-input.md, adr-010-ssoss-button-type-styling.md |
| 관련 TDD | [`tdd.md`](./tdd.md) |

---

## 1. 배경 및 목적

**배경**

저장 콘텐츠 상세·생성 관리에 「이 스타일로 새로 만들기」버튼이 있으나 동작이 없다. 기존 글의 말투·구성을 참고해 새 입력으로 콘텐츠를 만들고 싶다.

**목적**

확인 모달 → 채널 멀티 선택 → 원본 참고 배너 + 상세 입력 화면까지 진입할 수 있게 한다. 업로드 API·결과 화면 연동은 추후.

---

## 2. 사용자 스토리

- [ ] As a **가게 운영자**, I want to **저장된 콘텐츠 스타일을 참고해 새 생성을 시작**, so that **말투·구성을 이어 새 내용을 작성할 수 있다**.
- [ ] As a **가게 운영자**, I want to **채널을 여러 개 선택**, so that **한 번에 여러 채널용 문구를 준비할 수 있다**.
- [ ] As a **가게 운영자**, I want to **강조·금지·키워드를 직접 입력**, so that **매장 저장 정보가 자동으로 채워지지 않는다**.

---

## 3. 요구사항

### 3.1 기능 요구사항

| ID | 요구사항 | 우선순위 |
|----|---------|---------|
| FR-01 | 상세·생성 관리 「이 스타일로 새로 만들기」에서 확인 모달을 띄운다. | Must |
| FR-02 | 모달 primary「생성하러 가기」로 채널 선택 화면에 진입한다. | Must |
| FR-03 | 채널 선택 화면은 전체 4채널 멀티 선택. 「다음」은 1개 이상 선택 시 활성. | Must |
| FR-04 | 상세 화면 상단에 「참고한 콘텐츠」를 표시한다. 블로그는 제목, 그 외는 본문. 너비 초과 시 `...`. | Must |
| FR-05 | 상세 입력은 `ContentCreateStepDetail`과 동일 레이아웃·글자 수. 매장 prefill 없음(빈 값). | Must |
| FR-06 | 「콘텐츠 생성하기」버튼은 UI만 두고 액션(API·네비)은 넣지 않는다. | Must |

### 3.2 비기능 요구사항

| 항목 | 요구사항 |
|------|---------|
| 네비게이션 | 모달 확인 후 `context.push` |
| UI | Figma CMC 스타일 재사용 화면 기준 |
| 접근성 | 기존 공용 컴포넌트 준수 |

---

## 4. 범위

### In Scope

- 확인 모달, 채널 선택 + 상세 2스텝 페이지, 참고 배너, 진입 연결(상세·생성 관리)
- Cubit·route args·라우터 등록
- 추후용 `buildCreateInput` (생성 버튼에는 미연결)

### Out of Scope

- 업로드 API·`ContentGeneratingPage`·`ContentResultPage` 네비
- `ContentCreateFlow` / `ContentResultPage` 변경
- 목적·톤 선택 UI
- StoreCubit `ContentCreatePrefill` 연동

---

## 5. UX 흐름

```
Detail / Management
  → Modal (스타일 참고 확인)
  → NewStyle (channel)
  → NewStyle (detail)
  → [추후] Generating → Result(flow: initial)
```

| 화면 | Figma |
|------|-------|
| 확인 모달 | node 1927-9072 |
| 채널 선택 | node 2192-9297 |
| 콘텐츠 생성 상세 | node 1927-8982 |
