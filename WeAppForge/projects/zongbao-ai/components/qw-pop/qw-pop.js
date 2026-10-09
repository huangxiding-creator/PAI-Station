// qw-pop — 自绘弹窗系统 v0.9.7（1009 用户令：全站弹窗与品牌设计语言同源重做）
// 设计语言=工程图纸 × 瑞士制图（与 cite-pop/海报同源）：
//   遮罩 rgba(--t-deep-rgb,0.72) 随七套主题染色；弹体=纸面高光面 + 2rpx 纸边 +
//   6rpx 安全橙顶条（cite-pop 既有签名）；CTA=橙三段渐变+最深藏青字（.btn-primary DNA）。
// 三模式：modal（签认单）/ sheet（底部图纸盘）/ load（制图加载）。
// 按钮文字不再受原生 showModal 4 字符真机硬限（v0.9.6 根因战的彻底解）。
// 颜色一律 var(--t-*)（theme.js 46 变量经 page-meta 注入，CSS 自定义属性
// 可继承穿透组件边界——与 Vant 同机制）；写死色即断主题。
Component({
  data: {
    show: false,
    leaving: false,   // 退场动画进行中（200ms 后硬卸载）
    mode: '',         // '' | 'modal' | 'sheet' | 'load'
    // modal
    kicker: '',
    title: '',
    content: '',
    selectable: false,
    editable: false,
    placeholder: '',
    inputVal: '',
    confirmText: '确定',
    cancelText: '取消',
    showCancel: true,
    maskClosable: true,
    // sheet
    items: [],
    badge: '',
    // load
    loadText: '处理中…',
  },

  lifetimes: {
    // v0.9.9 评审修：退场动画 210ms 内页面卸载会对已 detach 组件 setData（真机报错噪音）——detached 一并清掉
    detached() {
      if (this._closeTimer) { clearTimeout(this._closeTimer); this._closeTimer = null; }
    },
  },

  methods: {
    noop() { /* catchtouchmove 占位：锁滚动穿透 */ },

    _emit(open, mode) {
      this.triggerEvent('popstate', { open: !!open, mode: open ? (mode || this.data.mode) : '' });
    },

    _open(patch) {
      if (this._closeTimer) { clearTimeout(this._closeTimer); this._closeTimer = null; }
      this.setData(Object.assign({ show: true, leaving: false }, patch));
      this._emit(true, patch.mode);
    },

    // 签认单（wx.showModal 替代）：resolve({confirm, cancel, content})
    modal(o) {
      o = o || {};
      return new Promise((resolve) => {
        // v0.9.9 评审修：弹窗已开时再开（双击可达）→ 旧 Promise 先收口，不再悬挂
        if (this._resolve) { const prev = this._resolve; this._resolve = null; prev({ confirm: false, cancel: true, content: '' }); }
        this._resolve = resolve;
        this._open({
          mode: 'modal',
          kicker: o.kicker || '告知 · NOTICE',
          title: o.title || '',
          content: o.content || '',
          selectable: !!o.selectable,
          editable: !!o.editable,
          placeholder: o.placeholder || '',
          inputVal: '',
          confirmText: o.confirmText || '确定',
          cancelText: o.cancelText || '取消',
          showCancel: o.showCancel !== false,
          maskClosable: o.maskClosable !== false,
        });
      });
    },

    // 底部图纸盘（wx.showActionSheet 替代）：resolve(下标；取消/遮罩=-1)
    sheet(o) {
      o = o || {};
      return new Promise((resolve) => {
        // v0.9.9 评审修：同 modal——旧 sheet Promise 先收口（取消语义 -1）
        if (this._resolve) { const prev = this._resolve; this._resolve = null; prev(-1); }
        this._resolve = resolve;
        this._open({
          mode: 'sheet',
          kicker: o.kicker || '请选择 · SELECT',
          badge: o.badge || '',
          items: (o.items || []).map((it, i) => ({
            idx: i, t: it.t || '', sub: it.sub || '', ext: it.ext || '',
          })),
          maskClosable: true,
        });
      });
    },

    // 制图加载（wx.showLoading 替代；可反复改文案，同 mode 不重播动画）
    loading(text) {
      const t = text || '处理中…';
      if (this.data.show && this.data.mode === 'load' && !this.data.leaving) {
        this.setData({ loadText: t });
        return;
      }
      this._open({ mode: 'load', loadText: t });
    },

    hideLoading() {
      if (this.data.show && this.data.mode === 'load' && !this.data.leaving) this._shut();
    },

    _shut() {
      this.setData({ show: false, leaving: false });
      this._emit(false);
    },

    // 带退场动画收口（modal/sheet）；loading 即时收（对齐原生）
    _leave(done) {
      if (this.data.leaving) return;
      this.setData({ leaving: true });
      this._closeTimer = setTimeout(() => {
        this._closeTimer = null;
        this._shut();
        if (done) done();
      }, 210);
    },

    onMaskTap() {
      if (this.data.mode === 'modal' && !this.data.maskClosable) return;
      this.onCancel();
    },

    onCancel() {
      const mode = this.data.mode;
      if (mode === 'modal') {
        this._leave(() => { if (this._resolve) this._resolve({ confirm: false, cancel: true, content: this.data.inputVal }); this._resolve = null; });
      } else if (mode === 'sheet') {
        this._leave(() => { if (this._resolve) this._resolve(-1); this._resolve = null; });
      }
    },

    onConfirm() {
      if (this.data.leaving) return;
      const payload = { confirm: true, cancel: false, content: this.data.inputVal };
      this._leave(() => { if (this._resolve) this._resolve(payload); this._resolve = null; });
    },

    onItem(e) {
      if (this.data.leaving) return;
      const i = e.currentTarget.dataset.i;
      this._leave(() => { if (this._resolve) this._resolve(i); this._resolve = null; });
    },

    onInput(e) {
      this.setData({ inputVal: e.detail.value || '' });
    },
  },
});
