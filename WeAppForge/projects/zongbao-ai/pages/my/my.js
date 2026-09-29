// 我的页 — 总包AI顾问 v0.5.0
// 打破砂锅（用户令）：配额常显 + 历史记录 + 批量导出全部咨询（Word/PDF/Markdown，引擎生成 b64 落盘）
const api = require('../../utils/api');

Page({
  data: {
    quota: null,
    items: [],          // {id, question, preview, liked, unlocked, created_at, timeText, lockedText}
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
  },

  onShow() {
    // 自绘 tabBar 选中态（v0.5.0 三页签：问=0 锅=1 我=2）
    if (typeof this.getTabBar === 'function' && this.getTabBar()) {
      this.getTabBar().setData({ selected: 2 });
    }
    this.refresh();
  },

  onPullDownRefresh() {
    this.refresh(() => wx.stopPullDownRefresh());
  },

  refresh(done) {
    api.history()
      .then((d) => {
        const items = (d.items || []).map((it) => {
          let badge = '';
          let badgeCls = 'hist-badge';
          if (it.status === 'pending') { badge = '生成中'; badgeCls = 'hist-badge hist-pending'; }
          else if (it.status === 'error') { badge = '未成功·次数已退'; badgeCls = 'hist-badge hist-err'; }
          else if (!it.unlocked) { badge = '部分预览'; }
          return {
            ...it,
            timeText: this.formatTime(it.created_at),
            badge,
            badgeCls
          };
        });
        this.setData({
          quota: d.quota || null,
          items,
          loading: false,
          loadError: ''
        });
        if (d.quota) wx.setStorageSync('qw_quota', d.quota);
      })
      .catch((err) => {
        this.setData({ loading: false, loadError: api.errMsg(err, '加载失败') });
      })
      .then(() => { if (done) done(); });
  },

  // sqlite: "2026-09-28 14:33:21" → 今天 14:33 / 昨天 14:33 / 09-26 14:33
  formatTime(s) {
    if (!s || s.length < 16) return s || '';
    const day = s.slice(0, 10);
    const hm = s.slice(11, 16);
    const now = new Date();
    const pad = (n) => (n < 10 ? '0' + n : '' + n);
    const today = now.getFullYear() + '-' + pad(now.getMonth() + 1) + '-' + pad(now.getDate());
    const yesterday = new Date(now.getTime() - 86400000);
    const yStr = yesterday.getFullYear() + '-' + pad(yesterday.getMonth() + 1) + '-' + pad(yesterday.getDate());
    if (day === today) return '今天 ' + hm;
    if (day === yStr) return '昨天 ' + hm;
    return day.slice(5) + ' ' + hm;
  },

  onItem(e) {
    const id = e.currentTarget.dataset.id;
    if (id) wx.navigateTo({ url: '/pages/answer/answer?id=' + id });
  },

  goAsk() {
    wx.switchTab({ url: '/pages/ask/ask' });
  },

  onRetry() {
    this.setData({ loading: true });
    this.refresh();
  },

  // ── 批量导出全部咨询（用户令 v0.5.0）：Word/PDF/MD 三选一，引擎聚合生成 ──
  onExportAll() {
    if (!this.data.items.length) return;
    wx.showActionSheet({
      itemList: ['Word 文档 (.docx)', 'PDF 文档 (.pdf)', 'Markdown (.md)'],
      success: (r) => this._exportAllAs(['docx', 'pdf', 'md'][r.tapIndex]),
      fail: () => { /* 用户取消 */ }
    });
  },

  _exportAllAs(fmt) {
    if (this._exporting) return;
    this._exporting = true;
    wx.showLoading({ title: '汇总生成中…', mask: true });
    api.exportAll(fmt)
      .then((d) => {
        const fname = d.filename || ('总包AI顾问-咨询档案.' + fmt);
        const filePath = wx.env.USER_DATA_PATH + '/export-all-' + Date.now() + '.' + fmt;
        wx.getFileSystemManager().writeFile({
          filePath,
          data: d.b64 || '',
          encoding: 'base64',
          success: () => {
            wx.hideLoading();
            this._exporting = false;
            wx.showModal({
              title: '全部咨询已汇总',
              content: fname + ' · 可直接微信转发给同事，或预览后另存。',
              confirmText: '微信转发',
              cancelText: '预览',
              success: (m) => {
                if (m.confirm) this._shareFile(filePath, fname);
                else this._previewFile(filePath);
              }
            });
          },
          fail: () => {
            wx.hideLoading();
            this._exporting = false;
            wx.showToast({ title: '本机写入失败', icon: 'none' });
          }
        });
      })
      .catch((err) => {
        wx.hideLoading();
        this._exporting = false;
        wx.showToast({ title: api.errMsg(err, '批量导出失败'), icon: 'none', duration: 2500 });
      });
  },

  _shareFile(filePath, fileName) {
    if (!wx.shareFileMessage) {
      this._previewFile(filePath); // 老基础库：预览菜单里也能转发
      return;
    }
    wx.shareFileMessage({
      filePath,
      fileName,
      fail: () => this._previewFile(filePath)
    });
  },

  _previewFile(filePath) {
    wx.openDocument({
      filePath,
      showMenu: true,
      fail: () => wx.showToast({ title: '本机暂不支持预览该格式', icon: 'none' })
    });
  }
});
