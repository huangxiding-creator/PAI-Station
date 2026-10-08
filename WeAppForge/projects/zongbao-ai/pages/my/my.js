// 我的页 — 总包AI顾问 v0.5.0
// 打破砂锅（用户令）：配额常显 + 历史记录 + 批量导出全部咨询（Word/PDF/Markdown，引擎生成 b64 落盘）
// v0.7.3：外观画廊——周换装主题选择（跟随星期 / 锁定七套调色板之一）
const api = require('../../utils/api');
const theme = require('../../utils/theme');
const pay = require('../../utils/pay');

Page({
  data: {
    quota: null,
    items: [],          // {id, question, preview, liked, unlocked, created_at, timeText, lockedText}
    loading: true,
    loadError: '',
    nav: { statusBarHeight: 20, navHeight: 44 },
    sheetNo: '',
    themes: [],          // v0.7.3 外观画廊（theme.list()）
    payOk: true,         // v0.8.0 虚拟支付可用（iOS=false → 隐藏批量导出付费入口）
    exportUnpaidAll: -1, // 服务端权威未解锁计数（-1=未知；0 且 iOS 也显示入口=纯导出无需支付）
    reportMine: -1       // v0.9.0 已购报告计数（-1=未知不显示书架行）
  },

  onLoad() {
    const app = getApp();
    if (app.globalData && app.globalData.nav) {
      this.setData({ nav: app.globalData.nav });
    }
    theme.apply(this); // v0.7.4 首帧即上主题变量（onShow 仍会再刷，不闪白）
    this.setData({ payOk: pay.paySupported() });
    const now = new Date();
    const pad = (n) => (n < 10 ? '0' + n : '' + n);
    this.setData({ sheetNo: 'GC-' + pad(now.getMonth() + 1) + pad(now.getDate()) });
  },

  onShow() {
    // v0.7.3 周换装：主题刷新 + 画廊激活态重算（跨日回到本页可见轮换效果）
    theme.apply(this);
    this.setData({ themes: theme.list() });
    // 自绘 tabBar 选中态（v0.7.2 四页签：问=0 锅=1 智=2 我=3）
    if (typeof this.getTabBar === 'function' && this.getTabBar()) {
      this.getTabBar().setData({ selected: 4 });
    }
    this.refresh();
  },

  // v0.7.3 锁定主题（用户令：用户可调整喜欢的配色）
  onThemeTap(e) {
    const key = e.currentTarget.dataset.key || '';
    if (!key) return;
    theme.setPref(key);
    theme.apply(this);
    this.setData({ themes: theme.list() });
    wx.vibrateShort({ type: 'light', fail: () => {} });
    const t = theme.list().find((x) => x.key === key);
    wx.showToast({ title: '已切换：' + (t ? t.name : key), icon: 'none', duration: 1600 });
  },

  // v0.7.3 解锁偏好 → 跟随星期自动轮换
  onThemeAuto() {
    theme.setPref('');
    theme.apply(this);
    this.setData({ themes: theme.list() });
    wx.vibrateShort({ type: 'light', fail: () => {} });
    wx.showToast({ title: '已恢复：每周七天自动轮换', icon: 'none', duration: 1600 });
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
          // 审计 MEDIUM-5：弹窗金额以服务端全量计数为准（items 仅 20 条截断）
          exportUnpaidAll: (typeof d.export_unpaid_all === 'number')
            ? d.export_unpaid_all : -1,
          loading: false,
          loadError: ''
        });
        if (d.quota) wx.setStorageSync('qw_quota', d.quota);
      })
      .catch((err) => {
        this.setData({ loading: false, loadError: api.errMsg(err, '加载失败') });
      })
      .then(() => { if (done) done(); });
    // v0.9.0 报告商城：已购计数（失败静默——书架入口不阻断我的页）
    api.reportList()
      .then((d) => {
        const mine = ((d && d.reports) || []).filter((r) => r.unlocked).length;
        this.setData({ reportMine: mine });
      })
      .catch(() => {});
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

  // v0.9.0 我的报告书架 → 研究页已购筛
  goReports() {
    wx.switchTab({ url: '/pages/research/research' });
  },

  // v0.7.4 提审合规：用户协议 · 隐私政策
  goPrivacy() {
    wx.navigateTo({ url: '/pages/legal/privacy' });
  },

  onRetry() {
    this.setData({ loading: true });
    this.refresh();
  },

  // ── 批量导出全部咨询（用户令 v0.5.0）：Word/PDF/MD 三选一，引擎聚合生成 ──
  // v0.8.0（用户令 1008）：导出按条收费 ¥0.1；未解锁条数一单付清（iOS 隐藏入口）
  onExportAll() {
    if (!this.data.items.length) return;
    // 服务端权威未解锁计数（-1=旧服务端未知时，回退本地 items 估算——仅含近 20 条，保守）
    const unpaid = this.data.exportUnpaidAll >= 0
      ? this.data.exportUnpaidAll
      : this.data.items.filter((it) => it.status === 'ready' && !it.export_paid).length;
    // 已全部解锁 → 直接导出（iOS 已解锁内容也可导出：铁律只禁「新增付费入口」）
    if (!unpaid) {
      this._exportAllSheet();
      return;
    }
    if (!this.data.payOk) {
      wx.showToast({ title: '当前系统暂不支持导出', icon: 'none' });
      return;
    }
    // 引擎单笔上限 99 条（buyQuantity 上限）：超量引导先单篇解锁（审计 MEDIUM-4）
    if (unpaid > 99) {
      wx.showModal({
        title: '一次最多解锁 99 条',
        content: '当前未解锁 ' + unpaid + ' 条，超出单笔上限。请先在部分回答页单独解锁，剩余不足 99 条后再来批量导出。',
        showCancel: false,
        confirmText: '知道了'
      });
      return;
    }
    const yuan = (unpaid * 0.1).toFixed(1);
    wx.showModal({
      title: '批量导出 ' + unpaid + ' 条',
      content: '咨询全程免费，导出按 ¥0.1/条：本次 ' + unpaid + ' 条共 ' + yuan + ' 元（一单付清，解锁后可反复导出）。',
      confirmText: '支付 ' + yuan + ' 元',
      cancelText: '再想想',
      success: (r) => {
        if (!r.confirm) return;
        if (this._payBusy) return;
        this._payBusy = true;
        wx.showLoading({ title: '拉起支付…', mask: true });
        pay.payExportAll()
          .then((res) => {
            wx.hideLoading();
            this._payBusy = false;
            wx.showToast({ title: res.message, icon: 'none', duration: 2000 });
            if (res.reconciling) {
              // 已扣款、核验腿抖断：不谎报完成，刷新等查单补标记后自然解锁（重按=409 收口）
              this.refresh();
              return;
            }
            if (res.ok) {
              this.refresh();
              this._exportAllSheet();
            }
          });
      }
    });
  },

  _exportAllSheet() {
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
