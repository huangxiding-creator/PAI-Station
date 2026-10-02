"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// pages/reader/reader.ts — 分章阅读器：章节侧栏 / 试读章 md2blocks 渲染（包内缓存优先·服务端校真）/
// 付费章锁定占位与按权益在线拉取 / 试读末章决策卡 / scene 容错解析（链路①，FR-P0-04）/
// P1 末章轻入口：点赞得赠阅（结果弹层复用 like-sheet）+ 批评跳详情页表单（FR-P1-01/02）
const api_1 = require("../../utils/api");
const format_1 = require("../../utils/format");
const render_1 = require("../../utils/render");
const pay_1 = require("../../utils/pay");
const agreement_1 = require("../../utils/agreement");
const store_1 = require("../../utils/store");
const config_1 = require("../../config");
const p1_view_1 = require("../../utils/p1-view");
Page({
    data: {
        reportId: '',
        p1: config_1.appConfig.features.p1, // P1 玩法包总开关（末章点赞/批评轻入口联动）
        reportTitle: '',
        priceYuan: '498',
        chapters: [],
        activeIdx: 0,
        activeTitle: '',
        activeBlocks: [],
        activeLocked: false,
        activeLoading: false,
        lastTrialIdx: -1,
        unlocked: false,
        paying: false,
        payGrayed: false,
        sidebarOpen: false,
        netDown: false,
        decision: null,
        // 支付前披露半屏弹层（T-P0-26，与 detail 页同一真源 utils/agreement.ts）
        paySheetOpen: false,
        paySheet: agreement_1.PAY_SHEET,
        // 页脚一行版（NFR-08 断言文案，逐字）
        footerDisclaimer: agreement_1.FOOTER_DISCLAIMER,
        // P1 点赞结果弹层（templates/p1-sheet.wxml like-sheet 复用；赠品由服务端指定）
        liking: false,
        likeOpen: false,
        likeGift: { id: '', title: '', rule: '', granted: false },
        likeRules: (0, p1_view_1.likeRulesLines)(),
    },
    htmlCache: {},
    offPayGray: null,
    onLoad(query) {
        // scene 容错解析（ARCHITECTURE 链路①）：r=报告短ID&i=邀请人短ID；解析失败归因降级不报错
        const fromScene = query.scene ? (0, format_1.parseScene)(query.scene) : null;
        const id = (fromScene && fromScene.reportId) || query.id || this.defaultReportId();
        const startIdx = Math.max(1, Number(query.ch) || 1) - 1;
        this.offPayGray = (0, api_1.onPayGray)(() => this.setData({ payGrayed: true }));
        this.boot(id, startIdx);
    },
    onUnload() {
        if (this.offPayGray)
            this.offPayGray();
    },
    defaultReportId() {
        return loadCatalogFirst();
    },
    async boot(id, startIdx) {
        const meta = (0, store_1.getReport)(id);
        this.setData({
            reportId: id,
            reportTitle: meta ? meta.title : id,
            priceYuan: meta ? (0, format_1.fenToYuan)(meta.price) : '498',
            unlocked: (0, store_1.isUnlocked)(id),
            payGrayed: (0, api_1.isPayGrayed)(),
        });
        // 1) 包内章节秒开（NFR-02/11：试读缓存优先）
        const bundled = (0, store_1.loadBundledChapters)(id);
        const trial = (0, store_1.trialChapterCount)();
        if (bundled.length) {
            bundled.forEach((c) => {
                if (c.html)
                    this.htmlCache[c.id] = c.html;
            });
            this.setData({
                chapters: bundled.map((c, i) => ({ id: c.id, title: c.title, idx: i + 1, isTrial: i < trial })),
                lastTrialIdx: Math.min(trial, bundled.length) - 1,
            });
            this.setActive(startIdx);
        }
        // 2) 服务端校真（目录/试读边界以服务端为准，冲突服务端赢）
        try {
            const res = await api_1.api.chapters(id);
            const list = (res.chapters || []).map((c, i) => ({
                id: c.id,
                title: c.title,
                idx: Number(c.idx) || i + 1,
                isTrial: Number(c.is_trial) === 1,
            }));
            (res.chapters || []).forEach((c) => {
                if (typeof c.html === 'string' && c.html)
                    this.htmlCache[c.id] = c.html;
            });
            this.setData({
                chapters: list,
                lastTrialIdx: list.reduce((acc, c, i) => (c.isTrial ? i : acc), -1),
                netDown: false,
            });
            this.setActive(startIdx); // 服务端目录/试读正文覆盖后重渲染当前章
        }
        catch {
            if (!bundled.length) {
                wx.showToast({ title: '章节加载失败', icon: 'none' });
                return;
            }
            this.setData({ netDown: true }); // 引擎不可达：包内试读仍可读（NFR-11）
        }
        // 3) 详情（决策卡数据+owned 态；离线走包内推导兜底）
        try {
            const raw = (await api_1.api.report(id));
            this.setData({
                decision: (0, format_1.buildDecisionCard)(raw.decision_card || null, bundled),
                unlocked: !!raw.owned || this.data.unlocked,
                reportTitle: raw.title || this.data.reportTitle,
                priceYuan: raw.price_fen ? (0, format_1.fenToYuan)(raw.price_fen) : this.data.priceYuan,
            });
        }
        catch {
            this.setData({ decision: (0, format_1.buildDecisionCard)(null, bundled) });
        }
    },
    async setActive(idx) {
        const chapters = this.data.chapters;
        if (!chapters.length)
            return;
        const safe = Math.min(Math.max(idx, 0), chapters.length - 1);
        const ch = chapters[safe];
        this.setData({ sidebarOpen: false });
        if (ch.isTrial) {
            const html = this.htmlCache[ch.id] || '';
            this.setData({
                activeIdx: safe,
                activeTitle: ch.title,
                activeBlocks: (0, render_1.chapterBlocks)(html, ch.title),
                activeLocked: false,
                activeLoading: false,
            });
            return;
        }
        if (this.data.unlocked) {
            this.setData({ activeIdx: safe, activeTitle: ch.title, activeLoading: true });
            try {
                const d = await api_1.api.fetchChapter(this.data.reportId, ch.id);
                this.htmlCache[ch.id] = d.html;
                this.setData({
                    activeBlocks: (0, render_1.chapterBlocks)(d.html, ch.title),
                    activeLocked: false,
                    activeLoading: false,
                });
            }
            catch (err) {
                const e = err;
                this.setData({ activeLoading: false });
                const msg = e.code === 'RATE_LIMITED'
                    ? '操作过快，请稍后再试'
                    : e.code === 'NOT_ENTITLED'
                        ? '尚未解锁该研报'
                        : e.message || '章节加载失败';
                wx.showToast({ title: msg, icon: 'none' });
            }
            return;
        }
        // 未解锁付费章：锁定占位（🔒+章标题+解锁 CTA），不拉正文
        this.setData({ activeIdx: safe, activeTitle: ch.title, activeBlocks: [], activeLocked: true, activeLoading: false });
    },
    onToggleSidebar() {
        this.setData({ sidebarOpen: !this.data.sidebarOpen });
    },
    onCloseSidebar() {
        this.setData({ sidebarOpen: false });
    },
    onPickChapter(e) {
        const idx = e.currentTarget.dataset.index;
        this.setActive(idx);
    },
    onPrev() {
        this.setActive(this.data.activeIdx - 1);
    },
    onNext() {
        this.setActive(this.data.activeIdx + 1);
    },
    // —— 解锁（支付前披露半屏弹层 → 同意后灰置矩阵 → /pay/sign 透传 → 轮询发货）——
    onUnlock() {
        const { paying, unlocked } = this.data;
        if (paying || unlocked)
            return;
        // 先弹披露（灰置时照常可看规则）
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
        const { paying, unlocked, reportId, payGrayed } = this.data;
        this.setData({ paySheetOpen: false });
        if (paying || unlocked)
            return;
        if (payGrayed) {
            wx.showToast({ title: (0, pay_1.payDegradeMessage)(), icon: 'none', duration: 2500 });
            return;
        }
        this.setData({ paying: true });
        try {
            const result = await (0, pay_1.unlockReport)(reportId, 0);
            wx.showToast({ title: result.message, icon: 'none' });
            if (result.ok) {
                this.setData({ unlocked: true });
                this.setActive(this.data.activeIdx);
            }
        }
        finally {
            this.setData({ paying: false });
        }
    },
    // —— P1 末章轻入口：点赞得赠阅（FR-P1-01，与分享解耦）+ 批评跳详情表单（FR-P1-02）——
    async onReaderLike() {
        const { liking, reportId } = this.data;
        if (liking)
            return;
        this.setData({ liking: true });
        try {
            const res = await api_1.api.like(reportId);
            const hit = (0, store_1.getReport)(res.granted_report_id);
            this.setData({
                likeOpen: true,
                likeGift: (0, p1_view_1.buildLikeGift)(res, (rid) => (hit && rid === hit.id ? hit.title : ((0, store_1.getReport)(rid) || { title: `研报 ${rid}` }).title)),
            });
        }
        catch (err) {
            const e = err;
            const msg = e.code === 'GIFT_DAILY_LIMIT'
                ? '今日赠阅已领取，明日再来'
                : e.code === 'NETWORK'
                    ? e.message
                    : (0, api_1.errMsg)(err, '点赞失败，请稍后重试');
            wx.showToast({ title: msg, icon: 'none' });
        }
        finally {
            this.setData({ liking: false });
        }
    },
    onLikeSheetClose() {
        this.setData({ likeOpen: false });
    },
    onLikeGoRead() {
        const rid = this.data.likeGift.id;
        this.setData({ likeOpen: false });
        if (rid)
            wx.redirectTo({ url: `/pages/reader/reader?id=${rid}` });
    },
    onLikeRules() {
        this.setData({ likeOpen: false });
        wx.navigateTo({ url: '/pages/agreement/agreement?anchor=like' });
    },
    onReaderCriticize() {
        // 批评表单只在详情页一处（50-300 计数器/回执/退款申请），轻入口带参直达
        wx.navigateTo({ url: `/pages/detail/detail?id=${this.data.reportId}&criticize=1` });
    },
    noop() {
        // 弹层遮罩点击不关闭（内容须主动确认/关闭）
    },
});
function loadCatalogFirst() {
    try {
        const catalog = require('../../content/catalog.json');
        return catalog.reports.length ? catalog.reports[0].id : '';
    }
    catch (e) {
        console.error('[reader] 默认报告取目录失败', e);
        return '';
    }
}
