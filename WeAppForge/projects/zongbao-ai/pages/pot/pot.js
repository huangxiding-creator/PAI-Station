// 锅圈页 — 总包AI顾问 v0.7.0（用户十一点令：200 字脱符号预览 + 最新优先兼顾互动排序）
// 锅 = 打破砂锅问到底：EPC 总承包热点难点问题（智库已答），列表显示问题 + 答案前 200 字预览，点开看全文
const api = require('../../utils/api');
const theme = require('../../utils/theme');

Page({
  data: {
    items: [],   // {id, question, preview, likes, liked, full_chars, views, shares}
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
    theme.apply(this); // v0.7.4 首帧即上主题变量（onShow 仍会再刷，不闪白）
    const now = new Date();
    const pad = (n) => (n < 10 ? '0' + n : '' + n);
    this.setData({ sheetNo: 'GC-' + pad(now.getMonth() + 1) + pad(now.getDate()) });
    this.refresh();
  },

  onShow() {
    theme.apply(this);
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
  },

  // v0.7.4 提审合规：锅圈 UGC 内容举报入口（catchtap 防冒泡进详情）
  onReport(e) {
    const id = e.currentTarget.dataset.id;
    const q = e.currentTarget.dataset.q || '';
    if (!id) return;
    wx.showModal({
      title: '举报内容',
      editable: true,
      placeholderText: '请简要描述举报原因（如含不当内容）',
      success: (r) => {
        if (!r.confirm) return;
        const reason = (r.content || '').trim();
        if (!reason) {
          wx.showToast({ title: '请填写举报原因', icon: 'none' });
          return;
        }
        api.potReport(id, reason)
          .then(() => wx.showToast({ title: '已收到举报', icon: 'success' }))
          .catch((err) => wx.showToast({ title: api.errMsg(err, '提交失败'), icon: 'none' }));
      }
    });
  }
});
