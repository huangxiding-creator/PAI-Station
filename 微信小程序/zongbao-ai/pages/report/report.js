// 报告详情页 — v0.9.0 报告商城（购买/试读/PDF 阅读）
// 链路：目录页带入 sku → 详情+试读 → 购买（pay.payReport，Android/工具端）→
// 解锁后 wx.downloadFile(带 Bearer) + openDocument 打开 PDF 全文。
// 合规铁律：iOS 不展示购买入口（paySupported() 门控），已解锁内容 iOS 可正常阅读。
const theme = require('../../utils/theme');
const api = require('../../utils/api');
const pay = require('../../utils/pay');
const md2blocks = require('../../utils/md2blocks');
const tel = require('../../utils/telemetry'); // v0.9.6：购买入口打点（对照组——此链在真机已活）
const pop = require('../../utils/pop'); // v0.9.7：qw-pop 自绘弹窗（品牌同源重设计，按钮文字摆脱 4 字硬限）

Page({
  data: {
    nav: { statusBarHeight: 20, navHeight: 44 },
    sku: '',
    d: null,           // 详情（price/badges/chapters/audience/intro...）
    sample: '',        // 试读原文（md）
    sampleBlocks: [],  // 试读结构化块（md2blocks，渲染用）
    sampleOpen: false,
    loading: true,
    errMsg: '',
    buying: false,
    opening: false,
    paySupported: true, // iOS=false（虚拟支付铁律）
    popOpen: false,     // v0.9.7 qw-pop 开合镜像（e2e/结构锚 + tabBar 压暗让路）
    popMode: '',
    usefulDone: false,  // v0.9.15 有用已点（乐观置位防双击；400 已点过=终态保持）
    posterBusy: false,  // v0.9.15 海报生成在途
    rewardShow: false,  // v0.9.16 授勋动画开关（与答案页统一）
    reward: '',         // v0.9.16 授勋动画副题文案
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
        // v0.9.5 审计修（L6）：删除 wx.setNavigationBarTitle——全站 custom 导航栏（死调用）
        if (!this.data.sample) {
          api.reportSample(this.data.sku)
            .then((s) => {
              const t = (s && s.text) || '';
              this.setData({ sample: t, sampleBlocks: t ? md2blocks.md2blocks(t) : [] });
            })
            .catch(() => this.setData({ sample: '', sampleBlocks: [] })); // 试读整理中（404）静默
        }
      })
      .catch((err) => {
        // v0.9.5 审计修（M4）：静默刷新（购买后/回页 onShow）失败不再无声——
        // 有内容在屏时 errMsg 卡不会渲染（wx:if={{!d}}），须 toast 告知（对齐 pot.js 先例）
        if (this.data.d) {
          wx.showToast({ title: '刷新失败，展示的是稍早内容', icon: 'none', duration: 2200 });
        } else {
          this.setData({ loading: false, errMsg: api.errMsg(err, '详情加载失败，请稍后重试') });
        }
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

  // 错误态重试（包装一层，防 tap 事件对象误入 load 的 quiet 参数）
  retry() {
    this.load();
  },

  // v0.9.7 qw-pop：弹窗开合镜像 + 自绘 tabBar 压暗让路（本页非 tab 页，getTabBar 自然跳过）
  onPopState(e) {
    pop.onPopState(this, e);
  },

  // 购买解锁（Android/开发工具；iOS 入口在 wxml 层已隐藏）
  buy() {
    tel.ping('buy_tap', { sku: String(this.data.sku || '').slice(0, 24) });
    if (this.data.buying) return;
    if (!pay.paySupported()) {
            wx.showToast({ title: 'iOS 暂不支持应用内购买，请在安卓设备完成购买', icon: 'none', duration: 2500 });
      return;
    }
    wx.vibrateShort({ type: 'light', fail: () => {} });
    this.setData({ buying: true });
    pay.payReport(this.data.sku)
      .then((r) => {
        this.setData({ buying: false });
        if (r.ok) {
          wx.showToast({ title: '已解锁', icon: 'success' });
          this.load(true);
          return;
        }
        // v0.9.5 审计修（M5）：与 my/answer 支付链同款——取消=轻提示，失败=大声弹窗
        // （toast 一闪而过在用户眼里就是「点了没反应」——¥498+ 的单更须说清楚）
                // v0.9.12（用户令）：未完成支付不弹窗——用户自己知道；取消静默，其余轻提示原因
        if (String(r.message || '').indexOf('取消') < 0) {
          wx.showToast({ title: r.message, icon: 'none', duration: 2500 });
        }
      })
      .catch((err) => {
        this.setData({ buying: false });
                wx.showToast({ title: api.errMsg(err, '网络波动，请稍后重试'), icon: 'none', duration: 2500 });
      });
  },

  // 打开 PDF 全文（已解锁；downloadFile 须带 Bearer 头）
  openPdf() {
    if (this.data.opening) return;
    this.setData({ opening: true });
    pop.loading(this, '打开报告中');
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
          success: () => {
            pop.hideLoading(this); // 须在 openDocument 之后收口，防读完 PDF 返回后蒙层滞留（审计锚）
            this.setData({ opening: false });
          },
          fail: () => this._pdfFail('本机暂不支持打开 PDF，请升级微信后重试'),
        });
      },
      fail: () => this._pdfFail('下载失败，请检查网络后重试'),
    });
  },

  _pdfFail(msg) {
    pop.hideLoading(this);
    this.setData({ opening: false });
    wx.showToast({ title: msg, icon: 'none', duration: 2500 });
  },

  // ══ v0.9.15（用户令 1011）互动三件：有用 / 分享给同行 / 生成海报 ══

  // 有用：赠 1 次咨询额度（每报告每人一次；与答案页 like 同构，反馈可见）
  onUseful() {
    if (this.data.usefulDone) return;
    tel.ping('report_useful_tap', { sku: String(this.data.sku || '').slice(0, 24) });
    this.setData({ usefulDone: true }); // 乐观置位防双击；网络失败回滚
    api.reportUseful(this.data.sku)
      .then((r) => {
        if (r && r.quota) wx.setStorageSync('qw_quota', r.quota);
        // v0.9.16（1012 用户令）：赠次反馈升级为授勋动画——与答案页有用/纠错/共享完全统一
        this._reward('「有用」是给同行的掌声');
      })
      .catch((err) => {
        const again = err && err.statusCode === 400; // 已点过=终态保持置位
        if (!again) this.setData({ usefulDone: false });
        wx.showToast({ title: again ? '已点过有用' : api.errMsg(err, '网络波动，请稍后重试'), icon: 'none', duration: 2000 });
      });
  },

  // 分享给同行：静默赠 1 次（运营规范 3.2.1——分享动作零诱导文案、不弹获赠提示，
  // 仅额度数字自然 +1；服务端幂等，重复分享不报错）。bindtap 先于转发面板触发。
  onShareTap() {
    tel.ping('report_share_tap', { sku: String(this.data.sku || '').slice(0, 24) });
    api.reportShare(this.data.sku)
      .then((r) => { if (r && r.quota) wx.setStorageSync('qw_quota', r.quota); })
      .catch(() => {}); // 静默：赠次腿失败绝不打扰分享动作本身
  },

  // 生成海报：研报转化海报（无价格·试读显眼·扫码直达报告），范式与答案页 onPoster 同构
  onPoster() {
    if (this.data.posterBusy) return;
    this.setData({ posterBusy: true });
    pop.loading(this, '海报生成中…');
    api.reportPoster(this.data.sku)
      .then((d) => new Promise((resolve, reject) => {
        // 固定文件名（按报告）：重复生成不堆积
        const path = wx.env.USER_DATA_PATH + '/poster-r-' + this.data.sku + '.png';
        wx.getFileSystemManager().writeFile({
          filePath: path,
          data: (d && d.b64) || '',
          encoding: 'base64',
          success: () => resolve(path),
          fail: () => reject(new Error('本机写入失败'))
        });
      }))
      .then((path) => {
        pop.hideLoading(this);
        this.setData({ posterBusy: false });
        if (wx.showShareImageMenu) {
          wx.showShareImageMenu({
            path,
            entrancePath: '/pages/ask/ask', // 分享图携带小程序入口，海报码回流同页路由
            fail: () => this._previewPoster(path)
          });
        } else {
          this._previewPoster(path); // 老基础库：预览菜单可长按转发
        }
      })
      .catch((err) => {
        pop.hideLoading(this);
        this.setData({ posterBusy: false });
        wx.showToast({ title: api.errMsg(err, '海报生成失败'), icon: 'none' });
      });
  },

  _previewPoster(path) {
    wx.previewImage({ urls: [path], fail: () => wx.showToast({ title: '海报已生成', icon: 'none' }) });
  },

  // ══ v0.9.16 授勋动画（1012 用户令：有用赠次统一动画）——与答案页 _reward 同构逐字移植 ══
  _reward(label) {
    this.setData({ rewardShow: true, reward: label });
    wx.vibrateShort({ type: 'heavy', fail: () => {} });
    if (this._rwTimer) clearTimeout(this._rwTimer);
    this._rwTimer = setTimeout(() => {
      this.setData({ rewardShow: false, reward: '' });
      this._rwTimer = null;
    }, 2400);
  },

  noop() {},

  onUnload() {
    if (this._rwTimer) { clearTimeout(this._rwTimer); this._rwTimer = null; } // 对齐答案页隐藏态纪律：离页不再对隐藏页 setData
  },

  onShareAppMessage() {
    const d = this.data.d || {};
    return {
      title: d.title ? ('总包研究 · ' + d.title) : '总包研究 · EPC 深度研究报告',
      path: '/pages/report/report?sku=' + this.data.sku,
    };
  },
});
