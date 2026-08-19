async function readJson(res) {
  const data = await res.json().catch(() => ({}))
  if (!res.ok) {
    throw new Error(data.error || '요청에 실패했습니다')
  }
  return data
}

export function submitContent({ name, body }) {
  return fetch('/api/submit', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ name, body }),
  }).then(readJson)
}

export function fetchRankings() {
  return fetch('/api/rankings').then(readJson)
}

export function fetchSubmission(id) {
  return fetch(`/api/submissions/${id}`).then(readJson)
}
