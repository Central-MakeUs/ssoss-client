const { insertSubmission } = require('./_lib/db')
const { scoreBody } = require('./_lib/gemini')
const { readJsonBody, sendJson, setCors } = require('./_lib/http')

module.exports = async function handler(req, res) {
  setCors(res)
  if (req.method === 'OPTIONS') {
    res.statusCode = 204
    res.end()
    return
  }
  if (req.method !== 'POST') {
    sendJson(res, 405, { error: '허용되지 않은 요청입니다' })
    return
  }

  try {
    const payload = await readJsonBody(req)
    const name = String(payload.name || '').trim()
    const body = String(payload.body || '').trim()

    if (name.length < 1 || name.length > 20) {
      sendJson(res, 400, { error: '이름은 1~20자로 입력해 주세요' })
      return
    }
    if (body.length < 1 || body.length > 4000) {
      sendJson(res, 400, { error: '본문은 1~4000자로 입력해 주세요' })
      return
    }

    const scored = await scoreBody(body)
    const saved = await insertSubmission({
      name,
      body,
      score: scored.score,
      breakdown: {
        situation: scored.situation,
        menuAppeal: scored.menuAppeal,
        hook: scored.hook,
        cta: scored.cta,
      },
      comment: '',
    })

    sendJson(res, 200, {
      id: saved.id,
      name: saved.name,
      score: saved.score,
      breakdown: saved.breakdown,
      rank: saved.rank,
      total: saved.total,
    })
  } catch (error) {
    const message = error.message || '제출에 실패했습니다'
    const status =
      message.includes('환경변수') || message.includes('채점할 본문') ? 400 : 500
    sendJson(res, status, { error: message })
  }
}

module.exports.config = {
  maxDuration: 60,
}
