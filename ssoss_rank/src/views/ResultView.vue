<template>
  <div class="flex min-h-dvh w-full flex-col bg-white pb-[calc(88px+env(safe-area-inset-bottom))]">
    <AppBar title="채점 결과" show-back @back="goHome" />

    <main class="w-full flex-1 px-4 py-6 sm:px-6 md:px-10 md:py-10 lg:px-16">
      <p v-if="error" class="text-center text-[14px] text-neutral-500">
        {{ error }}
      </p>
      <p v-else-if="loading" class="text-center text-[14px] text-neutral-500">
        결과를 불러오는 중이에요
      </p>
      <div v-else class="w-full">
        <p class="text-center text-[16px] font-semibold tracking-[-0.16px] text-neutral-800 md:text-[18px]">
          {{ result.name }}님의 점수
        </p>
        <p class="mt-2 text-center text-[32px] font-bold leading-[1.4] tracking-[-0.32px] text-black md:text-[48px]">
          {{ result.score }}점
        </p>
        <div class="mt-3 flex justify-center">
          <span
            class="rounded-full bg-primary-50 px-3 py-1 text-[14px] font-semibold tracking-[-0.14px] text-primary-500 md:text-[16px]"
          >
            {{ result.rank }}위 · {{ result.total }}명 중
          </span>
        </div>
        <div class="mt-8 w-full rounded-xl border border-neutral-200 bg-white p-4 md:p-6">
          <ScoreBreakdown :breakdown="result.breakdown" />
        </div>
      </div>
    </main>

    <div
      v-if="result"
      class="fixed inset-x-0 bottom-0 bg-white px-4 pb-[calc(16px+env(safe-area-inset-bottom))] pt-3 sm:px-6 md:px-10 lg:px-16"
    >
      <div class="w-full md:flex md:justify-end">
        <div class="w-full md:w-[240px]">
          <PrimaryButton label="순위표 보기" @click="goRanking" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import AppBar from '../components/AppBar.vue'
import PrimaryButton from '../components/PrimaryButton.vue'
import ScoreBreakdown from '../components/ScoreBreakdown.vue'
import { fetchSubmission } from '../api'

export default {
  name: 'ResultView',
  components: { AppBar, PrimaryButton, ScoreBreakdown },
  data() {
    return {
      result: null,
      loading: true,
      error: '',
    }
  },
  watch: {
    '$route.params.id': {
      immediate: true,
      handler: 'load',
    },
  },
  beforeRouteLeave(to, _from, next) {
    if (to.name === 'ranking' || to.name === 'home') {
      next()
      return
    }
    next({ name: 'home', replace: true })
  },
  methods: {
    async load() {
      this.loading = true
      this.error = ''
      try {
        this.result = await fetchSubmission(this.$route.params.id)
      } catch (err) {
        this.result = null
        this.error = err.message || '결과를 불러오지 못했습니다'
      } finally {
        this.loading = false
      }
    },
    goHome() {
      this.$router.replace({ name: 'home' })
    },
    goRanking() {
      this.$router.push({
        name: 'ranking',
        params: { id: this.$route.params.id },
      })
    },
  },
}
</script>
