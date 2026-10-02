"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.loadCatalog = loadCatalog;
exports.getReport = getReport;
exports.loadBundledChapters = loadBundledChapters;
exports.getEntitlements = getEntitlements;
exports.isUnlocked = isUnlocked;
exports.unlockLocal = unlockLocal;
exports.getFavoritesLocal = getFavoritesLocal;
exports.favoriteLocal = favoriteLocal;
exports.trialChapterCount = trialChapterCount;
// utils/store.ts — 研报目录装载 + 已购权益/收藏本地镜像（云端发货与收藏服务端态为准，本地仅离线兜底）
const index_1 = require("../config/index");
let catalogCache = null;
function loadCatalog() {
    if (catalogCache)
        return catalogCache;
    try {
        catalogCache = require('../content/catalog.json');
        return catalogCache;
    }
    catch (e) {
        console.error('[store] catalog 装载失败', e);
        return { reports: [] };
    }
}
function getReport(id) {
    return loadCatalog().reports.find((r) => r.id === id);
}
/** 包内章节（试读章带正文，付费章空壳——A 线产物）；装载失败降级空目录不崩 */
function loadBundledChapters(reportId) {
    try {
        return require(`../content/reports/${reportId}/chapters.json`);
    }
    catch (e) {
        console.error('[store] 章节装载失败', e);
        return [];
    }
}
// —— 已购权益（本地缓存，支付成功回调的先行动作；云端发货为准）——
const ENTITLE_KEY = 'zongbao_entitlements';
function getEntitlements() {
    try {
        return wx.getStorageSync(ENTITLE_KEY) || [];
    }
    catch {
        return [];
    }
}
function isUnlocked(reportId) {
    return getEntitlements().includes(reportId);
}
function unlockLocal(reportId) {
    const next = Array.from(new Set([...getEntitlements(), reportId]));
    wx.setStorageSync(ENTITLE_KEY, next);
}
// —— 收藏本地镜像（服务端态为真源，此处仅离线兜底展示）——
const FAV_KEY = 'zongbao_favorites';
function getFavoritesLocal() {
    try {
        return wx.getStorageSync(FAV_KEY) || [];
    }
    catch {
        return [];
    }
}
function favoriteLocal(reportId, on) {
    const cur = getFavoritesLocal();
    const next = on ? Array.from(new Set([...cur, reportId])) : cur.filter((id) => id !== reportId);
    wx.setStorageSync(FAV_KEY, next);
}
function trialChapterCount() {
    return index_1.appConfig.trialChapterCount;
}
