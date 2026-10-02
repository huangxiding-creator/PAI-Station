"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// pages/index/index.ts — 商城首页：搜索（防抖 300ms）/榜单 tab/三筛选 chips/省份入口/
// 报告卡（封面占位+标签+分转元价格）/下拉刷新+上拉分页；catalog 双源=包内秒开+接口刷新（NFR-02）
const store_1 = require("../../utils/store");
const api_1 = require("../../utils/api");
const format_1 = require("../../utils/format");
const PAGE_SIZE = 20;
Page({
    data: {
        tab: 'hot',
        items: [],
        facets: { provinces: [], ownerTypes: [], industries: [] },
        province: '',
        ownerType: '',
        industry: '',
        page: 1,
        total: 0,
        hasMore: false,
        loading: false,
        netDown: false,
        // 搜索态
        query: '',
        searching: false,
        searchItems: [],
        layerHint: '',
        hotWords: [],
        fallbackHint: false,
        payGrayed: false,
    },
    searchTimer: -1,
    offPayGray: null,
    onLoad() {
        // 包内 catalog 先渲染（首屏秒开），再接口增量刷新
        const bundled = (0, store_1.loadCatalog)().reports.map((r) => (0, format_1.normalizeReport)(r));
        this.setData({ items: this.decorate(bundled), facets: (0, format_1.aggregateFacets)(bundled) });
        this.refresh();
        this.offPayGray = (0, api_1.onPayGray)(() => this.setData({ payGrayed: true }));
    },
    onUnload() {
        if (this.searchTimer >= 0)
            clearTimeout(this.searchTimer);
        if (this.offPayGray)
            this.offPayGray();
    },
    onShow() {
        this.setData({ items: this.decorate(this.data.items) });
    },
    decorate(list) {
        return list.map((r) => ({ ...r, unlocked: (0, store_1.isUnlocked)(r.id) }));
    },
    buildParams(page) {
        const { tab, province, ownerType, industry } = this.data;
        return {
            tab,
            province,
            owner_type: ownerType,
            industry,
            page,
            page_size: PAGE_SIZE,
        };
    },
    async fetchPage(page) {
        this.setData({ loading: true });
        try {
            const res = await api_1.api.catalog(this.buildParams(page));
            const items = (res.items || []).map((raw) => (0, format_1.normalizeReport)(raw));
            const merged = page > 1 ? [...this.data.items, ...items] : items;
            const seen = new Set();
            const dedup = merged.filter((r) => (seen.has(r.id) ? false : seen.add(r.id)));
            const serverFacets = res.facets;
            const aggregated = (0, format_1.aggregateFacets)([...this.data.items, ...items]);
            this.setData({
                items: this.decorate(dedup),
                page,
                total: res.total,
                hasMore: page * PAGE_SIZE < res.total,
                netDown: false,
                facets: (0, format_1.mergeFacets)(serverFacets, aggregated),
            });
        }
        catch (err) {
            // 引擎不可达：保持包内列表可逛（NFR-11 服务维护+试读兜底）
            this.setData({ netDown: true, hasMore: false });
        }
        finally {
            this.setData({ loading: false });
        }
    },
    refresh() {
        return this.fetchPage(1);
    },
    onTabTap(e) {
        const tab = e.currentTarget.dataset.tab;
        if (tab === this.data.tab)
            return;
        this.setData({ tab });
        this.refresh();
    },
    onChipTap(e) {
        const { field, value } = e.currentTarget.dataset;
        const cur = this.data[field];
        const patch = { [field]: cur === value ? '' : value };
        this.setData(patch);
        this.refresh();
    },
    async onPullDownRefresh() {
        await this.refresh();
        wx.stopPullDownRefresh();
    },
    async onReachBottom() {
        if (!this.data.hasMore || this.data.loading)
            return;
        await this.fetchPage(this.data.page + 1);
    },
    // —— 搜索（输入防抖 300ms → GET /search）——
    onSearchInput(e) {
        const q = e.detail.value;
        this.setData({ query: q });
        if (this.searchTimer >= 0)
            clearTimeout(this.searchTimer);
        this.searchTimer = setTimeout(() => this.doSearch(q), 300);
    },
    onSearchConfirm() {
        if (this.searchTimer >= 0)
            clearTimeout(this.searchTimer);
        this.doSearch(this.data.query);
    },
    async doSearch(q) {
        const kw = String(q || '').trim();
        if (!kw) {
            this.setData({ searching: false, searchItems: [], layerHint: '', fallbackHint: false });
            return;
        }
        try {
            const res = await api_1.api.search(kw);
            const items = (res.items || []).map((raw) => (0, format_1.normalizeReport)(raw));
            this.setData({
                searching: true,
                searchItems: this.decorate(items),
                layerHint: (0, format_1.layerHintText)(res.layer_used, kw),
                hotWords: res.hot_words || [],
                fallbackHint: !!res.fallback_hint,
                netDown: false,
            });
        }
        catch {
            this.setData({ searching: true, searchItems: [], layerHint: '', fallbackHint: true, netDown: true });
        }
    },
    onHotWordTap(e) {
        const w = e.currentTarget.dataset.word;
        this.setData({ query: w });
        this.doSearch(w);
    },
    onClearSearch() {
        this.setData({ query: '', searching: false, searchItems: [], layerHint: '', fallbackHint: false });
    },
    onOpenReport(e) {
        const id = e.currentTarget.dataset.id;
        wx.navigateTo({ url: `/pages/detail/detail?id=${id}` });
    },
});
