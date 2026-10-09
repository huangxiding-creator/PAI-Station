// pages/rank/rank.ts — 3c 榜单页：一周商机故事+三榜单（省级热度/最大单/新入榜业主）。
// 公开内容页（纯信息分享无利益诱导——红线自查项）；引擎 ISO 周快照冻结=周更节奏。
// 失败=空态+重试（不静默造数）；行点击穿卡详情/报告详情；分享载荷=周榜本身（谈资传播）。
import { rankingsGet, RankResp, RankStory } from '../../utils/api'

interface HeatView extends Record<string, unknown> {
  rank: number
  province: string
  cards: number
  scans_7d: number
  score: number
  barPct: number // 条形宽度=score/榜首（仅展示比例）
}

Page({
  data: {
    loading: true,
    failed: false,
    week: '',
    heat: [] as HeatView[],
    deals: [] as RankResp['max_deals'],
    owners: [] as RankResp['rising_owners'],
    story: null as RankStory | null,
  },

  onLoad() {
    this.refresh()
  },

  async refresh() {
    this.setData({ loading: true, failed: false })
    try {
      const r = await rankingsGet()
      const top = (r.province_heat && r.province_heat[0] && r.province_heat[0].score) || 0
      this.setData({
        loading: false,
        week: r.week || '',
        heat: (r.province_heat || []).map((h) => ({
          ...h,
          barPct: top > 0 ? Math.max(6, Math.round((h.score / top) * 100)) : 0,
        })),
        deals: r.max_deals || [],
        owners: r.rising_owners || [],
        story: r.story || null,
      })
    } catch {
      this.setData({ loading: false, failed: true })
    }
  },

  onRetry() {
    this.refresh()
  },

  /** 最大单行 → 卡详情落地页（免登录可读该条全文） */
  onOpenCard(e: WechatMiniprogram.TouchEvent) {
    const id = String(e.currentTarget.dataset.id || '')
    if (id) wx.navigateTo({ url: `/pages/cards/detail?card_id=${encodeURIComponent(id)}` })
  },

  /** 新入榜业主行 / 故事「读完整拆解」→ 报告详情 */
  onOpenReport(e: WechatMiniprogram.TouchEvent) {
    const rid = String(e.currentTarget.dataset.rid || '')
    if (rid) wx.navigateTo({ url: `/pages/detail/detail?id=${encodeURIComponent(rid)}` })
  },

  onShareAppMessage(): WechatMiniprogram.Page.ICustomShareContent {
    return {
      title: `总包学园商机周榜${this.data.week ? `（${this.data.week}）` : ''}`,
      path: '/pages/rank/rank',
    }
  },
})
