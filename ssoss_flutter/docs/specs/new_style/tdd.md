# TDD — 이 스타일로 새로 만들기

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/new-style` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-08-05 |
| 상태 | Approved |
| 관련 PRD | [`prd.md`](./prd.md) |

---

## 1. 기능 요약

`lib/features/new_style/` 피처로 관리한다. 저장 콘텐츠를 참고해 채널을 고르고 상세 입력을 받는 2스텝 UI를 제공한다. 매장 prefill 없이 빈 폼으로 시작한다. 업로드·결과 연동은 추후 `ContentCreateFlow.initial`로 기존 Result를 그대로 쓴다. content의 `ContentCreateInput`·채널/상세 위젯을 재사용한다.

**피처 경로**: `lib/features/new_style/`

---

## 2. 설계 결정

| 결정 | 선택 | 이유 |
|------|------|------|
| 피처 분리 | `new_style` 전용 피처 | 스타일 재사용 플로우를 독립 관리 |
| Domain/Data | 이번 범위 미사용 | API 미연동, content 엔티티 재사용 |
| 화면 구조 | 채널·상세 **각각 페이지** (`push` 스택) | 뒤로가기 제스처·시스템 back 동작 |
| 목적/톤 UI | 없음. args의 purpose/tone 보관 | 스타일 참고는 원본 메타 재사용 |
| 매장 prefill | 미사용 | 사용자 요구: 새로 삽입 |
| 결과 플로우 | `ContentResultPage` 무수정, `flow: initial` | 타이틀·나가기·다시생성 분기 불필요 |
| 생성 CTA | onPressed 없음 | API 추후 연동 |

---

## 3. Presentation 구조

| 파일 | 역할 |
|------|------|
| `models/new_style_args.dart` | `NewStyleArgs` / `NewStyleDetailArgs` |
| `cubit/new_style_channel_*.dart` | 채널 선택 |
| `cubit/new_style_detail_*.dart` | 상세 입력, `buildCreateInput` |
| `pages/new_style_channel_page.dart` | 채널 선택 (`/new-style`) |
| `pages/new_style_detail_page.dart` | 상세 입력 (`/new-style/detail`) |
| `widgets/new_style_reference_section.dart` | 헤더 + 참고 카드 |
| `util/new_style_reference_text.dart` | 참고 문구 추출·truncate |

---

## 4. 데이터 흐름

```
Detail/Management
  → showSsossModal
  → push NewStyleChannel
  → push NewStyleDetail
  → [추후] buildCreateInput → Generating → Result(flow: initial)
```

**Args**

- `sourceContentId`, `purpose`, `tone`, `referenceChannel`, `referenceRawText`

**참고 문구**

- blog → title(없으면 body), 그 외 → body
- 표시: 한 줄, 너비 초과 시 `TextOverflow.ellipsis`

**buildCreateInput (추후용)**

- selected channels + args purpose/tone + form fields + `sourceContentId`
- highlight trim 비어 있으면 null
