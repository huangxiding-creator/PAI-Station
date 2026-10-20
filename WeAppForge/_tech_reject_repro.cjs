// 1.3.2 驳回复现：打开提审真身(work/zongbao_trial)，看审核员看到的首页
const automator = require('miniprogram-automator');
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
  const mini = await automator.connect({ wsEndpoint: 'ws://localhost:9421' });
  console.log('[1] connected');
  const page = await mini.reLaunch('/pages/index/index');
  await sleep(6000);
  const d = await page.data();
  console.log('[2] items:', (d.items||[]).length, '| facets:', (d.facets&&d.facets.provinces||[]).length,
              '| netDown:', d.netDown, '| total:', d.total, '| loading:', d.loading);
  await mini.screenshot({ path: 'E:/AI-Station/WeAppForge/_tech_index_reviewer_view.png' });
  // 数一下实际渲染的卡片节点
  const cards = await page.$$('.report-card, .card');
  console.log('[3] rendered card nodes:', cards.length);
  const el = await page.$('report-item, .report-card');
  console.log('[4] first card exists:', !!el);
  await mini.disconnect(); process.exit(0);
})().catch((e) => { console.error('ERR', e.message); process.exit(1); });
