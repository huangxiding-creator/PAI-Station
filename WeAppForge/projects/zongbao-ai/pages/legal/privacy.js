// 用户协议 · 隐私政策（静态页）— v0.7.4 提审合规
// 内容口径与《用户隐私保护指引》申报项对齐：微信 openid / 剪切板（写入）/ 用户发布内容
const theme = require('../../utils/theme');

Page({
  data: {
    nav: { statusBarHeight: 20, navHeight: 44 },
  },

  onLoad() {
    const app = getApp();
    if (app.globalData && app.globalData.nav) {
      this.setData({ nav: app.globalData.nav });
    }
    theme.apply(this); // v0.7.4 首帧即上主题变量（onShow 仍会再刷，不闪白）
  },

  onShow() {
    theme.apply(this);
  },

  goBack() {
    const pages = getCurrentPages();
    if (pages.length > 1) {
      wx.navigateBack();
    } else {
      wx.switchTab({ url: '/pages/my/my' });
    }
  }
});
