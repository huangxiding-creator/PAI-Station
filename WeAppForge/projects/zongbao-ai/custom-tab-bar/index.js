// 自绘 tabBar — v0.7.2 蓝图设计：图框字标四 tab（问/锅/智/我），激活=安全橙填充
// 锅圈=打破砂锅问到底（热点问题展区）；智库=飞书知识库入口（四库全通）
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
      { i: 3, path: '/pages/my/my', glyph: '我', text: '我的' }
    ]
  },
  lifetimes: {
    attached() { this.applyTheme(); }
  },
  methods: {
    applyTheme() {
      this.setData({ themeStyle: theme.styleStr(theme.current()) });
    },
    switchTo(e) {
      const i = Number(e.currentTarget.dataset.i || 0);
      const item = this.data.list[i];
      if (!item) return;
      wx.switchTab({ url: item.path });
    }
  }
});
