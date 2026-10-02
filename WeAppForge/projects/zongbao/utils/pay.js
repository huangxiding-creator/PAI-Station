"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.payDegradeMessage = payDegradeMessage;
exports.unlockReport = unlockReport;
// utils/pay.ts — 虚拟支付封装（数字内容唯一合规通道；未开通时优雅降级）
// 三层灰置矩阵：本地开关 virtualPay / 服务端 503 PAY_NOT_CONFIGURED / login 回包 pay_configured（API_DESIGN §五）。
// 支付链前端只透传不组装：sign_data/pay_sig/signature 三值由 /pay/sign 供给、逐字节透传（签名与该字符串绑定）。
const index_1 = require("../config/index");
const store_1 = require("./store");
const api_1 = require("./api");
const DEGRADE_MSG = '支付通道开通中，敬请期待。试读章节持续免费开放。';
function payDegradeMessage() {
    return DEGRADE_MSG;
}
function payError(err, fallback) {
    const e = err;
    if (e && (e.code === 'PAY_NOT_CONFIGURED' || e.statusCode === 503)) {
        return { ok: false, message: DEGRADE_MSG };
    }
    if (e && e.code === 'ALREADY_ENTITLED') {
        return { ok: true, message: '已解锁该研报' };
    }
    return { ok: false, message: (e && e.message) || fallback };
}
/** 支付成功后轮询 /pay/status 确认云端发货（1s 间隔，限次；未确认不视为失败——云端发货为准） */
function pollPayStatus(outTradeNo, left = 5) {
    return api_1.api
        .payStatus(outTradeNo)
        .then((d) => d.entitlement_granted || d.status === 'paid')
        .catch(() => false)
        .then((ok) => {
        if (ok || left <= 1)
            return ok;
        return new Promise((resolve) => {
            setTimeout(() => resolve(pollPayStatus(outTradeNo, left - 1)), 1000);
        });
    });
}
/**
 * 解锁一篇研报：本地开关未开→降级文案；已开→/pay/sign → wx.requestVirtualPayment 原样透传 →
 * 成功先本地解锁（体验先行）→ 轮询 /pay/status 确认发货（云端为准）。
 */
async function unlockReport(reportId, priceFen) {
    if (!index_1.appConfig.features.virtualPay || !wx.requestVirtualPayment) {
        return { ok: false, message: DEGRADE_MSG };
    }
    let sign;
    try {
        sign = await api_1.api.paySign(reportId);
    }
    catch (err) {
        return payError(err, '拉起支付失败，请稍后重试');
    }
    return new Promise((resolve) => {
        wx.requestVirtualPayment({
            mode: sign.mode,
            signData: sign.sign_data, // 服务端签名字符串原样透传（逐字节绑定签名，不重序列化）
            paySig: sign.pay_sig,
            signature: sign.signature,
            success: () => {
                (0, store_1.unlockLocal)(reportId); // 本地先行动作；云端发货为准（engine_conventions §3b）
                pollPayStatus(sign.out_trade_no).then(() => resolve({ ok: true, message: '已解锁全文' }));
            },
            fail: (errRes) => {
                const raw = String((errRes && errRes.errMsg) || '');
                const silentCancel = raw.indexOf('cancel') >= 0 || errRes?.errCode === 1;
                if (!silentCancel)
                    console.error('[pay] 虚拟支付失败', errRes);
                resolve({
                    ok: false,
                    message: silentCancel ? '已取消支付' : '支付未完成，请稍后重试',
                });
            },
        });
    });
}
