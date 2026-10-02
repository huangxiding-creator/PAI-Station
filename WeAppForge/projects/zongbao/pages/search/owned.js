"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// pages/search/owned.ts — P2 已购检索页：已解锁研报库的章级检索（FR-P2-03）；
// 搜索框+结果列表（report/chapter/snippet）+「加载更多」游标分页（next_cursor 空串止）；
// 结果项点按跳 reader 对应章（chapter_id→?ch= 1 基章序，引擎 _idx_of 同口径）。
const api_1 = require("../../utils/api");
const p2_view_1 = require("../../utils/p2-view");
const config_1 = require("../../config");
Page({
    data: {
        p1: config_1.appConfig.features.p1, // P1 玩法包总开关（p1 功能闸，detail/reader 同挂法）
        q: '',
        items: [],
        total: 0,
        hasMore: false,
        nextCursor: '',
        searching: false,
        loadingMore: false,
        searched: false, // 是否已发起过搜索（空态文案区分）
    },
    onSearchInput(e) {
        this.setData({ q: e.detail.value });
    },
    async onSearch() {
        const { searching, q } = this.data;
        if (searching)
            return;
        const kw = q.trim();
        if (!kw) {
            wx.showToast({ title: '请输入搜索词', icon: 'none' });
            return;
        }
        this.setData({ searching: true });
        try {
            const r = await (0, api_1.searchOwned)(kw);
            this.setData({
                items: r.items || [],
                total: Number(r.total) || 0,
                hasMore: !!r.has_more,
                nextCursor: r.next_cursor || '',
                searched: true,
            });
        }
        catch (err) {
            const e = err;
            const msg = e.code === 'INVALID_PARAM' ? '请输入搜索词' : e.code === 'NETWORK' ? e.message : (0, api_1.errMsg)(err, '检索失败，请稍后重试');
            wx.showToast({ title: msg, icon: 'none' });
            this.setData({ items: [], total: 0, hasMore: false, nextCursor: '', searched: true });
        }
        finally {
            this.setData({ searching: false });
        }
    },
    async onLoadMore() {
        const { hasMore, nextCursor, loadingMore, q } = this.data;
        if (!hasMore || loadingMore || !nextCursor)
            return;
        this.setData({ loadingMore: true });
        try {
            const r = await (0, api_1.searchOwned)(q.trim(), nextCursor);
            this.setData({
                items: [...this.data.items, ...(r.items || [])],
                hasMore: !!r.has_more,
                nextCursor: r.next_cursor || '',
            });
        }
        catch (err) {
            wx.showToast({ title: (0, api_1.errMsg)(err, '加载失败，请重试'), icon: 'none' });
        }
        finally {
            this.setData({ loadingMore: false });
        }
    },
    onOpenItem(e) {
        const rid = String(e.currentTarget.dataset.rid || '');
        const cid = String(e.currentTarget.dataset.cid || '');
        if (!rid)
            return;
        wx.navigateTo({ url: `/pages/reader/reader?id=${rid}&ch=${(0, p2_view_1.chapterIdxOf)(cid)}` });
    },
});
