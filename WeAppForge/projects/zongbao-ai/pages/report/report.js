// 报告详情页 — v0.9.0 报告商城（购买/试读/PDF 阅读）
// 链路：目录页带入 sku → 详情+试读 → 购买（pay.payReport，Android/工具端）→
// 解锁后 wx.downloadFile(带 Bearer) + openDocument 打开 PDF 全文。
// 合规铁律：iOS 不展示购买入口（paySupported() 门控），已解锁内容 iOS 可正常阅读。
const theme = require('../../utils/theme');
const api = require('../../utils/api');
const pay = require('../../utils/pay');

Page({
  data: {
    nav: { statusBarHeight: 20, navHeight: 44 },
    sku: '',
    d: null,           // 详情（price/badges/chapters/audience/intro...）
    sample: '',        // 试读正文
    sampleOpen: false,
    loading: true,
    errMsg: '',
    buying: false,
    opening: false,
    paySupported: true, // iOS=false（虚拟支付铁律）
  },

  onLoad(query) {
    const app = getApp();
    if (app.globalData && app.globalData.nav) {
      this.setData({ nav: app.globalData.nav });
    }
    theme.apply(this);
    this.setData({ sku: (query && query.sku) || '', paySupported: pay.paySupported() });
    this.load();
  },

  onShow() {
    theme.apply(this);
    // 从支付流程返回时刷新解锁态（onLoad 不重跑）
    if (this.data.d) this.load(true);
  },

  load(quiet) {
    if (!this.data.sku) {
      this.setData({ loading: false, errMsg: '缺少报告编号' });
      return;
    }
    if (!quiet) this.setData({ loading: true, errMsg: '' });
    api.reportDetail(this.data.sku)
      .then((d) => {
        this.setData({ d, loading: false });
        wx.setNavigationBarTitle && wx.setNavigationBarTitle({ title: d.title || '报告详情', fail: () => {} });
        if (!this.data.sample) {
          api.reportSample(this.data.sku)
            .then((s) => this.setData({ sample: (s && s.text) || '' }))
            .catch(() => this.setData({ sample: '' })); // 试读整理中（404）静默
        }
      })
      .catch((err) => {
        this.setData({ loading: false, errMsg: api.errMsg(err, '详情加载失败，请稍后重试') });
      });
  },

  toggleSample() {
    this.setData({ sampleOpen: !this.data.sampleOpen });
  },

  goBack() {
    const pages = getCurrentPages();
    if (pages.length > 1) wx.navigateBack();
    else wx.switchTab({ url: '/pages/research/research' });
  },

  // 购买解锁（Android/开发工具；iOS 入口在 wxml 层已隐藏）
  buy() {
    if (this.data.buying) return;
    if (!pay.paySupported()) {
      wx.showModal({
        title: '购买方式',
        content: 'iOS 暂不支持应用内购买，请在安卓设备上完成购买后再阅读。',
        showCancel: false,
      });
      return;
    }
    this.setData({ buying: true });
    pay.payReport(this.data.sku)
      .then((r) => {
        this.setData({ buying: false });
        wx.showToast({ title: r.message || '已解锁', icon: 'success' });
        if (r.ok) this.load(true);
      })
      .catch((err) => {
        this.setData({ buying: false });
        wx.showToast({ title: api.errMsg(err, '支付未完成'), icon: 'none' });
      });
  },

  // 打开 PDF 全文（已解锁；downloadFile 须带 Bearer 头）
  openPdf() {
    if (this.data.opening) return;
    this.setData({ opening: true });
    wx.showLoading({ title: '打开报告中', mask: true });
    wx.downloadFile({
      url: api.reportPdfUrl(this.data.sku),
      header: { Authorization: 'Bearer ' + (api.tokenSync() || '') },
      success: (res) => {
        if (res.statusCode !== 200) {
          this._pdfFail('报告暂不可用（' + res.statusCode + '），请稍后重试');
          return;
        }
        wx.openDocument({
          filePath: res.tempFilePath,
          fileType: 'pdf',
          showMenu: true,
          success: () => this.setData({ opening: false }),
          fail: () => this._pdfFail('本机暂不支持打开 PDF，请升级微信后重试'),
        });
      },
      fail: () => this._pdfFail('下载失败，请检查网络后重试'),
    });
  },

  _pdfFail(msg) {
    wx.hideLoading();
    this.setData({ opening: false });
    wx.showToast({ title: msg, icon: 'none', duration: 2500 });
  },

  onShareAppMessage() {
    const d = this.data.d || {};
    return {
      title: d.title ? ('总包研究 · ' + d.title) : '总包研究 · EPC 深度研究报告',
      path: '/pages/report/report?sku=' + this.data.sku,
    };
  },
});
