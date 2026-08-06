# PRD — 해시태그 묶음 카탈로그·북마크

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/hashtag-catalog` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-08-06 |
| 상태 | Approved |
| 관련 ADR | adr-001-clean-architecture.md, adr-002-flutter-bloc.md, adr-007-tab-bar-page-view.md |
| 관련 TDD | [`tdd.md`](./tdd.md) |

---

## 1. 배경 및 목적

**배경**

추천 콘텐츠 소스 화면의 해시태그 탭은 더미 데이터만 보여 준다. 운영자가 심은 해시태그 묶음 카탈로그와 회원별 북마크를 실 API로 연결해야 한다.

**목적**

해시태그 탭에서 묶음 목록을 조회·검색·페이지네이션하고, 북마크 아이콘으로 저장·해제할 수 있게 한다.

---

## 2. 사용자 스토리

- [ ] As a **가게 운영자**, I want to **해시태그 탭에서 운영자 묶음 카드를 보고**, so that **홍보에 쓸 태그를 고를 수 있다**.
- [ ] As a **가게 운영자**, I want to **검색어로 묶음·태그를 거르고**, so that **원하는 세트를 빨리 찾을 수 있다**.
- [ ] As a **가게 운영자**, I want to **아래로 스크롤해 다음 페이지를 불러오고**, so that **전체 카탈로그를 볼 수 있다**.
- [ ] As a **가게 운영자**, I want to **북마크 아이콘으로 묶음을 담거나 빼고**, so that **나중에 북마크 목록에서 다시 볼 수 있다**.

---

## 3. 요구사항

### 3.1 기능 요구사항 (Functional Requirements)

| ID | 요구사항 | 우선순위 |
|----|---------|---------|
| FR-01 | 해시태그 탭 진입 시 `GET /v1/hashtag-bundles` 로 목록 조회 (page=0, size=20) | Must |
| FR-02 | 카드에 `name`, `hashtags` 전부, `bookmarked` 로 북마크 아이콘 표시 | Must |
| FR-03 | `hasNext` 가 true 인 동안 하단 스크롤 시 다음 page 조회. 로딩 중 카드 아래 CircularProgressIndicator | Must |
| FR-04 | 검색창 입력을 `keyword` 쿼리로 서버 검색 (디바운스). 빈 값이면 전체 | Must |
| FR-05 | 북마크 OFF→ON: `PUT /v1/members/me/hashtag-bundles/{bundleId}`. ON→OFF: `DELETE` 동일 경로 | Must |
| FR-06 | 북마크 토글은 낙관적 업데이트. 실패 시 롤백 + 토스트 | Must |
| FR-07 | ACTIVE 회원 accessToken 전용 (기존 Dio 인터셉터) | Must |

### 3.2 비기능 요구사항 (Non-functional Requirements)

| 항목 | 요구사항 |
|------|---------|
| 성능 | 초기·추가 로딩 인디케이터. 검색 디바운스 기본 1초 |
| 보안 | ACTIVE 회원 accessToken |
| 오프라인 | 네트워크 필요. 캐시 없음 |
| 접근성 | 기존 카드·버튼 패턴 유지 |

---

## 4. 범위 (Scope)

### In Scope (이번 구현에 포함)

- `hashtag` 피처 data/domain (목록·북마크 저장·해제)
- `HashtagCatalogCubit` + 추천 콘텐츠 소스 해시태그 탭 연동
- 서버 검색·페이지네이션·북마크 토글

### Out of Scope (이번 구현에서 제외)

- 북마크 전용 목록 화면 (이유: 추후. usecase는 재사용 가능하도록 준비)
- 템플릿 탭 API 연동
- 해시태그 카드 UI 리디자인

---

## 5. 화면 & UX 흐름

**화면 목록**

| 화면 이름 | 설명 | Figma 링크 |
|-----------|------|-----------|
| 추천 콘텐츠 소스 (해시태그 탭) | 기존 탭·카드 UI에 API 연동 | N/A |

**주요 사용자 흐름**

```
[추천 콘텐츠 소스] → 해시태그 탭 → 목록 로드
  → 검색어 입력 → 디바운스 후 재조회
  → 하단 스크롤 → loadMore
  → 북마크 탭 → PUT/DELETE → 아이콘 반영
```

---

## 6. 엣지 케이스 & 에러 처리

| 케이스 | 기대 동작 |
|--------|----------|
| 네트워크 오류 (목록) | 에러 메시지 노출. 재시도 가능하면 재조회 |
| 빈 목록 | 빈 리스트 (검색 결과 0건 포함) |
| 북마크 실패 | 아이콘 롤백 + 토스트 |
| 401/403 | 기존 인증 인터셉터 처리 |
| 이미 북마크한 묶음 재저장 / 미북마크 해제 | 서버 멱등 204 — 클라이언트는 성공으로 처리 |

---

## 7. 성공 지표 (Success Metrics)

- 해시태그 탭에서 실 카탈로그가 표시된다.
- 검색·페이지네이션·북마크 토글이 오류 없이 동작한다.

---

## 8. 의존성 & 선행 조건

- **API**: `GET /v1/hashtag-bundles`, `PUT|DELETE /v1/members/me/hashtag-bundles/{bundleId}`
- **권한**: ACTIVE accessToken
- **외부 서비스**: 없음
- **선행 기능**: 추천 콘텐츠 소스 화면·탭 UI (ADR-007)
