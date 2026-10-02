// app.ts — 总包学园入口：云开发按需初始化
import { appConfig } from './config/index'

App<{
  cloudReady: boolean
}>({
  cloudReady: false,
  onLaunch() {
    if (appConfig.features.cloud && appConfig.cloudEnvId && wx.cloud) {
      wx.cloud.init({ env: appConfig.cloudEnvId, traceUser: true })
      this.cloudReady = true
    }
    // cloud 未开通=cloudReady 保持 false，各页按 featureFlags 降级（无日志输出，XY14 门禁）
  },
})
