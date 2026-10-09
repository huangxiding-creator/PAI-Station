"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.appConfig = void 0;
exports.apiBaseUrl = apiBaseUrl;
const DEV_BASE = 'http://127.0.0.1:8872/api/v1';
// 占位：提审生产域名定稿后替换（须 HTTPS+备案域名，加入小程序后台 request 合法域名）
const PROD_BASE = 'https://api.zongbao-xueyuan.tbd/api/v1';
// 测试/harness 可注入 BaseURL（biaoxun __QW_BASE__ 同款惯例），不扰默认行为
function resolveBase(env) {
    try {
        const ovr = globalThis.__XY_BASE__;
        if (typeof ovr === 'string' && ovr)
            return ovr;
    }
    catch {
        // globalThis 不可用时静默走默认
    }
    return env === 'prod' ? PROD_BASE : DEV_BASE;
}
function apiBaseUrl() {
    return resolveBase(exports.appConfig.apiEnv);
}
exports.appConfig = {
    cloudEnvId: '', // 云开发环境 ID（开通时填）
    trialChapterCount: 2, // 免费试读章节数（服务端裁剪为准，冲突服务端赢）
    apiEnv: 'dev',
    mockApi: true, // B 线引擎 8872 就绪后置 false 联调
    features: {
        virtualPay: false,
        cloud: false,
        voiceInput: false,
        p1: true,
    },
};
