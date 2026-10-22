// 知识库工厂页 — KB-FACTORY W4 v1 + W6 支付/导出/整库下单
// 链路：输入(文字/语音) → utils/kbfactory_service.generate（v1 本地真样本+八阶段模拟，M6 接后端）
// → 蓝图渲染（三级树折叠 · 配比三段条 · 动态报价）
//   v2 document_driven 蓝图：tree.l1=超越层（名称+描述）、文件带 real 真实检索标记、
//   配比键=超越层名（core/field/guide 为兼容键）——同页双模式自适应，v1 渲染不变。
// → W6：导出蓝图 ¥0.1（pay 解锁→离屏 canvas 绘长图→存相册/预览）· 免费分享卡（各平台可看）
//        · 带走整库（确认层三版本单选+邮箱校验+合规三句 → kb_order 支付 → 履约单提交/本地订单箱 → 履约中状态页）。
// 合规铁律：iOS 隐藏一切付费入口（paySupported 双门：js 守卫+wxml wx:if），导出件本身各平台可看。
const theme = require('../../utils/theme');
const kbf = require('../../utils/kbfactory_service');
const pop = require('../../utils/pop');
const pay = require('../../utils/pay');
const kbp = require('../../utils/kbfactory_pay');
const kpost = require('../../utils/kbfactory_poster');

// 语音腿（复用 report 页冻结范式）：WechatSI 同声传译插件，缺失/失败降级为提示，文字永在
let _si = null;
try { _si = requirePlugin('WechatSI'); } catch (e) { _si = null; }

