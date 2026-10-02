"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// pages/agreement/agreement.ts — 用户协议与规则页（T-P0-26）：
// 八节全文（文案真源 utils/agreement.ts，逐字渲染）；页首三要点卡；
// 一/二节条款折叠可展开（默认收起 1.1-1.5 与 2.2-2.7）；
// anchor=pay 锚定第二节、anchor=transfer 锚定§四转赠、anchor=invite 锚定§六情报官体系块。
const agreement_1 = require("../../utils/agreement");
/** 锚点→滚动目标（节级 sec-*；invite 精确到 §六内 clause-invite 块） */
const ANCHOR_TARGETS = {
    pay: 'sec-pay',
    like: 'sec-like',
    transfer: 'sec-transfer',
    team: 'sec-team',
    voucher: 'sec-voucher',
    invite: 'clause-invite',
};
function initialExpanded() {
    const map = {};
    agreement_1.AGREEMENT_SECTIONS.forEach((section) => {
        section.clauses.forEach((c) => {
            map[c.id] = c.openByDefault;
        });
    });
    return map;
}
Page({
    data: {
        sections: agreement_1.AGREEMENT_SECTIONS,
        highlights: agreement_1.PAY_HIGHLIGHTS,
        versionLine: agreement_1.AGREEMENT_VERSION_LINE,
        effectiveLine: agreement_1.AGREEMENT_EFFECTIVE_LINE,
        expanded: initialExpanded(),
        anchorId: '',
    },
    onLoad(query) {
        // detail 支付前弹层「查看完整付费与退款规则」→ anchor=pay 锚定第二节；
        // me 情报官卡「情报官体系规则」→ anchor=invite；转赠入口 → anchor=transfer（§四）
        const target = query && query.anchor ? ANCHOR_TARGETS[query.anchor] : '';
        if (target) {
            setTimeout(() => this.setData({ anchorId: target }), 200);
        }
    },
    onToggleClause(e) {
        const id = e.currentTarget.dataset.id;
        if (!id)
            return;
        this.setData({ expanded: { ...this.data.expanded, [id]: !this.data.expanded[id] } });
    },
});
