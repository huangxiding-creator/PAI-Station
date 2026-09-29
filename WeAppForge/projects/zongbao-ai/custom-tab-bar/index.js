// 自绘 tabBar — v0.5.0 蓝图设计：图框字标三 tab（问/锅/我），激活=安全橙填充
// 锅圈=打破砂锅问到底（居中位置，公共热点问题展区）
Component({
  data: {
    selected: 0,
    list: [
      { i: 0, path: '/pages/ask/ask', glyph: '问', text: '咨询' },
      { i: 1, path: '/pages/pot/pot', glyph: '锅', text: '锅圈' },
      { i: 2, path: '/pages/my/my', glyph: '我', text: '我的' }
    ]
  },
  methods: {
    switchTo(e) {
      const i = Number(e.currentTarget.dataset.i || 0);
      const item = this.data.list[i];
      if (!item) return;
      wx.switchTab({ url: item.path });
    }
  }
});
