// 后端地址：腾讯云全托管链（HTTPS ai.epcschool.top → CloudBase 网关 → qianwen-engine；2026-10-02 切轨）
// 域名须在小程序后台 request 合法域名；回退裸IP仅限内部调试（正式版会被微信拦截）
// 自动化测试可用 global.__QW_BASE__ 指到带闸测试实例，不扰生产
var OVR = '';
try { OVR = global.__QW_BASE__ || ''; } catch (e) { OVR = ''; }
module.exports = {
  BASE_URL: OVR || 'https://ai.epcschool.top'
};
