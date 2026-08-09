# PRD — 추천 템플릿 목록·상세·적용·저장

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/template-catalog` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-08-08 |
| 상태 | Approved |
| 관련 ADR | adr-003-page-app-bar-safe-area.md, adr-004-template-contents-edit-card.md, adr-005-button-modal-loading-ux.md, adr-007-tab-bar-page-view.md, adr-010-ssoss-button-type-styling.md |
| 관련 TDD | [`tdd.md`](./tdd.md) |

---

## 1. 배경 및 목적

**배경**

추천 콘텐츠 소스의 템플릿 탭·상세·적용·저장 화면은 더미 데이터와 클라이언트 치환만 사용한다. 운영자가 심은 추천 템플릿을 실 API로 조회하고, 내 매장 정보로 채운 본문을 저장할 수 있어야 한다.

**목적**

템플릿 목록·상세·적용·저장을 실 API에 연결하고, 저장 완료 후 콘텐츠 생성 관리의 템플릿 탭으로 이동할 수 있게 한다.

---

## 2. 사용자 스토리

- [ ] As a **가게 운영자**, I want to **추천 템플릿 카드 목록을 분류별로 보고**, so that **우리 가게에 맞는 글을 고를 수 있다**.
- [ ] As a **가게 운영자**, I want to **카드를 눌러 본문과 예시를 보고**, so that **적용하기 전에 내용을 확인할 수 있다**.
- [ ] As a **가게 운영자**, I want to **적용하기를 눌러 매장 정보가 채워진 본문을 편집하고**, so that **바로 쓸 수 있는 글을 만들 수 있다**.
- [ ] As a **가게 운영자**, I want to **저장하기를 눌러 내 글로 남기고**, so that **저장 내역에서 다시 볼 수 있다**.
- [ ] As a **가게 운영자**, I want to **생성 관리 템플릿 탭에서 저장한 글을 다시 보고**, so that **예전에 저장한 글을 꺼내 쓸 수 있다**.

---

## 3. 요구사항

### 3.1 기능 요구사항 (Functional Requirements)

| ID | 요구사항 | 우선순위 |
|----|---------|---------|
| FR-01 | 템플릿 탭 진입 시 `GET /v1/templates` 로 목록 조회 (page=0, size=20). 「전체」는 category 생략 | Must |
| FR-02 | 카드에 title, description, recommendedChannels 배지, bookmarked 아이콘 표시 | Must |
| FR-03 | 분류 칩 변경 시 해당 category 로 page=0 재조회. 홈 바로가기의 초기 분류를 그대로 사용 | Must |
| FR-04 | `hasNext` 가 true 인 동안 하단 스크롤 시 다음 page 조회 | Must |
| FR-05 | 카드 탭 시 `GET /v1/templates/{templateId}` 로 상세 조회. body 미리보기 + exampleBody 예시 | Must |
| FR-06 | 적용하기 시 `GET /v1/templates/{templateId}/applied` 후 적용 화면에 받은 body 표시 | Must |
| FR-07 | 저장하기 시 `POST /v1/saved-templates` (templateId, 화면 본문). 성공 시 완료 페이지 | Must |
| FR-08 | 완료 화면 「저장 내역 보기」는 홈 대시보드 + 생성 관리 템플릿 탭으로 진입 | Must |
| FR-09 | bookmarked 는 조회 결과만 표시. 북마크 추가/삭제 API는 호출하지 않음 | Must |
| FR-10 | ACTIVE 회원 accessToken 전용 (기존 Dio 인터셉터) | Must |
| FR-11 | 생성 관리 템플릿 탭 진입 시 `GET /v1/saved-templates` (sort, page=0, size=10). 채널·분류 필터 없음 | Must |
| FR-12 | 카드 탭 시 `GET /v1/saved-templates/{savedTemplateId}` 로 상세 조회. body·recommendedChannels 표시 | Must |
| FR-13 | 카드 점 3개 메뉴는 콘텐츠 탭과 동일(이름 수정·삭제 모달). 삭제·이름 수정 API는 호출하지 않음 | Must |

### 3.2 비기능 요구사항 (Non-functional Requirements)

| 항목 | 요구사항 |
|------|---------|
| 성능 | 목록·상세·적용·저장·저장 내역 CTA 로딩 인디케이터 |
| 보안 | ACTIVE 회원 accessToken |
| 오프라인 | 네트워크 필요. 캐시 없음 |
| 접근성 | 기존 카드·버튼 패턴 유지 |

---

## 4. 범위 (Scope)

### In Scope (이번 구현에 포함)

- `template` 피처 data/domain (목록·상세·적용·저장·저장 내역 조회)
- 추천 콘텐츠 소스 템플릿 탭 연동
- 상세·적용·저장 화면 실 API 연동
- 저장 완료 → 생성 관리 템플릿 탭 진입
- 생성 관리 템플릿 탭 저장 글 목록·상세 조회
- 저장 글 카드 점 3개 메뉴(이름 수정·삭제 모달 UI만)

### Out of Scope (이번 구현에서 제외)

- 북마크 추가/삭제 API
- 저장 템플릿 삭제·이름 수정 API
- 마이페이지 저장 소스 템플릿 북마크 목록
- 템플릿 탭 서버 검색 (API keyword 없음)
- 저장 내역 채널·분류 필터 (API 없음)

---

## 5. 화면 & UX 흐름

**화면 목록**

| 화면 이름 | 설명 | Figma 링크 |
|-----------|------|-----------|
| 추천 콘텐츠 소스 (템플릿 탭) | 분류 칩 + 카드 목록 | N/A |
| 템플릿 미리보기 | 본문·예시·적용하기 | N/A |
| 템플릿 적용 | 채워진 본문 편집·저장 | N/A |
| 저장 완료 | 저장 내역 / 다른 템플릿 | N/A |
| 콘텐츠 생성 관리 (템플릿 탭) | 저장한 글 목록·정렬·페이지네이션 | N/A |
| 저장한 템플릿 상세 | 저장 시점 본문·추천 채널 | N/A |

**주요 사용자 흐름**

```
[추천 콘텐츠 소스] → 분류 칩 / 스크롤
  → 카드 탭 → [상세] 로드
  → 적용하기 → applied API → [적용] 편집
  → 저장하기 → POST → [완료]
  → 저장 내역 보기 → 홈 대시보드 + 템플릿 탭
  → 저장 글 목록 / 정렬 / 스크롤
  → 카드 탭 → [저장 상세] GET
  → 점 3개 → 이름 수정·삭제 모달 (API 없음)
