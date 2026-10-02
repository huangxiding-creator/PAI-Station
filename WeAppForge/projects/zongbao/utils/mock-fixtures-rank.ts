// utils/mock-fixtures-rank.ts — mockApi 榜单/一周故事夹具与路由处理器（3c）：
// 契约 GET /rankings（公开）→ {week, province_heat, max_deals, rising_owners, story, formula}
// （引擎 xueyuan_engine/leaderboard.py 同形状；周快照=ISO 周首访冻结，mock 固定样本即可）。
// max_deals/story 由 CARDS 派生（卡 id 保证 mock 内可点穿到 detail 夹具）；
// province_heat/rising_owners 为展示样本（heat 行不可点，无跨夹具耦合）。
// 注册方式照 mock-fixtures-cards.ts 惯例：api.ts 尾部 mockApi 分支接 mockRankRequest。
// 密钥卫生：本文件不含任何密钥/凭据类字段（卫生扫描断言目标）。
import { CARDS } from './mock-fixtures-cards'

interface Resp {
  status: number
  body: unknown
}

const ok = (body: unknown): Resp => ({ status: 200, body })

/** 金额文本→亿元（与引擎 leaderboard.amount_yi 同口径：万/亿单位，无数字=0） */
function amountYi(text: string): number {
  const m = /([0-9][0-9,，.]*)(?:\s*(亿|万))?/.exec(text || '')
  if (!m || !m[1]) return 0
  const n = Number(m[1].replace(/[,，]/g, ''))
  if (!Number.isFinite(n)) return 0
  if (m[2] === '亿') return n
  if (m[2] === '万') return n / 10000
  return n / 100000000
}

/** 卡派生最大单榜：金额降序 TOP5（id 在 CARDS 内，mock 点穿有落点） */
function deriveDeals() {
  return CARDS
    .map((c) => ({ card: c, yi: amountYi(c.amount || c.amount_raw) }))
    .filter((x) => x.yi > 0)
    .sort((a, b) => b.yi - a.yi)
    .slice(0, 5)
    .map((x, i) => ({
      rank: i + 1,
      card_id: x.card.id,
      title: x.card.title,
      amount: x.card.amount || x.card.amount_raw,
      amount_yi: x.yi,
      province: x.card.province,
      owner: x.card.owner,
      report_id: x.card.report_id,
      report_title: `${x.card.report_id}（夹具报告）`,
    }))
}

/** 卡派生一周故事（TOP1 卡三段式，与引擎模板同构：全字段真实拼装） */
function deriveStory() {
  const top = deriveDeals()[0]
  if (!top) return null
  const c = CARDS.find((x) => x.id === top.card_id)!
  const bg = `本周商机焦点落在${c.province}。业主方为${c.owner}，项目处于${c.stage}阶段。`
  const proj = `${c.title}，投资规模约${top.amount}。窗口期${c.window}。`
  const eat = `该商机出自《${top.report_title}》${c.source_chapter}，完整拆解含切入策略与对接建议，小程序内可免费试读。`
  return {
    card_id: c.id, title: c.title, amount: top.amount, amount_yi: top.amount_yi,
    province: c.province, owner: c.owner, stage: c.stage, window: c.window,
    report_id: c.report_id, report_title: top.report_title,
    paragraphs: [bg, proj, eat],
  }
}

/** 榜单整包夹具（契约冻结形状；heat 含两省展示条形对比） */
export const RANK = {
  week: '2026-W40',
  generated_at: '2026-09-28T08:00:00',
  province_heat: [
    { rank: 1, province: '江苏', cards: 42, scans_7d: 18, score: 78 },
    { rank: 2, province: '广东', cards: 9, scans_7d: 2, score: 13 },
  ],
  max_deals: deriveDeals(),
  rising_owners: [
    { rank: 1, owner: '苏州市水务局', amount: '2.4亿', province: '江苏',
      report_id: 'js-shuiwang-2026', report_title: 'js-shuiwang-2026（夹具报告）' },
    { rank: 2, owner: '无锡市水务集团', amount: '9600万', province: '江苏',
      report_id: 'js-shuiwang-2026', report_title: 'js-shuiwang-2026（夹具报告）' },
  ],
  story: deriveStory(),
  formula: {
    province_heat: 'score = 省内商机卡数×1 + 近7日扫码×2（本周快照冻结）',
    max_deals: '库内全量口径（卡数据无时间戳，月度口径待 A 线时间字段）',
    rising_owners: '仅出现在最新 published_at 报告中的业主（真时间轴）',
    story: '金额 TOP12 池按 ISO 周序号确定性轮换（零模型）',
  },
}

/** 榜单 mock 路由：命中返回 {status,body}；非榜单路由返回 null */
export function handleRank(method: string, route: string): Resp | null {
  if (route === '/rankings' && method === 'GET') return ok(RANK)
  return null
}

/** mock 入口：与 mockRequest 同构签名（{status,body}，30ms 延迟对齐既有夹具体感） */
export function mockRankRequest(method: string, path: string): Promise<Resp> {
  return new Promise((resolve) => {
    const route = path.split('?')[0]
    const resp = handleRank(method, route)
    setTimeout(() => resolve(resp || { status: 404, body: { code: 'NOT_FOUND', message: `mock 未实现: ${method} ${route}` } }), 30)
  })
}
