# PRD — 저장 콘텐츠 목록·상세·삭제

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/content-saved-contents` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-07-29 |
| 상태 | Approved |
| 관련 ADR | adr-001-clean-architecture.md, adr-002-flutter-bloc.md |
| 관련 TDD | [`tdd.md`](./tdd.md) |

---

## 1. 배경 및 목적

**배경**

홈 「최근 생성된 콘텐츠」와 대시보드 「콘텐츠 생성 관리」·상세는 더미 데이터만 보여 준다. 저장·편집 PUT은 연동됐으나 목록·상세 GET·삭제가 없어 실제 저장 기록을 확인·수정·삭제할 수 없다.

**목적**

저장한 콘텐츠를 목록에서 조회하고, 상세에서 채널별 본문을 확인·편집(PUT)하며, 생성 관리에서 삭제할 수 있게 한다.

---

## 2. 사용자 스토리

- [ ] As a **가게 운영자**, I want to **홈에서 최근 저장 콘텐츠 최대 3건을 보고**, so that **바로 이어서 확인·생성할 수 있다**.
- [ ] As a **가게 운영자**, I want to **생성 관리에서 페이지네이션·필터로 저장 기록을 보고**, so that **과거 콘텐츠를 찾을 수 있다**.
- [ ] As a **가게 운영자**, I want to **카드를 눌러 상세에서 채널별 본문을 보고 편집**, so that **저장된 최신본을 고칠 수 있다**.
- [ ] As a **가게 운영자**, I want to **생성 관리에서 콘텐츠를 삭제**, so that **불필요한 저장을 없앨 수 있다**.

---

## 3. 요구사항

### 3.1 기능 요구사항 (Functional Requirements)

| ID | 요구사항 | 우선순위 |
|----|---------|---------|
| FR-01 | 홈 최근 목록: `GET /v1/contents?size=3`. 없으면 「콘텐츠 생성하러 가기」 | Must |
| FR-02 | 생성 관리: `GET /v1/contents?size=10&page=` 페이지네이션, 하단 lazy load, `hasNext`/`totalCount`면 중단 | Must |
| FR-03 | 생성 관리 필터 칩·n건·최신순 영역 sticky. pull-to-refresh로 재조회 | Must |
| FR-04 | 카드 1건 = 저장 1회. `channels` 전부 표시. 제목은 서버 말줄임 그대로 | Must |
| FR-05 | 카드 탭 → `GET /v1/contents/{contentId}` 상세. 다중 채널이면 첫 채널(index 0)부터 | Must |
| FR-06 | 상세 편집 → 기존 PUT (`persistMode: put`). 성공 후 상세·목록에 반영 | Must |
| FR-07 | 생성 관리 삭제 → `DELETE /v1/contents/{contentId}` | Must |
| FR-08 | 필터는 `channel` 쿼리(서버). 정렬은 저장 시각 최신순 고정 | Must |

### 3.2 비기능 요구사항 (Non-functional Requirements)

| 항목 | 요구사항 |
|------|---------|
| 성능 | 목록·상세 로딩 인디케이터. lazy load 하단 CircularProgressIndicator |
| 보안 | ACTIVE 회원 accessToken (기존 Dio 인터셉터) |
| 오프라인 | 네트워크 필요. 캐시 없음 |
| 접근성 | 기존 공용 컴포넌트 준수 |

---

## 4. 범위 (Scope)

### In Scope

- `GET /v1/contents`, `GET /v1/contents/{id}`, `DELETE /v1/contents/{id}`
- 홈 최근 3건, 생성 관리 페이지네이션·sticky·refresh·삭제
- 상세 실데이터 + 다중 채널 탭/PageView(첫 페이지)
- PUT 편집 후 목록 invalidate

### Out of Scope

- 오래된순 정렬 (API 미지원)
- 채널 단위 삭제
- 콘텐츠 재활용하기 API 변경
- OpenAPI 클라이언트 자동 생성

---

## 5. 화면 & UX 흐름

| 화면 이름 | 설명 | Figma 링크 |
|-----------|------|-----------|
| ContentPage (최근 섹션) | 최근 3건 또는 빈 상태 | N/A |
| ContentGenerationManagementPage | 필터·목록·삭제 | N/A |
| ContentDetailPage | 채널별 상세·편집 | N/A |
| ContentEditPage | PUT 편집 (기존) | N/A |

```
[홈 최근] → 카드 탭 → [상세 GET] → 편집 → PUT → 상세 갱신 → pop → 목록 refresh
[생성 관리] → 스크롤 끝 → loadMore → [생성 관리]
[생성 관리] → 삭제 → DELETE → 목록에서 제거
[생성 관리] pull-to-refresh → page=0 재조회
```

---

## 6. 엣지 케이스 & 에러 처리

| 케이스 | 기대 동작 |
|--------|----------|
| 빈 목록 (홈) | 「아직 생성된 콘텐츠가 없어요」 + 생성 CTA |
| 빈 목록 (관리) | 카드 없음, totalCount 0 |
| 네트워크 오류 | 에러 메시지 / 토스트 |
| 상세 404 (CT0005) | 에러 UI, 뒤로가기 |
| 삭제 404 | 토스트, 목록 유지 또는 재조회 |
| size/page 범위 | 클라이언트는 3·10만 전송 |

---

## 7. 성공 지표

- 홈에서 실제 저장 3건(또는 미만)이 최신순으로 보인다.
- 생성 관리에서 스크롤 시 추가 페이지가 로드되고 totalCount에 도달하면 중단된다.
- 상세·편집·삭제가 서버와 일치하고 다른 화면에 반영된다.

---

## 8. 의존성 & 선행 조건

- **API**: `GET/DELETE /v1/contents`, `GET /v1/contents/{id}`, 기존 PUT 채널 편집
- **권한**: ACTIVE accessToken
- **선행 기능**: content save/edit (`generation-api`, `edit`)
