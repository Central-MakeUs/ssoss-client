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

저장한 콘텐츠를 원본으로 삼아, 아직 만들지 않은 SNS 채널용 글을 이어 만들고 싶다. 목적·톤·강조·금지·키워드·사진 가이드는 앱이 다시 보내지 않고, 원본을 만든 생성 작업 입력을 서버가 이어받는다.

**목적**

저장 콘텐츠 상세에서 「다른 채널용으로 만들기」로 진입해, 남은 채널(1~3개)을 선택·생성·저장까지 이어갈 수 있게 한다.

---

## 2. 사용자 스토리

- [x] As a **가게 운영자**, I want to **저장 콘텐츠 상세에서 남은 채널을 선택해 생성**, so that **같은 입력으로 다른 SNS용 문구를 받을 수 있다**.
- [x] As a **가게 운영자**, I want to **다시 생성하기로 동일 채널을 재생성**, so that **채널을 다시 고르지 않고 결과를 받을 수 있다**.
- [x] As a **가게 운영자**, I want to **다른 채널 선택 화면에서 뒤로가기 시 상세로 복귀(또는 홈 확인)**, so that **실수로 이탈하지 않는다**.

---

## 3. 요구사항

### 3.1 기능 요구사항

| ID | 요구사항 | 우선순위 |
|----|---------|---------|
| FR-01 | 저장 콘텐츠 상세에서 「다른 채널용으로 만들기」로 채널 선택 화면에 진입한다. (이미 전 채널이 있으면 CTA 숨김) | Must |
| FR-02 | 경로에 현재 탭의 `contentId`·`contentChannelId`를 넣고, 요청 본문은 새로 고를 채널 목록만 담는다. | Must |
| FR-03 | 채널 선택 화면은 이미 저장된 채널을 제외하고 1~3개 멀티 선택한다. | Must |
| FR-04 | 「선택한 채널로 만들기」로 생성 중 → 결과 화면으로 이동한다. (목적·톤 등은 서버가 원본 생성 작업에서 이어받음) | Must |
| FR-05 | 결과 앱바 타이틀은 `다른 채널용 생성 결과`. 멀티 채널이면 기존 탭바를 쓴다. | Must |
| FR-06 | 다시 생성하기 모달 확인 시 동일 conversion args로 생성 중 화면을 다시 띄운다. | Must |
| FR-07 | 저장하면 `finalSave`와 동일하게 저장 완료(저장 내역 CTA만)로 이동한다. | Must |
| FR-08 | 저장 완료 화면에는 「다른 채널용으로 만들기」 CTA를 두지 않는다. | Must |

### 3.2 비기능 요구사항

| 항목 | 요구사항 |
|------|---------|
| API | `POST /v1/contents/{contentId}/channels/{contentChannelId}/conversions` → `generationId` 후 기존 generations 폴링·저장 |
| UI | Figma CMC 다른 채널용 생성 화면 기준 |

---

## 4. 범위

### In Scope

- 다른 채널 선택 페이지·네비·결과 모드·다시 생성하기
- conversions API 연동
- 저장 콘텐츠 상세 진입점

### Out of Scope

- 저장 완료에서 이어만들기 CTA
- 일반 `POST /v1/generations`의 `sourceContentId`로 다른 채널 생성

---

## 5. UX 흐름

```
ContentDetail(현재 탭 contentChannelId)
  → OtherChannelCreate (남은 채널 1~3 선택)
  → Generating (conversions → poll)
  → Result(otherChannel)
       ├─ 다시 생성하기 → Generating (동일 conversion args)
       └─ 저장하기 → SaveComplete (저장 내역만)
OtherChannelCreate back → pop(상세) 또는 홈 확인 모달
```
