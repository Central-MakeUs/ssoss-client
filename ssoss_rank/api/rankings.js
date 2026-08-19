const { listSubmissions } = require('./_lib/db')
const { sendJson, setCors } = require('./_lib/http')

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

  try {
    const rankings = await listSubmissions()
    sendJson(res, 200, {
      rankings,
      total: rankings.length,
    })
  } catch (error) {
    sendJson(res, 500, { error: error.message || '랭킹을 불러오지 못했습니다' })
  }
}
