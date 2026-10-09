// 自绘 tabBar — v0.7.2 蓝图设计：图框字标五 tab（问/锅/智/研/我），激活=安全橙填充
// 锅圈=打破砂锅问到底（热点问题展区）；智库=飞书知识库入口（四库全通）；
// 研究=研究报告商城（v0.9.0 用户令 1008：售卖整合进 AI顾问，倒数第二位）
// v0.7.3 周换装：根节点内联注入主题 CSS 变量（页面 onShow 经 theme.apply 触发刷新）
const theme = require('../utils/theme');

Component({
  data: {
    selected: 0,
    themeStyle: '',
    list: [
      { i: 0, path: '/pages/ask/ask', glyph: '问', text: '咨询' },
      { i: 1, path: '/pages/pot/pot', glyph: '锅', text: '锅圈' },
      { i: 2, path: '/pages/zhiku/zhiku', glyph: '智', text: '智库' },
      { i: 3, path: '/pages/research/research', glyph: '研', text: '研究' },
      { i: 4, path: '/pages/my/my', glyph: '我', text: '我的' }
    ]
  },
  lifetimes: {
    attached() { this.applyTheme(); }
  },
  methods: {
    applyTheme() {
      // v0.9.2 深色感知：与 theme.apply 同源取 effective()，系统深色时与页面同走 obsidian
      this.setData({ themeStyle: theme.styleStr(theme.effective()) });
    },
    switchTo(e) {
      const i = Number(e.currentTarget.dataset.i || 0);
      const item = this.data.list[i];
      if (!item) return;
      wx.switchTab({ url: item.path, fail() { /* 防 fail 未处理 rejection */ } });
    }
  }
});
