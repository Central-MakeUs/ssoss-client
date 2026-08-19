<template>
  <div>
    <p
      v-if="!rankings.length"
      class="py-16 text-center text-[14px] leading-[1.5] tracking-[-0.14px] text-neutral-500 md:text-[16px]"
    >
      아직 제출된 콘텐츠가 없어요
    </p>

    <template v-else>
      <div
        class="mb-6 grid gap-2 md:gap-4"
        :class="podiumGridClass"
      >
        <article
          v-for="item in podiumItems"
          :key="item.id"
          class="flex min-w-0 flex-col items-center rounded-xl border bg-white px-2 py-4 md:px-4"
          :class="[
            highlightId === item.id ? 'border-primary-500' : 'border-neutral-200',
            item.rank === 1 && podium.length === 3 ? 'md:py-8' : 'md:py-6',
          ]"
        >
          <MedalIcon :rank="item.rank" />
          <p class="mt-2 text-[13px] font-semibold tracking-[-0.13px] text-neutral-500 md:text-[14px]">
            {{ item.rank }}등
          </p>
          <p class="mt-1 w-full truncate text-center text-[15px] font-semibold tracking-[-0.15px] text-black md:text-[18px]">
            {{ item.name }}
          </p>
          <p class="mt-1 text-[15px] font-semibold tracking-[-0.15px] text-black md:text-[18px]">
            {{ item.score }}점
          </p>
        </article>
      </div>

      <div
        v-if="rest.length"
        class="grid grid-cols-1 gap-2 sm:grid-cols-2"
      >
        <article
          v-for="item in rest"
          :key="item.id"
          class="flex items-center gap-3 rounded-xl border bg-white px-4 py-3 md:px-5 md:py-4"
          :class="highlightId === item.id ? 'border-primary-500' : 'border-neutral-200'"
        >
          <span class="w-8 shrink-0 text-[18px] font-semibold tracking-[-0.18px] text-neutral-800 md:w-10 md:text-[20px]">
            {{ item.rank }}
          </span>
          <p class="min-w-0 flex-1 truncate text-[16px] font-semibold tracking-[-0.16px] text-black">
            {{ item.name }}
          </p>
          <p class="shrink-0 text-[16px] font-semibold tracking-[-0.16px] text-black md:text-[18px]">
            {{ item.score }}점
          </p>
        </article>
      </div>
    </template>
  </div>
</template>

<script>
import MedalIcon from './MedalIcon.vue'

export default {
  name: 'RankingList',
  components: { MedalIcon },
  props: {
    rankings: {
      type: Array,
      default: () => [],
    },
    highlightId: {
      type: Number,
      default: null,
    },
  },
  computed: {
    podium() {
      return this.rankings.filter((item) => item.rank >= 1 && item.rank <= 3)
    },
    podiumItems() {
      return this.podium
    },
    podiumGridClass() {
      if (this.podium.length <= 1) {
        return 'grid-cols-1'
      }
      if (this.podium.length === 2) {
        return 'grid-cols-2'
      }
      return 'grid-cols-3'
    },
    rest() {
      return this.rankings.filter((item) => item.rank > 3)
    },
  },
}
</script>
