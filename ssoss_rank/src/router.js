import { createRouter, createWebHistory } from 'vue-router'
import HomeView from './views/HomeView.vue'
import SubmitView from './views/SubmitView.vue'
import ResultView from './views/ResultView.vue'
import RankingView from './views/RankingView.vue'

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes: [
    { path: '/', name: 'home', component: HomeView },
    { path: '/submit', name: 'submit', component: SubmitView },
    { path: '/result/:id', name: 'result', component: ResultView },
    { path: '/result/:id/ranking', name: 'ranking', component: RankingView },
    { path: '/:pathMatch(.*)*', redirect: '/' },
  ],
  scrollBehavior() {
    return { top: 0 }
  },
})

export default router
