const automator = require('miniprogram-automator');
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
  const mp = await automator.connect({ wsEndpoint: 'ws://127.0.0.1:9420' });
  for (let i = 0; i < 10; i++) { const s = await mp.pageStack().catch(() => []); if (s.length) break; await sleep(2000); }
  const out = await mp.evaluate(() => {
    const pages = getCurrentPages();
    const p = pages[pages.length - 1];
    return {
      stack: pages.map((x) => x.route || x.__route__),
      lastRoute: p && (p.route || p.__route__),
      dataKeys: p ? Object.keys(p.data || {}).slice(0, 15) : null,
      building: p && p.data && p.data.building,
      genErr: p && p.data && p.data.genErr,
    };
  }, null).catch((e) => ({ evalErr: String(e).slice(0, 120) }));
  console.log(JSON.stringify(out, null, 1));
  process.exit(0);
})().catch((e) => { console.error('ERR', e.message); process.exit(1); });
