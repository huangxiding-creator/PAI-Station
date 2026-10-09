// telemetry.js — v0.9.6 真机执行轨迹打点（1009 真机根因战的地面真值腿）
// 背景：devtools 全绿 + 真机失灵的双重盲区（wx.showModal 真机静默 fail / e2e 全程 mock），
// 需要一条不依赖任何弹窗与控制台的「事件是否真的发生了」上行通道。
// 设计铁律：fire-and-forget，绝不抛错、绝不弹窗、绝不阻塞主流程、失败零提示。
// 隐私：不上报任何问题内容/回答内容/openid——只有事件名、匿名 boot id、少量状态数字。
var BASE_URL = '';
try { BASE_URL = require('./config').BASE_URL || ''; } catch (e) { BASE_URL = ''; }

var VER = '0.9.6';

// 匿名 boot id：一次安装生命周期一个（storage 持久，清缓存才换），
// 形如 b3x9k2m1（b + 时间36进制 + 随机），不含任何可识别个人的信息
function bootId() {
  try {
    var b = wx.getStorageSync('qw_boot');
    if (b) return b;
    var rand = Math.floor(Math.random() * 1296).toString(36); // 0-1295 → 最多2字符
    b = 'b' + Date.now().toString(36) + rand;
    wx.setStorageSync('qw_boot', b);
    return b;
  } catch (e) {
    return 'bunknown';
  }
}

// ping(event, extra)：POST /api/telemetry，fire-and-forget。
// extra 只放数字/布尔/短字符串（服务端截断），调用处无需 try/catch——本函数自吞一切。
function ping(event, extra) {
  try {
    wx.request({
      url: BASE_URL + '/api/telemetry',
      method: 'POST',
      timeout: 8000,
      data: {
        event: String(event || '').slice(0, 40),
        boot: bootId(),
        ver: VER,
        extra: extra || null
      },
      success: function () { /* 只上行不关心回包 */ },
      fail: function () { /* 网络败=丢点，不打扰任何人 */ }
    });
  } catch (e) {
    /* wx.request 本身异常（极端环境）也绝不外抛 */
  }
}

// 启动打点：platform/sdk/系统版本——区分 iOS/Android/DevTools 的第一手数据
function boot() {
  var info = {};
  try {
    var win = wx.getWindowInfo ? wx.getWindowInfo() : {};
    info.pixelRatio = win.pixelRatio;
  } catch (e) { /* 可选字段 */ }
  try {
    var app = wx.getAppBaseInfo ? wx.getAppBaseInfo() : {};
    info.platform = app.platform;
    info.sdk = (app.SDKVersion || '').slice(0, 12);
    info.enableDebug = !!app.enableDebug;
  } catch (e) { /* 可选字段 */ }
  ping('boot', info);
}

module.exports = { ping: ping, boot: boot, bootId: bootId };
