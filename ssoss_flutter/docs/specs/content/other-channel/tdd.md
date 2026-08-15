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

기존 `lib/features/content/`를 확장한다. 저장 콘텐츠 상세에서 현재 탭의 `contentChannelId`와 함께 채널만 고른 뒤, generating/result를 `ContentCreateFlow.otherChannel`로 재사용한다. 생성 시작은 conversions API를 쓴다.

**피처 경로**: `lib/features/content/`

---

## 2. 설계 결정

| 결정 | 선택 | 이유 |
|------|------|------|
| 시작 API | `POST .../conversions` | 서버가 원본 생성 입력을 이어받음. 앱은 channels만 전송 |
| 채널 선택 UI | 전용 페이지 (3단계 위저드 미사용) | Figma가 채널만 고르는 단일 화면 |
| 결과/생성중 | 기존 페이지 + flow 모드 | UI 동일, 타이틀·네비만 분기 |
| 다시 생성하기 | 동일 `ContentGenerationArgs`(conversionContentChannelId 포함) | 채널 재선택 없음 |
| 진입점 | 저장 콘텐츠 상세만 | 저장 완료 CTA 제거 |
| 저장 완료 | CTA 단일(저장 내역) | continueAvailable 모드 삭제 |

---

## 3. Presentation 구조

| 파일 | 역할 |
|------|------|
| `models/content_create_flow.dart` | `ContentCreateFlow` |
| `models/content_generation_args.dart` | generating/result + `conversionContentChannelId` |
| `models/content_other_channel_args.dart` | `sourceContentId` + `sourceContentChannelId` |
| `pages/content_other_channel_create_page.dart` | 채널 선택 |
| `cubit/content_other_channel_create_cubit.dart` | 채널 토글·최소 input 조립 |
| `widgets/create/content_other_channel_*.dart` | 안내 배너·채널 목록 |

---

## 4. Domain / Data

| 구성 | 역할 |
|------|------|
| `ChannelConversionInput` | contentId, contentChannelId, channels |
| `ChannelConversionRequest` | `{ channels: [...] }` |
| `StartChannelConversionUseCase` | 검증 + repository |
| `RunChannelConversionGenerationUseCase` | start + poll |

Path: `POST /v1/contents/{contentId}/channels/{contentChannelId}/conversions`  
응답: `GenerationStartResponse` (`generationId`) → 기존 `GET /v1/generations/{id}` 폴링.

---

## 5. 데이터 흐름

```
ContentDetail(contentId, 현재 탭 contentChannelId, excludedChannels)
  → OtherChannelCreate
  → ContentGenerationArgs(flow: otherChannel, conversionContentChannelId, channels)
  → Generating → RunChannelConversionGenerationUseCase
  → Result
       remake → Generating(same args)
       save → SaveComplete
```
