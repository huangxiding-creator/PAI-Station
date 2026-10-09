// utils/api.ts — 统一请求封装：Bearer 注入 / 401 静默重登重试一次 / 503 PAY_NOT_CONFIGURED 灰置事件 /
// 网络失败「服务维护」降级（NFR-10/11，API_DESIGN §五降级矩阵）。
// mockApi 模式与真实请求同一函数签名（config.mockApi 翻 flag 即联调）。
import { appConfig, apiBaseUrl } from '../config/index'
import { mockRequest } from './mock-fixtures'

export interface ApiErr extends Error {
  code?: string
  statusCode?: number
  network?: boolean
}

const TOKEN_KEY = 'zongbao_token'
const UID_KEY = 'zongbao_uid'

export function token(): string {
  try {
    return (wx.getStorageSync(TOKEN_KEY) as string) || ''
  } catch {
    return ''
  }
}

function setToken(t: string, uid?: string): void {
  try {
    if (t) wx.setStorageSync(TOKEN_KEY, t)
    else wx.removeStorageSync(TOKEN_KEY)
    if (uid) wx.setStorageSync(UID_KEY, uid)
  } catch (e) {
    console.error('[api] token 落盘失败', e)
  }
}

export function errMsg(err: unknown, fallback = '请求失败，请稍后重试'): string {
  const e = err as ApiErr
  return (e && e.message) || fallback
}

// —— 支付灰置事件（三层矩阵：本地开关在 pay.ts；此处承接服务端 503 与 login 预判）——
export interface PayGrayInfo {
  code: string
  message: string
  source: string
}
type PayGrayListener = (info: PayGrayInfo) => void
const payGrayListeners: PayGrayListener[] = []
let payGrayed = false

export function onPayGray(cb: PayGrayListener): () => void {
  payGrayListeners.push(cb)
  return () => {
    const i = payGrayListeners.indexOf(cb)
    if (i >= 0) payGrayListeners.splice(i, 1)
  }
}

export function isPayGrayed(): boolean {
  return payGrayed
}

function emitPayGray(code: string, message: string, source: string): void {
  payGrayed = true
  payGrayListeners.forEach((cb) => {
    try {
      cb({ code, message, source })
    } catch (e) {
      console.error('[api] 灰置监听器异常', e)
    }
  })
}

const NETWORK_MSG = '服务维护中，试读内容仍可离线阅读'

function httpError(statusCode: number, body: unknown): ApiErr {
  const b = (body || {}) as { code?: string; message?: string; detail?: string }
  const e = new Error(b.message || b.detail || `HTTP ${statusCode}`) as ApiErr
  e.statusCode = statusCode
  e.code = b.code
  if (b.code === 'PAY_NOT_CONFIGURED') {
    // 503 降级契约：前端灰置支付入口，试读/收藏/搜索不受影响（NFR-10）
    emitPayGray(b.code, b.message || '虚拟支付尚未开通', 'server_503')
  }
  return e
}

function rawWxRequest(method: string, path: string, data: unknown): Promise<unknown> {
  return new Promise((resolve, reject) => {
    wx.request({
      url: apiBaseUrl() + path,
      method: method as 'GET' | 'POST' | 'DELETE',
      data: data as string | object | undefined,
      timeout: 10000,
      header: {
        'Content-Type': 'application/json',
        Authorization: token() ? `Bearer ${token()}` : '',
      },
      success(res) {
        if (res.statusCode >= 200 && res.statusCode < 300) resolve(res.data)
        else reject(httpError(res.statusCode, res.data))
      },
      fail(errRes) {
        const raw = String((errRes && errRes.errMsg) || '')
        const e = new Error(NETWORK_MSG) as ApiErr
        e.network = true
        e.code = 'NETWORK'
        if (raw.indexOf('url not in domain list') >= 0) {
          e.message = '未开调试模式：点右上角"…"→开发调试→打开调试，重启小程序后重试'
        }
        reject(e)
      },
    })
  })
}

/** 单一请求入口：mock/真实同一签名；401 静默重登换发后重试一次（qianwen 惯例） */
export function request<T>(method: string, path: string, data?: unknown, opts?: { anon?: boolean }): Promise<T> {
  const attempt = (retryable: boolean): Promise<T> => {
    const transport = (): Promise<T> => {
      if (appConfig.mockApi) {
        // mock 应答 {status, body} 与 wx.request 成功分支同构归一（2xx 解包/非 2xx 走 httpError）
        return mockRequest(method, path, data, token()).then((r) => {
          if (r.status >= 200 && r.status < 300) return r.body as T
          throw httpError(r.status, r.body)
        })
      }
      return rawWxRequest(method, path, data) as Promise<T>
    }
    return transport().catch((err) => {
      const e = err as ApiErr
      if (e && e.statusCode === 401 && retryable && !opts?.anon) {
        return silentLogin().then(() => attempt(false))
      }
      throw err
    })
  }
  return attempt(true)
}

