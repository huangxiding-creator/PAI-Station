const automator = require('miniprogram-automator');
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
  const mp = await automator.connect({ wsEndpoint: 'ws://127.0.0.1:9420' });
  for (let i = 0; i < 10; i++) { const s = await mp.pageStack().catch(() => []); if (s.length) break; await sleep(2000); }
  await mp.navigateTo('/pages/kbfactory/kbfactory').catch((e) => console.log('navigateTo:', String(e).slice(0, 100)));
  await sleep(3000);
  const out = await mp.evaluate(() => {
    const pages = getCurrentPages();
    const p = pages[pages.length - 1];
    return {
      lastRoute: p && (p.route || p.__route__),
      dataKeys: p ? Object.keys(p.data || {}) : null,
      building: p && p.data && p.data.building,
      hasStages: !!(p && p.data && p.data.stages),
      genErr: p && p.data && p.data.genErr,
    };
  }, null).catch((e) => ({ evalErr: String(e).slice(0, 150) }));
  console.log(JSON.stringify(out, null, 1));
  process.exit(0);
})().catch((e) => { console.error('ERR', e.message); process.exit(1); });
