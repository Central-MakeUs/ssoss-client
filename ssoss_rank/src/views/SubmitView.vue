<template>
  <div class="flex min-h-dvh w-full flex-col bg-white">
    <template v-if="submitting">
      <div class="flex flex-1 flex-col items-center justify-center px-6">
        <div
          class="h-[72px] w-[72px] animate-spin rounded-full border-4 border-primary-100 border-t-primary-500"
        />
        <h2 class="mt-6 text-center text-[28px] font-semibold leading-[1.4] tracking-[-0.28px] text-black">
          콘텐츠를 채점하고 있어요
        </h2>
        <p class="mt-3 text-center text-[14px] leading-[1.5] tracking-[-0.14px] text-neutral-500">
          본문만 보고 점수를 매기고 있어요
        </p>
      </div>
    </template>

    <template v-else>
      <AppBar title="콘텐츠 제출" show-back @back="$router.push('/')" />
      <form
        class="flex w-full flex-1 flex-col px-4 pb-[calc(88px+env(safe-area-inset-bottom))] pt-2 sm:px-6 md:px-10 lg:px-16"
        @submit.prevent="onSubmit"
      >
        <label class="mt-4 block text-[14px] font-semibold tracking-[-0.14px] text-black">
          이름
        </label>
        <input
          v-model="name"
          maxlength="20"
          type="text"
          placeholder="이름을 입력해 주세요"
          class="mt-2 h-[52px] w-full rounded-lg border border-neutral-200 px-4 text-[16px] tracking-[-0.16px] text-black outline-none placeholder:text-neutral-400 focus:border-primary-500"
        >
        <label class="mt-6 block text-[14px] font-semibold tracking-[-0.14px] text-black">
          본문
        </label>
        <textarea
          v-model="body"
          maxlength="4000"
          placeholder="앱에서 복사한 본문을 붙여 넣어 주세요"
          class="mt-2 min-h-[220px] w-full flex-1 resize-none rounded-lg border border-neutral-200 px-4 py-3 text-[16px] leading-[1.5] tracking-[-0.16px] text-black outline-none placeholder:text-neutral-400 focus:border-primary-500"
        />
        <p v-if="error" class="mt-3 text-[14px] text-primary-600">
          {{ error }}
        </p>
      </form>
      <div
        class="fixed inset-x-0 bottom-0 bg-white px-4 pb-[calc(16px+env(safe-area-inset-bottom))] pt-3 sm:px-6 md:px-10 lg:px-16"
      >
        <div class="w-full md:flex md:justify-end">
          <div class="w-full md:w-[240px]">
            <PrimaryButton
              label="채점하기"
              :disabled="!canSubmit"
              @click="onSubmit"
            />
          </div>
        </div>
      </div>
    </template>
  </div>
</template>

<script>
import AppBar from '../components/AppBar.vue'
import PrimaryButton from '../components/PrimaryButton.vue'
import { submitContent } from '../api'

export default {
  name: 'SubmitView',
  components: { AppBar, PrimaryButton },
  data() {
    return {
      name: '',
      body: '',
      error: '',
      submitting: false,
    }
  },
  computed: {
    canSubmit() {
      const name = this.name.trim()
      const body = this.body.trim()
      return name.length >= 1 && name.length <= 20 && body.length >= 1 && body.length <= 4000
    },
  },
  methods: {
    async onSubmit() {
      if (!this.canSubmit || this.submitting) {
        return
      }
      this.error = ''
      this.submitting = true
      try {
        const result = await submitContent({
          name: this.name.trim(),
          body: this.body.trim(),
        })
        this.$router.replace({ name: 'home' })
        this.$router.push({ name: 'result', params: { id: String(result.id) } })
      } catch (err) {
        this.submitting = false
        this.error = err.message || '채점에 실패했습니다'
      }
    },
  },
}
</script>