let loginInflight: Promise<void> | null = null

/** 静默登录：wx.login → POST /auth/login 换发 token（登录端点自身不再触发 401 重试） */
export function silentLogin(): Promise<void> {
  if (loginInflight) return loginInflight
  loginInflight = new Promise<void>((resolve, reject) => {
    wx.login({
      success(r) {
        if (!r.code) {
          reject(new Error('微信登录失败，请重试') as ApiErr)
          return
        }
        const transport = (): Promise<unknown> =>
          appConfig.mockApi
            ? mockRequest('POST', '/auth/login', { code: r.code }, '').then((r) => {
                if (r.status >= 200 && r.status < 300) return r.body
                throw httpError(r.status, r.body)
              })
            : rawWxRequest('POST', '/auth/login', { code: r.code })
        transport()
          .then((d) => {
            const resp = d as { token: string; uid?: string; pay_configured?: boolean }
            setToken(resp.token, resp.uid)
            if (resp.pay_configured === false) {
              // login 回包预判灰置（API_DESIGN §五）
              emitPayGray('PAY_NOT_CONFIGURED', '虚拟支付尚未开通', 'login_hint')
            }
            resolve()
          })
          .catch(reject)
      },
      fail() {
        reject(new Error('微信登录调用失败，请重试') as ApiErr)
      },
    })
  })
  const clear = () => {
    loginInflight = null
  }
  loginInflight.then(clear, clear)
  return loginInflight
}

// —— 端点封装（API_DESIGN P0 全量前端所需）——
export interface CatalogQuery {
  tab?: 'hot' | 'new'
  province?: string
  owner_type?: string
  industry?: string
  page?: number
  page_size?: number
}

export interface CatalogResp {
  items: Array<Record<string, unknown>>
  total: number
  page: number
  page_size: number
  praise_visible?: boolean
}

export function buildQuery(q: Record<string, string | number | undefined>): string {
  return Object.keys(q)
    .filter((k) => q[k] !== undefined && q[k] !== '')
    .map((k) => `${k}=${encodeURIComponent(String(q[k]))}`)
    .join('&')
}

