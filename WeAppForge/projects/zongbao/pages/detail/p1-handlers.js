"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.p1Handlers = void 0;
// pages/detail/p1-handlers.ts — 详情页 P1 交互处理器（点赞赠阅/组队/批评评分退款）：
// 从 detail.ts 拆出守住单文件 ≤400 行预算；方法经对象展开并入 Page 配置，this=页面实例
// （data/setData/titleOf 由宿主页面提供；规则文案仍从 utils/agreement.ts 真源经 p1-view 取）。
const api_1 = require("../../utils/api");
const p1_view_1 = require("../../utils/p1-view");
exports.p1Handlers = {
    // —— P1 点赞必得赠阅（FR-P1-01：与分享完全解耦；当日二次 429「明日再来」）——
    async onLike() {
        const { liking, id } = this.data;
        if (liking)
            return;
        this.setData({ liking: true });
        try {
            const res = await api_1.api.like(id);
            const gift = (0, p1_view_1.buildLikeGift)(res, (rid) => this.titleOf(rid));
            this.setData({ likeOpen: true, likeGift: gift });
        }
        catch (err) {
            const e = err;
            const msg = e.code === 'GIFT_DAILY_LIMIT'
                ? '今日赠阅已领取，明日再来'
                : e.code === 'NETWORK'
                    ? e.message
                    : (0, api_1.errMsg)(err, '点赞失败，请稍后重试');
            wx.showToast({ title: msg, icon: 'none' });
        }
        finally {
            this.setData({ liking: false });
        }
    },
    onLikeSheetClose() {
        this.setData({ likeOpen: false });
    },
    onLikeGoRead() {
        const rid = this.data.likeGift.id;
        this.setData({ likeOpen: false });
        if (rid)
            wx.navigateTo({ url: `/pages/reader/reader?id=${rid}` });
    },
    onLikeRules() {
        this.setData({ likeOpen: false });
        wx.navigateTo({ url: '/pages/agreement/agreement?anchor=like' });
    },
    // —— P1 组队 ¥998/3 人（FR-P1-10；创建/加入/进度；规则文案引自 agreement 真源）——
    onTeamOpen() {
        this.setData({ teamOpen: true, team: null, teamJoinId: '' });
    },
    onTeamClose() {
        this.setData({ teamOpen: false });
    },
    onTeamRules() {
        this.setData({ teamOpen: false });
        wx.navigateTo({ url: '/pages/agreement/agreement?anchor=team' });
    },
    async onTeamCreate() {
        const { teamCreating, id } = this.data;
        if (teamCreating)
            return;
        this.setData({ teamCreating: true });
        try {
            const t = await api_1.api.teamCreate(id);
            this.setData({ team: (0, p1_view_1.buildTeamView)(t) });
        }
        catch (err) {
            const e = err;
            const msg = e.code === 'TEAM_DUP'
                ? '已在组队中，不可重复入队'
                : e.code === 'NETWORK'
                    ? e.message
                    : (0, api_1.errMsg)(err, '组队发起失败，请稍后重试');
            wx.showToast({ title: msg, icon: 'none' });
        }
        finally {
            this.setData({ teamCreating: false });
        }
    },
    onTeamJoinIdInput(e) {
        this.setData({ teamJoinId: e.detail.value });
    },
    async onTeamJoin() {
        const teamId = (this.data.teamJoinId || '').trim();
        if (!teamId) {
            wx.showToast({ title: '请输入队友的组队编号', icon: 'none' });
            return;
        }
        try {
            const t = await api_1.api.teamJoin(teamId);
            this.setData({ team: (0, p1_view_1.buildTeamView)(t) });
        }
        catch (err) {
            const e = err;
            const msg = e.code === 'TEAM_FULL'
                ? '该组队已满员'
                : e.code === 'TEAM_NOT_FOUND'
                    ? '组队编号不存在或已解散'
                    : e.code === 'NETWORK'
                        ? e.message
                        : (0, api_1.errMsg)(err, '加入失败，请稍后重试');
            wx.showToast({ title: msg, icon: 'none' });
        }
    },
    // —— P1 批评评分退款（FR-P1-02~05：四层闸错误分码提示；受理回执+评分刷新+按分退款）——
    onCritOpen() {
        // 每次打开重置回执态（同一报告每账号限 1 次，重复提交由服务端 DUP 闸兜底）
        this.setData({ critOpen: true, critReceipt: null, critSubmitted: null, critContent: '', critCounter: (0, p1_view_1.critCounter)('') });
    },
    onCritClose() {
        this.setData({ critOpen: false });
    },
    onCritRules() {
        this.setData({ critOpen: false });
        wx.navigateTo({ url: '/pages/agreement/agreement?anchor=pay' });
    },
    onCritInput(e) {
        this.setData({ critContent: e.detail.value, critCounter: (0, p1_view_1.critCounter)(e.detail.value) });
    },
    critErrMsg(e) {
        const map = {
            NOT_PURCHASED: '须先解锁或获赠本报告，才能发起批评',
            NO_READ_RECORD: '请先真实阅读本报告，再发起批评',
            CRITICISM_DUP: '每份报告每个账号限发起 1 次批评',
            REFUND_MONTHLY_LIMIT: '本月成功退款已达 2 次上限',
            ANCHOR_ZERO: '批评须引用具体章节或数据点，模板化话术无法通过',
        };
        if (map[e.code || ''])
            return map[e.code];
        if (e.code === 'NETWORK')
            return e.message;
        return (0, api_1.errMsg)(e, '提交失败，请稍后重试');
    },
    async onCritSubmit() {
        const { critSubmitting, critCounter, critContent, id } = this.data;
        if (critSubmitting || !critCounter.ok)
            return;
        this.setData({ critSubmitting: true });
        try {
            const res = await api_1.api.criticize(id, critContent);
            // 409 SIMILARITY_HIGH 在 api 层抛错；此处为 200 pre_gate_passed / manual 回执
            this.setData({ critSubmitted: { criticism_id: res.criticism_id, stage: res.stage }, critReceipt: (0, p1_view_1.buildCritReceipt)(res) });
        }
        catch (err) {
            const e = err;
            if (e.code === 'SIMILARITY_HIGH') {
                // 转人工不自动拒：以回执形态告知（AGREEMENT 2.6）
                this.setData({ critSubmitted: { criticism_id: '', stage: 'manual_pending' }, critReceipt: (0, p1_view_1.buildCritReceipt)({ criticism_id: '', stage: 'manual_pending' }) });
                return;
            }
            wx.showToast({ title: this.critErrMsg(e), icon: 'none', duration: 2500 });
        }
        finally {
            this.setData({ critSubmitting: false });
        }
    },
    async onCritRefresh() {
        const submitted = this.data.critSubmitted;
        if (!submitted || !submitted.criticism_id)
            return;
        try {
            const res = await api_1.api.criticism(submitted.criticism_id);
            this.setData({ critReceipt: (0, p1_view_1.buildCritReceipt)(submitted, res) });
        }
        catch (err) {
            wx.showToast({ title: (0, api_1.errMsg)(err, '评分仍在进行中，请稍后再刷新'), icon: 'none' });
        }
    },
    async onCritApplyRefund() {
        const submitted = this.data.critSubmitted;
        if (!submitted || !submitted.criticism_id)
            return;
        try {
            await api_1.api.refundApply(submitted.criticism_id);
            wx.showToast({ title: '退款申请已发起', icon: 'none' });
            await this.onCritRefresh();
        }
        catch (err) {
            const e = err;
            const msg = e.code === 'REFUND_DUP'
                ? '该批评已发起过退款'
                : e.code === 'FUSE_OPEN'
                    ? '退款申请复核中，请稍后再试'
                    : e.code === 'NETWORK'
                        ? e.message
                        : (0, api_1.errMsg)(err, '退款申请失败，请稍后重试');
            wx.showToast({ title: msg, icon: 'none', duration: 2500 });
        }
    },
};
