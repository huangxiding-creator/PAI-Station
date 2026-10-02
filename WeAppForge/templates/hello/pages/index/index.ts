// pages/index/index.ts — 首页：计数器演示
Page({
  data: {
    count: 0,
    motto: 'WeAppForge 一句话 → 我的小程序后台',
  },
  onIncrement() {
    this.setData({ count: this.data.count + 1 })
  },
})
