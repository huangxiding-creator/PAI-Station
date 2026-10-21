// 知识库工厂页 — KB-FACTORY W4 v1（一句话 → 编目引擎蓝图 → 树/仪表盘/报价卡/施工直播）
// 链路：输入(文字/语音) → utils/kbfactory_service.generate（v1 本地真样本+八阶段模拟，M6 接后端）
// → 蓝图渲染（三级树折叠 · 配比三段条 · 动态报价）→ 导出/海报为占位弹窗（M5 接支付链路）。
const theme = require('../../utils/theme');
const kbf = require('../../utils/kbfactory_service');
const pop = require('../../utils/pop');

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
    mdPrice: '',  // Markdown 版价（×1.5，实测计算非手填）
    sampleNote: '', // 样本截断注明（演示数据与全量真值的边界，如实展示）
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
      building: true, built: false, bp: null, tree: [], mdPrice: '',
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
        mdPrice: this._round1(bp.quote.total * bp.quote.md_factor),
        sampleNote: (bp._sample && bp._sample.note) || '',
      });
      wx.vibrateShort({ type: 'light', fail: () => {} });
    }).catch((err) => {
      if (this._dead) return;
      this.setData({ building: false });
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

  // ── 导出/海报：占位弹窗（M5 接支付链路后替换为真链路） ──
  onExport() {
    wx.vibrateShort({ type: 'light', fail: () => {} });
    pop.modal(this, {
      kicker: 'EXPORT · 导出蓝图',
      title: '支付链路对接中',
      content: '蓝图导出（¥0.1）支付链路对接中，M5 接通后即可带走。',
      confirmText: '好的',
      showCancel: false,
    }).catch(() => {});
  },

  onPoster() {
    wx.vibrateShort({ type: 'light', fail: () => {} });
    pop.modal(this, {
      kicker: 'POSTER · 分享海报',
      title: '分享海报施工中',
      content: '海报生成链路对接中，M5 接通后一键生成。',
      confirmText: '好的',
      showCancel: false,
    }).catch(() => {});
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
