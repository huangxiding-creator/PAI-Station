// v1.4.0 展示厅验证：首页渲染(featured 6卡) + 全目录页 + me页 + 截图
const automator = require('miniprogram-automator');
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
  const mini = await automator.connect({ wsEndpoint: 'ws://localhost:9421' });
  console.log('[1] connected');
  const page = await mini.reLaunch('/pages/index/index');
  await sleep(5000);
  const d = await page.data();
  console.log('[2] featured:', (d.featured||[]).length);
  const cards = await page.$$('.prod');
  const svcs = await page.$$('.svc');
  console.log('[3] DOM: prod cards =', cards.length, '| svc cards =', svcs.length);
  await mini.screenshot({ path: 'E:/AI-Station/WeAppForge/_tech_v140_index.png' });
  // 全目录页
  const p2 = await mini.navigateTo('/pages/detail/detail?cat=all');
  await sleep(3000);
  const d2 = await p2.data();
  const rows = await p2.$$('.prod');
  console.log('[4] all-catalog: reports =', (d2.reports||[]).length, '| DOM rows =', rows.length);
  await mini.screenshot({ path: 'E:/AI-Station/WeAppForge/_tech_v140_catalog.png' });
  await mini.navigateBack();
  // me 页
  const p3 = await mini.switchTab('/pages/me/me');
  await sleep(2000);
  await mini.screenshot({ path: 'E:/AI-Station/WeAppForge/_tech_v140_me.png' });
  console.log('[5] me page ok');
  await mini.disconnect(); process.exit(0);
})().catch((e) => { console.error('ERR', e.message); process.exit(1); });
