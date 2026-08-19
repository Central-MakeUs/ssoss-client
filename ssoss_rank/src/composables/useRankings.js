import { onMounted, onUnmounted, ref } from 'vue'
import { fetchRankings } from '../api'

export function useRankings(intervalMs = 3000) {
  const rankings = ref([])
  const total = ref(0)
  const error = ref('')
  const loading = ref(true)
  let timer

  async function load() {
    try {
      const data = await fetchRankings()
      rankings.value = data.rankings || []
      total.value = data.total || 0
      error.value = ''
    } catch (err) {
      error.value = err.message || '랭킹을 불러오지 못했습니다'
    } finally {
      loading.value = false
    }
  }

  onMounted(() => {
    load()
    timer = setInterval(load, intervalMs)
  })

  onUnmounted(() => {
    if (timer) {
      clearInterval(timer)
    }
  })

  return { rankings, total, error, loading, reload: load }
}
