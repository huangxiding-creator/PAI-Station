"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// app.ts — 总包学园入口：云开发按需初始化
const index_1 = require("./config/index");
App({
    cloudReady: false,
    onLaunch() {
        if (index_1.appConfig.features.cloud && index_1.appConfig.cloudEnvId && wx.cloud) {
            wx.cloud.init({ env: index_1.appConfig.cloudEnvId, traceUser: true });
            this.cloudReady = true;
        }
        // cloud 未开通=cloudReady 保持 false，各页按 featureFlags 降级（无日志输出，XY14 门禁）
    },
});
