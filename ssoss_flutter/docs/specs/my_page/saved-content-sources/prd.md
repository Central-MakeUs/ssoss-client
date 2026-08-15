# PRD — 저장한 콘텐츠 소스

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/my-page-saved-content-sources` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-08-08 |
| 상태 | Approved |
| 관련 ADR | adr-001-clean-architecture.md, adr-002-flutter-bloc.md, adr-003-page-app-bar-safe-area.md, adr-007-tab-bar-page-view.md |
| 관련 TDD | [`tdd.md`](./tdd.md) |

---

## 1. 배경 및 목적

**배경**

마이페이지 「저장한 콘텐츠 소스」 메뉴에서 북마크한 해시태그·추천 템플릿을 모아서 본다.

**목적**

마이페이지에서 저장한 템플릿·해시태그를 탭으로 확인하고, 북마크 해제·해시태그 복사를 할 수 있게 한다.

---

## 2. 사용자 스토리

- [ ] As a **가게 운영자**, I want to **마이페이지에서 저장한 콘텐츠 소스 화면으로 들어가**, so that **담아 둔 템플릿·해시태그를 모아서 볼 수 있다**.
- [ ] As a **가게 운영자**, I want to **템플릿/해시태그 탭을 탭하거나 스와이프해**, so that **원하는 목록을 빠르게 전환할 수 있다**.
- [ ] As a **가게 운영자**, I want to **북마크한 해시태그만 보고 해제·복사할 수 있어**, so that **필요한 태그만 유지할 수 있다**.
- [ ] As a **가게 운영자**, I want to **북마크한 추천 템플릿만 보고 해제할 수 있어**, so that **담아 둔 글 양식만 유지할 수 있다**.

---

## 3. 요구사항

### 3.1 기능 요구사항 (Functional Requirements)

| ID | 요구사항 | 우선순위 |
|----|---------|---------|
| FR-01 | 마이페이지 「저장한 콘텐츠 소스」 → `SavedContentSourcesPage` 진입 | Must |
| FR-02 | `SsossTabBar` + `PageView` 로 템플릿 / 해시태그 탭·스와이프 | Must |
| FR-03 | 해시태그 탭: `GET /v1/members/me/hashtag-bundles` 로 북마크 목록만 표시. 건수 `N건` | Must |
| FR-04 | 해시태그 카드는 카탈로그와 동일 UI. 북마크 아이콘은 저장된 상태 | Must |
| FR-05 | 북마크 해제: 기존 `DELETE /v1/members/me/hashtag-bundles/{bundleId}`. 낙관적 제거 | Must |
| FR-06 | 해제 성공: info 토스트 「북마크가 해제되었습니다」. 실패: error 토스트 + 목록 복원 | Must |
| FR-07 | 해시태그 복사하기는 기존 카드 동작 유지 | Must |
| FR-08 | 템플릿 탭: `GET /v1/members/me/templates` 로 북마크 목록만 표시. 건수 `N건`. 해제는 `DELETE /v1/members/me/templates/{templateId}` 낙관적 제거. 성공 info 토스트, 실패 error + 복원 | Must |
| FR-09 | 정렬 버튼·최신순 UI 없음 | Must |

### 3.2 비기능 요구사항 (Non-functional Requirements)

| 항목 | 요구사항 |
|------|---------|
| 레이아웃 | ADR-003: `SsossAppBar`는 SafeArea 안 Column |
| 보안 | ACTIVE accessToken (기존 Dio) |
| 오프라인 | 네트워크 필요. 캐시 없음 |

---

## 4. 범위 (Scope)

### In Scope

- 마이페이지 presentation 페이지·컴포넌트
- 해시태그 피처에 북마크 목록 GET + Cubit
- 기존 unbookmark usecase 재사용
- 템플릿 피처 북마크 목록 GET + Cubit + 해제

### Out of Scope

- 정렬 UI / 정렬 API
- go_router 등록 (MaterialPageRoute push)

---

## 5. 화면 & UX 흐름

| 화면 이름 | 설명 | Figma |
|-----------|------|-------|
| SavedContentSourcesPage (템플릿) | 탭 + 북마크 목록 | node 2272-9952 |
| SavedContentSourcesPage (해시태그) | 탭 + 북마크 목록 | node 2196-12945 |
| 해제 토스트 | info 「북마크가 해제되었습니다」 | node 2286-10667 |

```
[마이페이지] → [저장한 콘텐츠 소스]
  → 템플릿 탭: GET 목록 → 해제 → DELETE → 토스트
  → 해시태그 탭: GET 목록 → 해제 → DELETE → 토스트
```

---

## 6. 엣지 케이스 & 에러 처리

| 케이스 | 기대 동작 |
|--------|----------|
| 해시태그 빈 목록 | `0건` + 빈 상태 문구 |
| 목록 로드 실패 | 에러 메시지 + 재시도 |
| 북마크 해제 실패 | 항목 복원 + error 토스트 |
| 템플릿 빈 목록 | `0건` + 빈 상태 문구 |
| 템플릿 목록 로드 실패 | 에러 메시지 + 재시도 |
| 템플릿 북마크 해제 실패 | 항목 복원 + error 토스트 |

---

## 7. 성공 지표

- 마이페이지에서 화면이 열린다.
- 템플릿·해시태그 북마크가 보이고, 해제 시 목록·토스트가 맞다.
- 탭 스와이프가 된다.

---

## 8. 의존성 & 선행 조건

- **API**: `GET|DELETE /v1/members/me/hashtag-bundles`, `GET|DELETE /v1/members/me/templates`
- **선행**: 해시태그 카탈로그·북마크 (`feature/hashtag-catalog`), 템플릿 북마크 (`feature/template-catalog`)
- **UI 재사용**: `TemplateCard`, `RecommendSourceHashtagSetCard`, `SsossTabBar`, `SsossToast`
