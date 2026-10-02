"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.VOUCHER_REDEEM_FEN = void 0;
exports.teamRulesLines = teamRulesLines;
exports.likeRulesLines = likeRulesLines;
exports.critRefundRulesLines = critRefundRulesLines;
exports.buildLikeGift = buildLikeGift;
exports.buildTeamView = buildTeamView;
exports.critCounter = critCounter;
exports.buildInviteCard = buildInviteCard;
exports.buildVoucherCard = buildVoucherCard;
exports.buildCritReceipt = buildCritReceipt;
// utils/p1-view.ts — P1 展示层纯函数（detail/reader/me 三页共享；无 wx 依赖可单测）：
// 规则文案一律从 utils/agreement.ts 真源结构化提取（不改真源）；组队/批评/点赞/邀请/书券视图整形。
const agreement_1 = require("./agreement");
const format_1 = require("./format");
/** 节内全部 bullets 平铺提取（结构化取文；真源零改动） */
function sectionBullets(key) {
    const sec = agreement_1.AGREEMENT_SECTIONS.find((s) => s.key === key);
    if (!sec)
        return [];
    const out = [];
    sec.clauses.forEach((c) => c.blocks.forEach((b) => {
        if (b.kind === 'bullets' && b.items)
            out.push(...b.items);
    }));
    return out;
}
/** 组队规则四条（含 72h 未满员处置，AGREEMENT_COPY §四逐字） */
function teamRulesLines() {
    return sectionBullets('team');
}
/** 点赞赠报告规则五条（§三逐字） */
function likeRulesLines() {
    return sectionBullets('like');
}
/** 2.4「四、退款映射」bullets（评分达标按比例退款规则，§二逐字） */
function critRefundRulesLines() {
    const sec = agreement_1.AGREEMENT_SECTIONS.find((s) => s.key === 'pay');
    const clause = sec && sec.clauses.find((c) => c.id === '2.4');
    if (!clause)
        return [];
    let after = false;
    const out = [];
    clause.blocks.forEach((b) => {
        if (b.kind === 'subhead' && b.text === '四、退款映射') {
            after = true;
            return;
        }
        if (after && b.kind === 'bullets' && b.items)
            out.push(...b.items);
    });
    return out;
}
function buildLikeGift(resp, titleOf) {
    return {
        id: resp.granted_report_id || '',
        title: resp.granted_report_id ? titleOf(resp.granted_report_id) : '',
        rule: resp.gift_rule || '',
        granted: !!resp.granted,
    };
}
function buildTeamView(raw) {
    return {
        teamId: raw.team_id || '',
        size: Number(raw.size) || 0,
        capacity: Number(raw.capacity) || 3,
        priceYuan: (0, format_1.fenToYuan)(Number(raw.total_price_fen) || 99800),
        open: raw.status !== 'full',
        progressText: `已入队 ${Number(raw.size) || 0}/${Number(raw.capacity) || 3} 人`,
        statusText: raw.status === 'full' ? '已满员成队，全队已获得阅读权益' : '组队进行中，满 3 人全队各得一份',
    };
}
function critCounter(content) {
    const len = Array.from(content || '').length;
    return { len, text: `${len}/300`, ok: len >= 50 && len <= 300 };
}
function buildInviteCard(raw) {
    const n = Number(raw.progress && raw.progress.new_users) || 0;
    const req = Number(raw.progress && raw.progress.required) || 2;
    const unlocked = !!(raw.progress && raw.progress.unlocked);
    return {
        newUsers: n,
        required: req,
        unlocked,
        earnedYuan: (0, format_1.fenToYuan)(Number(raw.voucher_earned_fen) || 0),
        progressText: `已邀 ${n}/${req} 位新用户`,
        hint: unlocked ? '已达成：馆友标记已点亮，50 书券已入账' : '邀满 2 位新用户即达成：点亮馆友标记并发 50 书券（仅 1 位时进度可见但不发放）',
    };
}
// —— 书券卡（1 券=1 元；攒满 498 券兑一份）——
exports.VOUCHER_REDEEM_FEN = 49800;
const VOUCHER_SOURCE_TEXT = {
    invite: '邀请奖励',
    criticism_thanks: '感谢券',
    ios_refund: 'iOS 退款补偿',
    campaign: '活动发放',
};
function buildVoucherCard(raw) {
    const balanceFen = Number(raw.balance_fen) || 0;
    const pct = Math.min(100, Math.round((balanceFen / exports.VOUCHER_REDEEM_FEN) * 100));
    return {
        balanceFen,
        balanceYuan: (0, format_1.fenToYuan)(balanceFen),
        progressPct: pct,
        canRedeem: balanceFen >= exports.VOUCHER_REDEEM_FEN,
        ledger: (raw.ledger || []).map((x) => ({
            id: x.id,
            amountYuan: (x.status === 'used' ? '-' : '+') + (0, format_1.fenToYuan)(Number(x.amount_fen) || 0),
            neg: x.status === 'used',
            sourceText: VOUCHER_SOURCE_TEXT[x.source] || x.source,
            statusText: x.status === 'used' ? '已消耗' : x.status === 'expired' ? '已过期' : '生效中',
            createdAt: String(x.created_at || '').slice(0, 10),
        })),
    };
}
function buildCritReceipt(submitted, result) {
    const stage = submitted.stage;
    const manual = stage === 'manual_pending' || (result && result.status === 'manual_pending');
    const score = result && typeof result.final_score === 'number' ? result.final_score : null;
    const refund = result && result.refund ? result.refund : null;
    return {
        criticismId: submitted.criticism_id || '',
        stageText: manual
            ? '已受理：与历史批评相似度较高，转人工复核，结论将在结果页通知'
            : score === null
                ? '已受理：评分进行中，稍后点「刷新评分结果」查看'
                : `评分完成：总分 ${score} 分`,
        scoreText: score === null ? '' : `总分 ${score}（真诚/真实/建设 三维综合）`,
        rationale: (result && result.llm_scores && result.llm_scores.rationale) || '',
        refundText: refund
            ? refund.method === 'voucher'
                ? `总分未达 50 分：不退款，感谢券 ¥${(0, format_1.fenToYuan)(refund.amount_fen)} 已入账书券`
                : `退款已发起：¥${(0, format_1.fenToYuan)(refund.amount_fen)}（${refund.method === 'auto' ? '原路自动退回' : '人工审核处理'}，${refund.status}）`
            : score === null
                ? ''
                : score >= 50
                    ? '总分 ≥50：可按分数线性申请退款（50 分退 50%，100 分退 100%）'
                    : '总分 <50：不退款，发放感谢券致谢',
        canApplyRefund: score !== null && score >= 50 && !refund,
        refundApplied: !!refund,
    };
}
