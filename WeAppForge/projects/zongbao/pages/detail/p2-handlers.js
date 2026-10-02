"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.p2Handlers = void 0;
// pages/detail/p2-handlers.ts — 详情页 P2 转赠处理器（this=页面实例，p1-handlers 同拆分惯例）：
// 确认弹层=三行规则摘要（utils/p2-view 内联真源不改 agreement）+「查看完整规则」跳协议 §四
// anchor=transfer + 对方学园号输入 + 确认按钮；错误族 8 码经 transferErrMsg 逐码 toast；
// 成功后 lockLocal 清本地已购镜像并整页 reload（权益已失，owned/转赠入口联动熄灭）。
const api_1 = require("../../utils/api");
const p2_view_1 = require("../../utils/p2-view");
const store_1 = require("../../utils/store");
exports.p2Handlers = {
    onTransferOpen() {
        this.setData({ transferOpen: true, transferUid: '' });
    },
    onTransferClose() {
        this.setData({ transferOpen: false });
    },
    onTransferRules() {
        this.setData({ transferOpen: false });
        wx.navigateTo({ url: '/pages/agreement/agreement?anchor=transfer' });
    },
    onTransferUidInput(e) {
        this.setData({ transferUid: e.detail.value });
    },
    async onTransferConfirm() {
        const { transferSubmitting, id, transferUid } = this.data;
        if (transferSubmitting)
            return;
        const toUid = transferUid.trim();
        if (!toUid) {
            wx.showToast({ title: '请填写对方的学园号', icon: 'none' });
            return;
        }
        this.setData({ transferSubmitting: true });
        try {
            await (0, api_1.transferReport)(id, toUid);
            (0, store_1.lockLocal)(id); // 服务端已确认转出：清本地已购镜像（云端态为准）
            this.setData({ transferOpen: false });
            wx.showToast({ title: '转赠成功，阅读权益已转移', icon: 'none' });
            await this.load(); // 权益已失：整页态刷新（owned=false，转赠入口联动熄灭）
        }
        catch (err) {
            wx.showToast({ title: (0, p2_view_1.transferErrMsg)(err), icon: 'none', duration: 2500 });
        }
        finally {
            this.setData({ transferSubmitting: false });
        }
    },
};
