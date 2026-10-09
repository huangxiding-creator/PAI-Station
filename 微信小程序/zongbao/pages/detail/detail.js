"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// pages/detail/detail.ts — 报告详情页：元数据+预览三件套+决策卡+价格锚（行业均价参照）+
// 发票入口（P0 收集开票信息）+披露三件（NFR-08）+收藏/解锁（支付链见 utils/pay）+
// P1 三入口：点赞必得赠阅（FR-P1-01）/3 人组队 ¥998（FR-P1-10）/批评评分退款（FR-P1-02~05）
const api_1 = require("../../utils/api");
const format_1 = require("../../utils/format");
const pay_1 = require("../../utils/pay");
const store_1 = require("../../utils/store");
const agreement_1 = require("../../utils/agreement");
const p1_view_1 = require("../../utils/p1-view");
const p2_view_1 = require("../../utils/p2-view");
const p1_handlers_1 = require("./p1-handlers");
const p2_handlers_1 = require("./p2-handlers");
const config_1 = require("../../config");
const INVOICE_KEY = 'zongbao_invoice';
Page({
    data: {
        id: '',
        p1: config_1.appConfig.features.p1, // P1 玩法包总开关（组队/批评/点赞入口联动）
        loading: true,
        loadError: '',
        view: null,
        decision: null,
        owned: false,
        favorited: false,
        paying: false,
        payGrayed: false,
        // 发票（P0=收集开票信息，存本地备注级；真实开票流 P1）
        invoiceOpen: false,
        invoiceTitle: '',
        invoiceTax: '',
        invoiceSaved: false,
        // 规则弹层（退款/赠品池，NFR-08 断言目标）
        rulesOpen: false,
        rulesKind: '',
        rulesTitle: '',
        rulesBody: '',
        // 支付前披露半屏弹层（T-P0-26：2.2 三条逐字；灰置时照常可看规则）
        paySheetOpen: false,
        paySheet: agreement_1.PAY_SHEET,
        // 页脚一行版（NFR-08 断言文案，utils/agreement.ts 单一真源）
        footerDisclaimer: agreement_1.FOOTER_DISCLAIMER,
        // —— P1：点赞赠报告（FR-P1-01；赠品由服务端指定，前端不本地随机）——
        liking: false,
        likeOpen: false,
        likeGift: { id: '', title: '', rule: '', granted: false },
        likeRules: (0, p1_view_1.likeRulesLines)(),
        // —— P1：3 人组队 ¥998（FR-P1-10；进度以服务端 size/capacity 为准）——
        teamOpen: false,
        teamCreating: false,
        teamJoinId: '',
        team: null,
        teamPriceYuan: '998',
        teamRules: (0, p1_view_1.teamRulesLines)(),
        // —— P1：批评评分退款（FR-P1-02~05；50-300 计数器+受理回执+线性退款规则）——
        critOpen: false,
        critContent: '',
        critCounter: (0, p1_view_1.critCounter)(''),
        critRules: (0, p1_view_1.critRefundRulesLines)(),
        critSubmitting: false,
        critSubmitted: null,
        critReceipt: null,
        // —— P2：转赠（入口闸 p1 && owned && ownedSource==='purchase'；source 从 /me 权益查证）——
        ownedSource: '',
        transferOpen: false,
        transferUid: '',
        transferSubmitting: false,
        transferRules: p2_view_1.TRANSFER_RULES_LINES,
    },
    offPayGray: null,
    autoCritOpen: false,
    // P1 三入口处理器（点赞赠阅/组队/批评评分退款；拆自本文件守住 400 行预算，this=页面实例）
    ...p1_handlers_1.p1Handlers,
    // P2 转赠处理器（确认弹层+错误族逐码 toast；拆分同 p1-handlers 惯例）
    ...p2_handlers_1.p2Handlers,
    onLoad(query) {
        this.setData({ id: query.id ?? '' });
        // reader 末章「批评评分退款」轻入口带参直达（P1 前端）
        this.autoCritOpen = query.criticize === '1';
        this.offPayGray = (0, api_1.onPayGray)(() => this.setData({ payGrayed: true }));
        this.load();
    },
    onUnload() {
        if (this.offPayGray)
            this.offPayGray();
    },
    async load() {
        const id = this.data.id;
        this.setData({ loading: true, loadError: '' });
        try {
            const raw = (await api_1.api.report(id));
            const view = (0, format_1.shapeDetail)(raw);
            const owned = !!raw.owned || (0, store_1.isUnlocked)(id);
            this.setData({
                loading: false,
                view,
                decision: (0, format_1.buildDecisionCard)(raw.decision_card || null),
                owned,
                favorited: !!raw.favorited,
                payGrayed: (0, api_1.isPayGrayed)(),
            });
            this.resolveOwnedSource(id, owned);
            if (this.autoCritOpen) {
                this.autoCritOpen = false;
                this.setData({ critOpen: true });
            }
            this.loadInvoiceDraft(id);
        }
        catch (err) {
            this.setData({
                loading: false,
                loadError: err?.message || '加载失败，请稍后重试',
            });
        }
    },
    /** P2 转赠闸：已购时从 /me 权益查 source（detail 响应只有 owned 布尔，无 source 字段；
     *  引擎 /me entitlements.source 为真源；/me 不可达或未命中 → 保守隐藏转赠入口） */
    resolveOwnedSource(id, owned) {
        if (!config_1.appConfig.features.p1 || !owned) {
            if (this.data.ownedSource)
                this.setData({ ownedSource: '' });
            return;
        }
        api_1.api
            .me()
            .then((me) => {
            const hit = (me.entitlements || []).find((e) => e.report_id === id);
            this.setData({ ownedSource: hit ? hit.source || '' : '' });
        })
            .catch(() => {
            if (this.data.ownedSource)
                this.setData({ ownedSource: '' });
        });
    },
    // —— 目录树：试读章直达阅读器，付费章提示解锁 ——
    onTapToc(e) {
        const idx = e.currentTarget.dataset.idx;
        const isTrial = !!e.currentTarget.dataset.trial;
        if (!isTrial) {
            if (this.data.owned)
                wx.navigateTo({ url: `/pages/reader/reader?id=${this.data.id}&ch=${idx}` });
            else
                wx.showToast({ title: '本章为付费内容，解锁后可读全文', icon: 'none' });
            return;
        }
        wx.navigateTo({ url: `/pages/reader/reader?id=${this.data.id}&ch=${idx}` });
    },
    onOpenRelated(e) {
        const id = e.currentTarget.dataset.id;
        wx.redirectTo({ url: `/pages/detail/detail?id=${id}` });
    },
    onReadTrial() {
        wx.navigateTo({ url: `/pages/reader/reader?id=${this.data.id}` });
    },
    async onFavorite() {
        const { id, favorited } = this.data;
        try {
            const res = await api_1.api.favorite(id, !favorited);
            this.setData({ favorited: !!res.favorited });
            (0, store_1.favoriteLocal)(id, !!res.favorited);
        }
        catch (err) {
            wx.showToast({ title: err?.message || '操作失败，请稍后重试', icon: 'none' });
        }
    },
    // —— 解锁（支付前披露半屏弹层 → 同意后走三层灰置矩阵 → /pay/sign 透传）——
    onUnlock() {
        const { paying, owned } = this.data;
        if (paying || owned)
            return;
        // 先弹披露（mockApi/真实两形态同过此门；503 灰置时弹层照常可看规则）
        this.setData({ paySheetOpen: true });
    },
    onPaySheetClose() {
        this.setData({ paySheetOpen: false });
    },
    onOpenPayRules() {
        this.setData({ paySheetOpen: false });
        wx.navigateTo({ url: '/pages/agreement/agreement?anchor=pay' });
    },
    async onPayAgree() {
        const { paying, owned, id, payGrayed } = this.data;
        this.setData({ paySheetOpen: false });
        if (paying || owned)
            return;
        if (payGrayed) {
            this.onPayDegradeInfo();
            return;
        }
        this.setData({ paying: true });
        try {
            const result = await (0, pay_1.unlockReport)(id, this.data.view?.card.priceFen || 49800);
            wx.showToast({ title: result.message, icon: 'none' });
            if (result.ok)
                this.setData({ owned: true });
        }
        finally {
            this.setData({ paying: false });
        }
    },
    onPayDegradeInfo() {
        wx.showToast({ title: (0, pay_1.payDegradeMessage)(), icon: 'none', duration: 2500 });
    },
    // —— 发票入口（P0 收集存本地备注级）——
    loadInvoiceDraft(reportId) {
        try {
            const all = wx.getStorageSync(INVOICE_KEY) || {};
            const draft = all[reportId];
            if (draft)
                this.setData({ invoiceTitle: draft.title, invoiceTax: draft.tax, invoiceSaved: true });
        }
        catch (e) {
            console.error('[detail] 开票信息读取失败', e);
        }
    },
    onInvoiceOpen() {
        this.setData({ invoiceOpen: true });
    },
    onInvoiceClose() {
        this.setData({ invoiceOpen: false });
    },
    onInvoiceInput(e) {
        const field = e.currentTarget.dataset.field;
        if (field === 'invoiceTitle')
            this.setData({ invoiceTitle: e.detail.value });
        else if (field === 'invoiceTax')
            this.setData({ invoiceTax: e.detail.value });
    },
    onInvoiceSave() {
        const { id, invoiceTitle, invoiceTax } = this.data;
        if (!invoiceTitle.trim()) {
            wx.showToast({ title: '请填写发票抬头', icon: 'none' });
            return;
        }
        try {
            const all = wx.getStorageSync(INVOICE_KEY) || {};
            wx.setStorageSync(INVOICE_KEY, { ...all, [id]: { title: invoiceTitle.trim(), tax: invoiceTax.trim() } });
            this.setData({ invoiceSaved: true, invoiceOpen: false });
            wx.showToast({ title: '开票信息已记录，付款后可开具', icon: 'none' });
        }
        catch (e) {
            console.error('[detail] 开票信息保存失败', e);
            wx.showToast({ title: '保存失败，请重试', icon: 'none' });
        }
    },
    // —— 披露三件入口（退款规则/赠品池规则，NFR-08）——
    onRefundRules() {
        this.setData({
            rulesOpen: true,
            rulesKind: 'refund',
            rulesTitle: '退款规则（批评评分制）',
            rulesBody: '付费内容不支持无理由退款。认为研报名不副实？提交 50-300 字批评（须引用具体章节或数据），' +
                '经评分 ≥50 分按分退款（50 分退 50%，100 分退 100%），每月最多 2 次；' +
                '评分 <50 不退款、发感谢券。Android 自动原路退，iOS 等额书券补偿并引导苹果通道。完整规则见用户协议退款条款。',
        });
    },
    onGiftRules() {
        this.setData({
            rulesOpen: true,
            rulesKind: 'gift',
            rulesTitle: '赠品池规则（附条件赠送）',
            rulesBody: '站内点赞研报，每日首次必得一份赠阅研报（从你的未购清单中指定；必得·附条件赠送，非抽奖，无概率）。' +
                '每日限 1 份，第二日起顺延。赠阅与分享行为完全解耦。',
        });
    },
    onRulesClose() {
        this.setData({ rulesOpen: false });
    },
    onCopyRefundUrl() {
        const url = this.data.view?.refundUrl || '';
        if (!url)
            return;
        wx.setClipboardData({ data: url, success: () => wx.showToast({ title: '规则链接已复制', icon: 'none' }) });
    },
    titleOf(reportId) {
        const hit = (0, store_1.getReport)(reportId);
        return hit ? hit.title : `研报 ${reportId}`;
    },
    noop() {
        // 弹层遮罩点击不关闭（内容须主动确认/关闭）
    },
});
