const { getSubmission } = require('../_lib/db')
const { sendJson, setCors } = require('../_lib/http')

module.exports = async function handler(req, res) {
  setCors(res)
  if (req.method === 'OPTIONS') {
    res.statusCode = 204
    res.end()
    return
  }
  if (req.method !== 'GET') {
    sendJson(res, 405, { error: '허용되지 않은 요청입니다' })
    return
  }

  const id = Number(req.query.id)
  if (!Number.isInteger(id) || id < 1) {
    sendJson(res, 400, { error: '잘못된 제출입니다' })
    return
  }

  try {
    const submission = await getSubmission(id)
    if (!submission) {
      sendJson(res, 404, { error: '제출을 찾을 수 없습니다' })
      return
    }
    sendJson(res, 200, {
      id: submission.id,
      name: submission.name,
      score: submission.score,
      breakdown: submission.breakdown,
      rank: submission.rank,
      total: submission.total,
    })
  } catch (error) {
    sendJson(res, 500, { error: error.message || '결과를 불러오지 못했습니다' })
  }
}
