"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.fenToYuan = fenToYuan;
exports.normalizeReport = normalizeReport;
exports.buildDecisionCard = buildDecisionCard;
exports.aggregateFacets = aggregateFacets;
exports.mergeFacets = mergeFacets;
exports.layerHintText = layerHintText;
exports.parseScene = parseScene;
exports.shapeDetail = shapeDetail;
// utils/format.ts — 展示层数据整形（纯函数：分转元/目录归一/决策卡/筛选项聚合/scene 解析）
// 输入形状按 API_DESIGN（P0-2/P0-4）；包内 catalog.json（A 线产物）同函数兼容。
const index_1 = require("../config/index");
/** 分转元展示串：49800→'498'；990→'9.9'；188800→'1888'；12345→'123.45' */
function fenToYuan(fen) {
    const n = Number(fen) || 0;
    const yuan = n / 100;
    if (Number.isInteger(yuan))
        return String(yuan);
    const fixed = yuan.toFixed(2).replace(/0+$/, '').replace(/\.$/, '');
    return fixed;
}
/** 目录条目归一：服务端形状或包内形状 → 统一展示卡（缺失字段安全缺省，不造数） */
function normalizeReport(raw) {
    const item = raw;
    const priceFen = typeof item.price_fen === 'number' ? item.price_fen : Number(item.price) || 0;
    return {
        id: item.id,
        title: item.title || '',
        summary: item.summary || '',
        priceFen,
        priceYuan: fenToYuan(priceFen),
        province: item.province || '',
        ownerType: item.owner_type || '',
        industry: item.industry || '',
        chapterCount: Number(item.chapter_count ?? item.chapterCount) || 0,
        trialChapters: Number(item.trial_chapters) || index_1.appConfig.trialChapterCount,
        tags: Array.isArray(item.tags) ? item.tags : [],
        publishedAt: item.published_at || item.publishedAt || '',
        cover: item.cover || '',
    };
}
/**
 * 决策卡整形（FR-P0-03）：服务端 decision_card 优先；
 * 缺席时从包内章节数（空壳章）推导——页数不可知时置 null 不编造。
 */
function buildDecisionCard(raw, fallbackChapters) {
    const trialCount = index_1.appConfig.trialChapterCount;
    if (raw && (Array.isArray(raw.toc) || typeof raw.remaining_chapters === 'number')) {
        const toc = (raw.toc || []).map((t, i) => ({
            id: t.id,
            title: t.title,
            idx: i + 1,
            isTrial: Number(t.is_trial) === 1,
        }));
        const locked = (raw.locked_conclusions || []).map((c) => c.title);
        const readPages = typeof raw.read_pages === 'number' ? raw.read_pages : null;
        const remainCh = typeof raw.remaining_chapters === 'number' ? raw.remaining_chapters : 0;
        const remainPages = typeof raw.remaining_pages === 'number' ? raw.remaining_pages : null;
        const trialN = toc.filter((t) => t.isTrial).length;
        return {
            readPages,
            remainingChapters: remainCh,
            remainingPages: remainPages,
            lockedTitles: locked,
            lockedCount: locked.length,
            toc,
            readText: readPages === null ? `已读 ${trialN} 章` : `已读 ${readPages} 页`,
            remainText: remainPages === null ? `全文还有 ${remainCh} 章` : `全文还有 ${remainCh} 章 · ${remainPages} 页`,
            paywallNote: highTrialNote(trialN, toc.length, remainCh),
        };
    }
    // 离线兜底：包内空壳章推导（无页数维度，只报章数）
    const chapters = fallbackChapters || [];
    const paid = chapters.slice(trialCount);
    const trialN = Math.min(trialCount, chapters.length);
    return {
        readPages: null,
        remainingChapters: paid.length,
        remainingPages: null,
        lockedTitles: paid.slice(0, 3).map((c) => c.title),
        lockedCount: paid.length,
        toc: chapters.map((c, i) => ({ id: c.id, title: c.title, idx: i + 1, isTrial: i < trialCount })),
        readText: `已读 ${trialN} 章`,
        remainText: `全文还有 ${paid.length} 章`,
        paywallNote: highTrialNote(trialN, chapters.length, paid.length),
    };
}
/**
 * 高试读比报告的付费范围明示（RL 决策②默认，js-shuiwang 17/19 场景）：
 * 过半章节免费时说明「付费=末 N 章数据本体」，避免「基本全免费」预期错位。
 */
function highTrialNote(trialN, total, paidCh) {
    if (!total || !paidCh || trialN / total <= 0.5)
        return '';
    return `本报告前 ${trialN}/${total} 章均可免费试读；付费解锁的是末 ${paidCh} 章数据本体（商机项目清单明细，全文核心交付内容）`;
}
/** 筛选 chips 选项：接口未供 facets 时前端从列表聚合（API_DESIGN §二 P0-2 说明） */
function aggregateFacets(reports) {
    const pick = (fn) => Array.from(new Set(reports.map(fn).filter(Boolean))).sort();
    return { provinces: pick((r) => r.province), ownerTypes: pick((r) => r.ownerType), industries: pick((r) => r.industry) };
}
/** 合并两份 facets（服务端给了就用服务端，否则聚合兜底） */
function mergeFacets(server, aggregated) {
    if (server && Array.isArray(server.provinces)) {
        return {
            provinces: server.provinces || [],
            ownerTypes: server.owner_types || [],
            industries: server.industries || [],
        };
    }
    return aggregated;
}
/** 三层检索降级提示（API_DESIGN §三）：L2/L3/like 各配一句，前端据此展示 */
function layerHintText(layerUsed, q) {
    const kw = q || '';
    if (layerUsed === 'L2')
        return `已在章节标题中检索「${kw}」`;
    if (layerUsed === 'L3')
        return `已在商机关键词中检索「${kw}」`;
    if (layerUsed === 'like')
        return `已全文检索「${kw}」`;
    return '';
}
/** scene 容错解析（ARCHITECTURE 链路①）：r=报告短ID&i=邀请人短ID；失败返 null 走归因降级不报错 */
function parseScene(scene) {
    if (!scene)
        return null;
    let decoded = scene;
    try {
        decoded = decodeURIComponent(scene);
    }
    catch {
        // 非法编码按原文兜底尝试
    }
    const r = /(?:^|&)r=([A-Za-z0-9_-]+)/.exec(decoded);
    if (!r)
        return null;
    const i = /(?:^|&)i=([A-Za-z0-9_-]+)/.exec(decoded);
    return { reportId: r[1], inviterId: i ? i[1] : '' };
}
/** 详情页视图整形：锚价/预览三件套/披露字段安全缺省 */
function shapeDetail(raw) {
    const card = normalizeReport(raw);
    return {
        card,
        anchorYuan: fenToYuan(Number(raw.anchor_price_fen) || 0),
        anchorCopy: raw.anchor_copy || '同等深度内容 1/4 价格',
        rankBadge: (raw.preview_triad && raw.preview_triad.rank_badge) || '',
        related: ((raw.preview_triad && raw.preview_triad.related) || []).map((x) => ({
            id: x.id,
            title: x.title,
            why: x.why || '',
        })),
        readersAlso: (raw.preview_triad && raw.preview_triad.readers_also) || [],
        refundUrl: raw.refund_policy_url || '',
        invoiceEntry: !!(raw.disclosure && raw.disclosure.invoice_entry),
    };
}
