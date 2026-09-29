// 总包AI顾问 — 工程人的10秒专业问答
App({
  onLaunch() {
    // 登录态静默续期：有 token 就拉一次配额
    const token = wx.getStorageSync('qw_token');
    if (token) {
      this.globalData.token = token;
    }
    // 自绘导航度量（v0.3.0 蓝图设计：全页 navigationStyle=custom）
    // statusBarHeight + 胶囊实测 → 导航行高，WXML 用 px 内联绑定
    let statusBarHeight = 20;
    let navHeight = 44;
    try {
      const sys = wx.getSystemInfoSync();
      statusBarHeight = sys.statusBarHeight || 20;
      const cap = wx.getMenuButtonBoundingClientRect();
      if (cap && cap.height) {
        navHeight = cap.height + (cap.top - statusBarHeight) * 2;
      }
    } catch (e) { /* 老客户端兜底默认值 */ }
    this.globalData.nav = { statusBarHeight, navHeight };
  },
  globalData: {
    token: '',
    nav: { statusBarHeight: 20, navHeight: 44 }
  }
});
