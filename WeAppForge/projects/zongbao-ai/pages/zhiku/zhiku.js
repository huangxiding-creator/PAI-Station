// 智库页 — 总包AI顾问 v0.7.2（用户令：底部加「智库」栏，链到「总包智库」知识库）
// v0.7.4 提审合规改版：撤二维码/长按识别/引导外部App文案（运营规范导流红线），只留低姿态复制链接
const theme = require('../../utils/theme');

Page({
  data: {
    nav: { statusBarHeight: 20, navHeight: 44 },
    url: 'https://epctalkk.feishu.cn/wiki/space/7689289338592431383?ccm_open_type=lark_wiki_spaceLink&open_tab_from=wiki_home',
    urlHost: 'epctalkk.feishu.cn/wiki',
    vaults: [
      { g: '市', h: '市场库', d: '区域市场 · 业主 · 项目动态' },
      { g: '企', h: '企业库', d: '总包同行 · 竞对 · 供应链画像' },
      { g: '专', h: '专家库', d: '行业专家 · 判例 · 实务方法论' },
      { g: '知', h: '知识库', d: '政策 · 法规 · 课程 · 实务手册' },
    ],
  },

  onLoad() {
    const app = getApp();
    if (app.globalData && app.globalData.nav) {
      this.setData({ nav: app.globalData.nav });
    }
    theme.apply(this); // v0.7.4 首帧即上主题变量（onShow 仍会再刷，不闪白）
  },

  onShow() {
    theme.apply(this);
    // 自绘 tabBar 选中态（v0.7.2 四页签：问=0 锅=1 智=2 我=3）
    if (typeof this.getTabBar === 'function' && this.getTabBar()) {
      this.getTabBar().setData({ selected: 2 });
    }
  },

  // 一键复制链接（唯一出口，低姿态）
  copyUrl() {
    wx.setClipboardData({
      data: this.data.url,
      success: () => {
        wx.showToast({ title: '链接已复制', icon: 'success' });
      },
    });
  },

  onShareAppMessage() {
    return {
      title: '总包智库 · 四库全通的知识资产',
      path: '/pages/zhiku/zhiku',
    };
  },
});
