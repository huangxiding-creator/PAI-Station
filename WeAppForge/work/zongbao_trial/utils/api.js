"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.api = void 0;
exports.token = token;
exports.errMsg = errMsg;
exports.onPayGray = onPayGray;
exports.isPayGrayed = isPayGrayed;
exports.request = request;
exports.silentLogin = silentLogin;
exports.buildQuery = buildQuery;
exports.resetPayGrayForTest = resetPayGrayForTest;
// utils/api.ts — 统一请求封装：Bearer 注入 / 401 静默重登重试一次 / 503 PAY_NOT_CONFIGURED 灰置事件 /
// 网络失败「服务维护」降级（NFR-10/11，API_DESIGN §五降级矩阵）。
// mockApi 模式与真实请求同一函数签名（config.mockApi 翻 flag 即联调）。
const index_1 = require("../config/index");
const mock_fixtures_1 = require("./mock-fixtures");
const TOKEN_KEY = 'zongbao_token';
const UID_KEY = 'zongbao_uid';
function token() {
    try {
        return wx.getStorageSync(TOKEN_KEY) || '';
    }
    catch {
        return '';
    }
}
function setToken(t, uid) {
    try {
        if (t)
            wx.setStorageSync(TOKEN_KEY, t);
        else
            wx.removeStorageSync(TOKEN_KEY);
        if (uid)
            wx.setStorageSync(UID_KEY, uid);
    }
    catch (e) {
        console.error('[api] token 落盘失败', e);
    }
}
function errMsg(err, fallback = '请求失败，请稍后重试') {
    const e = err;
    return (e && e.message) || fallback;
}
const payGrayListeners = [];
let payGrayed = false;
function onPayGray(cb) {
    payGrayListeners.push(cb);
    return () => {
        const i = payGrayListeners.indexOf(cb);
        if (i >= 0)
            payGrayListeners.splice(i, 1);
    };
}
function isPayGrayed() {
    return payGrayed;
}
function emitPayGray(code, message, source) {
    payGrayed = true;
    payGrayListeners.forEach((cb) => {
        try {
            cb({ code, message, source });
        }
        catch (e) {
            console.error('[api] 灰置监听器异常', e);
        }
    });
}
const NETWORK_MSG = '服务维护中，试读内容仍可离线阅读';
function httpError(statusCode, body) {
    const b = (body || {});
    const e = new Error(b.message || b.detail || `HTTP ${statusCode}`);
    e.statusCode = statusCode;
    e.code = b.code;
    if (b.code === 'PAY_NOT_CONFIGURED') {
        // 503 降级契约：前端灰置支付入口，试读/收藏/搜索不受影响（NFR-10）
        emitPayGray(b.code, b.message || '虚拟支付尚未开通', 'server_503');
    }
    return e;
}
function rawWxRequest(method, path, data) {
    return new Promise((resolve, reject) => {
        wx.request({
            url: (0, index_1.apiBaseUrl)() + path,
            method: method,
            data: data,
            timeout: 10000,
            header: {
                'Content-Type': 'application/json',
                Authorization: token() ? `Bearer ${token()}` : '',
            },
            success(res) {
                if (res.statusCode >= 200 && res.statusCode < 300)
                    resolve(res.data);
                else
                    reject(httpError(res.statusCode, res.data));
            },
            fail(errRes) {
                const raw = String((errRes && errRes.errMsg) || '');
                const e = new Error(NETWORK_MSG);
                e.network = true;
                e.code = 'NETWORK';
                if (raw.indexOf('url not in domain list') >= 0) {
                    e.message = '未开调试模式：点右上角"…"→开发调试→打开调试，重启小程序后重试';
                }
                reject(e);
            },
        });
    });
}
/** 单一请求入口：mock/真实同一签名；401 静默重登换发后重试一次（qianwen 惯例） */
function request(method, path, data, opts) {
    const attempt = (retryable) => {
        const transport = () => {
            if (index_1.appConfig.mockApi) {
                // mock 应答 {status, body} 与 wx.request 成功分支同构归一（2xx 解包/非 2xx 走 httpError）
                return (0, mock_fixtures_1.mockRequest)(method, path, data, token()).then((r) => {
                    if (r.status >= 200 && r.status < 300)
                        return r.body;
                    throw httpError(r.status, r.body);
                });
            }
            return rawWxRequest(method, path, data);
        };
        return transport().catch((err) => {
            const e = err;
            if (e && e.statusCode === 401 && retryable && !opts?.anon) {
                return silentLogin().then(() => attempt(false));
            }
            throw err;
        });
    };
    return attempt(true);
}
let loginInflight = null;
/** 静默登录：wx.login → POST /auth/login 换发 token（登录端点自身不再触发 401 重试） */
function silentLogin() {
    if (loginInflight)
        return loginInflight;
    loginInflight = new Promise((resolve, reject) => {
        wx.login({
            success(r) {
                if (!r.code) {
                    reject(new Error('微信登录失败，请重试'));
                    return;
                }
                const transport = () => index_1.appConfig.mockApi
                    ? (0, mock_fixtures_1.mockRequest)('POST', '/auth/login', { code: r.code }, '').then((r) => {
                        if (r.status >= 200 && r.status < 300)
                            return r.body;
                        throw httpError(r.status, r.body);
                    })
                    : rawWxRequest('POST', '/auth/login', { code: r.code });
                transport()
                    .then((d) => {
                    const resp = d;
                    setToken(resp.token, resp.uid);
                    if (resp.pay_configured === false) {
                        // login 回包预判灰置（API_DESIGN §五）
                        emitPayGray('PAY_NOT_CONFIGURED', '虚拟支付尚未开通', 'login_hint');
                    }
                    resolve();
                })
                    .catch(reject);
            },
            fail() {
                reject(new Error('微信登录调用失败，请重试'));
            },
        });
    });
    const clear = () => {
        loginInflight = null;
    };
    loginInflight.then(clear, clear);
    return loginInflight;
}
function buildQuery(q) {
    return Object.keys(q)
        .filter((k) => q[k] !== undefined && q[k] !== '')
        .map((k) => `${k}=${encodeURIComponent(String(q[k]))}`)
        .join('&');
}
exports.api = {
    catalog(q) {
        return request('GET', `/catalog?${buildQuery({ ...q })}`);
    },
    search(kw) {
        return request('GET', `/search?${buildQuery({ q: kw })}`);
    },
    report(id) {
        return request('GET', `/reports/${id}`);
    },
    chapters(id, withContent = 'trial') {
        return request('GET', `/reports/${id}/chapters?with_content=${withContent}`);
    },
    fetchChapter(id, chapterId) {
        return request('POST', `/reports/${id}/chapters/${chapterId}`, {});
    },
    favorite(id, on) {
        return request(on ? 'POST' : 'DELETE', `/reports/${id}/favorite`, {});
    },
    paySign(reportId) {
        return request('POST', '/pay/sign', { report_id: reportId });
    },
    payStatus(outTradeNo) {
        return request('GET', `/pay/status?${buildQuery({ out_trade_no: outTradeNo })}`);
    },
    me() {
        return request('GET', '/me');
    },
    // —— P1 端点封装（API_DESIGN P1-1/2/3/4/8/9/10）——
    /** P1-1 点赞→赠报告（与分享完全解耦；当日第二次 429 GIFT_DAILY_LIMIT） */
    like(reportId) {
        return request('POST', `/reports/${reportId}/like`, {});
    },
    /** P1-2 批评提交（四层闸同步预筛；409 SIMILARITY_HIGH 带 stage=manual_pending 转人工不自动拒） */
    criticize(reportId, content, orderId) {
        return request('POST', `/reports/${reportId}/criticize`, orderId ? { content, order_id: orderId } : { content });
    },
    /** P1-3 批评结果查询（仅作者；评分异步落 llm_scores/final_score/refund） */
    criticism(id) {
        return request('GET', `/criticisms/${id}`);
    },
    /** P1-4 退款申请（评分路径；423 FUSE_OPEN=熔断停新发起） */
    refundApply(criticismId) {
        return request('POST', '/refund/apply', { criticism_id: criticismId });
    },
    /** P1-8 邀请关系与进度（me 页邀请战绩卡） */
    inviteRelations() {
        return request('GET', '/invite/relations');
    },
    /** P1-9 创建组队（¥998/3 人；重复入队 409） */
    teamCreate(reportId) {
        return request('POST', '/team', { report_id: reportId });
    },
    /** P1-9 加入组队（TEAM_FULL/TEAM_DUP→409） */
    teamJoin(teamId) {
        return request('POST', `/team/${teamId}/join`, {});
    },
    /** P1-10 书券账本（发放/消耗/余额三条一致；书券非卖品无提现出口） */
    meVouchers() {
        return request('GET', '/me/vouchers');
    },
    /** P1-10 书券兑换报告（49800 分兑一份；余额不足 400 BALANCE_INSUFFICIENT） */
    voucherRedeem(reportId) {
        return request('POST', '/vouchers/redeem', { report_id: reportId });
    },
};
function resetPayGrayForTest() {
    payGrayed = false;
}
