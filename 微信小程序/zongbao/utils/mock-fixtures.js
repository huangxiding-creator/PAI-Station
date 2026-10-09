"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.resetMockStateForTest = resetMockStateForTest;
exports.mockRequest = mockRequest;
const mock_reports_1 = require("./mock-reports");
const mock_fixtures_p1_1 = require("./mock-fixtures-p1");
const mock_fixtures_p2_1 = require("./mock-fixtures-p2");
const err = (status, code, message) => ({ status, body: { code, message } });
const ok = (body) => ({ status: 200, body });
/** 页数估算（对齐引擎口径 chars/340 向上取整、至少 1 页；T-P0-17 形状对拍） */
function pageCount(html) {
    const chars = html.replace(/<[^>]+>/g, '').length;
    return Math.max(1, Math.ceil(chars / 340));
}
function bundledShuiwangChapters() {
    try {
        return require('../content/reports/js-shuiwang-2026/chapters.json');
    }
    catch (e) {
        console.error('[mock] 包内章节装载失败', e);
        return [];
    }
}
function decisionOf(r) {
    const toc = r.chapters.map((c, i) => ({ id: c.id, title: c.title, is_trial: i < (r.trial_chapters || 2) ? 1 : 0 }));
    const paid = r.chapters.slice(r.trial_chapters || 2);
    return {
        read_pages: 20,
        remaining_chapters: paid.length,
        remaining_pages: paid.length * 16,
        locked_conclusions: paid.slice(0, 3).map((c) => ({ title: c.title, blurred: true })),
        toc,
    };
}
function detailOf(r) {
    const { cover: _cover, chapters: _chapters, readingRank: _rank, ...rest } = r;
    return {
        ...rest,
        anchor_price_fen: mock_reports_1.MOCK_ANCHOR_FEN,
        anchor_copy: '同等深度内容 1/4 价格',
        trial_pages: 20,
        owned: state.owned.has(r.id),
        favorited: state.favorites.has(r.id),
        decision_card: decisionOf(r),
        preview_triad: {
            related: mock_reports_1.REPORTS.filter((x) => x.id !== r.id && (x.province === r.province || x.industry === r.industry))
                .slice(0, 3)
                .map((x) => ({
                id: x.id,
                title: x.title,
                why: x.province === r.province ? '同省' : '同行业',
            })),
            readers_also: mock_reports_1.REPORTS.filter((x) => x.id !== r.id)
                .slice(0, 2)
                .map((x) => ({ id: x.id, title: x.title })),
            rank_badge: `阅读榜 #${r.readingRank}`,
        },
        refund_policy_url: '/pages/agreement/index#refund',
        disclosure: { no_reason_refund: false, invoice_entry: true },
    };
}
function paidChapterHtml(r, chapterId) {
    const ch = r.chapters.find((c) => c.id === chapterId);
    const title = ch ? ch.title : chapterId;
    return (`<h1>${title}</h1>` +
        `<p>（mock 联调正文）本章对应「${r.title}」付费章，真实正文由 B 线引擎按权益下发。</p>` +
        `<h2>小节样本</h2><p>段落一：投资规模与招标节奏要点。</p><p>段落二：区域梯度与业主偏好。</p>` +
        `<table><tr><td>指标</td><td>数值</td></tr><tr><td>样本项目数</td><td>12</td></tr></table>`);
}
function parseQuery(path) {
    const [route, qs] = path.split('?');
    const q = {};
    String(qs || '').split('&').forEach((kv) => {
        if (!kv)
            return;
        const [k, v] = kv.split('=');
        q[k] = decodeURIComponent(v || '');
    });
    return { route, q };
}
// —— mock 状态（模块级；devtools 会话内持久）。P1 子状态由 mock-fixtures-p1 读写 ——
const state = {
    token: '',
    owned: new Set(),
    ownedSource: new Map(), // report_id → entitlement source（缺省 purchase）
    favorites: new Set(),
    payOrders: new Map(), // out_trade_no → report_id
    readLog: new Set(), // 层①真实阅读行为（付费章在线拉取成功即记）
    likeDate: '', // 当日点赞日期（UNIQUE(user,grant_date) 近似）
    criticisms: new Map(),
    refundCountMonth: 0,
    teams: new Map(),
    myTeam: '',
    vouchers: [
        // campaign 样例（mock 演示：上线活动发券形态；真实来源=invite/criticism_thanks/ios_refund）
        { id: 'v-demo-1', amount_fen: 50000, source: 'campaign', source_ref: 'launch_demo', status: 'active', created_at: '2026-09-28T09:00:00+08:00' },
    ],
    refunds: [],
};
function voucherBalance() {
    return state.vouchers.reduce((acc, x) => acc + (x.status === 'active' ? x.amount_fen : -x.amount_fen), 0);
}
/** 测试隔离：重置 mock 会话状态（node --test 每测独立基线；与 api.resetPayGrayForTest 同惯例，生产不调用） */
function resetMockStateForTest() {
    state.token = '';
    state.owned.clear();
    state.ownedSource.clear();
    state.favorites.clear();
    state.payOrders.clear();
    state.readLog.clear();
    state.likeDate = '';
    state.criticisms.clear();
    state.refundCountMonth = 0;
    state.teams.clear();
    state.myTeam = '';
    state.vouchers = [
        { id: 'v-demo-1', amount_fen: 50000, source: 'campaign', source_ref: 'launch_demo', status: 'active', created_at: '2026-09-28T09:00:00+08:00' },
    ];
    state.refunds = [];
}
/** mock 路由：与 wx.request 同构的 {status, body} 应答 */
function mockRequest(method, path, data, token) {
    return new Promise((resolve) => {
        const { route, q } = parseQuery(path);
        const body = (data || {});
        const authed = !!token && token === state.token;
        const R = mock_reports_1.REPORTS.find((r) => r.id === q.id || route.includes(`/reports/${r.id}`)) || null;
        const delayed = (resp) => setTimeout(() => resolve(resp || err(404, 'NOT_FOUND', `mock 未实现: ${method} ${route}`)), 30);
        // —— P1 路由优先委托（点赞/批评/退款/组队/书券/邀请；未命中回落 P0）——
        const p1 = (0, mock_fixtures_p1_1.handleP1)(method, route, q, body, { authed, R, state });
        if (p1)
            return delayed(p1);
        // —— P2 路由委托（AI 伴读/已购检索/转赠/订阅；状态同源注入，handleP1 同惯例；未命中回落 P0）——
        const p2 = (0, mock_fixtures_p2_1.handleP2)(method, route, q, body, { authed, R, state });
        if (p2)
            return delayed(p2);
        // —— 鉴权 ——
        if (route === '/auth/login' && method === 'POST') {
            state.token = `mock-token-${Date.now()}`;
            return delayed(ok({ token: state.token, uid: 'uMock01', expires_in: 2592000, pay_configured: true }));
        }
        if (route === '/catalog') {
            if (q.tab === 'praise') {
                // 好评榜 P0 不可见（引擎口径：空 items + praise_visible:false）
                const page = Math.max(1, Number(q.page) || 1);
                const pageSize = Math.min(50, Number(q.page_size) || 20);
                return delayed(ok({ items: [], total: 0, page, page_size: pageSize, praise_visible: false }));
            }
            let list = [...mock_reports_1.REPORTS];
            if (q.tab === 'new')
                list.sort((a, b) => ((a.published_at || '') < (b.published_at || '') ? 1 : -1));
            else
                list.sort((a, b) => a.readingRank - b.readingRank);
            if (q.province)
                list = list.filter((r) => r.province === q.province);
            if (q.owner_type)
                list = list.filter((r) => r.owner_type === q.owner_type);
            if (q.industry)
                list = list.filter((r) => r.industry === q.industry);
            const page = Math.max(1, Number(q.page) || 1);
            const pageSize = Math.min(50, Number(q.page_size) || 20);
            const items = list.slice((page - 1) * pageSize, page * pageSize).map(({ chapters, readingRank, ...rest }) => rest);
            return delayed(ok({ items, total: list.length, page, page_size: pageSize, praise_visible: false }));
        }
        if (route === '/search') {
            const kw = (q.q || '').trim();
            // 空 q=400（引擎口径：空搜索词拒绝，前端空态走榜单不进检索）
            if (!kw)
                return delayed(err(400, 'INVALID_PARAM', '缺少搜索词 q'));
            const hit = (f) => mock_reports_1.REPORTS.filter((r) => f(r).indexOf(kw) >= 0);
            let layer = 'L1';
            let subLayer = 'title';
            let found = hit((r) => `${r.title}${r.summary}`);
            if (!found.length) {
                layer = 'L2';
                subLayer = 'chapter_title';
                found = hit((r) => r.chapters.map((c) => c.title).join(' '));
            }
            if (!found.length) {
                layer = 'L3';
                subLayer = 'keyword';
                found = hit((r) => (r.tags || []).join(' '));
            }
            if (!found.length) {
                return delayed(ok({ layer_used: 'none', layer: null, items: [], hot_words: (0, mock_reports_1.hotWords)(), fallback_hint: true }));
            }
            const items = found.map(({ chapters, readingRank, ...rest }) => rest);
            return delayed(ok({ layer_used: layer, layer: subLayer, items, hot_words: (0, mock_reports_1.hotWords)(), fallback_hint: false }));
        }
        if (route.startsWith('/reports/') && route.endsWith('/chapters') && method === 'GET') {
            if (!R)
                return delayed(err(404, 'REPORT_NOT_FOUND', '报告不存在或已下架'));
            const trial = R.trial_chapters || 2;
            const bundled = R.id === 'js-shuiwang-2026' ? bundledShuiwangChapters() : [];
            const chapters = R.chapters.map((c, i) => {
                if (i < trial) {
                    const html = R.id === 'js-shuiwang-2026' ? (bundled.find((b) => b.id === c.id) || {}).html || '' : c.trialHtml || '';
                    return { id: c.id, title: c.title, idx: i + 1, is_trial: 1, html, pages: pageCount(html) };
                }
                // 未购付费章：无 html 字段（字段缺席判据，API_DESIGN P0-5），元数据含 html_len/pages（引擎口径）
                const shellHtml = paidChapterHtml(R, c.id);
                return {
                    id: c.id, title: c.title, idx: i + 1, is_trial: 0,
                    html_len: shellHtml.replace(/<[^>]+>/g, '').length, pages: pageCount(shellHtml),
                };
            });
            return delayed(ok({ report_id: R.id, trial_chapters: trial, chapters }));
        }
        if (route.startsWith('/reports/') && route.includes('/chapters/') && method === 'POST') {
            if (!R)
                return delayed(err(404, 'REPORT_NOT_FOUND', '报告不存在或已下架'));
            const chapterId = route.split('/chapters/')[1].split('?')[0];
            const idx = R.chapters.findIndex((c) => c.id === chapterId);
            if (idx < 0)
                return delayed(err(404, 'CHAPTER_NOT_FOUND', '章节不存在'));
            const isTrial = idx < (R.trial_chapters || 2);
            if (!isTrial && !state.owned.has(R.id)) {
                if (!authed)
                    return delayed(err(401, 'UNAUTHORIZED', '未登录或凭证过期'));
                return delayed(err(403, 'NOT_ENTITLED', '尚未解锁该研报'));
            }
            if (!isTrial)
                state.readLog.add(R.id); // 层①阅读行为落账（P1-2 资格闸判据）
            const html = isTrial
                ? R.id === 'js-shuiwang-2026'
                    ? (bundledShuiwangChapters().find((b) => b.id === chapterId) || {}).html || ''
                    : R.chapters[idx].trialHtml || ''
                : paidChapterHtml(R, chapterId);
            return delayed(ok({ chapter_id: chapterId, html, is_trial: isTrial ? 1 : 0 }));
        }
        if (route.endsWith('/favorite') && (method === 'POST' || method === 'DELETE')) {
            if (!authed)
                return delayed(err(401, 'UNAUTHORIZED', '未登录或凭证过期'));
            if (!R)
                return delayed(err(404, 'REPORT_NOT_FOUND', '报告不存在或已下架'));
            if (method === 'POST')
                state.favorites.add(R.id);
            else
                state.favorites.delete(R.id);
            return delayed(ok({ favorited: method === 'POST' }));
        }
        if (route === '/pay/sign' && method === 'POST') {
            if (!authed)
                return delayed(err(401, 'UNAUTHORIZED', '未登录或凭证过期'));
            const reportId = String(body.report_id || '');
            const r = mock_reports_1.REPORTS.find((x) => x.id === reportId);
            if (!r)
                return delayed(err(404, 'REPORT_NOT_FOUND', '报告不存在或已下架'));
            if (state.owned.has(reportId))
                return delayed(err(409, 'ALREADY_ENTITLED', '已解锁该研报'));
            const outTradeNo = `${reportId}_${Date.now()}`;
            state.payOrders.set(outTradeNo, reportId);
            const signData = JSON.stringify({
                offerId: 'mockOfferId',
                buyQuantity: 1,
                env: 0,
                currencyType: 'CNY',
                productId: 'xy_report_unlock',
                goodsPrice: mock_reports_1.MOCK_PRICE_FEN,
                outTradeNo,
                attach: 'mockattach0123456789',
                mode: 'short_series_goods',
            });
            return delayed(ok({ mode: 'short_series_goods', sign_data: signData, pay_sig: 'mock-pay-sig', signature: 'mock-signature', out_trade_no: outTradeNo, price_fen: mock_reports_1.MOCK_PRICE_FEN }));
        }
        if (route === '/pay/status') {
            if (!authed)
                return delayed(err(401, 'UNAUTHORIZED', '未登录或凭证过期'));
            const no = q.out_trade_no || '';
            const reportId = state.payOrders.get(no);
            if (!reportId)
                return delayed(err(404, 'ORDER_NOT_FOUND', '订单不存在'));
            state.owned.add(reportId);
            return delayed(ok({ out_trade_no: no, report_id: reportId, status: 'paid', entitlement_granted: true }));
        }
        if (route === '/me') {
            if (!authed)
                return delayed(err(401, 'UNAUTHORIZED', '未登录或凭证过期'));
            const orderOf = (reportId) => {
                const hit = Array.from(state.payOrders.entries()).find(([, rid]) => rid === reportId);
                return hit ? hit[0] : '';
            };
            return delayed(ok({
                uid: 'uMock01',
                nickname: '试读者',
                entitlements: Array.from(state.owned).map((id) => ({
                    report_id: id,
                    source: state.ownedSource.get(id) || 'purchase',
                    order_id: orderOf(id),
                    granted_at: '2026-09-28T10:00:00+08:00',
                    expires_at: '',
                })),
                favorites: Array.from(state.favorites).map((id) => ({
                    report_id: id,
                    favorited_at: '2026-09-28T10:00:00+08:00',
                })),
                vouchers_balance_fen: voucherBalance(),
                refund_count_month: state.refundCountMonth,
                refund_monthly_limit: 2,
                refunds: state.refunds,
            }));
        }
        // /reports/{id} 详情（放最后兜底）
        if (route.startsWith('/reports/')) {
            if (!R)
                return delayed(err(404, 'REPORT_NOT_FOUND', '报告不存在或已下架'));
            return delayed(ok(detailOf(R)));
        }
        return delayed(null);
    });
}