export const api = {
  catalog(q: CatalogQuery): Promise<CatalogResp> {
    return request<CatalogResp>('GET', `/catalog?${buildQuery({ ...q })}`)
  },
  search(kw: string): Promise<{
    layer_used: string
    items: Array<Record<string, unknown>>
    hot_words: string[]
    fallback_hint: boolean
  }> {
    return request('GET', `/search?${buildQuery({ q: kw })}`)
  },
  report(id: string): Promise<Record<string, unknown>> {
    return request('GET', `/reports/${id}`)
  },
  chapters(id: string, withContent: 'trial' | 'all' = 'trial'): Promise<{
    report_id: string
    trial_chapters: number
    chapters: Array<{ id: string; title: string; idx?: number; is_trial?: number; html?: string; pages?: number }>
  }> {
    return request('GET', `/reports/${id}/chapters?with_content=${withContent}`)
  },
  fetchChapter(id: string, chapterId: string): Promise<{ chapter_id: string; html: string; is_trial: number }> {
    return request('POST', `/reports/${id}/chapters/${chapterId}`, {})
  },
  favorite(id: string, on: boolean): Promise<{ favorited: boolean }> {
    return request(on ? 'POST' : 'DELETE', `/reports/${id}/favorite`, {})
  },
  paySign(reportId: string): Promise<{
    mode: string
    sign_data: string
    pay_sig: string
    signature: string
    out_trade_no: string
    price_fen: number
  }> {
    return request('POST', '/pay/sign', { report_id: reportId })
  },
  payStatus(outTradeNo: string): Promise<{
    out_trade_no: string
    report_id: string
    status: 'pending' | 'paid' | 'failed'
    entitlement_granted: boolean
  }> {
    return request('GET', `/pay/status?${buildQuery({ out_trade_no: outTradeNo })}`)
  },
  me(): Promise<{
    uid: string
    entitlements: Array<{ report_id: string; source: string; granted_at: string }>
    favorites: Array<{ report_id: string; favorited_at: string }>
    vouchers_balance_fen: number
    refund_count_month?: number
    refund_monthly_limit?: number
    /** P0-12 P1 扩展字段（向后兼容追加，API_DESIGN 说明；me 页退款记录列表数据源） */
    refunds?: Array<{
      refund_id: string
      report_id: string
      amount_fen: number
      method: string
      status: string
      created_at: string
    }>
  }> {
    return request('GET', '/me')
  },

  // —— P1 端点封装（API_DESIGN P1-1/2/3/4/8/9/10）——

  /** P1-1 点赞→赠报告（与分享完全解耦；当日第二次 429 GIFT_DAILY_LIMIT） */
  like(reportId: string): Promise<{ granted: boolean; granted_report_id: string; gift_rule: string }> {
    return request('POST', `/reports/${reportId}/like`, {})
  },

  /** P1-2 批评提交（四层闸同步预筛；409 SIMILARITY_HIGH 带 stage=manual_pending 转人工不自动拒） */
  criticize(
    reportId: string,
    content: string,
    orderId?: string,
  ): Promise<{
    criticism_id: string
    stage: string
    anchor_score?: number
    similarity_score?: number
    scoring?: string
    poll?: string
  }> {
    return request('POST', `/reports/${reportId}/criticize`, orderId ? { content, order_id: orderId } : { content })
  },

  /** P1-3 批评结果查询（仅作者；评分异步落 llm_scores/final_score/refund） */
  criticism(id: string): Promise<{
    id: string
    status: string
    llm_scores?: { sincerity: number; authenticity: number; constructiveness: number; rationale: string }
    final_score?: number
    refund_tier?: string
    refund?: { refund_id: string; method: string; amount_fen: number; status: string } | null
  }> {
    return request('GET', `/criticisms/${id}`)
  },

  /** P1-4 退款申请（评分路径；423 FUSE_OPEN=熔断停新发起） */
  refundApply(criticismId: string): Promise<{
    refund_id: string
    platform: string
    tier: string
    method: string
    amount_fen: number
    status: string
    ios_track: string | null
  }> {
    return request('POST', '/refund/apply', { criticism_id: criticismId })
  },

  /** P1-8 邀请关系与进度（me 页情报官卡；v1.2 扩 level/ladder，new_users 语义升级=有效带新数，required=1 即 L1 门槛） */
  inviteRelations(): Promise<{
    invited: Array<{ invitee_uid: string; status: string; ts: string }>
    progress: { new_users: number; required: number; unlocked: boolean }
    voucher_earned_fen: number
    /** v1.2 情报官体系扩展（向后兼容追加；引擎未升级时缺席，前端按有效带新数推导） */
    level?: 'none' | 'L1' | 'L2' | 'L3'
    level_name?: '' | '观察员' | '分析师' | '情报官'
    effective_count?: number
    next_threshold?: number | null
    ladder?: Array<{ level: 'L1' | 'L2' | 'L3'; name: string; threshold: number; reached: boolean }>
  }> {
    return request('GET', '/invite/relations')
  },

  /** v1.2 情报官·阅读停留上报（有效带新条件②累计停留满 3 分钟；无归因关系恒 200 relation_marked:false；fire-and-forget 静默失败） */
  inviteDwell(reportId: string, seconds: number): Promise<{ relation_marked: boolean; effective: boolean }> {
    return request('POST', '/invite/dwell', { report_id: reportId, seconds })
  },

  /** P1-9 创建组队（¥998/3 人；重复入队 409） */
  teamCreate(reportId: string): Promise<{
    team_id: string
    report_id: string
    leader_uid: string
    size: number
    capacity: number
    total_price_fen: number
    status: string
  }> {
    return request('POST', '/team', { report_id: reportId })
  },

  /** P1-9 加入组队（TEAM_FULL/TEAM_DUP→409） */
  teamJoin(teamId: string): Promise<{
    team_id: string
    report_id: string
    leader_uid: string
    size: number
    capacity: number
    total_price_fen: number
    status: string
  }> {
    return request('POST', `/team/${teamId}/join`, {})
  },

  /** P1-10 书券账本（发放/消耗/余额三条一致；书券非卖品无提现出口） */
  meVouchers(): Promise<{
    balance_fen: number
    ledger: Array<{
      id: string
      amount_fen: number
      source: string
      source_ref: string
      status: string
      created_at: string
    }>
  }> {
    return request('GET', '/me/vouchers')
  },

  /** P1-10 书券兑换报告（49800 分兑一份；余额不足 400 BALANCE_INSUFFICIENT） */
  voucherRedeem(reportId: string): Promise<{ redeemed: boolean; deducted_fen: number; report_id: string }> {
    return request('POST', '/vouchers/redeem', { report_id: reportId })
  },
}

