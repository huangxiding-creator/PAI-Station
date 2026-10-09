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
exports.cardDetail = cardDetail;
exports.cardResolve = cardResolve;
exports.cardsByReport = cardsByReport;
exports.chatReport = chatReport;
exports.searchOwned = searchOwned;
exports.transferReport = transferReport;
exports.subscriptionsGet = subscriptionsGet;
exports.subscriptionsSet = subscriptionsSet;
exports.subscriptionsDelete = subscriptionsDelete;
exports.rankingsGet = rankingsGet;
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
    /** P1-8 邀请关系与进度（me 页情报官卡；v1.2 扩 level/ladder，new_users 语义升级=有效带新数，required=1 即 L1 门槛） */
    inviteRelations() {
        return request('GET', '/invite/relations');
    },
    /** v1.2 情报官·阅读停留上报（有效带新条件②累计停留满 3 分钟；无归因关系恒 200 relation_marked:false；fire-and-forget 静默失败） */
    inviteDwell(reportId, seconds) {
        return request('POST', '/invite/dwell', { report_id: reportId, seconds });
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
// —— 商机卡（情报裂变 2.0 落地页；契约字段名冻结）——
// card_id 为不透明字符串（真实形态 <report_id>-cNNN），前端不做任何格式正则校验
// 契约1 GET /cards/{card_id} 公开（无 Bearer 也可，落地页语义）→ {card, report}
// 契约2 GET /cards/by-report/{rid} 两态：匿名/未购=前 3 张+locked:true+total；Bearer 且已购=全量分页
// 契约3 GET /cards/resolve?scene= → {card_id}；解析失败引擎降级 {card_id:""} 恒 200（同 invite/scan 哲学）
// mock 接线：/cards/* 路由不在 mock-fixtures.ts 路由表（该文件归 P0/P1 所有），
// 此处 mockApi 分支接 mock-fixtures-cards（注册方式同 handleP1 的 deps 注入惯例）；
// 引擎 404 错误信封为 {error:{code,message}} 嵌套形，归一后复用既有 httpError（机制为准适配）。
const mock_fixtures_cards_1 = require("./mock-fixtures-cards");
/** 卡端点统一入口：mock 走 fixtures（{status,body} 同构归一），真身走 request（Bearer/401 重试） */
function cardRequest(method, path) {
    if (index_1.appConfig.mockApi) {
        return (0, mock_fixtures_cards_1.mockCardsRequest)(method, path, undefined, token()).then((r) => {
            if (r.status >= 200 && r.status < 300)
                return r.body;
            const body = (r.body || {});
            const norm = body && typeof body.error === 'object' ? body.error : body;
            throw httpError(r.status, norm);
        });
    }
    return request(method, path);
}
/** 契约1：商机卡详情（公开落地页；404 → code=CARD_NOT_FOUND 错误信封上抛） */
function cardDetail(cardId) {
    return cardRequest('GET', `/cards/${encodeURIComponent(cardId)}`);
}
/** 契约3：卡二维码 scene → card_id（引擎降级恒 200 {card_id:""}，不 reject） */
function cardResolve(scene) {
    return cardRequest('GET', `/cards/resolve?${buildQuery({ scene })}`);
}
/** 契约2：按报告取卡列表（opts.page/page_size 默认 1/20）；
 * 匿名/未购由引擎回 locked 形状；请求失败按 locked 空形状兜底，卡列表调用方零崩 */
async function cardsByReport(rid, opts) {
    const page = opts?.page ?? 1;
    const pageSize = opts?.page_size ?? 20;
    try {
        return await cardRequest('GET', `/cards/by-report/${encodeURIComponent(rid)}?${buildQuery({ page, page_size: pageSize })}`);
    }
    catch {
        return { cards: [], total: 0, page, locked: true };
    }
}
/** P2 契约1：AI 伴读提问（Bearer+已购闸；1-200 字；provider 由引擎答，前端不做任何模型选择） */
function chatReport(rid, question) {
    return request('POST', `/reports/${encodeURIComponent(rid)}/chat`, { question });
}
/** P2 契约2：已购库章级检索（Bearer；游标分页，next_cursor 空串止） */
function searchOwned(q, cursor) {
    return request('GET', `/search/owned?${buildQuery({ q, cursor })}`);
}
/** P2 契约3：转赠（Bearer；仅本人付费购买源；错误族 8 码见 p2-view.transferErrMsg 映射） */
function transferReport(rid, toUid) {
    return request('POST', `/reports/${encodeURIComponent(rid)}/transfer`, { to_uid: toUid });
}
/** P2 契约4：订阅探测/读取（未配置引擎 501 SUBSCRIBE_NOT_CONFIGURED → 调用方整块隐藏不报错） */
function subscriptionsGet() {
    return request('GET', '/subscriptions');
}
/** P2 契约4：订阅保存（POST 全量选中集合；引擎幂等合并） */
function subscriptionsSet(provinces, topics) {
    return request('POST', '/subscriptions', { provinces, topics });
}
/** P2 契约4：取消单项订阅 */
function subscriptionsDelete(kind, value) {
    return request('DELETE', '/subscriptions', { kind, value });
}
// ── 榜单/一周故事（3c；公开无鉴权，mock 走 fixtures-rank）──────────────
const mock_fixtures_rank_1 = require("./mock-fixtures-rank");
/** 三榜+故事（公开；引擎 ISO 周快照冻结。失败上抛由页面落空态+重试，不静默造数） */
function rankingsGet() {
    if (index_1.appConfig.mockApi) {
        return (0, mock_fixtures_rank_1.mockRankRequest)('GET', '/rankings').then((r) => {
            if (r.status >= 200 && r.status < 300)
                return r.body;
            const body = (r.body || {});
            const norm = body && typeof body.error === 'object' ? body.error : body;
            throw httpError(r.status, norm);
        });
    }
    return request('GET', '/rankings');
}
