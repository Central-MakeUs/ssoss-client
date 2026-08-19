<template>
  <svg
    class="h-12 w-12 md:h-14 md:w-14"
    viewBox="0 0 48 48"
    fill="none"
    aria-hidden="true"
  >
    <path d="M18 8h12l-3.5 10h-5L18 8Z" :fill="ribbon" />
    <path d="M18 8 10 22l7 2 4.5-6L18 8Z" :fill="ribbonDark" />
    <path d="M30 8l8 14-7 2-4.5-6L30 8Z" :fill="ribbonDark" />
    <circle cx="24" cy="30" r="12" :fill="metal" />
    <circle cx="24" cy="30" r="8.5" :stroke="metalDark" stroke-width="1.5" />
    <text
      x="24"
      y="34"
      text-anchor="middle"
      font-size="12"
      font-weight="700"
      :fill="metalDark"
    >
      {{ rank }}
    </text>
  </svg>
</template>

<script>
const MEDALS = {
  1: { metal: '#F5C542', metalDark: '#B8860B', ribbon: '#F9560E', ribbonDark: '#DA4000' },
  2: { metal: '#D4D4D4', metalDark: '#737373', ribbon: '#737373', ribbonDark: '#525252' },
  3: { metal: '#E0A06A', metalDark: '#8A4B1F', ribbon: '#C47A3A', ribbonDark: '#8A4B1F' },
}

export default {
  name: 'MedalIcon',
  props: {
    rank: {
      type: Number,
      required: true,
    },
  },
  computed: {
    palette() {
      return MEDALS[this.rank] || MEDALS[3]
    },
    metal() {
      return this.palette.metal
    },
    metalDark() {
      return this.palette.metalDark
    },
    ribbon() {
      return this.palette.ribbon
    },
    ribbonDark() {
      return this.palette.ribbonDark
    },
  },
}
</script>
