# PRD — 콘텐츠 편집

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/content-edit` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-07-23 |
| 상태 | Approved |
| 관련 ADR | adr-004-template-contents-edit-card.md, adr-005-button-modal-loading-ux.md |
| 관련 TDD | [`tdd.md`](./tdd.md) |

---

## 1. 배경 및 목적

**배경**

콘텐츠 생성 결과 화면에 편집 아이콘이 있으나 동작하지 않는다. 사용자는 제목·본문·해시태그를 생성 직후 수정하고 싶어 한다.

**목적**

결과 화면에서 섹션별 편집으로 진입해 원문을 수정·초기화하고, 변경된 내용을 결과 화면 draft에 반영한다. 저장한 콘텐츠 상세(`ContentDetailPage`)에서는 수정하기 시 `PUT`으로 서버에 반영한다.

---

## 2. 사용자 스토리

- [ ] As a **가게 운영자**, I want to **결과의 제목/본문/해시태그 편집 아이콘을 눌러 편집 화면으로 이동**, so that **해당 섹션만 수정할 수 있다**.
- [ ] As a **가게 운영자**, I want to **원문과 다를 때만 수정하기가 활성화**, so that **불필요한 저장을 막을 수 있다**.
- [ ] As a **가게 운영자**, I want to **초기화로 초안을 복구**, so that **편집을 되돌릴 수 있다**.

---

## 3. 요구사항

### 3.1 기능 요구사항 (Functional Requirements)

| ID | 요구사항 | 우선순위 |
|----|---------|---------|
| FR-01 | 결과 화면 섹션별 편집 아이콘 → 편집 화면 진입 (제목/본문/해시태그) | Must |
| FR-02 | 블로그 제목 편집: `SsossContentsEditCard`, 최대 40자 | Must |
| FR-03 | 블로그 본문 편집: plain 카드, 최대 5000자 (추천사진 없음) | Must |
| FR-04 | 그 외 채널 본문: 추천사진 블록 포함 가능 (`photoGuideEnabled`), 최대 5000자 | Must |
| FR-05 | 인스타 해시태그 편집: 최대 10개, 각 30자 | Must |
| FR-06 | 원문과 다를 때만 `수정하기` 활성 | Must |
| FR-07 | 초기화 → 확인 모달 → 초안 복구 | Must |
| FR-08 | 결과 화면 `수정하기` 시 로컬 draft 반영 후 pop (API 없음). 실제 DB 저장은 결과 화면 **저장하기** `POST /v1/contents` | Must |
| FR-09 | 생성 플로우 키워드 입력에도 10개·30자 제한 적용 | Must |
| FR-10 | `ContentDetailPage` 등 저장 후 편집: `수정하기` → `PUT /v1/contents/{contentId}/channels/{contentChannelId}` (채널 title/body/hashtags 완전체) | Must |

### 3.2 비기능 요구사항 (Non-functional Requirements)

| 항목 | 요구사항 |
|------|---------|
| 성능 | 결과 편집은 로컬. 상세 PUT 시 로딩 표시 |
| 보안 | 인증된 사용자만 (기존 라우터 정책) |
| 오프라인 | 결과 로컬만. PUT은 네트워크 필요 |
| 접근성 | 기존 공용 컴포넌트 준수 |

---

## 4. 범위 (Scope)

### In Scope (이번 구현에 포함)

- 콘텐츠 결과 → 편집 화면 네비게이션 (로컬 draft)
- 채널·대상별 편집 UI
- dirty 기반 CTA, 초기화 모달
- 해시태그/키워드 10개·30자 공통 제한
- 결과 draft 로컬 반영 + 저장하기 POST (generation-api)
- ContentDetailPage 수정하기 → PUT 채널 편집

### Out of Scope (이번 구현에서 제외)

- ContentDetail 실서버 상세 GET
- 템플릿 본문 편집 (`SsossTemplateContentsEditCard`)
- 결과 화면 수정하기에서 POST/PUT 호출

---

## 5. 화면 & UX 흐름

**화면 목록**

| 화면 이름 | 설명 | Figma 링크 |
|-----------|------|-----------|
| 블로그 제목 편집 | 제목만, 40자 | [1499:15991](https://www.figma.com/design/I1DrEdPSi6LA8Skaz8flsS/CMC?node-id=1499-15991) |
| 블로그 본문 편집 | 본문만, 5000자 | [1005:17352](https://www.figma.com/design/I1DrEdPSi6LA8Skaz8flsS/CMC?node-id=1005-17352) |
| 기타 채널 본문 편집 | 추천사진 + 본문 | [1005:17418](https://www.figma.com/design/I1DrEdPSi6LA8Skaz8flsS/CMC?node-id=1005-17418) |
| 해시태그 편집 | 입력·칩 | [1005:17367](https://www.figma.com/design/I1DrEdPSi6LA8Skaz8flsS/CMC?node-id=1005-17367) |
| 초기화 모달 | 확인 | [1005:18115](https://www.figma.com/design/I1DrEdPSi6LA8Skaz8flsS/CMC?node-id=1005-18115) |

**주요 사용자 흐름**

```
[콘텐츠 생성 결과]
  → 섹션 편집 아이콘
  → [콘텐츠 편집] persist=none
      ├─ 수정하기 → pop + draft 반영
      └─ (결과) 저장하기 → POST /v1/contents

[콘텐츠 상세]
  → 섹션 편집
  → [콘텐츠 편집] persist=put
      └─ 수정하기 → PUT channel → pop + UI 반영
```

---

## 6. 엣지 케이스 & 에러 처리

| 케이스 | 기대 동작 |
|--------|----------|
| 원문과 동일 | 수정하기 비활성 |
| 해시태그 10개 초과 추가 | 추가 거부 (+ 토스트 권장) |
| 해시태그 30자 초과 | 입력 차단 또는 거부 |
| 추천사진 삭제 | dirty로 간주, 초기화 시 복구 |
| 뒤로가기 | 변경 미반영 pop |

---

## 7. 성공 지표 (Success Metrics)

- 결과 화면에서 섹션별 편집·반영이 오류 없이 동작한다.
- 수정하기는 dirty일 때만 활성이다.
- 초기화 모달 후 초안이 복구된다.

---

## 8. 의존성 & 선행 조건

- **API**: 없음 (로컬)
- **권한**: 기존 로그인
- **외부 서비스**: N/A
- **선행 기능**: 콘텐츠 생성 결과 화면
