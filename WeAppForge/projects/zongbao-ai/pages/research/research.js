// 研究页（tab 3）— v0.9.0 报告商城目录（用户令 1008：研究报告售卖整合进总包AI顾问）
// 66 份 EPC 总包深度研究报告：按份购买一次解锁永久阅读；整理中条目可看不可买。
// 目录公开浏览（漏斗前宽），解锁态随登录态刷新。
const theme = require('../../utils/theme');
const api = require('../../utils/api');

// 分类筛（cat 键与目录数据一致；「已购」独立一档）
const FILTERS = [
  { k: 'all', label: '全部' },
  { k: 'mine', label: '已购' },
  { k: 'ent', label: '企业研究' },
  { k: 'prov', label: '区域市场' },
  { k: 'topic', label: '专题研究' },
  { k: 'flagship', label: '旗舰' },
  { k: 'excl', label: '独家' },
];

Page({
  data: {
    nav: { statusBarHeight: 20, navHeight: 44 },
    filters: FILTERS,
    active: 'all',
    reports: [],
    shown: [],
    stats: { total: 0, sellable: 0, mine: 0 },
    loading: true,
    errMsg: '',
  },

  onLoad() {
    const app = getApp();
    if (app.globalData && app.globalData.nav) {
      this.setData({ nav: app.globalData.nav });
    }
    theme.apply(this);
  },

  onShow() {
    theme.apply(this);
    if (typeof this.getTabBar === 'function' && this.getTabBar()) {
      this.getTabBar().setData({ selected: 3 });
    }
    this.load();
  },

  onPullDownRefresh() {
    this.load(() => wx.stopPullDownRefresh());
  },

  load(done) {
    this.setData({ loading: true, errMsg: '' });
    api.reportList()
      .then((d) => {
        const reports = d.reports || [];
        const mine = reports.filter((r) => r.unlocked).length;
        const sellable = reports.filter((r) => r.sellable).length;
        this.setData({
          reports,
          stats: { total: reports.length, sellable, mine },
          loading: false,
        });
        this.applyFilter();
        if (done) done();
      })
      .catch((err) => {
        this.setData({ loading: false, errMsg: api.errMsg(err, '目录加载失败，请稍后重试') });
        if (done) done();
      });
  },

  applyFilter() {
    const { reports, active } = this.data;
    let shown = reports;
    if (active === 'mine') shown = reports.filter((r) => r.unlocked);
    else if (active !== 'all') shown = reports.filter((r) => r.cat === active);
    this.setData({ shown });
  },

  tapFilter(e) {
    const k = e.currentTarget.dataset.k;
    if (!k || k === this.data.active) return;
    this.setData({ active: k });
    this.applyFilter();
  },

  goReport(e) {
    const sku = e.currentTarget.dataset.sku;
    if (!sku) return;
    wx.navigateTo({ url: '/pages/report/report?sku=' + sku });
  },

  onShareAppMessage() {
    return {
      title: '总包研究 · EPC 深度研究报告商城',
      path: '/pages/research/research',
    };
  },
});
