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
      timeout: 300000, // KB 回答约 15-60s，上限 5 分钟
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
  paySign: (id) => request('POST', '/api/answer/' + id + '/pay_sign', {}),
  unlockPaid: (id, outTradeNo) => request('POST', '/api/answer/' + id + '/unlock_paid', { out_trade_no: outTradeNo || '' }),
  exportAnswer: (id, fmt) => request('POST', '/api/answer/' + id + '/export', { fmt }),
  history: () => request('GET', '/api/history'),
  // ── v0.5.0（用户九点令）──
  optimize: (question) => request('POST', '/api/question/optimize', { question }),          // AI优化提问
  shareReward: (id) => request('POST', '/api/answer/' + id + '/share', {}),                 // 分享赠次
  exportAll: (fmt) => request('POST', '/api/answers/export_all', { fmt }),                  // 批量导出全部咨询
  potList: () => request('GET', '/api/pot/list')                                            // 锅圈热点列表
};
