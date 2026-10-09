"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.criticismLength = criticismLength;
exports.handleP1 = handleP1;
// utils/mock-fixtures-p1.ts — mockApi P1 路由处理器（API_DESIGN P1-1/2/3/4/8/9/10 形状）：
// 点赞赠报告/批评四层闸/批评评分退款/组队/书券账本/邀请关系；
// v1.2 情报官体系：/invite/relations 扩 level/ladder（?form=achieved=L1 达成形态）+ /invite/dwell 停留上报。
// 防泄漏纪律：全部 P1 响应不含 html 正文与 sign_data/session_key 等密钥类字段（测试有缺席断言）。
// mock 单用户演示注：引擎侧组队 size 按 uid 去重、批评评分走异步免费模型；mock 以单账号状态机近似。
const mock_reports_1 = require("./mock-reports");
const err = (status, code, message, extra) => ({
    status,
    body: { code, message, ...(extra || {}) },
});
const ok = (body) => ({ status: 200, body });
const UID = 'uMock01';
const CAPACITY = 3;
const TEAM_PRICE_FEN = 99800;
const REDEEM_FEN = 49800;
/** 感谢券金额=运营参数（AGREEMENT 未公示固定值），mock 演示样例 ¥20 */
const THANKS_VOUCHER_FEN = 2000;
const GIFT_RULE = '每日限 1 份·必得·附条件赠送';
function today() {
    const d = new Date();
    const p = (n) => String(n).padStart(2, '0');
    return `${d.getFullYear()}-${p(d.getMonth() + 1)}-${p(d.getDate())}`;
}
function shortId(prefix) {
    return prefix + Date.now().toString(36) + Math.floor(Math.random() * 100).toString(36);
}
/** 批评字数（按 Unicode 码点，中文一字一点；与引擎 50-300 判据同口径的 mock 近似） */
function criticismLength(content) {
    return Array.from(content).length;
}
/** 语义锚定检测：须引用具体章节（第N章）或数字数据点；纯模板话术锚定分=0（FR-P1-03） */
function hasAnchor(content) {
    if (/第\s*[0-9一二三四五六七八九十百]+\s*章/.test(content))
        return true;
    return /\d/.test(content);
}
/** 懒评分（GET /criticisms/{id} 首查时落三维分+依据；mock 以内容特征近似免费模型判断层） */
function scoreCriticism(c, R) {
    const len = criticismLength(c.content);
    const chapterHit = /第\s*([0-9一二三四五六七八九十百]+)\s*章/.exec(c.content);
    const hasNum = /\d/.test(c.content);
    const adviceHit = /建议|应该|改进|希望|可以增加|宜/.test(c.content);
    const sincerity = Math.min(95, 40 + Math.floor(len / 5));
    const authenticity = chapterHit ? (hasNum ? 88 : 76) : hasNum ? 56 : 42;
    const constructiveness = adviceHit ? 78 : 42;
    const final = Math.round(((sincerity + authenticity + constructiveness) / 3) * 10) / 10;
    const chTitle = R && chapterHit ? (R.chapters.find((x) => x.title.indexOf(chapterHit[0].replace(/\s/g, '')) >= 0) || {}).title || chapterHit[0] : chapterHit ? chapterHit[0] : '执行摘要';
    c.llm_scores = {
        sincerity,
        authenticity,
        constructiveness,
        rationale: `「${c.content.slice(0, 12)}…」↔ ${chTitle}`,
    };
    c.final_score = final;
    c.refund_tier = `tier${Math.floor(final)}`;
    c.status = 'scored';
}
function teamView(t) {
    return {
        team_id: t.team_id,
        report_id: t.report_id,
        leader_uid: t.leader_uid,
        size: t.size,
        capacity: t.capacity,
        total_price_fen: t.total_price_fen,
        status: t.status,
    };
}
function voucherBalance(v) {
    return v.reduce((acc, x) => acc + (x.status === 'active' ? x.amount_fen : -x.amount_fen), 0);
}
/** P1 mock 路由：命中返回 {status, body}；非 P1 路由返回 null 回落 P0 处理器 */
function handleP1(method, route, q, body, deps) {
    const { authed, R, state } = deps;
    // —— P1-1 POST /reports/{id}/like（当日首赞必得；与分享完全解耦）——
    if (route.endsWith('/like') && method === 'POST' && R) {
        if (!authed)
            return err(401, 'UNAUTHORIZED', '未登录或凭证过期');
        if (state.likeDate === today())
            return err(429, 'GIFT_DAILY_LIMIT', '今日赠阅已领取，明日再来');
        // 赠品从「未购清单」指定，但排除所赞报告本身（点赞即免费读所赞报告=支付绕洞）
        const gift = mock_reports_1.REPORTS.find((r) => r.id !== R.id && !state.owned.has(r.id));
        state.likeDate = today();
        if (!gift)
            return ok({ granted: false, granted_report_id: '', gift_rule: GIFT_RULE });
        state.owned.add(gift.id);
        state.ownedSource.set(gift.id, 'gift');
        return ok({ granted: true, granted_report_id: gift.id, gift_rule: GIFT_RULE });
    }
    // —— P1-2 POST /reports/{id}/criticize（四层闸·同步预筛）——
    if (route.endsWith('/criticize') && method === 'POST' && R) {
        if (!authed)
            return err(401, 'UNAUTHORIZED', '未登录或凭证过期');
        const content = String(body.content || '');
        const len = criticismLength(content);
        if (len < 50 || len > 300)
            return err(400, 'LENGTH_INVALID', '批评须 50-300 字');
        if (!state.owned.has(R.id))
            return err(403, 'NOT_PURCHASED', '须先解锁或获赠该报告后才能发起批评');
        if (!state.readLog.has(R.id))
            return err(400, 'NO_READ_RECORD', '须先真实阅读该报告后才能发起批评');
        const dup = Array.from(state.criticisms.values()).some((c) => c.report_id === R.id && c.status !== 'manual_pending');
        if (dup)
            return err(400, 'CRITICISM_DUP', '每份报告每个账号限发起 1 次批评');
        if (state.refundCountMonth >= 2)
            return err(429, 'REFUND_MONTHLY_LIMIT', '本月成功退款已达 2 次上限');
        if (!hasAnchor(content))
            return err(400, 'ANCHOR_ZERO', '批评须引用具体章节或数据点，模板化话术无法通过评估');
        const similar = Array.from(state.criticisms.values()).find((c) => c.content.slice(0, 12) === content.slice(0, 12));
        if (similar)
            return err(409, 'SIMILARITY_HIGH', '与历史批评高度雷同，已转人工复核', { stage: 'manual_pending' });
        const id = shortId('c');
        state.criticisms.set(id, { id, report_id: R.id, content, status: 'pending_score', applied: false, refund: null });
        return ok({
            criticism_id: id,
            stage: 'pre_gate_passed',
            anchor_score: chapterAnchorScore(content),
            similarity_score: 0.11,
            scoring: 'async',
            poll: `/api/v1/criticisms/${id}`,
        });
    }
    // —— P1-3 GET /criticisms/{id}（评分异步；首查懒落三维分）——
    if (route.startsWith('/criticisms/') && method === 'GET') {
        if (!authed)
            return err(401, 'UNAUTHORIZED', '未登录或凭证过期');
        const c = state.criticisms.get(route.split('/')[2]);
        if (!c)
            return err(404, 'CRITICISM_NOT_FOUND', '批评记录不存在');
        if (c.status === 'pending_score')
            scoreCriticism(c, mock_reports_1.REPORTS.find((r) => r.id === c.report_id) || null);
        return ok({
            id: c.id,
            status: c.status,
            llm_scores: c.llm_scores,
            final_score: c.final_score,
            refund_tier: c.refund_tier,
            refund: c.refund,
        });
    }
    // —— P1-4 POST /refund/apply（评分路径；映射=50→50%…100→100% 线性，<50 感谢券）——
    if (route === '/refund/apply' && method === 'POST') {
        if (!authed)
            return err(401, 'UNAUTHORIZED', '未登录或凭证过期');
        const c = state.criticisms.get(String(body.criticism_id || ''));
        if (!c)
            return err(404, 'CRITICISM_NOT_FOUND', '批评记录不存在');
        if (c.applied)
            return err(409, 'REFUND_DUP', '该批评已发起过退款');
        if (c.status === 'pending_score')
            scoreCriticism(c, mock_reports_1.REPORTS.find((r) => r.id === c.report_id) || null);
        c.applied = true;
        const score = c.final_score || 0;
        const refundId = shortId('rf');
        if (score < 50) {
            state.vouchers.push({
                id: shortId('v'),
                amount_fen: THANKS_VOUCHER_FEN,
                source: 'criticism_thanks',
                source_ref: c.id,
                status: 'active',
                created_at: new Date().toISOString(),
            });
            c.refund = { refund_id: refundId, method: 'voucher', amount_fen: THANKS_VOUCHER_FEN, status: 'settled' };
            return ok({ refund_id: refundId, platform: 'android', tier: `tier${Math.floor(score)}`, method: 'voucher', amount_fen: THANKS_VOUCHER_FEN, status: 'initiated', ios_track: null });
        }
        // ≥50 线性退款；自动退仅 ≤50% 档（ratio≤0.5），更高档转 manual（API_DESIGN P1-4 说明）
        const amount = Math.round((mock_reports_1.MOCK_PRICE_FEN * score) / 100);
        const method = score / 100 <= 0.5 ? 'auto' : 'manual';
        state.refunds.push({ refund_id: refundId, report_id: c.report_id, amount_fen: amount, method, status: 'initiated', created_at: new Date().toISOString() });
        state.refundCountMonth += 1;
        c.refund = { refund_id: refundId, method, amount_fen: amount, status: 'initiated' };
        return ok({ refund_id: refundId, platform: 'android', tier: `tier${Math.floor(score)}`, method, amount_fen: amount, status: 'initiated', ios_track: null });
    }
    // —— P1-9 POST /team（创建）／ POST /team/{id}/join（加入）——
    if (route === '/team' && method === 'POST') {
        if (!authed)
            return err(401, 'UNAUTHORIZED', '未登录或凭证过期');
        const reportId = String(body.report_id || '');
        if (!mock_reports_1.REPORTS.some((r) => r.id === reportId))
            return err(404, 'REPORT_NOT_FOUND', '报告不存在或已下架');
        if (state.myTeam && (state.teams.get(state.myTeam) || { status: 'full' }).status === 'open')
            return err(409, 'TEAM_DUP', '已在组队中，不可重复入队');
        const t = { team_id: shortId('t'), report_id: reportId, leader_uid: UID, size: 1, capacity: CAPACITY, total_price_fen: TEAM_PRICE_FEN, status: 'open' };
        state.teams.set(t.team_id, t);
        state.myTeam = t.team_id;
        return ok(teamView(t));
    }
    if (route.startsWith('/team/') && route.endsWith('/join') && method === 'POST') {
        if (!authed)
            return err(401, 'UNAUTHORIZED', '未登录或凭证过期');
        const t = state.teams.get(route.split('/')[2]);
        if (!t)
            return err(404, 'TEAM_NOT_FOUND', '组队不存在或已解散');
        if (t.status === 'full')
            return err(409, 'TEAM_FULL', '该组队已满员');
        // mock 单用户演示：引擎侧按 uid 去重计数，此处允许同一演示账号推进进度走查 UI
        t.size += 1;
        if (t.size >= t.capacity) {
            t.status = 'full';
            state.owned.add(t.report_id);
            state.ownedSource.set(t.report_id, 'invite');
        }
        return ok(teamView(t));
    }
    // —— P1-10 GET /me/vouchers ／ POST /vouchers/redeem ——
    if (route === '/me/vouchers' && method === 'GET') {
        if (!authed)
            return err(401, 'UNAUTHORIZED', '未登录或凭证过期');
        return ok({ balance_fen: voucherBalance(state.vouchers), ledger: state.vouchers });
    }
    if (route === '/vouchers/redeem' && method === 'POST') {
        if (!authed)
            return err(401, 'UNAUTHORIZED', '未登录或凭证过期');
        const reportId = String(body.report_id || '');
        if (!mock_reports_1.REPORTS.some((r) => r.id === reportId))
            return err(404, 'REPORT_NOT_FOUND', '报告不存在或已下架');
        if (state.owned.has(reportId))
            return err(409, 'ALREADY_ENTITLED', '已解锁该研报');
        if (voucherBalance(state.vouchers) < REDEEM_FEN)
            return err(400, 'BALANCE_INSUFFICIENT', '书券余额不足 498');
        state.vouchers.push({ id: shortId('v'), amount_fen: REDEEM_FEN, source: 'campaign', source_ref: `redeem:${reportId}`, status: 'used', created_at: new Date().toISOString() });
        state.owned.add(reportId);
        state.ownedSource.set(reportId, 'voucher');
        return ok({ redeemed: true, deducted_fen: REDEEM_FEN, report_id: reportId });
    }
    // —— P1-8 GET /invite/relations（v1.2 情报官体系：ladder 三档+有效带新计数；
    //    默认=未达成形态（进度可见但不发放）；?form=achieved=L1 达成形态（50 书券已发+馆友点亮））——
    if (route === '/invite/relations' && method === 'GET') {
        if (!authed)
            return err(401, 'UNAUTHORIZED', '未登录或凭证过期');
        const ladderOf = (l1) => [
            { level: 'L1', name: '观察员', threshold: 1, reached: l1 },
            { level: 'L2', name: '分析师', threshold: 5, reached: false },
            { level: 'L3', name: '情报官', threshold: 20, reached: false },
        ];
        if (q.form === 'achieved') {
            return ok({
                invited: [{ invitee_uid: 'uInvite01', status: 'unlocked', ts: '2026-09-28T09:30:00+08:00' }],
                progress: { new_users: 1, required: 1, unlocked: true },
                voucher_earned_fen: 5000,
                level: 'L1',
                level_name: '观察员',
                effective_count: 1,
                next_threshold: 5,
                ladder: ladderOf(true),
            });
        }
        return ok({
            invited: [{ invitee_uid: 'uInvite01', status: 'registered', ts: '2026-09-28T09:30:00+08:00' }],
            progress: { new_users: 0, required: 1, unlocked: false },
            voucher_earned_fen: 0,
            level: 'none',
            level_name: '',
            effective_count: 0,
            next_threshold: 1,
            ladder: ladderOf(false),
        });
    }
    // —— v1.2 POST /invite/dwell（情报官·阅读停留上报；契约 seconds≤600 由引擎钳位；
    //    mock 用户 uMock01 无上游邀请人=无归因关系 → 契约恒 200 + relation_marked:false）——
    if (route === '/invite/dwell' && method === 'POST') {
        if (!authed)
            return err(401, 'UNAUTHORIZED', '未登录或凭证过期');
        const reportId = String(body.report_id || '');
        if (!reportId)
            return err(400, 'PARAM_INVALID', '缺少 report_id');
        const sec = Number(body.seconds);
        if (!Number.isFinite(sec) || sec < 0)
            return err(400, 'PARAM_INVALID', 'seconds 须为非负数');
        return ok({ relation_marked: false, effective: false });
    }
    return null;
}
function chapterAnchorScore(content) {
    return /第\s*[0-9一二三四五六七八九十百]+\s*章/.test(content) ? 0.72 : 0.31;
}
