const automator = require('miniprogram-automator');
(async () => {
  const mp = await automator.connect({ wsEndpoint: 'ws://127.0.0.1:9420' });
  const page = await mp.switchTab('/pages/zhiku/zhiku');
  await new Promise((r) => setTimeout(r, 2500));
  for (const sel of ['.kbf-entry', '.kbf-e-kicker', '.zk-kicker', '.zk-v', '.zk-tl']) {
    let el = null;
    try { el = await page.$(sel); } catch (e) {}
    console.log(sel, el ? 'FOUND' : 'null');
  }
  const data = await page.data();
  console.log('zhiku data keys:', Object.keys(data).slice(0, 12).join(','));
  process.exit(0);
})().catch((e) => { console.error('ERR', e.message); process.exit(1); });
