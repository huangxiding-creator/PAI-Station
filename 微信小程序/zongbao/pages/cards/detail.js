"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// pages/cards/detail.ts — 商机情报卡落地页（情报裂变 2.0）：
// 进入路径：分享链接带 card_id 直达 / 扫卡二维码带 scene（先 cardResolve 再取详情）。
// card_id 为不透明字符串（<report_id>-cNNN），本页不做格式校验只透传。
// 渲染纠偏：amount 为空串→金额整行隐藏（不渲染 ¥ 或 0）；owner/stage/window 空串或占位 '-'→属性行跳过；
// source_chapter 引擎已富化为显示串，直接渲染不自行映射。
// 状态机 loading / ready / invalid 三态：两者都无、解析空、请求失败一律走「卡片已失效」兜底，
// 不把错误抛用户脸上；落地页语义：不挂 p1 开关（老用户体验版也能从卡进来），
// 也不放生成卡/卡列表入口（那是后续 p1 内页的事）。免责一行取 utils/agreement 单一真源。
const api_1 = require("../../utils/api");
const format_1 = require("../../utils/format");
const agreement_1 = require("../../utils/agreement");
/** 属性行取值规整：空串与占位 '-' 均视为无值（该行不显示；province 恒有值） */
function clean(v) {
    const s = (v || '').trim();
    return s === '-' ? '' : s;
}
/** 二维码 scene 由微信侧 URL 编码传入，安全解码（坏编码原样透传由 resolve 降级） */
function safeScene(raw) {
    try {
        return decodeURIComponent(raw);
    }
    catch {
        return raw;
    }
}
Page({
    data: {
        status: 'loading',
        cardId: '',
        card: null,
        tags: [],
        props: [],
        report: null,
        // 页脚一行版（与 detail/reader 逐字一致，utils/agreement.ts 单一真源）
        footerDisclaimer: agreement_1.FOOTER_DISCLAIMER,
    },
    onLoad(query) {
        const cardId = (query.card_id || '').trim();
        const scene = (query.scene || '').trim();
        if (cardId) {
            this.setData({ cardId });
            this.load(cardId);
            return;
        }
        if (scene) {
            this.fromScene(safeScene(scene));
            return;
        }
        this.setData({ status: 'invalid' });
    },
    // 二维码进入：scene → cardResolve → 详情；解析空/请求失败均降级 invalid（同 invite/scan 容错哲学）
    async fromScene(scene) {
        this.setData({ status: 'loading' });
        try {
            const res = await (0, api_1.cardResolve)(scene);
            const cardId = (res && res.card_id) || '';
            if (!cardId) {
                this.setData({ status: 'invalid' });
                return;
            }
            this.setData({ cardId });
            await this.load(cardId);
        }
        catch {
            this.setData({ status: 'invalid' });
        }
    },
    async load(cardId) {
        this.setData({ status: 'loading' });
        try {
            const res = await (0, api_1.cardDetail)(cardId);
            this.setData({
                status: 'ready',
                card: res.card,
                tags: [
                    { text: clean(res.card.province), kw: true },
                    { text: clean(res.card.stage), kw: false },
                    { text: clean(res.card.source_chapter), kw: false },
                ].filter((t) => t.text),
                props: [
                    { label: '业主单位', value: clean(res.card.owner) },
                    { label: '项目阶段', value: clean(res.card.stage) },
                    { label: '时间窗口', value: clean(res.card.window) },
                    { label: '省份', value: clean(res.card.province) },
                    { label: '来源章节', value: clean(res.card.source_chapter) },
                ].filter((row) => row.value),
                report: {
                    id: res.report.id,
                    title: res.report.title,
                    priceYuan: (0, format_1.fenToYuan)(res.report.price_fen),
                    trialChapters: res.report.trial_chapters,
                },
            });
        }
        catch {
            // 404 CARD_NOT_FOUND / 网络失败等一律走失效兜底态
            this.setData({ status: 'invalid' });
        }
    },
    // 来源报告 CTA：跳研报详情页（试读/解锁在彼处闭环）
    onOpenReport() {
        const rid = this.data.report?.id || '';
        if (!rid)
            return;
        wx.navigateTo({ url: `/pages/detail/detail?id=${rid}` });
    },
    // 失效兜底态出口：去首页（tabBar 页须 switchTab）
    onGoHome() {
        wx.switchTab({ url: '/pages/index/index' });
    },
    onShareAppMessage() {
        const { cardId, card } = this.data;
        return {
            title: card ? card.title : '商机情报卡',
            path: `/pages/cards/detail?card_id=${cardId}`,
        };
    },
});
