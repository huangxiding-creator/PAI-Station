// 知识库工厂页 — KB-FACTORY W4 v1 + W6 支付/导出/整库下单
// 链路：输入(文字/语音+深度三档) → utils/kbfactory_service.generate（v1 本地真样本+八阶段模拟，M6 接后端）
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

// 蓝图深度三档（轨A4）：key 上送云函数透传引擎；名称/说明=用户语言（零技术词）。
// 展示档位一律以蓝图自带的 provenance.depth 为准（本地兜底样本=标准版，如实标注）
const DEPTH_NAMES = { standard: '标准版', pro: '专业版', flagship: '旗舰版' };

Page({
  data: {
    nav: { statusBarHeight: 20, navHeight: 44 },
    needText: '',
    depth: 'standard', // 蓝图深度档：standard（默认）| pro | flagship
    recording: false,
    building: false,
    built: false,
    stages: [],   // 八阶段施工直播
    bp: null,     // 蓝图样本（service 层视图）
    tree: [],     // 三级树渲染模型（open 折叠态；主题视图=既有渲染零漂移）
    viewTab: 'by_topic', // 蓝图树视图档：by_topic（主题，默认）| by_phase（阶段）| by_type（类型）
    viewGroups: [],      // 阶段/类型视图平铺组渲染模型（单层列表，复用文件行样式）
    valueBadges: [],     // 价值徽标行计数（真实文件/文件总数/GB/来源全实测禁手填；真调研蓝图在场时第五计数「真实调研 N 件」）
    ratioSegs: [],  // 配比条渲染模型：v1 三段(core/field/guide)｜v2 按超越层名 N 段
    depthBadge: '', // 蓝图档位徽标（如「专业版 · 文件 87 项」，取自蓝图真值非选择态）
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

  // ── 蓝图深度三档点选（默认标准版；施工中不许换档）──
  onDepthPick(e) {
    const key = e.currentTarget.dataset.d;
    if (this.data.building || key === this.data.depth || !DEPTH_NAMES[key]) return;
    wx.vibrateShort({ type: 'light', fail: () => {} });
    this.setData({ depth: key });
  },

  // ── 免费设计主按钮 ──
  onGenerate() {
    const t = String(this.data.needText || '').trim();
    if (!t) {
      wx.showToast({ title: '先说一句你要的知识库', icon: 'none' });
      return;
    }
    if (this.data.building) return;
    this._viewsCache = null; // 三视图缓存随新蓝图失效（旧投影不得串新图）
    this.setData({
      building: true, built: false, bp: null, tree: [], ratioSegs: [], depthBadge: '', mdPrice: '',
      viewTab: 'by_topic', viewGroups: [], valueBadges: [],
      stages: kbf.STAGES.map((s) => ({ name: s.name, line: s.line, count: '', state: '' })),
    });
    kbf.generate(t, (st) => {
      if (this._dead) return;
      if (st && st.reset) { // 施工直播换轨（真调研三段 ↔ 演示八阶段；回落腿如实换骨架）
        this.setData({
          stages: st.reset.map((s) => ({ name: s.name, line: s.line, count: '', state: '' })),
        });
        return;
      }
      const patch = { ['stages[' + st.i + '].state']: st.state };
      if (st.count !== undefined) patch['stages[' + st.i + '].count'] = st.count;
      this.setData(patch);
    }, this.data.depth).then((bp) => {
      if (this._dead) return;
      this.setData({
        building: false, built: true, bp: bp,
        tree: this._buildTree(bp),
        ratioSegs: this._buildRatioSegs(bp),
        depthBadge: this._depthBadge(bp),
        mdPrice: this._round1(bp.quote.total * bp.quote.md_factor),
        valueBadges: this._buildValueBadges(bp),
        sampleNote: (bp._sample && bp._sample.note) || '',
      });
      wx.vibrateShort({ type: 'light', fail: () => {} });
    }).catch((err) => {
      if (this._dead) return;
      this.setData({ building: false, genErr: (err && err.message) || '生成失败' });  // 调试字段(e2e取证用)
      wx.showToast({ title: (err && err.message) || '生成失败，请重试', icon: 'none' });
    });
  },

  // 档位徽标：以蓝图自带 provenance.depth 为准（无标记=标准版，含本地兜底样本），
  // 文件数取蓝图统计真值 —— 档位与规模都如实可见
  _depthBadge(bp) {
    const key = (bp && bp.provenance && bp.provenance.depth) || 'standard';
    const name = DEPTH_NAMES[key] || DEPTH_NAMES.standard;
    const files = (bp && bp.stats && bp.stats.files) || 0;
    return name + ' · 文件 ' + files + ' 项';
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

  // 价值徽标行四计数（全部实测禁手填）：真实文件=树内 real:true 逐一计数；
  // 文件总数/GB=stats 真值；来源=渠道徽章种类数（badge 优先，v1 槽 src 回退）；
  // 分拆组拍平同口径（files 优先，与三视图投影一致）
  // A 案追加：蓝图带 provenance.evidence_tree 时加第五计数「真实调研 N 件」
  // （N=pool_size 真值；无此键=非真调研蓝图，不追加不编造）
  _buildValueBadges(bp) {
    let real = 0;
    const srcMap = {};
    ((((bp || {}).tree || {}).l1) || []).forEach((l1) => ((l1 && l1.l2) || []).forEach((l2) => {
      let slots = (l2.files && l2.files.length) ? l2.files : [];
      if (!slots.length) {
        slots = [];
        ((l2.split_dirs || []).forEach((sd) => ((sd && sd.files) || []).forEach((f) => slots.push(f))));
      }
      slots.forEach((f) => {
        if (!f || typeof f !== 'object') return;
        if (f.real === true) real++;
        const s = f.badge || f.src;
        if (s) srcMap[s] = true;
      });
    }));
    const st = (bp && bp.stats) || {};
    const badges = [
      { n: real, l: '真实文件' },
      { n: st.files || 0, l: '文件总数' },
      { n: st.gb || 0, l: 'GB' },
      { n: Object.keys(srcMap).length, l: '来源' },
    ];
    // 真调研件数（如实）：provenance.evidence_tree.pool_size 真值（A 案真调研服务腿的
    // 服务端记账）；键不在场或值非正数=不追加（禁手填禁编造）
    const evTree = ((bp && bp.provenance) || {}).evidence_tree;
    if (evTree && typeof evTree === 'object'
      && typeof evTree.pool_size === 'number' && evTree.pool_size > 0) {
      badges.push({ n: evTree.pool_size, l: '真实调研(件)' });
    }
    return badges;
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

  // ── 收口波A·三视图 tab（主题=既有三级树零漂移；阶段/类型=平铺组单层列表）──
  // 数据源=service 层 buildViews(bp)（引擎 views.py 的 JS 直译：组名 verbatim
  // 全名、「待归类」恒排尾、引用守恒）；按蓝图惰性算一次，切 tab 只换渲染模型
  onViewTabPick(e) {
    const key = e.currentTarget.dataset.v;
    if (key !== 'by_topic' && key !== 'by_phase' && key !== 'by_type') return;
    if (key === this.data.viewTab) return;
    wx.vibrateShort({ type: 'light', fail: () => {} });
    if (key === 'by_topic') { // 切回主题：树区复原既有三级树
      this.setData({ viewTab: key, viewGroups: [] });
      return;
    }
    if (!this._viewsCache) this._viewsCache = kbf.buildViews(this.data.bp || {});
    const v = this._viewsCache[key] || {};
    const groups = ((v.groups && v.groups.length) ? v.groups : []).map((g, i) => ({
      name: g.name,
      open: i === 0, // 首组默认展开，其余按需点开
      files: (g.files || []).map((r) => ({
        ref: r.ref,
        name: r.name,
        fmt: (r.meta && r.meta.fmt) || '',
        line: [r.meta && r.meta.tier, r.meta && r.meta.clc_no, r.meta && r.meta.group]
          .filter(Boolean).join(' · '), // 元数据标注一行（缺键如实省略不编造）
      })),
    }));
    this.setData({ viewTab: key, viewGroups: groups });
  },

  toggleViewGroup(e) {
    const i = e.currentTarget.dataset.i;
    if (!this.data.viewGroups[i]) return;
    wx.vibrateShort({ type: 'light', fail: () => {} });
    this.setData({ ['viewGroups[' + i + '].open']: !this.data.viewGroups[i].open });
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
      wx.showModal({ title: '暂不支持', content: 'iOS 暂不支持应用内购买，请在安卓设备完成解锁', showCancel: false });
      return;
    }
    if (!this.data.bp || this.data.exporting) return;
    const payload = kbp.buildExportPayload(this.data.bp, this.data.needText);
    console.log('[kbf-export] payload:', JSON.stringify(payload).slice(0, 120));
    this.setData({ exporting: true });
    pop.loading(this, '解锁导出中');
    pay.payBlueprintExport(payload)
      .then((r) => {
        console.log('[kbf-export] result:', JSON.stringify({ok: r.ok, msg: (r.message||'').slice(0,60), already: !!r.already}));
        if (!r.ok) {
          this.setData({ exporting: false });
          pop.hideLoading(this);
          if (String(r.message || '').indexOf('取消') < 0) {
            wx.showModal({ title: '解锁未完成', content: r.message || '支付未完成，请重试', showCancel: false });
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

  // ── 收口波A·生成预览站点（免费入口不挂付费门；服务端生成件未就绪=如实提示，
  // 不造假不崩溃；端点契约见 service 层 PREVIEW_ENDPOINT 注释） ──
  onPreviewSite() {
    wx.vibrateShort({ type: 'light', fail: () => {} });
    if (!this.data.bp) return;
    kbf.previewSite(this.data.bp)
      .then((r) => { // 端点部署后：预览站地址复制到剪贴板直达
        if (r && r.url) {
          wx.setClipboardData({ data: String(r.url), fail: () => {} });
          wx.showToast({ title: '预览链接已复制', icon: 'none', duration: 2500 });
        }
      })
      .catch((err) => {
        wx.showToast({ title: (err && err.message) || '即将上线', icon: 'none', duration: 2500 });
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
    console.log('[kbf-order] payload:', JSON.stringify(payload).slice(0, 120));
    this.setData({ ordBusy: true });
    pay.payKbOrder(payload)
      .then((r) => {
        console.log('[kbf-order] result:', JSON.stringify({ok: r.ok, msg: (r.message||'').slice(0,60)}));
        if (!r.ok) {
          this.setData({ ordBusy: false });
          if (String(r.message || '').indexOf('取消') < 0) {
            wx.showModal({ title: '购买未完成', content: r.message || '支付未完成，请重试', showCancel: false });
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
        console.error('[kbf-order] catch:', err);
        wx.showModal({ title: '网络波动', content: (err && err.message) || '网络波动，请稍后重试', showCancel: false });
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
