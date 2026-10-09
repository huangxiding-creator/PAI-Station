// 总包AI顾问 — 工程人的10秒专业问答
App({
  onLaunch() {
    // 自绘导航度量（v0.3.0 蓝图设计：全页 navigationStyle=custom）
    // statusBarHeight + 胶囊实测 → 导航行高，WXML 用 px 内联绑定
    let statusBarHeight = 20;
    let navHeight = 44;
    try {
      const win = wx.getWindowInfo();
      statusBarHeight = win.statusBarHeight || 20;
    } catch (e) {
      /* getWindowInfo 不可用的老客户端回退旧接口 */
      try {
        const sys = wx.getSystemInfoSync();
        statusBarHeight = sys.statusBarHeight || 20;
      } catch (e2) { /* 再失败用默认值 */ }
    }
    try {
      const cap = wx.getMenuButtonBoundingClientRect();
      if (cap && cap.height) {
        navHeight = cap.height + (cap.top - statusBarHeight) * 2;
      }
    } catch (e) { /* 老客户端兜底默认值 */ }
    this.globalData.nav = { statusBarHeight, navHeight };
  },
  // App 错误兜底三件套（v0.9.2 审计修复）：静默计数不扰民，绝不让异常白屏
  onError() {
    this.globalData.errCount += 1;
  },
  onUnhandledRejection() {
    /* 吞掉未处理 Promise 拒绝：防控制台噪声与白屏恐慌 */
  },
  onPageNotFound() {
    wx.reLaunch({
      url: '/pages/ask/ask',
      fail() {
        wx.switchTab({ url: '/pages/ask/ask', fail() { /* 双兜底仍失败则放弃 */ } });
      }
    });
  },
  globalData: {
    nav: { statusBarHeight: 20, navHeight: 44 },
    errCount: 0
  }
});
