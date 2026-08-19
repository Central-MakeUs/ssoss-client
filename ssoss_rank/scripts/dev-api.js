const fs = require('fs')
const http = require('http')
const path = require('path')
const { URL } = require('url')

function loadEnv() {
  const file = path.join(__dirname, '..', '.env')
  if (!fs.existsSync(file)) {
    return
  }
  for (const line of fs.readFileSync(file, 'utf8').split('\n')) {
    const trimmed = line.trim()
    if (!trimmed || trimmed.startsWith('#')) {
      continue
    }
    const eq = trimmed.indexOf('=')
    if (eq === -1) {
      continue
    }
    const key = trimmed.slice(0, eq).trim()
    let value = trimmed.slice(eq + 1).trim()
    if (
      (value.startsWith('"') && value.endsWith('"')) ||
      (value.startsWith("'") && value.endsWith("'"))
    ) {
      value = value.slice(1, -1)
    }
    process.env[key] = value
  }
}

loadEnv()

const rankings = require('../api/rankings')
const submit = require('../api/submit')
const submission = require('../api/submissions/[id]')

const server = http.createServer(async (req, res) => {
  try {
    const url = new URL(req.url, 'http://127.0.0.1')
    const pathname = url.pathname

    if (pathname === '/api/rankings') {
      await rankings(req, res)
      return
    }
    if (pathname === '/api/submit') {
      await submit(req, res)
      return
    }

    const match = pathname.match(/^\/api\/submissions\/([^/]+)$/)
    if (match) {
      req.query = { id: match[1] }
      await submission(req, res)
      return
    }

    res.statusCode = 404
    res.setHeader('Content-Type', 'application/json; charset=utf-8')
    res.end(JSON.stringify({ error: 'Not found' }))
  } catch (error) {
    if (!res.headersSent) {
      res.statusCode = 500
      res.setHeader('Content-Type', 'application/json; charset=utf-8')
      res.end(JSON.stringify({ error: error.message || '서버 오류' }))
    }
  }
})

const port = Number(process.env.API_PORT || 3000)
server.listen(port, '127.0.0.1', () => {
  console.log(`API listening on http://127.0.0.1:${port}`)
})