```

---

## 6. 엣지 케이스 & 에러 처리

| 케이스 | 기대 동작 |
|--------|----------|
| 목록 네트워크 오류 | 에러 메시지 + 다시 시도 |
| 빈 목록 | 빈 상태 문구 |
| 상세 404/오류 | 에러 표시. 적용 불가 |
| 적용 API 실패 | 토스트, 상세 화면 유지 |
| 저장 본문 공백/2000자 초과 | 호출 전 토스트 |
| 저장 API 실패 | 토스트, 적용 화면 유지 |
| 401/403 | 기존 인증 인터셉터 |
| 저장 내역 목록 오류 | 토스트 |
| 저장 상세 404/오류 | 에러 표시 + 다시 시도 |
| 이름 수정·삭제 확인 | 모달만 닫음. 서버·목록 미반영 |

---

## 7. 성공 지표 (Success Metrics)

- 템플릿 탭에서 실 카탈로그가 분류·페이지네이션과 함께 표시된다.
- 상세·적용·저장 흐름을 오류 없이 완료할 수 있다.
- 저장 내역 보기가 생성 관리 템플릿 탭을 연다.
- 템플릿 탭에서 저장한 글 목록·상세를 조회할 수 있다.

---

## 8. 의존성 & 선행 조건

- **API**: `GET /v1/templates`, `GET /v1/templates/{id}`, `GET /v1/templates/{id}/applied`, `POST /v1/saved-templates`, `GET /v1/saved-templates`, `GET /v1/saved-templates/{id}`
- **권한**: ACTIVE accessToken
- **외부 서비스**: 없음
- **선행 기능**: 추천 소스·상세·적용·완료 UI, ADR-004 템플릿 문서 모델
