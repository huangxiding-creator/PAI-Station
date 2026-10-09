// config/index.ts — 功能开关中心：后台能力开通一处翻转，代码零改动
export interface FeatureFlags {
  /** 虚拟支付（wx.requestVirtualPayment）——后台开通后置 true */
  virtualPay: boolean
  /** 云开发（AI 对话/知识库/PDF 云存储）——环境开通后置 true 并填 cloudEnvId */
  cloud: boolean
  /** 同声传译插件（WechatSI）——后台插件申请通过后置 true */
  voiceInput: boolean
  /** P1 玩法包（点赞赠/书券/邀请/组队/批评入口）——引擎 P1 未随包部署或灰度期置 false，全入口隐藏零死按钮 */
  p1: boolean
}

export interface AppConfig {
  cloudEnvId: string
  trialChapterCount: number
  /** 引擎环境：dev=本机 8872 影子位；prod=备案域名 nginx 反代 8871（域名 TBD 用户定，API_DESIGN §一） */
  apiEnv: 'dev' | 'prod'
  /** 引擎未就绪时走本地 fixtures（按 API_DESIGN 形状）；联调=翻此 flag，请求函数签名不变 */
  mockApi: boolean
  features: FeatureFlags
}

const DEV_BASE = 'http://127.0.0.1:8872/api/v1'
// 占位：提审生产域名定稿后替换（须 HTTPS+备案域名，加入小程序后台 request 合法域名）
const PROD_BASE = 'https://api.zongbao-xueyuan.tbd/api/v1'

// 测试/harness 可注入 BaseURL（biaoxun __QW_BASE__ 同款惯例），不扰默认行为
function resolveBase(env: 'dev' | 'prod'): string {
  try {
    const ovr = (globalThis as Record<string, unknown>).__XY_BASE__
    if (typeof ovr === 'string' && ovr) return ovr
  } catch {
    // globalThis 不可用时静默走默认
  }
  return env === 'prod' ? PROD_BASE : DEV_BASE
}

export function apiBaseUrl(): string {
  return resolveBase(appConfig.apiEnv)
}

export const appConfig: AppConfig = {
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
}
