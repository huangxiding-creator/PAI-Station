// app.ts — WeAppForge hello 模板入口
App<{
  launchCount: number
}>({
  launchCount: 0,
  onLaunch() {
    this.launchCount += 1
    console.log(`WeAppForge hello launched (#${this.launchCount})`)
  },
})
