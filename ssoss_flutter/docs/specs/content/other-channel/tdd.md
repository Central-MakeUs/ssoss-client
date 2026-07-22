# TDD — 다른 채널용 콘텐츠 생성

---

## 메타 정보

| 항목 | 내용 |
|------|------|
| 기능 ID | `feature/content-other-channel` |
| 작성자 | ahndohyeon |
| 작성일 | 2026-07-18 |
| 상태 | Approved |
| 관련 PRD | [`prd.md`](./prd.md) |

---

## 1. 기능 요약

기존 `lib/features/content/`를 확장한다. 저장 완료에서 이전 `ContentCreateInput`을 이어받아 남은 채널만 고른 뒤, 기존 generating/result 페이지를 `ContentCreateFlow.otherChannel` 모드로 재사용한다.

**피처 경로**: `lib/features/content/`

---

## 2. 설계 결정

| 결정 | 선택 | 이유 |
|------|------|------|
| 채널 선택 UI | 전용 페이지 (3단계 위저드 미사용) | Figma가 채널만 고르는 단일 화면 |
| 결과/생성중 | 기존 페이지 + flow 모드 | UI 동일, 타이틀·네비만 분기 |
| 다시 생성하기 | 동일 `ContentGenerationArgs`로 generating 재진입 | 채널 재선택 없음 |
| 저장 완료 extra | `ContentSaveCompleteArgs` | mode + previousInput |
| ContentsCard | blocks 전용 | 추천 카드 위치 가변 |

---

## 3. Presentation 구조

| 파일 | 역할 |
|------|------|
| `models/content_create_flow.dart` | `ContentCreateFlow` |
| `models/content_save_complete_args.dart` | 저장 완료 route extra |
| `models/content_generation_args.dart` | generating/result route extra |
| `pages/content_other_channel_create_page.dart` | 채널 선택 |
| `cubit/content_other_channel_create_cubit.dart` | 채널 토글·input 조립 |
| `widgets/create/content_other_channel_*.dart` | 안내 배너·채널 목록 |

---

## 4. 데이터 흐름

```
SaveComplete(args.previousInput)
  → OtherChannelCreate(completedChannels = previous.channels, base = previous)
  → build ContentCreateInput(new channels + base fields)
  → Generating(ContentGenerationArgs)
  → Result(same args)
       remake → Generating(same args)
       save → SaveComplete(finalSave)
```

---

## 5. SsossContentsCard

`List<SsossContentsCardBlock>`만 받는다. text / recommendation / hashtags. 복사 텍스트는 text 블록만 concat.
