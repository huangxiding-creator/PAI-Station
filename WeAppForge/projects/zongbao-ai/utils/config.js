// 后端地址：已上云（阿里云 ECS 47.120.43.20:8869，手机任意网络可直连，无需开调试模式）
// 生产域名化=HTTPS 域名（部署后替换，且须加入小程序后台 request 合法域名）
// 自动化测试可用 global.__QW_BASE__ 指到带闸测试实例，不扰生产
var OVR = '';
try { OVR = global.__QW_BASE__ || ''; } catch (e) { OVR = ''; }
module.exports = {
  BASE_URL: OVR || 'http://47.120.43.20:8869'
};
