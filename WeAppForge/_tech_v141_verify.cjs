// v1.4.1 验证：原设计首页（商城列表）是否渲染 38 份报告（审核员视角）
const automator = require('miniprogram-automator');
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
  const mini = await automator.connect({ wsEndpoint: 'ws://localhost:9421' });
  const page = await mini.reLaunch('/pages/index/index');
  await sleep(6000);
  const r = await mini.evaluate(() => {
    const ps = getCurrentPages();
    const p = ps[ps.length - 1];
    const d = (p && p.data) || {};
    return { route: p && p.route, items: (d.items || []).length, netDown: d.netDown,
             tab: d.tab, provinces: d.facets && d.facets.provinces ? d.facets.provinces.length : 0 };
  });
  console.log('[index]', JSON.stringify(r));
  await mini.screenshot({ path: 'E:/AI-Station/WeAppForge/_tech_v141_index.png' });
  // detail 页（阅读入口已断）
  const p2 = await mini.navigateTo('/pages/detail/detail?id=js-shuiwang-2026');
  await sleep(4000);
  const r2 = await mini.evaluate(() => {
    const ps = getCurrentPages();
    const p = ps[ps.length - 1];
    const d = (p && p.data) || {};
    return { route: p && p.route, hasView: !!d.view, title: d.view && d.view.card && d.view.card.title };
  });
  console.log('[detail]', JSON.stringify(r2));
  await mini.screenshot({ path: 'E:/AI-Station/WeAppForge/_tech_v141_detail.png' });
  await mini.disconnect(); process.exit(0);
})().catch((e) => { console.error('ERR', e.message); process.exit(1); });
