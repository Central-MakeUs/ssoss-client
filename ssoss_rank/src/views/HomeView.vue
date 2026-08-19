<template>
  <div class="flex min-h-dvh w-full flex-col bg-white pb-[calc(88px+env(safe-area-inset-bottom))]">
    <header
      class="sticky top-0 z-20 flex h-14 items-center bg-white px-4 pt-[env(safe-area-inset-top)] sm:px-6 md:h-16 md:px-10 lg:px-16"
    >
      <h1 class="text-[18px] font-semibold tracking-[-0.18px] text-black md:text-[20px]">
        쏘쓰 콘텐츠 랭킹
      </h1>
    </header>

    <main class="w-full flex-1 px-4 py-4 sm:px-6 md:px-10 md:py-8 lg:px-16">
      <p
        v-if="error"
        class="mb-4 rounded-xl bg-neutral-50 px-4 py-3 text-[14px] text-neutral-600"
      >
        {{ error }}
      </p>
      <p
        v-else-if="loading"
        class="py-16 text-center text-[14px] text-neutral-500"
      >
        랭킹을 불러오는 중이에요
      </p>
      <RankingList v-else :rankings="rankings" />
    </main>

    <div
      class="fixed inset-x-0 bottom-0 bg-white px-4 pb-[calc(16px+env(safe-area-inset-bottom))] pt-3 sm:px-6 md:px-10 lg:px-16"
    >
      <div class="w-full md:flex md:justify-end">
        <div class="w-full md:w-[240px]">
          <PrimaryButton label="콘텐츠 제출하기" @click="$router.push('/submit')" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import PrimaryButton from '../components/PrimaryButton.vue'
import RankingList from '../components/RankingList.vue'
import { useRankings } from '../composables/useRankings'

export default {
  name: 'HomeView',
  components: { PrimaryButton, RankingList },
  setup() {
    return useRankings()
  },
}
</script>
