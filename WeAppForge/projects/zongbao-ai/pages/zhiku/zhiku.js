// 智库页 — 总包AI顾问 v0.9.3（用户令 1009：与飞书知识库一级目录同步——四库→六库，新增案例库/研报库；细分市场研究已下线移除）
// 用户令 1008：第三方栏目库里有但不展示（广告/侵权风险）——展示层只列自有分组，包内品牌串归零（科思顿/小鹅通/秘塔等源库镜像一律不列）
// v0.7.4 提审合规基线保留：撤二维码/长按识别/引导外部App文案（运营规范导流红线），只留低姿态复制链接
const theme = require('../../utils/theme');

Page({
  data: {
    nav: { statusBarHeight: 20, navHeight: 44 },
    url: 'https://epctalkk.feishu.cn/wiki/space/7689289338592431383?ccm_open_type=lark_wiki_spaceLink&open_tab_from=wiki_home',
    urlHost: 'epctalkk.feishu.cn/wiki',
    // 六库 49 分组（展示层，第三方栏目与索引链接不列）——图纸目录编号 MK/EN/EX/KN/CA/RB（1009 飞书实测树）
    vaults: [
      {
        g: '市', code: 'MK', h: '市场库', d: '区域市场 · 前瞻 · 研究成果',
        subs: ['区域市场报告', '市场前瞻', '研究成果'],
      },
      {
        g: '企', code: 'EN', h: '企业库', d: '总包同行 · 竞对 · 供应链画像',
        subs: ['总包百强研究', '标杆企业研究', '标杆专访', '企业档案'],
      },
      {
        g: '专', code: 'EX', h: '专家库', d: '行业专家 · 判例 · 实务方法论',
        subs: ['专家百人档案', '专家百人课程包', '大咖课堂', '大咖私房课', '总包大家谈', '总包好声音', '总包讲师'],
      },
      {
        g: '知', code: 'KN', h: '知识库', d: '政策 · 法规 · 课程 · 实务手册',
        subs: ['VIP必修课', 'VIP深造课', 'SVIP私房课', 'VIP案例库', '项目管理知识体系', '项目管理过程',
          '组织能力建设', '国际EPC', 'AI技术与应用', '认知升级课', '探索总包', '工程总承包',
          '公益课程', '论坛峰会', '直播课件', '模板与工具', '政策法规资讯', '综合资料'],
      },
      {
        g: '案', code: 'CA', h: '案例库', d: '实务手册 · 行业指南 · 事故复盘',
        subs: ['《EPC总承包项目经理能力手册》', '《中国企业EPC业务创效30招式》', '《EPC工程总承包项目全周期成本精准管控工作指引》',
          '《工程总承包招投标合规工作指南》', '《核电工程EPC项目管理策划编制指南》', '《水利工程EPC项目管理策划编制指南》',
          '《风电EPC项目管理策划工作指南》', '《DeepSeek在EPC项目中的应用研究》', '《工程人这样用AI：从入门到精通，成为AI时代的超级项目管理者》',
          '《马斯克成大事五步法实践指北》', '《杨房沟水电站EPC实践全景复盘报告》', '《江西丰城电厂三期EPC特大事故沉思录》',
          '《建设项目工程总承包管理规范》GB/T 50358-2017'],
      },
      {
        g: '研', code: 'RB', h: '研报库', d: '电子书 · 论文 · 券商研报 · 年报',
        subs: ['电子书与研究报告', '学术论文', '券商研报精选', '公司公告与年报'],
      },
    ],
    expanded: 0, // 默认展开第一库（点击头部切换，-1=全收起）
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
    // 自绘 tabBar 选中态（v0.9.x 五页签：问=0 锅=1 智=2 研=3 我=4）
    if (typeof this.getTabBar === 'function' && this.getTabBar()) {
      this.getTabBar().setData({ selected: 2 });
    }
  },

  // 六库图纸目录手风琴：逐库展开/收起
  toggleVault(e) {
    const i = e.currentTarget.dataset.i;
    wx.vibrateShort({ type: 'light', fail: () => {} });
    this.setData({ expanded: this.data.expanded === i ? -1 : i });
  },

  // 一键复制链接（唯一出口，低姿态）
  copyUrl() {
    wx.vibrateShort({ type: 'light', fail: () => {} });
    wx.setClipboardData({
      data: this.data.url,
      success: () => {
        wx.showToast({ title: '链接已复制', icon: 'success' });
      },
      fail: () => {
        wx.showToast({ title: '复制失败，请重试', icon: 'none' });
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
