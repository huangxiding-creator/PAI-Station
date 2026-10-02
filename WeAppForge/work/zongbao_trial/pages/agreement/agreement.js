"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// pages/agreement/agreement.ts — 用户协议与规则页（T-P0-26）：
// 七节全文（文案真源 utils/agreement.ts，逐字渲染）；页首三要点卡；
// 一/二节条款折叠可展开（默认收起 1.1-1.5 与 2.2-2.7）；支持 anchor=pay 锚定第二节。
const agreement_1 = require("../../utils/agreement");
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
        // detail 支付前弹层「查看完整付费与退款规则」→ anchor=pay 锚定第二节
        if (query && query.anchor === 'pay') {
            setTimeout(() => this.setData({ anchorId: 'sec-pay' }), 200);
        }
    },
    onToggleClause(e) {
        const id = e.currentTarget.dataset.id;
        if (!id)
            return;
        this.setData({ expanded: { ...this.data.expanded, [id]: !this.data.expanded[id] } });
    },
});
