// 发票申请页 — 总包AI顾问 v0.9.4（用户令 1009：累计消费满 ¥200 可申请增值税专用发票；
// 收票邮箱必填；申请单企业微信实时推送运营）
const api = require('../../utils/api');
const theme = require('../../utils/theme');

const FIELDS = ['title', 'taxNo', 'addrPhone', 'bankAcct', 'email', 'note'];
const EMPTY = { title: '', taxNo: '', addrPhone: '', bankAcct: '', email: '', note: '' };

Page({
  data: {
    nav: { statusBarHeight: 20, navHeight: 44 },
    loading: true,
    loadError: '',
    totalYuan: '0.00',
    gapYuan: '',
    canApply: false,          // 门槛已到 且 无 pending
    pending: null,            // 处理中的申请（有则展示状态卡，不再收新单）
    ...EMPTY,
    submitting: false,
  },

  onLoad() {
    const app = getApp();
    if (app.globalData && app.globalData.nav) {
      this.setData({ nav: app.globalData.nav });
    }
    theme.apply(this); // 首帧即上主题变量（onShow 仍会再刷，不闪白）
  },

  onShow() {
    theme.apply(this);
    this.load();
  },

  load() {
    this.setData({ loading: true, loadError: '' });
    api.invoiceStatus()
      .then((d) => {
        const pending = (d.applications || []).find((a) => a.status === 'pending') || null;
        const total = d.total_fen || 0;
        const gap = Math.max(0, (d.threshold_fen || 20000) - total);
        this.setData({
          loading: false,
          totalYuan: (total / 100).toFixed(2),
          gapYuan: (gap / 100).toFixed(2),
          canApply: !!d.can_apply,
          pending,
        });
      })
      .catch((err) => {
        this.setData({ loading: false, loadError: api.errMsg(err, '发票信息加载失败') });
      });
  },

  onRetry() {
    this.load();
  },

  onField(e) {
    const f = e.currentTarget.dataset.f;
    if (FIELDS.indexOf(f) < 0) return;
    this.setData({ [f]: e.detail.value });
  },

  goBack() {
    const pages = getCurrentPages();
    if (pages.length > 1) {
      wx.navigateBack();
    } else {
      wx.switchTab({ url: '/pages/my/my' });
    }
  },

  // 本地预校验（与服务端同源规则；通过才发请求——省一次往返）
  _validate() {
    const d = this.data;
    if (!d.title.trim() || d.title.trim().length < 2) return '请填写发票抬头（单位全称）';
    if (!/^[0-9A-Za-z]{15,20}$/.test(d.taxNo.trim())) return '纳税人识别号须为 15-20 位数字或字母';
    if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(d.email.trim())) return '请填写正确的收票邮箱（必填）';
    return '';
  },

  onSubmit() {
    if (this.data.submitting) return;
    const msg = this._validate();
    if (msg) {
      wx.showToast({ title: msg, icon: 'none' });
      return;
    }
    const d = this.data;
    this.setData({ submitting: true });
    api.invoiceApply({
      title: d.title.trim(),
      tax_no: d.taxNo.trim(),
      email: d.email.trim(),
      addr_phone: d.addrPhone.trim(),
      bank_acct: d.bankAcct.trim(),
      note: d.note.trim(),
    })
      .then(() => {
        this.setData({ submitting: false });
        wx.showModal({
          title: '申请已提交',
          content: '发票申请已收到，开票后将发送至您的收票邮箱 ' + d.email.trim() + '。可在本页随时查看处理进度。',
          showCancel: false,
          confirmText: '好的',
          success: () => this.load(),
        });
      })
      .catch((err) => {
        this.setData({ submitting: false });
        // 403/409 服务端有明确口径，直接展示；其余走统一文案
        wx.showModal({
          title: '没提交成功',
          content: api.errMsg(err, '网络波动，请稍后重试'),
          showCancel: false,
          confirmText: '知道了',
        });
      });
  },
});
