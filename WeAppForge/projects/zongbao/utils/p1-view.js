"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.VOUCHER_REDEEM_FEN = exports.DWELL_MAX_SECONDS = exports.DWELL_MIN_SECONDS = void 0;
exports.teamRulesLines = teamRulesLines;
exports.likeRulesLines = likeRulesLines;
exports.critRefundRulesLines = critRefundRulesLines;
exports.buildLikeGift = buildLikeGift;
exports.buildTeamView = buildTeamView;
exports.critCounter = critCounter;
exports.buildInviteCard = buildInviteCard;
exports.dwellReportSeconds = dwellReportSeconds;
exports.buildVoucherCard = buildVoucherCard;
exports.buildCritReceipt = buildCritReceipt;
// utils/p1-view.ts — P1 展示层纯函数（detail/reader/me 三页共享；无 wx 依赖可单测）：
// 规则文案一律从 utils/agreement.ts 真源结构化提取（不改真源）；组队/批评/点赞/情报官/书券视图整形+停留上报判据。
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
/** 三档梯队缺省（与 agreement INVITE_LADDER_RULES 阈值对齐：1/5/20；服务端 ladder 缺席时兜底） */
const LADDER_DEFAULT = [
    { level: 'L1', name: '观察员', threshold: 1 },
    { level: 'L2', name: '分析师', threshold: 5 },
    { level: 'L3', name: '情报官', threshold: 20 },
];
function buildInviteCard(raw) {
    // new_users 语义 v1.2 升级为「有效带新数」（=effective_count；引擎未升级时以该字段近似）
    const eff = typeof raw.effective_count === 'number' && raw.effective_count >= 0
        ? Math.floor(raw.effective_count)
        : Number(raw.progress && raw.progress.new_users) || 0;
    const ladderRaw = Array.isArray(raw.ladder) ? raw.ladder : [];
    const ladder = LADDER_DEFAULT.map((fixed) => {
        const hit = ladderRaw.find((x) => x && x.level === fixed.level);
        const threshold = hit && Number(hit.threshold) > 0 ? Math.floor(Number(hit.threshold)) : fixed.threshold;
        const name = hit && hit.name ? String(hit.name) : fixed.name;
        const reached = hit && typeof hit.reached === 'boolean' ? hit.reached : eff >= threshold;
        return { level: fixed.level, name, threshold, reached, text: `${fixed.level} ${name} · ${threshold} 位` };
    });
    // 等级：服务端 level 优先（'none' 或缺席=未达成），缺席时按梯队已达成的最高档推导
    const derived = ladder.reduce((acc, s) => (s.reached ? s.level : acc), 'none');
    const level = raw.level === 'L1' || raw.level === 'L2' || raw.level === 'L3' ? raw.level : derived;
    const levelName = level === 'none' ? '未达成' : ladder.filter((s) => s.level === level).map((s) => s.name)[0] || String(raw.level_name || '');
    // 下一档阈值：服务端 next_threshold 优先；缺席=按当前等级取梯队下一档（none→L1；L3 满级=null）
    const curIdx = ladder.findIndex((s) => s.level === level);
    const nextFromLadder = level === 'none' ? (ladder[0] ? ladder[0].threshold : null) : curIdx >= 0 && curIdx < ladder.length - 1 ? ladder[curIdx + 1].threshold : null;
    const hasServerNext = raw.next_threshold === null || typeof raw.next_threshold === 'number';
    const nextThreshold = level === 'L3' ? null : hasServerNext ? raw.next_threshold : nextFromLadder;
    const req = Number(raw.progress && raw.progress.required) || (ladder[0] ? ladder[0].threshold : 1);
    const unlocked = raw.progress && typeof raw.progress.unlocked === 'boolean' ? raw.progress.unlocked : level !== 'none';
    const remainNext = nextThreshold !== null ? Math.max(0, nextThreshold - eff) : 0;
    const hint = level === 'L3'
        ? '已达成 L3「情报官」：1000 书券已入账+周榜署名「本周情报官」+年度闭门会邀请（远期权益，安排以届时公告为准）'
        : level === 'L2'
            ? `已达成 L2「分析师」：200 书券已入账+新报告首读权；再带 ${remainNext} 位有效带新升 L3「情报官」`
            : level === 'L1'
                ? `已达成 L1「观察员」：馆友标记已点亮，50 书券已入账；再带 ${remainNext} 位有效带新升 L2「分析师」`
                : '邀 1 位有效带新即达成 L1「观察员」：点亮馆友标记并发 50 书券（未达成时进度可见但不发放）';
    return {
        newUsers: eff,
        required: req,
        unlocked,
        earnedYuan: (0, format_1.fenToYuan)(Number(raw.voucher_earned_fen) || 0),
        progressText: nextThreshold === null ? `有效带新 ${eff} 位 · 梯队满级` : `有效带新 ${eff}/${nextThreshold} 位`,
        hint,
        level,
        levelName,
        badgeText: level === 'none' ? '未达成' : `${level} ${levelName}`,
        effectiveCount: eff,
        nextThreshold,
        ladder,
        progressPct: nextThreshold === null ? 100 : Math.min(100, Math.round((eff / nextThreshold) * 100)),
    };
}
// —— reader 停留上报判据（v1.2 有效带新条件②：停留 ≥30 秒才上报；单段封顶 600 秒与引擎契约一致）——
exports.DWELL_MIN_SECONDS = 30;
exports.DWELL_MAX_SECONDS = 600;
/** 停留秒数 → 应上报秒数（<30 返 0 不上报；>600 封顶） */
function dwellReportSeconds(startMs, nowMs) {
    const seconds = Math.floor((nowMs - startMs) / 1000);
    return seconds >= exports.DWELL_MIN_SECONDS ? Math.min(exports.DWELL_MAX_SECONDS, seconds) : 0;
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
