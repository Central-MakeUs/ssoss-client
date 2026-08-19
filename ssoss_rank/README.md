# 쏘쓰 콘텐츠 랭킹

쏘쓰 앱에서 복사한 SNS 콘텐츠 **본문**을 제출하면 Gemini가 점수를 매기고, 그 점수로 순위표를 보여주는 웹앱입니다.

입력은 **이름**과 **본문**만 받습니다. 제목은 없습니다. 채점은 본문만 보고, 사진 가이드(`<photo-guide />`, `[제목 삽입]`)는 점수에 넣지 않습니다. 결과에는 총점과 항목별 점수만 보여 주고, 코멘트는 없습니다.

## 화면 흐름

1. `/` 홈 — 현재 랭킹. 1~3등은 메달과 함께 좌→우(1등, 2등, 3등). 4등부터는 한 줄에 최대 2개. 3초마다 자동 갱신.
2. `/submit` 제출 — 이름·본문 입력. 채점 중에는 로딩 화면.
3. `/result/:id` 결과 — 총점, 순위, 4항목 점수. 뒤로가기(앱바·브라우저)는 홈으로.
4. `/result/:id/ranking` 순위표 — 내 순위 카드 + 전체 리스트.

모바일·웹 모두 화면 너비를 채우도록 반응형입니다.

## 채점 기준 (100점)

| 항목 | 배점 |
|------|------|
| 상황 반영도 | 25 |
| 메뉴 매력 전달 | 25 |
| 첫 문장 후킹력 | 25 |
| 방문/구매 유도력 | 25 |

모델: `gemini-3.1-flash-lite`

## 기술 스택

- 프론트: Vue 3, Vue CLI, Vue Router, Tailwind CSS
- API: Vercel Serverless Functions (`/api`)
- 로컬 API: `scripts/dev-api.js` (포트 3000)
- DB: Turso (`@libsql/client`)
- 배포: Vercel (`dist` + `/api` rewrite)

## 프로젝트 구조

```
ssoss_rank/
├── api/
│   ├── rankings.js              # GET  /api/rankings
│   ├── submit.js                # POST /api/submit
│   ├── submissions/[id].js      # GET  /api/submissions/:id
│   └── _lib/
│       ├── db.js                # Turso 스키마·조회·저장
│       ├── gemini.js            # 사진 가이드 제거 + 채점
│       └── http.js
├── scripts/dev-api.js           # 로컬 API 서버
├── src/
│   ├── views/                   # Home, Submit, Result, Ranking
│   ├── components/              # AppBar, RankingList, MedalIcon, …
│   ├── composables/useRankings.js
│   ├── api.js
│   └── router.js
├── vercel.json
├── vue.config.js                # /api → localhost:3000 프록시
└── .env.example
```

## 로컬 실행

터미널을 두 개 씁니다.

```bash
cp .env.example .env
# .env에 키를 넣습니다

npm install
npm run serve
```

다른 터미널:

```bash
npm run serve:api
```

브라우저: [http://localhost:8080](http://localhost:8080)

Vue CLI가 `/api` 요청을 `http://127.0.0.1:3000`으로 넘깁니다. `gemini.js` 등 API 코드를 바꾸면 `npm run serve:api`를 다시 실행해야 반영됩니다.

## 환경변수

`.env.example`을 복사해 값을 넣습니다. **실제 키는 커밋하지 마세요.**

| 키 | 설명 |
|----|------|
| `GEMINI_API_KEY` | Gemini API 키 |
| `TURSO_DATABASE_URL` | `libsql://...` 형식 |
| `TURSO_AUTH_TOKEN` | Turso 인증 토큰 |

Vercel 대시보드 Environment Variables에도 같은 키를 등록합니다.

## API

- `POST /api/submit` `{ name, body }` → 채점 후 저장. 응답: `id`, `name`, `score`, `breakdown`, `rank`, `total`
- `GET /api/rankings` → `{ rankings: [{ id, name, score, rank, createdAt }], total }`
- `GET /api/submissions/:id` → 제출 상세(점수·순위·항목별 점수)

이름 1~20자, 본문 1~4000자. 같은 이름이어도 제출마다 새 행입니다. 순위는 점수 내림차순, 동점이면 먼저 제출한 쪽이 위입니다.

## 배포

이 폴더(`ssoss_rank`)를 Vercel 프로젝트 루트로 연결합니다. `npm run build` 결과가 `dist`에 나오고, `/api/*`는 서버리스 함수로 동작합니다. `submit` 함수 `maxDuration`은 60초입니다.
