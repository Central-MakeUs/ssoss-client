<template>
  <header
    class="sticky top-0 z-20 flex h-14 items-center bg-white px-4 pt-[env(safe-area-inset-top)] sm:px-6 md:h-16 md:px-10 lg:px-16"
  >
    <button
      v-if="showBack"
      type="button"
      class="flex h-11 w-11 items-center justify-center text-black"
      aria-label="뒤로가기"
      @click="$emit('back')"
    >
      <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" aria-hidden="true">
        <path
          d="M15 6 9 12l6 6"
          stroke="currentColor"
          stroke-width="1.8"
          stroke-linecap="round"
          stroke-linejoin="round"
        />
      </svg>
    </button>
    <div v-else class="w-11" />
    <h1
      class="flex-1 text-center text-[16px] font-semibold leading-[1.5] tracking-[-0.16px] text-black md:text-[18px]"
    >
      {{ title }}
    </h1>
    <div class="w-11" />
  </header>
</template>

<script>
export default {
  name: 'AppBar',
  props: {
    title: {
      type: String,
      required: true,
    },
    showBack: {
      type: Boolean,
      default: false,
    },
  },
  emits: ['back'],
}
</script>
