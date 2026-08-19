<template>
  <div class="grid grid-cols-1 gap-4 md:grid-cols-2 md:gap-x-10 md:gap-y-6">
    <div v-for="item in items" :key="item.key" class="space-y-1.5">
      <div class="flex items-center justify-between">
        <p class="text-[14px] leading-[1.4] tracking-[-0.14px] text-neutral-800">
          {{ item.label }}
        </p>
        <p class="text-[14px] font-semibold tracking-[-0.14px] text-black">
          {{ item.score }}/25
        </p>
      </div>
      <div class="h-1.5 overflow-hidden rounded-full bg-neutral-100">
        <div
          class="h-full rounded-full bg-primary-500"
          :style="{ width: `${(item.score / 25) * 100}%` }"
        />
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ScoreBreakdown',
  props: {
    breakdown: {
      type: Object,
      default: () => ({}),
    },
  },
  computed: {
    items() {
      return [
        { key: 'situation', label: '상황 반영도', score: this.scoreOf('situation') },
        { key: 'menuAppeal', label: '메뉴 매력 전달', score: this.scoreOf('menuAppeal') },
        { key: 'hook', label: '첫 문장 후킹력', score: this.scoreOf('hook') },
        { key: 'cta', label: '방문/구매 유도력', score: this.scoreOf('cta') },
      ]
    },
  },
  methods: {
    scoreOf(key) {
      const value = Number(this.breakdown[key] || 0)
      if (!Number.isFinite(value)) {
        return 0
      }
      return Math.max(0, Math.min(25, value))
    },
  },
}
</script>
