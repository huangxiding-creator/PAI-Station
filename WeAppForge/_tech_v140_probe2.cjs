const automator = require('miniprogram-automator');
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
  const mini = await automator.connect({ wsEndpoint: 'ws://localhost:9421' });
  // 老页面(agreement 未动)能否渲染？
  try {
    const p = await mini.navigateTo('/pages/agreement/agreement');
    await sleep(2500);
    const d = await p.data();
    console.log('agreement OK, keys:', Object.keys(d).slice(0, 6));
    await mini.navigateBack();
  } catch (e) { console.log('agreement ERR:', e.message.slice(0, 80)); }
  // 新 index 直接 evaluate
  try {
    const r = await mini.evaluate(() => {
      const pages = getCurrentPages();
      const p = pages[pages.length - 1];
      return { path: p && p.route, data: p && p.data && Object.keys(p.data) };
    });
    console.log('evaluate:', JSON.stringify(r).slice(0, 200));
  } catch (e) { console.log('evaluate ERR:', e.message.slice(0, 120)); }
  await mini.disconnect(); process.exit(0);
})().catch((e) => { console.error('FATAL', e.message); process.exit(1); });
