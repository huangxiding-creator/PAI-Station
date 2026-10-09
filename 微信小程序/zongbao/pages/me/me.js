"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// pages/me/me.ts — 我的：已购列表（entitlements）/收藏列表（favorites）——服务端态为真源，离线走本地镜像兜底；
// P1 扩区块：书券余额（攒 498 换 1 份）/赠品架（获赠直接读）/退款记录/情报官卡（v1.2：L1 观察员/L2 分析师/L3 情报官 有效带新梯队）（FR-P1-01/09/11/12）
const api_1 = require("../../utils/api");
const store_1 = require("../../utils/store");
const format_1 = require("../../utils/format");
const p1_view_1 = require("../../utils/p1-view");
const config_1 = require("../../config");
const REFUND_METHOD_TEXT = { auto: '原路自动退', manual: '人工审核', voucher: '书券补偿' };
const REFUND_STATUS_TEXT = { initiated: '已发起', settled: '已到账', failed: '退款失败' };
const INVITEE_STATUS_TEXT = { scanned: '已扫码', registered: '已注册', unlocked: '已解锁', paid: '已付费' };
Page({
    data: {
        tab: 'owned',
        p1: config_1.appConfig.features.p1, // P1 玩法包总开关（灰度/体验版可关，全区块联动）
        giftTabEnabled: config_1.appConfig.features.p1, // P1 赠品架（FR-P1-01 点赞赠报告）
        owned: [],
        favs: [],
        gifts: [],
        offline: false,
        loading: true,
        // P1 书券卡（1 券=1 元；攒满 498 券兑任一份；账本逐笔可查）
        voucher: null,
        // P1 情报官卡（v1.2：有效带新判据+三档梯队；L1 达成点亮馆友+50 书券）
        invite: null,
        invitees: [],
        // P1 退款记录（P0-12 /me 扩展字段，向后兼容）
        refunds: [],
        refundCountText: '',
        // 书券兑换 sheet（余额 ≥49800 时可兑任一份在架报告）
        redeemOpen: false,
        redeemSelId: '',
        redeemSubmitting: false,
        redeemList: [],
        // —— P2：已购检索入口（随 p1 闸）+ 订阅入口（须引擎 configured 探测通过才露出）——
        subscribeOn: false,
    },
    onShow() {
        this.load();
    },
    titleOf(id) {
        const hit = (0, store_1.loadCatalog)().reports.find((r) => r.id === id);
        return hit ? hit.title : `研报 ${id}`;
    },
    async load() {
        this.setData({ loading: true });
        // P2 订阅位探测：configured 才露出「我的订阅」入口（501/探测失败=隐藏不报错，契约口径）
        if (config_1.appConfig.features.p1) {
            (0, api_1.subscriptionsGet)()
                .then((r) => {
                if (r && r.configured === true)
                    this.setData({ subscribeOn: true });
            })
                .catch(() => {
                // 未配置/探测失败：入口保持隐藏（不报错）
            });
        }
        try {
            // 三源并行、各自降级：主档（/me）失败才走离线兜底；书券/邀请失败仅置空区块不拖垮页面
            const [meR, vcR, invR] = await Promise.all([api_1.api.me().catch(() => null), api_1.api.meVouchers().catch(() => null), api_1.api.inviteRelations().catch(() => null)]);
            if (!meR)
                throw new Error('me offline');
            const all = (meR.entitlements || []).map((e) => ({
                id: e.report_id,
                title: this.titleOf(e.report_id),
                source: e.source,
            }));
            const favs = (meR.favorites || []).map((f) => ({
                id: f.report_id,
                title: this.titleOf(f.report_id),
                source: 'favorite',
            }));
            const refunds = (meR.refunds || []).map((r) => ({
                refundId: r.refund_id,
                title: this.titleOf(r.report_id),
                amountYuan: (0, format_1.fenToYuan)(Number(r.amount_fen) || 0),
                methodText: REFUND_METHOD_TEXT[r.method] || r.method,
                statusText: REFUND_STATUS_TEXT[r.status] || r.status,
                createdAt: String(r.created_at || '').slice(0, 10),
            }));
            this.setData({
                owned: all,
                favs,
                gifts: all.filter((x) => x.source === 'gift' || x.source === 'voucher'),
                voucher: vcR ? (0, p1_view_1.buildVoucherCard)(vcR) : null,
                invite: invR ? (0, p1_view_1.buildInviteCard)(invR) : null,
                invitees: (invR && invR.invited ? invR.invited : []).map((v) => ({
                    uid: v.invitee_uid,
                    statusText: INVITEE_STATUS_TEXT[v.status] || v.status,
                    ts: String(v.ts || '').slice(0, 10),
                })),
                refunds,
                refundCountText: `本月成功退款 ${Number(meR.refund_count_month) || 0}/${Number(meR.refund_monthly_limit) || 2} 次`,
                offline: false,
                loading: false,
            });
        }
        catch {
            // 引擎不可达/未登录：本地镜像兜底（服务端态恢复后以服务端为准）；P1 区块置空展示空态
            const ownedIds = (0, store_1.getEntitlements)();
            const favIds = (0, store_1.getFavoritesLocal)();
            this.setData({
                owned: ownedIds.map((id) => ({ id, title: this.titleOf(id), source: 'local' })),
                favs: favIds.map((id) => ({ id, title: this.titleOf(id), source: 'local' })),
                gifts: [],
                voucher: null,
                invite: null,
                invitees: [],
                refunds: [],
                refundCountText: '',
                offline: true,
                loading: false,
            });
        }
    },
    onTabTap(e) {
        this.setData({ tab: e.currentTarget.dataset.tab });
    },
    onOpenReport(e) {
        const id = e.currentTarget.dataset.id;
        wx.navigateTo({ url: `/pages/reader/reader?id=${id}` });
    },
    // —— P1 书券：兑换 sheet（余额≥498 时点「兑换」列在架报告）与规则入口 ——
    onRedeemOpen() {
        if (!this.data.voucher || !this.data.voucher.canRedeem)
            return;
        this.setData({
            redeemOpen: true,
            redeemSelId: '',
            redeemList: (0, store_1.loadCatalog)().reports.map((r) => ({ id: r.id, title: r.title, priceYuan: (0, format_1.fenToYuan)(r.price) })),
        });
    },
    onRedeemClose() {
        this.setData({ redeemOpen: false });
    },
    onRedeemPick(e) {
        this.setData({ redeemSelId: e.currentTarget.dataset.id || '' });
    },
    async onRedeemConfirm() {
        const { redeemSelId, redeemSubmitting } = this.data;
        if (redeemSubmitting)
            return;
        if (!redeemSelId) {
            wx.showToast({ title: '请先选择要兑换的研报', icon: 'none' });
            return;
        }
        this.setData({ redeemSubmitting: true });
        try {
            await api_1.api.voucherRedeem(redeemSelId);
            this.setData({ redeemOpen: false });
            wx.showToast({ title: '兑换成功，已加入已购', icon: 'none' });
            this.load();
        }
        catch (err) {
            wx.showToast({ title: (0, api_1.errMsg)(err, '兑换失败，请稍后重试'), icon: 'none' });
        }
        finally {
            this.setData({ redeemSubmitting: false });
        }
    },
    onVoucherRules() {
        wx.navigateTo({ url: '/pages/agreement/agreement' });
    },
    onInviteRules() {
        // 情报官体系规则 → 协议页 §六「情报官体系与有效带新规则」块（v1.2）
        wx.navigateTo({ url: '/pages/agreement/agreement?anchor=invite' });
    },
    // —— P2 入口：已购检索（随 p1 闸）/ 我的订阅（configured 探测通过才露出）——
    onOpenOwnedSearch() {
        wx.navigateTo({ url: '/pages/search/owned' });
    },
    // —— 3c 榜单入口（公开内容页：周榜+一周故事）——
    onOpenRank() {
        wx.navigateTo({ url: '/pages/rank/rank' });
    },
    onOpenSubscribe() {
        wx.navigateTo({ url: '/pages/subscribe/index' });
    },
    // —— 关于区：用户协议与规则入口（T-P0-26，文案真源 utils/agreement.ts）——
    onOpenAgreement() {
        wx.navigateTo({ url: '/pages/agreement/agreement' });
    },
    noop() {
        // 兑换弹层遮罩点击不关闭（须主动确认/关闭）
    },
});