Page({
  data: {
    nav: { statusBarHeight: 20, navHeight: 44 },
    needText: '',
    recording: false,
    building: false,
    built: false,
    stages: [],   // 八阶段施工直播
    bp: null,     // 蓝图样本（service 层视图）
    tree: [],     // 三级树渲染模型（open 折叠态）
    ratioSegs: [],  // 配比条渲染模型：v1 三段(core/field/guide)｜v2 按超越层名 N 段
    mdPrice: '',  // Markdown 版价（×1.5，实测计算非手填）
    sampleNote: '', // 样本截断注明（演示数据与全量真值的边界，如实展示）
    paySupported: true, // W6：iOS=false → 隐藏付费入口（虚拟支付铁律，双门之一）
    exporting: false,   // 长图生成/支付进行中（导出与分享卡共用防重入）
    // ── W6 整库订单确认层 ──
    ordOpen: false, ordBusy: false, ordDone: false,
    ordVersion: 'original',       // original | md | import（payload 稳定枚举）
    ordVersions: [],              // [{key,name,note,amount}]（报价真值计算）
    ordAmount: '',                // 当前选中版本应付金额（展示用；服务端按摘要复算为准）
    ordEmail: '', ordEmailErr: '', ordDoneEmail: '',
  },

  onLoad() {
    const app = getApp();
    if (app.globalData && app.globalData.nav) {
      this.setData({ nav: app.globalData.nav });
    }
    this.setData({ paySupported: pay.paySupported() });
    theme.apply(this);
  },

  onShow() {
    theme.apply(this);
  },

  onUnload() {
    this._dead = true; // 施工直播回调守卫：离页不再 setData
    if (this.data.recording && this._siMgr) this._siMgr.stop();
  },

  // ── 输入 ──
  onNeedInput(e) {
    this.setData({ needText: e.detail.value });
  },

  // ── 免费设计主按钮 ──
  onGenerate() {
    const t = String(this.data.needText || '').trim();
    if (!t) {
      wx.showToast({ title: '先说一句你要的知识库', icon: 'none' });
      return;
    }
    if (this.data.building) return;
    this.setData({
      building: true, built: false, bp: null, tree: [], ratioSegs: [], mdPrice: '',
      stages: kbf.STAGES.map((s) => ({ name: s.name, line: s.line, count: '', state: '' })),
    });
    kbf.generate(t, (st) => {
      if (this._dead) return;
      const patch = { ['stages[' + st.i + '].state']: st.state };
      if (st.count !== undefined) patch['stages[' + st.i + '].count'] = st.count;
      this.setData(patch);
    }).then((bp) => {
      if (this._dead) return;
      this.setData({
        building: false, built: true, bp: bp,
        tree: this._buildTree(bp),
        ratioSegs: this._buildRatioSegs(bp),
        mdPrice: this._round1(bp.quote.total * bp.quote.md_factor),
        sampleNote: (bp._sample && bp._sample.note) || '',
      });
      wx.vibrateShort({ type: 'light', fail: () => {} });
    }).catch((err) => {
      if (this._dead) return;
      this.setData({ building: false, genErr: (err && err.message) || '生成失败' });  // 调试字段(e2e取证用)
      wx.showToast({ title: (err && err.message) || '生成失败，请重试', icon: 'none' });
    });
  },

  _round1(n) {
    return Math.round(n * 10) / 10;
  },

  // 树渲染模型：首库默认展开，其余收起；L2 全收起（按需点开看文件清单）
  _buildTree(bp) {
    return (bp.tree.l1 || []).map((l1, i) => ({
      code: l1.code, name: l1.name, theme: l1.theme, l2_count: l1.l2_count,
      open: i === 0,
      l2: (l1.l2 || []).map((l2) => ({
        code: l2.code, name: l2.name, file_count: l2.file_count,
        files: l2.files || [], open: false,
      })),
    }));
  },

  // 配比条渲染模型：v2 document_driven 时键=超越层名（合规底线/技术标准/操作实务/参考工具，
  // core/field/guide 为 enrich 兼容键须剔除），按层名渲染 N 段；v1 仍为三段固定档
  _buildRatioSegs(bp) {
    const r = bp.ratio || {};
    if (bp.tree && bp.tree.mode === 'document_driven') {
      const CLS = ['core', 'field', 'guide', 'plus'];
      return Object.keys(r)
        .filter((k) => k !== 'core' && k !== 'field' && k !== 'guide')
        .map((k, i) => ({ name: k, pct: r[k] || 0, cls: CLS[i] || 'plus' }));
    }
    return [
      { name: '核心主干', pct: r.core || 0, cls: 'core' },
      { name: '领域补充', pct: r.field || 0, cls: 'field' },
      { name: '导读合成', pct: r.guide || 0, cls: 'guide' },
    ];
  },

  toggleL1(e) {
    const i = e.currentTarget.dataset.i;
    wx.vibrateShort({ type: 'light', fail: () => {} });
    this.setData({ ['tree[' + i + '].open']: !this.data.tree[i].open });
  },

  toggleL2(e) {
    const { i, j } = e.currentTarget.dataset;
    wx.vibrateShort({ type: 'light', fail: () => {} });
    this.setData({ ['tree[' + i + '].l2[' + j + '].open']: !this.data.tree[i].l2[j].open });
  },

  // ── 语音按住说（touchstart/touchend 事件对；插件缺失/失败文字兜底） ──
  onMicStart() {
    if (this.data.building) return;
    if (!_si || !_si.getRecordRecognitionManager) {
      wx.showToast({ title: '语音未就绪，请直接打字', icon: 'none', duration: 2500 });
      return;
    }
    if (this.data.recording) return;
    wx.getSetting({
      success: (s) => {
        if (s.authSetting['scope.record'] === false) {
          wx.showToast({ title: '请在设置中开启麦克风权限', icon: 'none', duration: 2500 });
          setTimeout(() => { wx.openSetting({}); }, 1500);
          return;
        }
        this._startVoiceRecord();
      },
      fail: () => this._startVoiceRecord(),
    });
  },

  _startVoiceRecord() {
    if (!this._siMgr) {
      const mgr = _si.getRecordRecognitionManager();
      mgr.onStart = () => this.setData({ recording: true });
      mgr.onRecognize = (res) => {
        const t = (res && res.result) || '';
        if (t) this.setData({ needText: t }); // 转写实时回填输入口
      };
      mgr.onStop = (res) => {
        const t = String((res && res.result) || this.data.needText || '').trim();
        this.setData({ recording: false, needText: t });
        if (t.length < 2) wx.showToast({ title: '说的内容有点短，可打字补充', icon: 'none', duration: 2000 });
      };
      mgr.onError = () => {
        this.setData({ recording: false });
        wx.showToast({ title: '语音识别失败，请直接打字', icon: 'none', duration: 2000 });
      };
      this._siMgr = mgr;
    }
    this._siMgr.start({ duration: 60000, lang: 'zh_CN' });
  },

  onMicEnd() {
    if (!this.data.recording) return;
    if (this._siMgr) this._siMgr.stop();
    this.setData({ recording: false });
  },

  // ── W6 导出蓝图（¥0.1）：pay 解锁 → 离屏 canvas 绘长图 → 存相册（拒绝→预览降级） ──
  onExport() {
    wx.vibrateShort({ type: 'light', fail: () => {} });
    if (!pay.paySupported()) { // iOS 双门之二（wxml 已隐藏；此为兜底守卫）
      wx.showToast({ title: 'iOS 暂不支持应用内购买，请在安卓设备完成解锁', icon: 'none', duration: 2500 });
      return;
    }
    if (!this.data.bp || this.data.exporting) return;
    const payload = kbp.buildExportPayload(this.data.bp, this.data.needText);
    this.setData({ exporting: true });
    pop.loading(this, '解锁导出中');
    pay.payBlueprintExport(payload)
      .then((r) => {
        if (!r.ok) {
          this.setData({ exporting: false });
          pop.hideLoading(this);
          if (String(r.message || '').indexOf('取消') < 0) {
            wx.showToast({ title: r.message, icon: 'none', duration: 2500 });
          }
          return;
        }
        // 已解锁（含 409 已付收口）→ 绘蓝图核心区长图（统计带+树缩略+配比+报价卡）
        pop.loading(this, '绘制蓝图长图中');
        kpost.generateBlueprintPoster(this.data.bp, payload.blueprint)
          .then((res) => {
            this.setData({ exporting: false });
            pop.hideLoading(this);
            this._savePoster(res.filePath);
          })
          .catch((err) => {
            this.setData({ exporting: false });
            pop.hideLoading(this);
            wx.showToast({ title: (err && err.message) || '长图生成失败，请重试', icon: 'none', duration: 2500 });
          });
      })
      .catch((err) => {
        this.setData({ exporting: false });
        pop.hideLoading(this);
        wx.showToast({ title: (err && err.message) || '网络波动，请稍后重试', icon: 'none', duration: 2500 });
      });
  },

  // ── W6 免费分享卡（不涉支付，各平台可看；导出件本身 iOS 可用） ──
  onPoster() {
    wx.vibrateShort({ type: 'light', fail: () => {} });
    if (!this.data.bp || this.data.exporting) return;
    this.setData({ exporting: true });
    pop.loading(this, '生成分享卡中');
    kpost.generateShareCard(this.data.bp, kbp.digestOf(this.data.bp))
      .then((res) => {
        this.setData({ exporting: false });
        pop.hideLoading(this);
        this._savePoster(res.filePath);
      })
      .catch((err) => {
        this.setData({ exporting: false });
        pop.hideLoading(this);
        wx.showToast({ title: (err && err.message) || '分享卡生成失败，请重试', icon: 'none', duration: 2500 });
      });
  },

  // 存相册；权限拒绝/受限 → 预览降级（预览内长按可存，零强制）
  _savePoster(filePath) {
    wx.saveImageToPhotosAlbum({
      filePath: filePath,
      success: () => wx.showToast({ title: '已存入相册', icon: 'success' }),
      fail: () => {
        wx.previewImage({ urls: [filePath], fail: () => {} });
        wx.showToast({ title: '已生成预览，长按图片可保存', icon: 'none', duration: 2500 });
      }
    });
  },

  // ── W6 带走整库：确认层（三版本单选+邮箱必填+合规三句）→ kb_order 支付 → 履约中 ──
  onBuyLibrary() {
    wx.vibrateShort({ type: 'light', fail: () => {} });
    if (!pay.paySupported()) { // iOS 双门（付费入口铁律）
      wx.showToast({ title: 'iOS 暂不支持应用内购买，请在安卓设备完成购买', icon: 'none', duration: 2500 });
      return;
    }
    if (!this.data.bp) return;
    const bp = this.data.bp;
    const vs = kbp.VERSIONS.map((v) => ({
      key: v.key, name: v.name, note: v.note, amount: kbp.priceOf(bp, v.key).amount
    }));
    this.setData({
      ordOpen: true, ordBusy: false, ordDone: false,
      ordVersion: 'original', ordVersions: vs, ordAmount: vs[0].amount,
      ordEmail: '', ordEmailErr: '', ordDoneEmail: ''
    });
  },

  onOrdClose() {
    if (this.data.ordBusy) return; // 支付进行中不许误关（防丢单）
    this.setData({ ordOpen: false });
  },

  onOrdPick(e) {
    const key = e.currentTarget.dataset.v;
    const v = (this.data.ordVersions || []).find((x) => x.key === key);
    if (v) this.setData({ ordVersion: key, ordAmount: v.amount });
    wx.vibrateShort({ type: 'light', fail: () => {} });
  },

  onOrdEmail(e) {
    this.setData({ ordEmail: e.detail.value, ordEmailErr: '' });
  },

  onOrdPay() {
    if (this.data.ordBusy) return;
    const email = String(this.data.ordEmail || '').trim();
    if (!kbp.isValidEmail(email)) {
      this.setData({ ordEmailErr: '请填写正确的邮箱（例：name@site.com）' });
      return;
    }
    const payload = kbp.buildOrderPayload(this.data.bp, this.data.needText, this.data.ordVersion, email);
    this.setData({ ordBusy: true });
    pay.payKbOrder(payload)
      .then((r) => {
        if (!r.ok) {
          this.setData({ ordBusy: false });
          if (String(r.message || '').indexOf('取消') < 0) {
            wx.showToast({ title: r.message, icon: 'none', duration: 2500 });
          }
          return;
        }
        // 支付成功 → 履约单提交（服务端配套待部署；失败落本地订单箱排队，不丢单）
        kbp.submitOrder(payload).then((r2) => {
          const queuedLocal = !!(r2 && r2.queued_local); // judge-W1修复：本地箱排队须如实告知
          this.setData({ ordBusy: false, ordDone: true, ordDoneEmail: email, ordQueuedLocal: queuedLocal });
          wx.vibrateShort({ type: 'medium', fail: () => {} });
          if (queuedLocal) {
            wx.showToast({ title: '订单已保存，服务开通后自动提交', icon: 'none', duration: 3000 });
          }
        });
      })
      .catch((err) => {
        this.setData({ ordBusy: false });
        wx.showToast({ title: (err && err.message) || '网络波动，请稍后重试', icon: 'none', duration: 2500 });
      });
  },

  onPopState(e) {
    pop.onPopState(this, e);
  },

  noop() {},

  onShareAppMessage() {
    return {
      title: '知识库工厂 · 一句话免费设计你的知识库',
      path: '/pages/kbfactory/kbfactory',
    };
  },
});
