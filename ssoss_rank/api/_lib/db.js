const { createClient } = require('@libsql/client')

let client
let schemaReady = false

function normalizeTursoUrl(url) {
  const trimmed = String(url || '').trim()
  if (trimmed.startsWith('xlibsql://')) {
    return `libsql://${trimmed.slice('xlibsql://'.length)}`
  }
  return trimmed
}

function getClient() {
  const url = normalizeTursoUrl(process.env.TURSO_DATABASE_URL)
  const authToken = String(process.env.TURSO_AUTH_TOKEN || '').trim()
  if (!url || !authToken) {
    throw new Error('Turso 환경변수가 없습니다')
  }
  if (!client) {
    client = createClient({ url, authToken })
  }
  return client
}

async function ensureSchema() {
  if (schemaReady) {
    return
  }
  const db = getClient()
  await db.execute(`
    CREATE TABLE IF NOT EXISTS submissions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      body TEXT NOT NULL,
      score INTEGER NOT NULL,
      breakdown TEXT NOT NULL,
      comment TEXT NOT NULL,
      created_at TEXT NOT NULL DEFAULT (datetime('now'))
    )
  `)
  await db.execute(`
    CREATE INDEX IF NOT EXISTS idx_submissions_score
    ON submissions (score DESC, created_at ASC)
  `)
  schemaReady = true
}

function parseBreakdown(value) {
  if (value && typeof value === 'object') {
    return value
  }
  try {
    return JSON.parse(value || '{}')
  } catch (error) {
    return {}
  }
}

async function listSubmissions() {
  await ensureSchema()
  const result = await getClient().execute(`
    SELECT id, name, score, created_at
    FROM submissions
    ORDER BY score DESC, created_at ASC, id ASC
  `)
  return result.rows.map((row, index) => ({
    id: Number(row.id),
    name: row.name,
    score: Number(row.score),
    createdAt: row.created_at,
    rank: index + 1,
  }))
}

async function insertSubmission({ name, body, score, breakdown, comment }) {
  await ensureSchema()
  const result = await getClient().execute({
    sql: `
      INSERT INTO submissions (name, body, score, breakdown, comment)
      VALUES (?, ?, ?, ?, ?)
      RETURNING id, name, body, score, breakdown, comment, created_at
    `,
    args: [name, body, score, JSON.stringify(breakdown), comment],
  })
  const row = result.rows[0]
  const rankings = await listSubmissions()
  const found = rankings.find((item) => item.id === Number(row.id))
  return {
    id: Number(row.id),
    name: row.name,
    body: row.body,
    score: Number(row.score),
    breakdown: parseBreakdown(row.breakdown),
    comment: row.comment,
    createdAt: row.created_at,
    rank: found ? found.rank : rankings.length,
    total: rankings.length,
  }
}

async function getSubmission(id) {
  await ensureSchema()
  const result = await getClient().execute({
    sql: `
      SELECT id, name, body, score, breakdown, comment, created_at
      FROM submissions
      WHERE id = ?
    `,
    args: [id],
  })
  const row = result.rows[0]
  if (!row) {
    return null
  }
  const rankings = await listSubmissions()
  const found = rankings.find((item) => item.id === Number(row.id))
  return {
    id: Number(row.id),
    name: row.name,
    body: row.body,
    score: Number(row.score),
    breakdown: parseBreakdown(row.breakdown),
    comment: row.comment,
    createdAt: row.created_at,
    rank: found ? found.rank : null,
    total: rankings.length,
  }
}

module.exports = {
  listSubmissions,
  insertSubmission,
  getSubmission,
}
