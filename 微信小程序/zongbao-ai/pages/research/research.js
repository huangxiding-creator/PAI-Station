// 研究页（tab 3）— v0.9.0 报告商城目录（用户令 1008：研究报告售卖整合进总包AI顾问）
// 66 份 EPC 总包深度研究报告：按份购买一次解锁永久阅读；整理中条目可看不可买。
// 目录公开浏览（漏斗前宽），解锁态随登录态刷新。
const theme = require('../../utils/theme');
const api = require('../../utils/api');
const tel = require('../../utils/telemetry');

// 分类筛（cat 键与目录数据一致；「已购」独立一档）
// v0.9.6（用户令 1009）：去掉「旗舰」「独家」两档（标签概念整体下线，目录数据同步 recat）
const FILTERS = [
  { k: 'all', label: '全部' },
  { k: 'mine', label: '已购' },
  { k: 'ent', label: '企业研究' },
  { k: 'prov', label: '区域市场' },
  { k: 'topic', label: '专题研究' },
];

Page({
  data: {
    nav: { statusBarHeight: 20, navHeight: 44 },
    filters: FILTERS,
    active: 'all',
    reports: [],
    latest: [],      // v0.9.21 双分区：最新研报（引擎目录序 TOP 3，不受筛选影响）
    hot: [],         // v0.9.21 双分区：最热研报（互动热度倒序；分类筛子只作用于此区）
    shown: [],
    stats: { total: 0, sellable: 0, mine: 0 },
    statsReady: false, // 首次目录到货前 hero 数据带显示占位，不闪 0
    loading: true,
    errMsg: '',
    query: '',   // 1118 检索：标题/副题/分类/SKU 即输即筛（本地全量，零后端往返）
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
        // 空 cat_name 客户端展示兜底（如线上 BLUEBOOK-2027）：按 title 前缀定文案，避免分类位空白
        const fixCat = (r) => (
          r.cat_name ? r : { ...r, cat_name: r.title && r.title.indexOf('蓝皮书') === 0 ? '蓝皮书' : '其他' }
        );
        // 1119 用户令：知识库 SKU 归智库页「知识库市场」——研究页全分区（含 latest/hot/stats）剔除
        const isKb = (r) => r.product_type === 'knowledge_base';
        const reports = (d.reports || []).map(fixCat).filter((r) => !isKb(r));
        // v0.9.21 双分区（用户令 1018）：latest=引擎目录序前 3（TOP 3 恒定不受筛选）；
        // hot=互动热度倒序（heat=views+likes+shares；引擎缺字段时客户端兜底同规则再排序）
        const withHeat = (r) => ({
          ...r,
          heat: (typeof r.heat === 'number') ? r.heat : ((r.views || 0) + (r.likes || 0) + (r.shares || 0)),
        });
        const latestSrc = ((d.latest || []).length ? d.latest : reports).filter((r) => !isKb(r));
        const latest = (latestSrc.length ? latestSrc : reports.filter((r) => r.sellable)).slice(0, 3).map(fixCat);
        const hotSrc = ((d.hot || []).length ? d.hot : reports).filter((r) => !isKb(r));
        const hot = (hotSrc.length ? hotSrc : reports).map(fixCat).map(withHeat)
          .sort((a, b) => (b.heat || 0) - (a.heat || 0));
        const mine = reports.filter((r) => r.unlocked).length;
        const sellable = reports.filter((r) => r.sellable).length;
        // 1012：起价数据驱动（原写死 ¥498，旗舰 ¥10,000 上架后口径漂移）
        const prices = reports.filter((r) => r.sellable).map((r) => Number(r.price) || 0);
        const pmin = prices.length ? Math.min.apply(null, prices) : 0;
        this.setData({
          reports,
          latest,
          hot,
          stats: { total: reports.length, sellable, mine, pmin },
          statsReady: true,
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

  // 重新加载按钮专用包装：吃掉 tap 事件对象，防止其被误当 done 回调传入 load
  retry() {
    this.load();
  },

  // v0.9.21：分类筛子只作用于最热区（shown=hot 的过滤视图；最新区恒为 TOP 3 不受筛选影响）
  // 1118：检索词先行过滤（title/subtitle/cat_name/sku 小写包含；覆盖研报+知识库全目录），
  // 再叠分类筛——hot 区本就是全量目录的热度排序视图，检索范围=在架全集。
  applyFilter() {
    const { hot, active, query } = this.data;
    const q = String(query || '').trim().toLowerCase();
    let shown = hot;
    if (q) {
      shown = shown.filter((r) => (
        (r.title || '').toLowerCase().indexOf(q) >= 0
        || (r.subtitle || '').toLowerCase().indexOf(q) >= 0
        || (r.cat_name || '').toLowerCase().indexOf(q) >= 0
        || (r.sku || '').toLowerCase().indexOf(q) >= 0
      ));
    }
    if (active === 'mine') shown = shown.filter((r) => r.unlocked);
    else if (active !== 'all') shown = shown.filter((r) => r.cat === active);
    this.setData({ shown });
  },

  // ── 1118 检索 ──
  onSearchInput(e) {
    this.setData({ query: e.detail.value });
    this.applyFilter();
    const q = String(e.detail.value || '').trim();
    if (q) {
      // 隐私纪律（telemetry 头注）：不上报检索内容本身——只上长度与命中数
      tel.ping('research_search', { len: Math.min(q.length, 40), hits: this.data.shown.length });
    }
  },

  onSearchClear() {
    this.setData({ query: '' });
    this.applyFilter();
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
    api.reportBump(sku, 'views').catch(() => {}); // v0.9.21 观看计数 fire-and-forget（不阻导航）
    wx.navigateTo({ url: '/pages/report/report?sku=' + sku });
  },

  onAskReport() {
    // 1020 用户令：问报告=研究页主角——直跳最新在售报告并自动聚焦提问区
    const first = (this.data.latest && this.data.latest[0]) || (this.data.items && this.data.items[0]);
    if (!first) {
      wx.showToast({ title: '报告加载中，稍候再试', icon: 'none' });
      return;
    }
    wx.navigateTo({ url: '/pages/report/report?sku=' + first.sku + '&focus=ask' });
  },

  onShareAppMessage() {
    return {
      title: '总包研究 · EPC 深度研究报告商城',
      path: '/pages/research/research',
    };
  },

  // v0.9.18（用户令 1013 朋友圈亮灯）：两步门槛第二步——同页成对 onShareTimeline；商城页仅标题不携参
  onShareTimeline() {
    return {
      title: '总包研究 · EPC 深度研究报告商城'
    };
  },
});
