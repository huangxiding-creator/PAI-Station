const automator = require('miniprogram-automator');
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
  const mini = await automator.connect({ wsEndpoint: 'ws://localhost:9421' });
  await mini.reLaunch('/pages/index/index').catch(e => console.log('reLaunch:', e.message.slice(0,60)));
  await sleep(6000);
  await mini.screenshot({ path: 'E:/AI-Station/WeAppForge/_tech_v140_index.png' });
  console.log('[shot1] index saved');
  // evaluate 取页面数据（绕过节点绑定）
  const r = await mini.evaluate(() => {
    const pages = getCurrentPages();
    const p = pages[pages.length - 1];
    return { route: p && p.route, featured: p && p.data && p.data.featured ? p.data.featured.length : -1,
             keys: p && p.data ? Object.keys(p.data) : [] };
  });
  console.log('[eval]', JSON.stringify(r).slice(0, 250));
  await mini.disconnect(); process.exit(0);
})().catch((e) => { console.error('FATAL', e.message); process.exit(1); });
