"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.resetMockP2ForTest = resetMockP2ForTest;
exports.setMockSubscribeConfiguredForTest = setMockSubscribeConfiguredForTest;
exports.handleP2 = handleP2;
// utils/mock-fixtures-p2.ts — mockApi P2 路由处理器（AI 伴读/已购检索/转赠/订阅；契约字段名冻结不得改）：
// POST /reports/{rid}/chat：确定性检索式应答（provider 恒 'local'，零外呼零计费，免费模型铁律）；
//   citations 形状对齐引擎 ai_chat.local_answer：{chapter_id, chapter_title, page, quote}（Top-K≤3，quote=命中句±40 字）；
// GET /search/owned：已购库章级检索，游标分页 cursor="{report_id}:{chapter_idx}"（页大小 20 对齐 SEARCH_OWNED_PAGE_SIZE，
//   结果按 (REPORTS 序, 章序) 稳定排序；snippet 泄漏控制对齐 ±40 字口径）；
// POST /reports/{rid}/transfer：错误族逐码（409 ALREADY_TRANSFERRED/403 NOT_ENTITLED/403 NOT_TRANSFERABLE/
//   409 REFUND_IN_FLIGHT/403 TRANSFER_SELF/409 ALREADY_ENTITLED/404 USER_NOT_FOUND/400 INVALID_PARAM），
//   成功即从同一 mock 会话移除权益（/me 即时反映「权益已失」）；
// GET/POST/DELETE /subscriptions：未配置引擎配置位时 501 SUBSCRIBE_NOT_CONFIGURED（前端整块隐藏契约）。
// 注册方式照 mock-fixtures-p1.ts 的 handleP1 惯例：导出 handleP2(method,route,q,body,deps)，
// 由 mock-fixtures.ts mockRequest 注入会话态（单一状态源，不自建影子会话）。
// 密钥卫生：本文件不含任何密钥/凭据/appid 类字段（卫生扫描断言目标）。
const mock_reports_1 = require("./mock-reports");
const err = (status, code, message) => ({ status, body: { code, message } });
const ok = (body) => ({ status: 200, body });
const UID_SELF = 'uMock01';
const DISCLAIMER = '检索式应答，待接免费模型';
const CHAT_MAX = 200;
const TOP_K = 3;
const SNIPPET_RADIUS = 40;
const PAGE_CHARS = 340;
const OWNED_PAGE_SIZE = 20;
/** mock 受赠方账号簿（引擎为全站学园号；uPeerOwned=已拥有全部报告的演示号） */
const KNOWN_PEERS = new Set(['uPeer01', 'uPeer02']);
const PEER_OWNS_ALL = 'uPeerOwned';
// 模块级引擎侧台账（非会话影子态：转赠登记簿=引擎 transfers 表的 mock 对应物；
// 订阅存储/配置位=引擎 subscriptions 表与 XY_SUBSCRIBE_* 配置的 mock 对应物）
const transferred = new Set();
const subs = new Map();
let subscribeConfigured = false;
/** 测试隔离：重置 P2 引擎侧台账（与 resetMockStateForTest 同惯例，生产不调用） */
function resetMockP2ForTest() {
    transferred.clear();
    subs.clear();
    subscribeConfigured = false;
}
/** 引擎订阅配置位翻转（对齐「运维配置 XY_SUBSCRIBE_* 后才 configured」；测试/演示用） */
function setMockSubscribeConfiguredForTest(v) {
    subscribeConfigured = v;
}
/** mock 确定性章语料：章标题+报告题+每章通用要点句（试读/付费同语料口径；引擎为全文检索） */
function chapterPlain(r, ch, i) {
    const trial = (ch.trialHtml || '').replace(/<[^>]+>/g, ' ');
    return (`${ch.title} ${r.title} ${trial} 第${i + 1}章要点：投资规模与招标节奏、商机清单与业主偏好、` +
        `区域梯度与时间窗口。样本项目数 ${12 + i} 个。`);
}
/** 问句切词 mock 近似（引擎 jieba）：拉丁词逐词 + CJK 逐字，去重排序 */
function tokenize(q) {
    return Array.from(new Set(q.toLowerCase().match(/[a-z0-9]+|[一-鿿]/g) || []));
}
/** 命中句 ±40 字窗口（对齐 make_snippet 泄漏控制口径） */
function snippetAround(plain, hit) {
    const start = Math.max(0, hit - SNIPPET_RADIUS);
    const end = Math.min(plain.length, hit + SNIPPET_RADIUS + 1);
    return { quote: plain.slice(start, end).trim(), offset: hit };
}
/** 确定性检索：各章命中计数→Top-K 段（带 quote/page；page 按 340 字/页估算口径） */
function retrieve(r, question) {
    const toks = tokenize(question);
    if (!toks.length)
        return [];
    const scored = [];
    r.chapters.forEach((ch, i) => {
        const plain = chapterPlain(r, ch, i);
        const low = plain.toLowerCase();
        const pos = toks.map((t) => low.indexOf(t)).filter((p) => p >= 0);
        if (!pos.length)
            return;
        scored.push({ n: pos.length, i, ch, plain, first: Math.min(...pos) });
    });
    scored.sort((a, b) => b.n - a.n || a.i - b.i);
    return scored.slice(0, TOP_K).map((s) => {
        const { quote } = snippetAround(s.plain, s.first);
        return {
            chapter_id: s.ch.id,
            chapter_title: s.ch.title,
            page: Math.max(1, Math.ceil((s.first + 1) / PAGE_CHARS)),
            quote,
        };
    });
}
/** 检索式应答（对齐引擎 local_answer 文案格式；无命中诚实说无，不编造） */
function localAnswer(r, question) {
    const cites = retrieve(r, question);
    if (!cites.length) {
        return { answer: `在《${r.title}》中未检索到与您提问直接相关的内容。${DISCLAIMER}`, citations: [] };
    }
    const best = cites[0];
    const answer = `依据《${r.title}》检索，与您提问最相关的段落位于「${best.chapter_title}」（约第 ${best.page} 页）：\n` +
        `「${best.quote}」\n以上为报告原文命中段，供溯源核对。${DISCLAIMER}`;
    return { answer, citations: cites };
}
function normList(v) {
    if (!Array.isArray(v))
        return [];
    return Array.from(new Set(v.map((x) => String(x).trim()).filter(Boolean)));
}
function subOf(kind) {
    let s = subs.get(kind);
    if (!s) {
        s = new Set();
        subs.set(kind, s);
    }
    return s;
}
function subsItems() {
    const out = [];
    Array.from(subs.keys())
        .sort()
        .forEach((kind) => {
        Array.from(subs.get(kind))
            .sort()
            .forEach((value) => out.push({ kind, value, created_at: '2026-09-28T10:00:00+08:00' }));
    });
    return out;
}
/** P2 mock 路由：命中返回 {status, body}；非 P2 路由返回 null 回落 P1/P0 处理器 */
function handleP2(method, route, q, body, deps) {
    const { authed, R, state } = deps;
    // —— 契约1 POST /reports/{rid}/chat（Bearer+已购闸；检索式应答零外呼）——
    const chatM = /^\/reports\/([^/]+)\/chat$/.exec(route);
    if (chatM && method === 'POST') {
        if (!authed)
            return err(401, 'UNAUTHORIZED', '未登录或凭证过期');
        if (!R)
            return err(404, 'REPORT_NOT_FOUND', '报告不存在或已下架');
        if (!state.owned.has(R.id))
            return err(403, 'NOT_ENTITLED', '尚未解锁该研报');
        const question = String(body.question || '').trim();
        if (!question || Array.from(question).length > CHAT_MAX) {
            return err(400, 'INVALID_PARAM', `问句须为 1-${CHAT_MAX} 字`);
        }
        const { answer, citations } = localAnswer(R, question);
        return ok({
            report_id: R.id,
            question,
            answer,
            provider: 'local',
            citations,
            degraded: false,
            disclaimer: DISCLAIMER,
        });
    }
    // —— 契约2 GET /search/owned（Bearer；已购库章级检索+游标分页）——
    if (route === '/search/owned' && method === 'GET') {
        if (!authed)
            return err(401, 'UNAUTHORIZED', '未登录或凭证过期');
        const kw = (q.q || '').trim();
        if (!kw)
            return err(400, 'INVALID_PARAM', '缺少搜索词 q');
        const low = kw.toLowerCase();
        const hits = [];
        mock_reports_1.REPORTS.filter((r) => state.owned.has(r.id)).forEach((r) => {
            r.chapters.forEach((ch, i) => {
                const plain = chapterPlain(r, ch, i);
                const at = plain.toLowerCase().indexOf(low);
                if (at >= 0)
                    hits.push({ rid: r.id, r, ch, i, plain, first: at });
            });
        });
        const order = new Map(mock_reports_1.REPORTS.map((r, idx) => [r.id, idx]));
        hits.sort((a, b) => (Number(order.get(a.rid)) - Number(order.get(b.rid))) || (a.i - b.i));
        let start = 0;
        if (q.cursor) {
            const parts = q.cursor.split(':');
            const co = order.get(parts[0]);
            const ci = Number(parts[1]);
            if (co === undefined || !Number.isFinite(ci))
                return err(400, 'INVALID_PARAM', 'cursor 无效');
            // 跳过已发条目：游标比较键 (REPORTS 序, 1 基章序)
            const at = hits.findIndex((h) => Number(order.get(h.rid)) > co || (Number(order.get(h.rid)) === co && h.i + 1 > ci));
            start = at < 0 ? hits.length : at;
        }
        const total = hits.length;
        const page = hits.slice(start, start + OWNED_PAGE_SIZE);
        const items = page.map((h) => {
            const { quote, offset } = snippetAround(h.plain, h.first);
            return { report_id: h.rid, title: h.r.title, chapter_id: h.ch.id, chapter_title: h.ch.title, snippet: quote, offset };
        });
        const hasMore = start + OWNED_PAGE_SIZE < total;
        const last = page[page.length - 1];
        return ok({ items, total, next_cursor: hasMore && last ? `${last.rid}:${last.i + 1}` : '', has_more: hasMore });
    }
    // —— 契约3 POST /reports/{rid}/transfer（Bearer；错误族逐码；成功即移除权益）——
    const trM = /^\/reports\/([^/]+)\/transfer$/.exec(route);
    if (trM && method === 'POST') {
        if (!authed)
            return err(401, 'UNAUTHORIZED', '未登录或凭证过期');
        if (!R)
            return err(404, 'REPORT_NOT_FOUND', '报告不存在或已下架');
        const toUid = String(body.to_uid || '').trim();
        if (!toUid)
            return err(400, 'INVALID_PARAM', '缺少受赠方标识（to_uid）');
        if (transferred.has(R.id))
            return err(409, 'ALREADY_TRANSFERRED', '该报告已转赠过，每份终身仅 1 次');
        if (!state.owned.has(R.id))
            return err(403, 'NOT_ENTITLED', '尚未持有该报告权益，不可转赠');
        if ((state.ownedSource.get(R.id) || 'purchase') !== 'purchase') {
            return err(403, 'NOT_TRANSFERABLE', '仅限本人付费购买的报告可转赠');
        }
        if (state.refunds.some((x) => x.report_id === R.id && x.status === 'initiated')) {
            return err(409, 'REFUND_IN_FLIGHT', '该报告存在未完结的退款申请，不可转赠');
        }
        if (toUid === UID_SELF)
            return err(403, 'TRANSFER_SELF', '不能把报告转赠给自己');
        if (toUid !== PEER_OWNS_ALL && !KNOWN_PEERS.has(toUid))
            return err(404, 'USER_NOT_FOUND', '受赠方账号不存在');
        if (toUid === PEER_OWNS_ALL)
            return err(409, 'ALREADY_ENTITLED', '受赠方已拥有该报告，无需转赠');
        transferred.add(R.id);
        state.owned.delete(R.id);
        state.ownedSource.delete(R.id);
        return ok({
            transferred: true,
            transfer_id: `tr${Date.now().toString(36)}`,
            report_id: R.id,
            from_uid: UID_SELF,
            to_uid: toUid,
            transferred_at: new Date().toISOString(),
        });
    }
    // —— 契约4 GET/POST/DELETE /subscriptions（Bearer；未配置 501 SUBSCRIBE_NOT_CONFIGURED）——
    if (route === '/subscriptions' && (method === 'GET' || method === 'POST' || method === 'DELETE')) {
        if (!authed)
            return err(401, 'UNAUTHORIZED', '未登录或凭证过期');
        if (!subscribeConfigured)
            return err(501, 'SUBSCRIBE_NOT_CONFIGURED', '订阅通知未配置');
        if (method === 'GET')
            return ok({ items: subsItems(), configured: true });
        if (method === 'POST') {
            const provinces = normList(body.provinces);
            const topics = normList(body.topics);
            if (!provinces.length && !topics.length)
                return err(400, 'INVALID_PARAM', 'provinces/topics 至少一项非空');
            provinces.forEach((v) => subOf('province').add(v));
            topics.forEach((v) => subOf('topic').add(v));
            return ok({ items: subsItems(), configured: true });
        }
        const kind = String(body.kind || '');
        const value = String(body.value || '').trim();
        if (kind !== 'province' && kind !== 'topic')
            return err(400, 'INVALID_PARAM', 'kind 仅支持 province|topic');
        if (!value)
            return err(400, 'INVALID_PARAM', '缺少 value');
        subOf(kind).delete(value);
        return ok({ items: subsItems(), configured: true });
    }
    return null;
}