export function resetPayGrayForTest(): void {
  payGrayed = false
}

// —— 商机卡（情报裂变 2.0 落地页；契约字段名冻结）——
// card_id 为不透明字符串（真实形态 <report_id>-cNNN），前端不做任何格式正则校验
// 契约1 GET /cards/{card_id} 公开（无 Bearer 也可，落地页语义）→ {card, report}
// 契约2 GET /cards/by-report/{rid} 两态：匿名/未购=前 3 张+locked:true+total；Bearer 且已购=全量分页
// 契约3 GET /cards/resolve?scene= → {card_id}；解析失败引擎降级 {card_id:""} 恒 200（同 invite/scan 哲学）
// mock 接线：/cards/* 路由不在 mock-fixtures.ts 路由表（该文件归 P0/P1 所有），
// 此处 mockApi 分支接 mock-fixtures-cards（注册方式同 handleP1 的 deps 注入惯例）；
// 引擎 404 错误信封为 {error:{code,message}} 嵌套形，归一后复用既有 httpError（机制为准适配）。
import { mockCardsRequest } from './mock-fixtures-cards'

export interface CardItem {
  id: string
  report_id: string
  title: string
  /** 展示串（如「190万」），可为空串（空则整行隐藏，不得渲染 ¥ 或 0） */
  amount: string
  /** 原始文本串（如「190万元」），非数字 */
  amount_raw: string
  owner: string
  stage: string
  window: string
  province: string
  /** 引擎已富化的显示串（如「第 11 章 · 某某」），前端直渲染不自行映射 */
  source_chapter: string
  summary: string
}

export interface CardReportRef {
  id: string
  title: string
  price_fen: number
  cover: string
  trial_chapters: number
}

export interface CardDetailResp {
  card: CardItem
  report: CardReportRef
}

export interface CardsByReportResp {
  cards: CardItem[]
  total: number
  page: number
  locked?: boolean
  page_size?: number
}

/** 卡端点统一入口：mock 走 fixtures（{status,body} 同构归一），真身走 request（Bearer/401 重试） */
function cardRequest<T>(method: string, path: string): Promise<T> {
  if (appConfig.mockApi) {
    return mockCardsRequest(method, path, undefined, token()).then((r) => {
      if (r.status >= 200 && r.status < 300) return r.body as T
      const body = (r.body || {}) as Record<string, unknown>
      const norm = body && typeof body.error === 'object' ? (body.error as Record<string, unknown>) : body
      throw httpError(r.status, norm)
    })
  }
  return request<T>(method, path)
}

/** 契约1：商机卡详情（公开落地页；404 → code=CARD_NOT_FOUND 错误信封上抛） */
export function cardDetail(cardId: string): Promise<CardDetailResp> {
  return cardRequest<CardDetailResp>('GET', `/cards/${encodeURIComponent(cardId)}`)
}

/** 契约3：卡二维码 scene → card_id（引擎降级恒 200 {card_id:""}，不 reject） */
export function cardResolve(scene: string): Promise<{ card_id: string }> {
  return cardRequest<{ card_id: string }>('GET', `/cards/resolve?${buildQuery({ scene })}`)
}

/** 契约2：按报告取卡列表（opts.page/page_size 默认 1/20）；
 * 匿名/未购由引擎回 locked 形状；请求失败按 locked 空形状兜底，卡列表调用方零崩 */
export async function cardsByReport(rid: string, opts?: { page?: number; page_size?: number }): Promise<CardsByReportResp> {
  const page = opts?.page ?? 1
  const pageSize = opts?.page_size ?? 20
  try {
    return await cardRequest<CardsByReportResp>(
      'GET',
      `/cards/by-report/${encodeURIComponent(rid)}?${buildQuery({ page, page_size: pageSize })}`,
    )
  } catch {
    return { cards: [], total: 0, page, locked: true }
  }
}

// —— P2 端点封装（AI 伴读/已购检索/转赠/订阅；契约字段名冻结；mock 走 mock-fixtures-p2 注册进 mockRequest 的路由）——

/** 伴读引用段（引擎 ai_chat local_answer 形状：章节定位四件） */
export interface ChatCitation {
  chapter_id: string
  chapter_title: string
  /** 页码估算（引擎 CHARS_PER_PAGE 口径） */
  page: number
  /** 命中句 ±40 字原文 */
  quote: string
}

