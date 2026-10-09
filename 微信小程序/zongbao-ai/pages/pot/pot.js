// 锅圈页 — 总包AI顾问 v0.7.0（用户十一点令：200 字脱符号预览 + 最新优先兼顾互动排序）
// 锅 = 打破砂锅问到底：EPC 总承包热点难点问题（智库已答），列表显示问题 + 答案前 200 字预览，点开看全文
const api = require('../../utils/api');
const theme = require('../../utils/theme');
const pop = require('../../utils/pop'); // v0.9.7：qw-pop 自绘弹窗（举报入口迁入，按钮文字摆脱 4 字硬限）

// v0.9.5 审计修：列表项导航节流（与 my 页同款防双击压栈）
let _navLastAt = 0;
function navToThrottled(url) {
  const now = Date.now();
  if (now - _navLastAt < 300) return;
  _navLastAt = now;
  wx.navigateTo({ url });
}

Page({
  data: {
    items: [],   // {id, question, preview, likes, liked, full_chars, views, shares, cat}
    cats: [],    // v0.9.10 分类标签（用户令 1009）：[{name, n}]，服务端按规则序返回非空分类
    activeCat: '',   // 当前筛选分类（''=全部）
    loading: true,
    loadError: '',
    nav: { statusBarHeight: 20, navHeight: 44 },
    sheetNo: '',
    popOpen: false,   // v0.9.7 qw-pop 开合镜像（e2e/结构锚 + tabBar 压暗让路）
    popMode: ''
  },

  onLoad() {
    const app = getApp();
    if (app.globalData && app.globalData.nav) {
      this.setData({ nav: app.globalData.nav });
    }
    theme.apply(this); // v0.7.4 首帧即上主题变量（onShow 仍会再刷，不闪白）
    const now = new Date();
    const pad = (n) => (n < 10 ? '0' + n : '' + n);
    this.setData({ sheetNo: 'GC-' + pad(now.getMonth() + 1) + pad(now.getDate()) });
    this.refresh();
  },

  onShow() {
    theme.apply(this);
    // 自绘 tabBar 选中态（v0.9.x 五页签：问=0 锅=1 智=2 研=3 我=4）
    if (typeof this.getTabBar === 'function' && this.getTabBar()) {
      this.getTabBar().setData({ selected: 1 });
    }
    // 从答案页返回（可能点了有用）→ 静默刷新点赞数
    if (!this.data.loading && !this.data.loadError) this.refresh();
  },

  refresh() {
    // v0.9.2（1009 补审计 MEDIUM 修复）：请求序号防竞态 + 已有列表时静默失败不吞内容——
    // 此前 onShow 静默刷新一旦失败会把已渲染的整个列表替换成错误卡；慢的失败响应
    // 还可能覆盖更新的成功响应。现在：仅首载/空列表才进错误态，有内容时失败只轻提示。
    // v0.9.10：带分类筛选（activeCat；服务端分类计数恒为全量，切筛不清 chips）。
    // v0.9.11 审计修：成功落列表时记 _renderedCat；切分类请求失败时回滚 activeCat，
    // 杜绝「chip 亮在新分类、列表还是旧分类内容」的错位态（同分类守卫随之恢复可重试）。
    const seq = (this._seq = (this._seq || 0) + 1);
    api.potList(this.data.activeCat || '')
      .then((d) => {
        if (seq !== this._seq) return; // 过期响应丢弃
        this._renderedCat = this.data.activeCat || '';
        this.setData({ items: d.items || [], cats: d.cats || [], loading: false, loadError: '' });
      })
      .catch((err) => {
        if (seq !== this._seq) return;
        if ((this.data.items || []).length > 0) {
          const patch = { loading: false };
          if ((this._renderedCat || '') !== (this.data.activeCat || '')) {
            patch.activeCat = this._renderedCat || '';   // 高亮回滚到已渲染内容的分类
          }
          this.setData(patch);
          wx.showToast({ title: api.errMsg(err, '刷新失败，稍后自动重试'), icon: 'none' });
          return;
        }
        this.setData({ loading: false, loadError: api.errMsg(err, '加载失败') });
      });
  },

  // v0.9.10 分类标签（用户令 1009）：点 chip 切分类——同分类不重复请求；chips 行常驻
  onCat(e) {
    const cat = e.currentTarget.dataset.cat || '';
    if (cat === (this.data.activeCat || '')) return;
    this.setData({ activeCat: cat });
    this.refresh();
  },

  onItem(e) {
    const id = e.currentTarget.dataset.id;
    // v0.9.5 审计修：接入 my 页同款 300ms 节流——快速双击不再重复压栈 answer 页
    if (id) navToThrottled('/pages/answer/answer?id=' + id);
  },

  onRetry() {
    this.setData({ loading: true, loadError: '' });
    this.refresh();
  },

  // v0.9.7 qw-pop：弹窗开合镜像 + 自绘 tabBar 压暗让路（本页是 tab 页，弹窗期间 tab 压暗不可误触）
  onPopState(e) {
    pop.onPopState(this, e);
  },

  // v0.7.4 提审合规：锅圈 UGC 内容举报入口（catchtap 防冒泡进详情）
  onReport(e) {
    const id = e.currentTarget.dataset.id;
    if (!id) return; // v0.9.2：删僵尸变量 q（data-q 取值后从未使用）
    // v0.9.7：qw-pop 自绘弹窗——maskClosable:false（合规须显式二选一），按钮文字摆脱 4 字硬限
    pop.modal(this, {
      kicker: '举报 · REPORT',
      title: '举报内容',
      editable: true,
      placeholder: '请简要描述举报原因（如含不当内容）',
      confirmText: '提交举报',
      cancelText: '再想想',
      maskClosable: false
    }).then((r) => {
      if (!r.confirm) return;
      const reason = (r.content || '').trim();
      if (!reason) {
        wx.showToast({ title: '请填写举报原因', icon: 'none' });
        return;
      }
      api.potReport(id, reason)
        .then(() => wx.showToast({ title: '已收到举报', icon: 'success' }))
        .catch((err) => wx.showToast({ title: api.errMsg(err, '提交失败'), icon: 'none' }));
    });
  }
});
