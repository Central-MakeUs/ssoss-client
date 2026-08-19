/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './public/index.html',
    './src/**/*.{vue,js}',
  ],
  theme: {
    extend: {
      colors: {
        primary: {
          50: '#FFF6F2',
          100: '#FFE1D3',
          200: '#FFCDB2',
          300: '#FF9E70',
          400: '#FF763B',
          500: '#F9560E',
          600: '#DA4000',
          700: '#B43200',
          800: '#882400',
          900: '#6F2D1B',
        },
        neutral: {
          50: '#FAFAFA',
          100: '#F5F5F5',
          200: '#E5E5E5',
          300: '#D4D4D4',
          400: '#A1A1A1',
          500: '#737373',
          600: '#525252',
          700: '#404040',
          800: '#262626',
        },
        black: '#171717',
      },
      fontFamily: {
        sans: [
          'Pretendard',
          '-apple-system',
          'BlinkMacSystemFont',
          'system-ui',
          'sans-serif',
        ],
      },
    },
  },
  plugins: [],
}
