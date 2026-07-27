# PRD — 콘텐츠 생성 API 연동

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/content-generation-api` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-07-27 |
| 상태 | Approved |
| 관련 ADR | N/A |
| 관련 TDD | [`tdd.md`](./tdd.md) |
| 선행 PRD | [`../create/prd.md`](../create/prd.md), [`../other-channel/prd.md`](../other-channel/prd.md) |

---

## 1. 배경 및 목적

**배경**

콘텐츠 생성 UI(위저드·생성 중·결과·저장)는 구현되어 있으나, 백엔드 API는 Demo 스텁(2초 지연 더미)으로 동작한다. 실제 생성 작업 API(`/v1/generations`)·조회·저장(`/v1/contents`) 연동이 필요하다.

**목적**

사용자가 입력한 조건으로 AI 콘텐츠 생성 작업을 시작하고, 폴링으로 결과를 받아 결과 화면에 표시한 뒤, 수정한 내용을 포함해 콘텐츠로 저장할 수 있게 한다. 생성 실패 시 전용 화면을 제공한다.

---

## 2. 사용자 스토리

- [ ] As a **가입 회원**, I want to **콘텐츠 생성하기를 누르면 서버에 생성 작업이 시작**되고, so that **실제 AI 콘텐츠 결과를 받을 수 있다**.
- [ ] As a **가입 회원**, I want to **생성이 실패하면 안내 화면에서 닫기 또는 다시 시도**할 수 있어, so that **다음 행동을 명확히 알 수 있다**.
- [ ] As a **가입 회원**, I want to **결과 화면에서 채널별 콘텐츠를 확인·로컬 편집 후 저장**할 수 있어, so that **원하는 내용으로 콘텐츠를 보관할 수 있다**.
- [ ] As a **가입 회원**, I want to **채널별 글자 수 상한을 넘기지 않도록 편집·저장이 제한**되면, so that **플랫폼별 제약에 맞는 콘텐츠만 저장할 수 있다**.

---

## 3. 요구사항

### 3.1 기능 요구사항

| ID | 요구사항 | 우선순위 |
|----|---------|---------|
| FR-01 | `POST /v1/generations`로 생성 작업을 시작하고 `generationId`를 받는다. | Must |
| FR-02 | `GET /v1/generations/{generationId}`를 반복 호출해 `IN_PROGRESS`가 풀릴 때까지 대기한다. (클라이언트 폴링 간격·중단은 앱 책임) | Must |
| FR-03 | `status == SUCCEEDED`이면 채널별 결과를 결과 화면에 표시한다. `results`는 요청 채널 순서 그대로 사용한다. | Must |
| FR-04 | `status == FAILED` 또는 네트워크/타임아웃 시 [Figma 실패 화면](https://www.figma.com/design/I1DrEdPSi6LA8Skaz8flsS/CMC?node-id=1543-8009)을 표시한다. | Must |
| FR-05 | 실패 화면 **닫기** → 홈. **다시 시도하기** → `POST /v1/generations` 재호출. | Must |
| FR-06 | 생성 중 **나가기** → 클라이언트 폴링 중단 후 홈 이동. | Must |
| FR-07 | 본문의 `<photo-guide />` 태그는 파싱해 추천 사진 카드로 표시하고, 사용자에게 태그 문자열을 노출하지 않는다. | Must |
| FR-08 | `POST /v1/contents`로 `generationId`와 **채널 단위 완전체**(각 채널 title/body/hashtags)를 담아 저장한다. 작업의 전 채널을 빠짐없이 포함한다. | Must |
| FR-09 | 결과 화면 편집(`ContentEditPage`)은 **해당 채널** 로컬 draft만 갱신한다. PUT은 [`../edit/`](../edit/) — `ContentDetailPage`. | Must |
| FR-10 | 채널별 글자 수 상한(§4)을 편집 입력·수정하기·저장하기에서 초과할 수 없다. | Must |
| FR-11 | 다른 채널용 생성 시 `sourceContentId`를 generations 요청에 포함한다. | Must |

### 3.2 비기능 요구사항

| 항목 | 요구사항 |
|------|---------|
| 인증 | ACTIVE 회원 accessToken (기존 Dio 인터셉터) |
| 폴링 | 2~3초 간격, 작업 60초 상한(서버)에 맞춰 클라이언트도 타임아웃 처리 |
| 에러 | 서버 `message` 필드를 toast/실패 UI에 표시 |

---

## 4. 채널별 글자 수 상한

| 채널 | 제목 | 본문 |
|------|------|------|
| 블로그 | 40자 | 2,000자 |
| 인스타그램 | — | 700자 |
| 당근 비즈 | — | 400자 |
| 스레드 | — | 500자 |

- 결과 카드: API 응답 그대로 표시 (truncate 없음)
- 편집: `SsossContentsEditCard` `maxLength` + `canSubmit` 검증
- 저장: POST 전 draft 재검증

[`../edit/tdd.md`](../edit/tdd.md) §5.6과 동일.

---

## 5. 범위

### In Scope

- generations 시작·폴링·실패 UI
- 결과 API 데이터 표시·photo-guide 파싱
- POST contents 저장 (수정본 포함)
- 채널별 글자 상한 (`ContentChannelLimits`)
- 일반 생성 · 다른 채널 생성 진입

### Out of Scope

- `PUT /v1/contents/{contentId}/channels/{contentChannelId}` — [`../edit/`](../edit/) 스펙에서 구현
- 결과 화면 `ContentEditPage`에서 서버 호출 (로컬 draft → 저장하기 POST)

---

## 6. UX 흐름

```
[입력 완료] → [생성 중] → (성공) [결과] → [저장 완료]
                  ↓ (실패)
            [생성 실패] → 닫기(홈) / 다시 시도
```

---

## 7. 관련 문서

- [`../create/tasks.md`](../create/tasks.md) Phase 7 → 본 스펙으로 위임
- [`tdd.md`](./tdd.md), [`tasks.md`](./tasks.md)
