<template>
  <div class="flex min-h-dvh w-full flex-col bg-white">
    <AppBar title="순위표" show-back @back="goBack" />

    <main class="w-full flex-1 px-4 py-4 sm:px-6 md:px-10 md:py-8 lg:px-16">
      <article
        v-if="mine"
        class="mb-4 rounded-xl bg-primary-50 px-4 py-4 md:flex md:items-center md:justify-between md:px-6 md:py-5"
      >
        <div>
          <p class="text-[14px] tracking-[-0.14px] text-neutral-600">내 순위</p>
          <p class="mt-1 text-[18px] font-semibold tracking-[-0.18px] text-black md:text-[20px]">
            {{ mine.name }}
          </p>
        </div>
        <div class="mt-2 flex items-baseline justify-between gap-4 md:mt-0 md:block md:text-right">
          <p class="text-[16px] font-semibold tracking-[-0.16px] text-black md:text-[18px]">
            {{ mine.score }}점
          </p>
          <p class="text-[18px] font-semibold tracking-[-0.18px] text-primary-500 md:text-[24px]">
            {{ mine.rank }}위
          </p>
        </div>
      </article>

      <p v-if="error" class="mb-4 text-[14px] text-neutral-500">
        {{ error }}
      </p>
      <RankingList :rankings="rankings" :highlight-id="highlightId" />
    </main>
  </div>
</template>

<script>
import AppBar from '../components/AppBar.vue'
import RankingList from '../components/RankingList.vue'
import { useRankings } from '../composables/useRankings'

export default {
  name: 'RankingView',
  components: { AppBar, RankingList },
  setup() {
    return useRankings()
  },
  computed: {
    highlightId() {
      const id = Number(this.$route.params.id)
      return Number.isInteger(id) ? id : null
    },
    mine() {
      return this.rankings.find((item) => item.id === this.highlightId) || null
    },
  },
  methods: {
    goBack() {
      this.$router.replace({
        name: 'result',
        params: { id: this.$route.params.id },
      })
    },
  },
}
</script>
