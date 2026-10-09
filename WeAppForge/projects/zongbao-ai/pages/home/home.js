// 兼容入口页 — v0.5.1 根治「页面不存在」（教训级）
// 机制：本 appid 线上老版(1.0.7)页面表只有 home/home 与 my/my，一切无路径入口
// （后台自带体验版码/最近使用/会话卡片默认页）都按老表解析到 home/home——
// 新版包没有此页即「页面不存在」。本页存在即兼容所有入口，落地即跳咨询首页。
const theme = require('../../utils/theme');

Page({
  onLoad(options) {
    // v0.7.4 卫生项：nav 对齐其余页（跳板闪屏期顶部不错位）
    const g = (getApp().globalData || {});
    this.setData({ nav: g.nav || { statusBarHeight: 20, navHeight: 44 } });
    // v0.7.4 海报深链：海报码若以本跳板页为 page，scene "s=p&a={aid}" 直达答案。
    // v0.9.2（1009 审计 MEDIUM 修复）：scene 带畸形百分号序列会让 decodeURIComponent 抛
    // URIError 且 onLoad 在 reLaunch 之前中断——本页 navigationStyle=custom 无按钮，
    // 用户将永久卡「OPENING…」闪屏。解码失败按无 scene 处理走默认分支。
    let sc = '';
    try {
      sc = decodeURIComponent((options && options.scene) || '');
    } catch (e) {
      sc = '';
    }
    const dm = sc.match(/^s=p&a=(.+)$/);
    wx.reLaunch({
      url: dm && dm[1] ? '/pages/answer/answer?id=' + dm[1] : '/pages/ask/ask',
      fail: () => wx.switchTab({ url: '/pages/ask/ask' })
    });
  },

  onShow() { theme.apply(this); },
});
