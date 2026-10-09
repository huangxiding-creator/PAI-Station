// utils/pay.js — 虚拟支付封装（v0.8.0 导出 ¥0.1/条；v0.9.0 报告商城 ¥498-1999/份）
// 链路：服务端出双签名 → wx.requestVirtualPayment 原样透传（sign_data 为签名字符串，逐字节绑定，不重序列化）
// → 成功后回调服务端标记（订单+微信查单核验）→ 引擎侧闸门放行。
// 合规铁律：iOS 不展示任何付费入口（虚拟支付 Android-only；已解锁内容 iOS 可阅读）；
// 503 未开通走降级文案；409=服务端判定已解锁（含已付补标记），直接收口不再拉起支付。
const api = require('./api');

// 平台探测（缓存一次；getDeviceInfo 优先，老库回退 getSystemInfoSync）
let _platform = '';
try {
  _platform = (wx.getDeviceInfo ? wx.getDeviceInfo().platform : wx.getSystemInfoSync().platform) || '';
} catch (e) {
  _platform = '';
}

const DEGRADE_MSG = '支付服务开通中，敬请期待；已解锁内容不受影响。';

// 虚拟支付是否可用：Android/开发工具 且 基础库支持（iOS 隐藏付费入口——虚拟支付铁律）
function paySupported() {
  return _platform !== 'ios' && typeof wx.requestVirtualPayment === 'function';
}

function platform() {
  return _platform;
}

// 统一错误 → 用户文案
function payError(err, fallback) {
  if (err && err.statusCode === 503) return { ok: false, message: DEGRADE_MSG };
  if (err && err.statusCode === 401) return { ok: false, message: '登录态已刷新，请再试一次' };
  return { ok: false, message: (err && err.message) || fallback || '支付未完成，请稍后重试' };
}

// 拉起支付面板（透传签名三件套）；成功后回调 confirm(服务端订单核验标记)
function _requestPay(sign, confirmPath, label) {
  return new Promise((resolve) => {
    wx.requestVirtualPayment({
      mode: sign.mode,
      signData: sign.sign_data, // 服务端签名字符串原样透传（逐字节绑定签名）
      paySig: sign.pay_sig,
      signature: sign.signature,
      success: () => {
        // 支付成功 → 服务端查单核验+标记（幂等）。核验腿若网络抖断不谎报完成：
        // 微信侧已扣款，服务端重试时查单补标记（409 收口），绝不二次支付。
        // （0.9.2 修复：api 模块只导出 requestRaw，此处原误调 api.request → 支付成功后同步抛 TypeError，
        //   回执永不送达+页面 loading 卡死——1009 全量审计 CRITICAL。）
        api.requestRaw(confirmPath.method, confirmPath.path, { out_trade_no: sign.out_trade_no })
          .then((d) => resolve({ ok: true, message: '已解锁' + (label || '导出'), confirm: d }))
          .catch(() => resolve({
            ok: true, reconciling: true,
            message: '已支付，正在对账；请稍后重新进入完成解锁'
          }));
      },
      fail: (errRes) => {
        const raw = String((errRes && errRes.errMsg) || '');
        const silentCancel = raw.indexOf('cancel') >= 0 || !!(errRes && errRes.errCode === 1);
        resolve({
          ok: false,
          message: silentCancel ? '已取消支付' : '支付未完成，请稍后重试'
        });
      }
    });
  });
}

// 签名腿 409 = 服务端判定已解锁（此前已付/支付已到账自动补标记）——直接收口。
// fallback 按流别给文案（0.9.2 修复：报告流共用「导出已解锁」兜底属品类文案错置）。
function _catchSign(err, fallback) {
  if (err && err.statusCode === 409) {
    return { ok: true, already: true, message: err.message || fallback || '导出已解锁' };
  }
  return payError(err);
}

// 单条导出解锁（¥0.1/条）
function payExport(answerId) {
  return api.exportSign(answerId)
    .then((sign) => _requestPay(sign, {
      method: 'POST', path: '/api/answer/' + answerId + '/export_paid'
    }))
    .catch((err) => _catchSign(err, '本篇导出已解锁'));
}

// 批量导出解锁（N × ¥0.1，一单付清）
function payExportAll() {
  return api.exportAllSign()
    .then((sign) => _requestPay(sign, {
      method: 'POST', path: '/api/answers/export_all_paid'
    }))
    .catch((err) => _catchSign(err, '导出已全部解锁'));
}

// 报告解锁（¥498-1999/份，一次解锁永久阅读；v0.9.0 用户令 1008）
function payReport(sku) {
  return api.reportSign(sku)
    .then((sign) => _requestPay(sign, {
      method: 'POST', path: '/api/report/' + sku + '/unlock_paid'
    }, '本报告'))
    .catch((err) => _catchSign(err, '本报告已解锁，可直接阅读'));
}

module.exports = {
  paySupported,
  platform,
  payExport,
  payExportAll,
  payReport,
  degradeMessage: () => DEGRADE_MSG
};
