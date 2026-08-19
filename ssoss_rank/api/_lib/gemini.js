const GEMINI_URL =
  'https://generativelanguage.googleapis.com/v1beta/models/gemini-3.1-flash-lite:generateContent'

function stripPhotoGuides(body) {
  return String(body)
    .replace(/<photo-guide\b[^>]*\/?\s*>/gi, '')
    .replace(/\[[^\]]*삽입\]/g, '')
    .replace(/[ \t]+\n/g, '\n')
    .replace(/\n{3,}/g, '\n\n')
    .trim()
}

function clampScore(value) {
  const n = Number(value)
  if (!Number.isFinite(n)) {
    return 0
  }
  return Math.max(0, Math.min(25, Math.round(n)))
}

function buildPrompt(body) {
  return `당신은 카페/베이커리 사장님이 SNS에 올릴 콘텐츠 본문을 채점하는 심사위원입니다.
제출된 본문만 보고 아래 4항목을 각 0~25점 정수로 채점하세요. 합계가 총점(0~100)입니다.

채점 기준:
1. situation (상황 반영도, 25점): 언제, 누구, 어떤 장면인지 본문에 드러나는가
2. menuAppeal (메뉴 매력 전달, 25점): 메뉴·맛·식감·분위기가 구체적으로 그려지는가
3. hook (첫 문장 후킹력, 25점): 첫 문장이 스크롤을 멈추게 하는가
4. cta (방문/구매 유도력, 25점): 방문·주문·구매로 이어질 이유가 본문에 있는가

금지:
- 작성자 이름, 제목, 해시태그 품질은 점수에 넣지 마세요.
- 사진 가이드, 추천 사진, "[~ 삽입]", "<photo-guide>" 관련 문장은 없는 것처럼 완전히 무시하세요.
- 본문에 없는 정보를 추측해 가산하지 마세요.

JSON만 반환하세요:
{
  "situation": 0,
  "menuAppeal": 0,
  "hook": 0,
  "cta": 0
}

본문:
---
${body}
---`
}

function extractJson(text) {
  const trimmed = String(text || '').trim()
  try {
    return JSON.parse(trimmed)
  } catch (error) {
    const match = trimmed.match(/\{[\s\S]*\}/)
    if (!match) {
      throw new Error('채점 결과를 해석하지 못했습니다')
    }
    return JSON.parse(match[0])
  }
}

async function scoreBody(rawBody) {
  const apiKey = process.env.GEMINI_API_KEY
  if (!apiKey) {
    throw new Error('Gemini 환경변수가 없습니다')
  }

  const bodyForScoring = stripPhotoGuides(rawBody)
  if (!bodyForScoring) {
    throw new Error('채점할 본문이 없습니다')
  }

  const response = await fetch(`${GEMINI_URL}?key=${encodeURIComponent(apiKey)}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      contents: [
        {
          parts: [{ text: buildPrompt(bodyForScoring) }],
        },
      ],
      generationConfig: {
        temperature: 0.2,
        responseMimeType: 'application/json',
      },
    }),
  })

  const payload = await response.json().catch(() => ({}))
  if (!response.ok) {
    const message =
      payload?.error?.message || 'Gemini 채점에 실패했습니다'
    throw new Error(message)
  }

  const text = payload?.candidates?.[0]?.content?.parts
    ?.map((part) => part.text || '')
    .join('')
  const parsed = extractJson(text)
  const situation = clampScore(parsed.situation)
  const menuAppeal = clampScore(parsed.menuAppeal)
  const hook = clampScore(parsed.hook)
  const cta = clampScore(parsed.cta)
  return {
    situation,
    menuAppeal,
    hook,
    cta,
    score: situation + menuAppeal + hook + cta,
  }
}

module.exports = {
  stripPhotoGuides,
  scoreBody,
}
