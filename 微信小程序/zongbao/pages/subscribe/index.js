"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// pages/subscribe/index.ts — P2 订阅位：省份/主题两组标签多选+保存（POST 全量）+已订阅项点删（DELETE）。
// 契约：GET /subscriptions 探测 configured——false 或 501 SUBSCRIBE_NOT_CONFIGURED → 整页隐藏不报错
// （me 页入口同闸；引擎侧配置位翻转后才露出）。省份候选=固定 31 省常量（catalog 聚合太薄），
// 主题候选=包内 catalog industry 字段聚合（store.loadCatalog 真实来源，聚合空兜底固定集）。
const api_1 = require("../../utils/api");
const p2_view_1 = require("../../utils/p2-view");
const store_1 = require("../../utils/store");
const config_1 = require("../../config");
Page({
    data: {
        p1: config_1.appConfig.features.p1, // P1 玩法包总开关（p1 功能闸，detail/reader/me 同挂法）
        hidden: true, // 探测失败/未配置 → 整页隐藏（契约口径：不报错）
        provinces: [],
        topics: [],
        saved: [],
        saving: false,
    },
    topicOptions: [], // 主题候选（onLoad 一次聚合，非渲染态）
    async onLoad() {
        if (!config_1.appConfig.features.p1)
            return;
        this.topicOptions = (0, p2_view_1.subscribeTopics)((0, store_1.loadCatalog)().reports);
        try {
            const r = await (0, api_1.subscriptionsGet)();
            if (!r || r.configured !== true) {
                this.setData({ hidden: true }); // 引擎回 configured:false → 隐藏
                return;
            }
            this.setData({ hidden: false });
            this.applyItems(r.items || []);
        }
        catch {
            // 501 SUBSCRIBE_NOT_CONFIGURED / 网络失败 → 整页隐藏不报错
            this.setData({ hidden: true });
        }
    },
    /** 引擎 items → 本页视图（已订阅项列表+两组标签选中态同步） */
    applyItems(items) {
        const prov = new Set(items.filter((i) => i.kind === 'province').map((i) => i.value));
        const top = new Set(items.filter((i) => i.kind === 'topic').map((i) => i.value));
        this.setData({
            saved: items.map((i) => ({ kind: i.kind, value: i.value })),
            provinces: p2_view_1.PROVINCE_OPTIONS.map((v) => ({ value: v, on: prov.has(v) })),
            topics: this.topicOptions.map((v) => ({ value: v, on: top.has(v) })),
        });
    },
    onToggleProvince(e) {
        const v = String(e.currentTarget.dataset.value || '');
        this.setData({ provinces: this.data.provinces.map((p) => (p.value === v ? { value: p.value, on: !p.on } : p)) });
    },
    onToggleTopic(e) {
        const v = String(e.currentTarget.dataset.value || '');
        this.setData({ topics: this.data.topics.map((t) => (t.value === v ? { value: t.value, on: !t.on } : t)) });
    },
    async onSubSave() {
        const { saving, provinces, topics } = this.data;
        if (saving)
            return;
        const ps = provinces.filter((p) => p.on).map((p) => p.value);
        const ts = topics.filter((t) => t.on).map((t) => t.value);
        if (!ps.length && !ts.length) {
            wx.showToast({ title: '请先选择省份或主题', icon: 'none' });
            return;
        }
        this.setData({ saving: true });
        try {
            const r = await (0, api_1.subscriptionsSet)(ps, ts);
            this.applyItems(r.items || []);
            wx.showToast({ title: '订阅已保存', icon: 'none' });
        }
        catch (err) {
            const e = err;
            const msg = e.code === 'INVALID_PARAM' ? '请先选择省份或主题' : e.code === 'NETWORK' ? e.message : (0, api_1.errMsg)(err, '保存失败，请稍后重试');
            wx.showToast({ title: msg, icon: 'none' });
        }
        finally {
            this.setData({ saving: false });
        }
    },
    async onSubRemove(e) {
        const kind = String(e.currentTarget.dataset.kind || '');
        const value = String(e.currentTarget.dataset.value || '');
        try {
            const r = await (0, api_1.subscriptionsDelete)(kind, value);
            this.applyItems(r.items || []);
            wx.showToast({ title: '已取消该订阅', icon: 'none' });
        }
        catch (err) {
            wx.showToast({ title: (0, api_1.errMsg)(err, '取消失败，请重试'), icon: 'none' });
        }
    },
});
