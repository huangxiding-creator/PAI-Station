// pages/agreement/agreement.ts — 用户协议与规则页（T-P0-26）：
// 八节全文（文案真源 utils/agreement.ts，逐字渲染）；页首三要点卡；
// 一/二节条款折叠可展开（默认收起 1.1-1.5 与 2.2-2.7）；
// anchor=pay 锚定第二节、anchor=transfer 锚定§四转赠、anchor=invite 锚定§六情报官体系块。
import {
  AGREEMENT_SECTIONS,
  PAY_HIGHLIGHTS,
  AGREEMENT_VERSION_LINE,
  AGREEMENT_EFFECTIVE_LINE,
} from '../../utils/agreement'

/** 锚点→滚动目标（节级 sec-*；invite 精确到 §六内 clause-invite 块） */
const ANCHOR_TARGETS: Record<string, string> = {
  pay: 'sec-pay',
  like: 'sec-like',
  transfer: 'sec-transfer',
  team: 'sec-team',
  voucher: 'sec-voucher',
  invite: 'clause-invite',
}

function initialExpanded(): Record<string, boolean> {
  const map: Record<string, boolean> = {}
  AGREEMENT_SECTIONS.forEach((section) => {
    section.clauses.forEach((c) => {
      map[c.id] = c.openByDefault
    })
  })
  return map
}

Page({
  data: {
    sections: AGREEMENT_SECTIONS,
    highlights: PAY_HIGHLIGHTS,
    versionLine: AGREEMENT_VERSION_LINE,
    effectiveLine: AGREEMENT_EFFECTIVE_LINE,
    expanded: initialExpanded(),
    anchorId: '',
  },

  onLoad(query: Record<string, string | undefined>) {
    // detail 支付前弹层「查看完整付费与退款规则」→ anchor=pay 锚定第二节；
    // me 情报官卡「情报官体系规则」→ anchor=invite；转赠入口 → anchor=transfer（§四）
    const target = query && query.anchor ? ANCHOR_TARGETS[query.anchor] : ''
    if (target) {
      setTimeout(() => this.setData({ anchorId: target }), 200)
    }
  },

  onToggleClause(e: WechatMiniprogram.TouchEvent) {
    const id = e.currentTarget.dataset.id as string
    if (!id) return
    this.setData({ expanded: { ...this.data.expanded, [id]: !this.data.expanded[id] } })
  },
})
