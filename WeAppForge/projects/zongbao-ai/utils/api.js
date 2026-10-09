// 后端 API 客户端 — 总包AI顾问
// 特性：401 自动重登重试 / 统一错误文案 / 配额随登录落缓存
const BASE_URL = require('./config').BASE_URL;

function token() {
  return wx.getStorageSync('qw_token') || '';
}

function setToken(t) {
  if (t) wx.setStorageSync('qw_token', t);
  else wx.removeStorageSync('qw_token');
}

function rawRequest(method, path, data) {
  return new Promise((resolve, reject) => {
    wx.request({
      url: BASE_URL + path,
      method,
      data,
      timeout: 120000, // ask 秒回进答案页轮询；主请求 2 分钟足够（v0.7.6 收紧，防弱网转圈）
      header: {
        'Content-Type': 'application/json',
        Authorization: token() ? 'Bearer ' + token() : ''
      },
      success(res) {
        if (res.statusCode >= 200 && res.statusCode < 300) {
          resolve(res.data);
        } else {
          const detail = (res.data && res.data.detail) || ('HTTP ' + res.statusCode);
          const e = new Error(detail);
          e.statusCode = res.statusCode;
          reject(e);
        }
      },
      fail(err) {
        const raw = (err && err.errMsg) || '';
        let msg = '网络连接失败，请检查网络后重试';
        if (raw.indexOf('url not in domain list') >= 0) {
          msg = '未开调试模式：点右上角"…"→开发调试→打开调试，重启小程序后重试';
        } else if (raw.indexOf('timeout') >= 0) {
          msg = '连接超时，请稍后重试';
        }
        const e = new Error(msg);
        e.raw = raw;
        reject(e);
      }
    });
  });
}

function rawLogin() {
  return new Promise((resolve, reject) => {
    wx.login({
      success(r) {
        if (!r.code) {
          reject(new Error('微信登录失败，请重试'));
          return;
        }
        rawRequest('POST', '/api/login', { code: r.code })
          .then((d) => {
            setToken(d.token);
            if (d.quota) wx.setStorageSync('qw_quota', d.quota);
            resolve(d);
          })
          .catch(reject);
      },
      fail: () => reject(new Error('微信登录调用失败，请重试'))
    });
  });
}

function request(method, path, data) {
  return rawRequest(method, path, data).catch((err) => {
    // 401 = 凭证过期/失效：静默重登一次再重试（用户无感）
    if (err && err.statusCode === 401) {
      setToken('');
      return rawLogin().then(() => rawRequest(method, path, data));
    }
    throw err;
  });
}

function ensureLogin() {
  if (token()) {
    return Promise.resolve({ token: token() });
  }
  return login();
}

function login() {
  return rawLogin();
}

function errMsg(err, fallback) {
  const m = (err && err.message) || fallback || '请求失败';
  return m.length > 40 ? m.slice(0, 40) + '…' : m;
}

module.exports = {
  ensureLogin,
  login,
  tokenSync: () => token(),
  errMsg,
  ask: (question) => request('POST', '/api/ask', { question }),
  answer: (id) => request('GET', '/api/answer/' + id),
  quota: () => request('GET', '/api/quota'),
  like: (id) => request('POST', '/api/answer/' + id + '/like'),
  criticize: (id, text) => request('POST', '/api/answer/' + id + '/criticize', { text }),
  exportAnswer: (id, fmt) => request('POST', '/api/answer/' + id + '/export', { fmt }),
  history: () => request('GET', '/api/history'),
  // ── v0.5.0（用户九点令）──
  optimize: (question) => request('POST', '/api/question/optimize', { question }),          // AI优化提问
  exportAll: (fmt) => request('POST', '/api/answers/export_all', { fmt }),                  // 批量导出全部咨询
  potList: (cat) => request('GET', '/api/pot/list' + (cat ? '?cat=' + encodeURIComponent(cat) : '')),  // 锅圈热点列表（v0.9.10 可按分类过滤）
  stats: () => request('GET', '/api/stats'),                                               // 注册用户/咨询总数（v0.9.10 首页信任面，未登录可看）
  potReport: (id, reason) => request('POST', '/api/pot/report', { aid: id, reason }),      // 锅圈内容举报（UGC 合规）
  // ── v0.6.0（100× 弧线：全免费，智谱接地）──
  followup: (id, question) => request('POST', '/api/answer/' + id + '/followup', { question }), // 免费追问
  followups: (id) => request('GET', '/api/answer/' + id + '/followups'),                    // 追问对话流
  digest: (id) => request('GET', '/api/answer/' + id + '/digest'),                          // 要点速览+相关问题
  poster: (id) => request('GET', '/api/answer/' + id + '/poster'),                           // 分享海报 b64
  // ── v0.7.0（用户十一点令：公益免费）──
  shareOn: (id) => request('POST', '/api/answer/' + id + '/share_on', {}),                   // 共享入锅圈 +1 次
  shareOff: (id) => request('POST', '/api/answer/' + id + '/share_off', {}),                 // 取消共享 -1 次
  citationFulltext: (id, n) => request('GET', '/api/answer/' + id + '/citations/' + n),      // 依据全文展开
  // ── v0.8.0（用户令 1008：咨询全免费，导出按条收费 ¥0.1，虚拟支付）──
  exportSign: (id) => request('POST', '/api/answer/' + id + '/export_sign'),                 // 单条导出签名
  exportAllSign: () => request('POST', '/api/answers/export_all_sign'),                      // 批量导出签名（buyQuantity=未解锁条数）
  // ── v0.9.0（用户令 1008：研究报告商城整合，按份售卖 ¥498-1999）──
  reportList: () => request('GET', '/api/reports'),                                          // 报告目录（公开浏览+本人解锁态）
  reportDetail: (sku) => request('GET', '/api/report/' + sku),                               // 报告详情（章节/试读/适用人群）
  reportSample: (sku) => request('GET', '/api/report/' + sku + '/sample'),                   // 试读正文
  reportSign: (sku) => request('POST', '/api/report/' + sku + '/unlock_sign'),               // 报告解锁签名
  reportPdfUrl: (sku) => BASE_URL + '/api/report/' + sku + '/pdf',                           // PDF 全文（downloadFile 带 Bearer）
  invoiceStatus: () => request('GET', '/api/invoice/status'),                                // 发票：累计消费+门槛+申请记录
  invoiceApply: (d) => request('POST', '/api/invoice/apply', d),                             // 发票：提交开票申请（≥¥200）
  requestRaw: request                                                                        // pay.js 回调腿用（带 401 重登语义）
};
