// 智库页 — 总包AI顾问 v0.8.0（用户令 1008：同步 F:\ZBZK 四库大幅升级——34 分组全树 + 诚实库存）
// v0.7.4 提审合规改版：撤二维码/长按识别/引导外部App文案（运营规范导流红线），只留低姿态复制链接
const theme = require('../../utils/theme');

Page({
  data: {
    nav: { statusBarHeight: 20, navHeight: 44 },
    url: 'https://epctalkk.feishu.cn/wiki/space/7689289338592431383?ccm_open_type=lark_wiki_spaceLink&open_tab_from=wiki_home',
    urlHost: 'epctalkk.feishu.cn/wiki',
    // 四库 34 分组（与 F:\ZBZK 飞书智库实际目录一一对应，2026-10-08）
    vaults: [
      {
        g: '市', h: '市场库', d: '区域市场 · 业主 · 项目动态',
        subs: ['区域市场报告', '细分市场研究', '市场前瞻', '研究成果', '科思顿·工程行业月度观察'],
      },
      {
        g: '企', h: '企业库', d: '总包同行 · 竞对 · 供应链画像',
        subs: ['总包百强研究', '标杆企业研究', '标杆专访', '企业档案'],
      },
      {
        g: '专', h: '专家库', d: '行业专家 · 判例 · 实务方法论',
        subs: ['专家百人档案', '专家百人课程包', '大咖课堂', '大咖私房课', '总包大家谈', '总包好声音', '总包讲师'],
      },
      {
        g: '知', h: '知识库', d: '政策 · 法规 · 课程 · 实务手册',
        subs: ['VIP必修课', 'VIP深造课', 'SVIP私房课', 'VIP案例库', '项目管理知识体系', '项目管理过程',
          '组织能力建设', '国际EPC', 'AI技术与应用', '认知升级课', '探索总包', '工程总承包',
          '公益课程', '论坛峰会', '直播课件', '模板与工具', '政策法规资讯', '综合资料'],
      },
    ],
    // 诚实库存（可证成口径，来源=迁移工程 PROGRESS.json 盘点：持续入库中，不吹全量）
    stats: [
      { n: '1855', l: '知识条目' },
      { n: '847', l: '电子书' },
      { n: '906', l: '视频·直播' },
      { n: '620', l: '图文专栏' },
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
      title: '总包智库 · 建筑工程知识地图',
      path: '/pages/zhiku/zhiku',
    };
  },
});
