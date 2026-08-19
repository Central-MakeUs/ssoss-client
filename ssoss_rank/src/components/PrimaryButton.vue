<template>
  <button
    type="button"
    :disabled="disabled || loading"
    class="flex h-[52px] w-full min-h-[44px] items-center justify-center rounded-lg bg-primary-500 text-[16px] font-semibold tracking-[-0.16px] text-white disabled:bg-neutral-200 disabled:text-neutral-400"
    @click="$emit('click')"
  >
    <span
      v-if="loading"
      class="mr-2 h-4 w-4 animate-spin rounded-full border-2 border-white/40 border-t-white"
    />
    {{ label }}
  </button>
</template>

<script>
export default {
  name: 'PrimaryButton',
  props: {
    label: {
      type: String,
      required: true,
    },
    disabled: {
      type: Boolean,
      default: false,
    },
    loading: {
      type: Boolean,
      default: false,
    },
  },
  emits: ['click'],
}
</script>
