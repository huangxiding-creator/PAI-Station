// 锅圈页 — 总包AI顾问 v0.5.0（用户九点令第 9 条）
// 锅 = 打破砂锅问到底：EPC 总承包热点难点问题（智库已答），列表显示问题 + 答案前 100 字，点开看全文
const api = require('../../utils/api');

Page({
  data: {
    items: [],   // {id, question, preview, likes, liked, full_chars}
    loading: true,
    loadError: '',
    nav: { statusBarHeight: 20, navHeight: 44 },
    sheetNo: ''
  },

  onLoad() {
    const app = getApp();
    if (app.globalData && app.globalData.nav) {
      this.setData({ nav: app.globalData.nav });
    }
    const now = new Date();
    const pad = (n) => (n < 10 ? '0' + n : '' + n);
    this.setData({ sheetNo: 'GC-' + pad(now.getMonth() + 1) + pad(now.getDate()) });
    this.refresh();
  },

  onShow() {
    // 自绘 tabBar 选中态（v0.5.0 三页签：问=0 锅=1 我=2）
    if (typeof this.getTabBar === 'function' && this.getTabBar()) {
      this.getTabBar().setData({ selected: 1 });
    }
    // 从答案页返回（可能点了有用）→ 静默刷新点赞数
    if (!this.data.loading && !this.data.loadError) this.refresh();
  },

  refresh() {
    api.potList()
      .then((d) => {
        this.setData({ items: d.items || [], loading: false, loadError: '' });
      })
      .catch((err) => {
        this.setData({ loading: false, loadError: api.errMsg(err, '加载失败') });
      });
  },

  onItem(e) {
    const id = e.currentTarget.dataset.id;
    if (id) wx.navigateTo({ url: '/pages/answer/answer?id=' + id });
  },

  onRetry() {
    this.setData({ loading: true, loadError: '' });
    this.refresh();
  }
});
