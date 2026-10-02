"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PROVINCE_OPTIONS = exports.TRANSFER_RULES_LINES = void 0;
exports.transferErrMsg = transferErrMsg;
exports.chatCounter = chatCounter;
exports.chatMsgOf = chatMsgOf;
exports.chatUserMsg = chatUserMsg;
exports.chatPendingMsg = chatPendingMsg;
exports.subscribeTopics = subscribeTopics;
exports.chapterIdxOf = chapterIdxOf;
// utils/p2-view.ts — P2 展示层纯函数与文案（AI 伴读/转赠/已购检索/订阅；供页面与测试共用）：
// 转赠三行规则摘要内联于此（utils/agreement.ts 无 TRANSFER 导出常量，真源不改——
// 完整规则仍跳协议页 §四 anchor=transfer）；转赠错误族 8 码→友好文案集中映射；
// 伴读消息视图（provider=local 或 degraded 时尾部渲染引擎 disclaimer 原串，前端不做任何模型选择）。
const api_1 = require("./api");
/** 转赠确认弹层三行规则摘要（完整版=协议 §四「转赠规则」，agreement?anchor=transfer） */
exports.TRANSFER_RULES_LINES = [
    '仅限您本人付费购买解锁的报告可转赠（获赠、书券兑换、组队获得、他人转赠的不可转赠）；',
    '每份报告终身仅可转赠 1 次，转赠一经完成不可撤回；',
    '转赠完成后您即时失去该报告完整阅读权益，受赠方获得完整阅读权益（不可再转赠）。',
];
/** 转赠错误族→友好文案（契约 8 码全覆盖 + 网络降级 + 兜底） */
function transferErrMsg(e) {
    const map = {
        ALREADY_TRANSFERRED: '该报告已转赠过，每份终身仅 1 次',
        NOT_ENTITLED: '尚未持有该报告权益，不可转赠',
        NOT_TRANSFERABLE: '仅限本人付费购买的报告可转赠',
        REFUND_IN_FLIGHT: '该报告有未完结的退款申请，暂不可转赠',
        TRANSFER_SELF: '不能把报告转赠给自己',
        ALREADY_ENTITLED: '对方已拥有该报告，无需转赠',
        USER_NOT_FOUND: '对方学园号不存在，请核对后重试',
        INVALID_PARAM: '请填写对方的学园号',
    };
    if (map[e.code || ''])
        return map[e.code];
    if (e.code === 'NETWORK')
        return e.message;
    return (0, api_1.errMsg)(e, '转赠失败，请稍后重试');
}
/** 伴读问句计数（契约冻结口径 1-200 字；中文一字一点，Unicode 码点数） */
function chatCounter(text) {
    const n = Array.from(text || '').length;
    return { text: `${n}/200`, ok: n > 0 && n <= 200 };
}
function emptyMsg() {
    return { role: 'assistant', text: '', citations: [], disclaimer: '', showDisclaimer: false, pending: false };
}
/** 引擎应答→伴读消息视图（免费模型铁律：前端不选模型，provider 由引擎答） */
function chatMsgOf(res) {
    const show = res.provider === 'local' || !!res.degraded;
    return {
        ...emptyMsg(),
        text: res.answer || '',
        citations: Array.isArray(res.citations) ? res.citations : [],
        disclaimer: show ? res.disclaimer || '' : '',
        showDisclaimer: show,
    };
}
/** 用户消息视图 */
function chatUserMsg(text) {
    return { ...emptyMsg(), role: 'user', text };
}
/** 待答占位消息视图 */
function chatPendingMsg() {
    return { ...emptyMsg(), pending: true };
}
/** 31 省级行政区清单（订阅省份候选常量；catalog 聚合仅覆盖已上架省份太薄，按任务口径写死常见集合） */
exports.PROVINCE_OPTIONS = [
    '北京', '天津', '河北', '山西', '内蒙古', '辽宁', '吉林', '黑龙江',
    '上海', '江苏', '浙江', '安徽', '福建', '江西', '山东', '河南',
    '湖北', '湖南', '广东', '广西', '海南', '重庆', '四川', '贵州',
    '云南', '西藏', '陕西', '甘肃', '青海', '宁夏', '新疆',
];
/** 订阅主题候选：包内 catalog industry 字段聚合（真实来源=store.loadCatalog().reports）；聚合为空兜底固定集 */
function subscribeTopics(reports) {
    const set = new Set();
    reports.forEach((r) => {
        const v = (r.industry || '').trim();
        if (v)
            set.add(v);
    });
    const out = Array.from(set).sort();
    return out.length ? out : ['水利工程', '轨道交通', '能源电力'];
}
/** chapter_id（形如 chNN，与引擎 owned_search._idx_of 同口径）→ 阅读器 ?ch= 1 基章序；解析失败回 1 */
function chapterIdxOf(chapterId) {
    const m = /(\d+)\s*$/.exec(String(chapterId || ''));
    return m ? Math.max(1, Number(m[1])) : 1;
}