export interface ChatResp {
  report_id: string
  question: string
  answer: string
  provider: 'local' | 'openai_compat'
  citations: ChatCitation[]
  degraded: boolean
  disclaimer: string
}

/** P2 契约1：AI 伴读提问（Bearer+已购闸；1-200 字；provider 由引擎答，前端不做任何模型选择） */
export function chatReport(rid: string, question: string): Promise<ChatResp> {
  return request<ChatResp>('POST', `/reports/${encodeURIComponent(rid)}/chat`, { question })
}

export interface OwnedSearchItem {
  report_id: string
  title: string
  chapter_id: string
  chapter_title: string
  snippet: string
  /** 命中词在该章去标签纯文本中的字符偏移（阅读器跳转锚） */
  offset: number
}

export interface OwnedSearchResp {
  items: OwnedSearchItem[]
  total: number
  /** 游标 "{report_id}:{chapter_idx}"；空串=到底 */
  next_cursor: string
  has_more: boolean
}

/** P2 契约2：已购库章级检索（Bearer；游标分页，next_cursor 空串止） */
export function searchOwned(q: string, cursor?: string): Promise<OwnedSearchResp> {
  return request<OwnedSearchResp>('GET', `/search/owned?${buildQuery({ q, cursor })}`)
}

export interface TransferResp {
  transferred: boolean
  transfer_id: string
  report_id: string
  from_uid: string
  to_uid: string
  transferred_at: string
}

/** P2 契约3：转赠（Bearer；仅本人付费购买源；错误族 8 码见 p2-view.transferErrMsg 映射） */
export function transferReport(rid: string, toUid: string): Promise<TransferResp> {
  return request<TransferResp>('POST', `/reports/${encodeURIComponent(rid)}/transfer`, { to_uid: toUid })
}

export type SubscribeKind = 'province' | 'topic'

export interface SubscribeItem {
  kind: SubscribeKind
  value: string
  created_at?: string
}

export interface SubscriptionsResp {
  items: SubscribeItem[]
  configured: boolean
}

/** P2 契约4：订阅探测/读取（未配置引擎 501 SUBSCRIBE_NOT_CONFIGURED → 调用方整块隐藏不报错） */
export function subscriptionsGet(): Promise<SubscriptionsResp> {
  return request<SubscriptionsResp>('GET', '/subscriptions')
}

/** P2 契约4：订阅保存（POST 全量选中集合；引擎幂等合并） */
export function subscriptionsSet(provinces: string[], topics: string[]): Promise<SubscriptionsResp> {
  return request<SubscriptionsResp>('POST', '/subscriptions', { provinces, topics })
}

/** P2 契约4：取消单项订阅 */
export function subscriptionsDelete(kind: SubscribeKind, value: string): Promise<SubscriptionsResp> {
  return request<SubscriptionsResp>('DELETE', '/subscriptions', { kind, value })
}

// ── 榜单/一周故事（3c；公开无鉴权，mock 走 fixtures-rank）──────────────
import { mockRankRequest } from './mock-fixtures-rank'

export interface RankHeatRow {
  rank: number
  province: string
  cards: number
  scans_7d: number
  score: number
}

export interface RankDealRow {
  rank: number
  card_id: string
  title: string
  amount: string
  amount_yi: number
  province: string
  owner: string
  report_id: string
  report_title: string
}

export interface RankOwnerRow {
  rank: number
  owner: string
  amount: string
  province: string
  report_id: string
  report_title: string
}

export interface RankStory {
  card_id: string
  title: string
  amount: string
  amount_yi: number
  province: string
  owner: string
  stage: string
  window: string
  report_id: string
  report_title: string
  paragraphs: string[]
}

export interface RankResp {
  week: string
  generated_at: string
  province_heat: RankHeatRow[]
  max_deals: RankDealRow[]
  rising_owners: RankOwnerRow[]
  story: RankStory | null
  formula: Record<string, string>
}

/** 三榜+故事（公开；引擎 ISO 周快照冻结。失败上抛由页面落空态+重试，不静默造数） */
export function rankingsGet(): Promise<RankResp> {
  if (appConfig.mockApi) {
    return mockRankRequest('GET', '/rankings').then((r) => {
      if (r.status >= 200 && r.status < 300) return r.body as RankResp
      const body = (r.body || {}) as Record<string, unknown>
      const norm = body && typeof body.error === 'object' ? (body.error as Record<string, unknown>) : body
      throw httpError(r.status, norm)
    })
  }
  return request<RankResp>('GET', '/rankings')
}
