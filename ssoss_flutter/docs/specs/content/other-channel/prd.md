# PRD — 다른 채널용 콘텐츠 생성

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/content-other-channel` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-07-18 |
| 상태 | Approved |
| 관련 ADR | N/A |
| 관련 TDD | [`tdd.md`](./tdd.md) |

---

## 1. 배경 및 목적

**배경**

최초 콘텐츠를 일부 채널만 생성·저장한 뒤, 남은 채널용 문구를 이어 만들고 싶다. 기존 3단계 위저드를 다시 밟지 않고, 저장된 입력(목적·톤·강조 등)을 재사용해 채널만 고르는 흐름이 필요하다.

**목적**

저장 완료(`continueAvailable`)에서 「다른 채널용으로 만들기」로 진입해, 남은 채널을 선택·생성·저장(finalSave)까지 이어갈 수 있게 한다.

---

## 2. 사용자 스토리

- [x] As a **가게 운영자**, I want to **저장 완료 후 남은 채널을 선택해 생성**, so that **같은 입력으로 다른 SNS용 문구를 받을 수 있다**.
- [x] As a **가게 운영자**, I want to **다시 생성하기로 동일 채널을 재생성**, so that **채널을 다시 고르지 않고 결과를 받을 수 있다**.
- [x] As a **가게 운영자**, I want to **다른 채널 선택 화면에서 뒤로가기 시 확인 후 홈으로**, so that **실수로 이탈하지 않는다**.

---

## 3. 요구사항

### 3.1 기능 요구사항

| ID | 요구사항 | 우선순위 |
|----|---------|---------|
| FR-01 | 저장 완료 `continueAvailable`에서 「다른 채널용으로 만들기」로 채널 선택 화면에 진입한다. | Must |
| FR-02 | 채널 선택 화면은 이미 생성·저장된 채널을 제외하고 멀티 선택한다. | Must |
| FR-03 | 「선택한 채널로 만들기」로 생성 중 → 결과 화면으로 이동한다. (목적·톤·세부 입력은 이전 input 재사용) | Must |
| FR-04 | 결과 앱바 타이틀은 `다른 채널용 생성 결과`. 멀티 채널이면 기존 탭바를 쓴다. | Must |
| FR-05 | 다시 생성하기 모달 확인 시 동일 채널 input으로 생성 중 화면을 다시 띄운다. (채널 재선택 없음) | Must |
| FR-06 | 다른 채널 결과에서 저장하면 `finalSave` 저장 완료로 이동한다. | Must |
| FR-07 | 채널 선택 화면 뒤로가기 시 홈 이탈 확인 모달 후 홈으로 이동한다. | Must |

### 3.2 비기능 요구사항

| 항목 | 요구사항 |
|------|---------|
| 네비게이션 | `context.go` 기반. 생성 중은 기존 2초 더미 타이머 유지 |
| UI | Figma CMC 다른 채널용 생성 화면 기준 |

---

## 4. 범위

### In Scope

- 다른 채널 선택 페이지·네비·결과 모드·다시 생성하기 재생성
- `SsossContentsCard` blocks 전용 API

### Out of Scope

- 저장 내역 보기 실제 네비
- 실제 생성 API 연동
- 본문 편집 진입

---

## 5. UX 흐름

```
SaveComplete(continueAvailable)
  → OtherChannelCreate (남은 채널 선택)
  → Generating
  → Result(otherChannel)
       ├─ 다시 생성하기 → Generating (동일 channels)
       └─ 저장하기 → SaveComplete(finalSave)
OtherChannelCreate back → 모달 → Home
```
