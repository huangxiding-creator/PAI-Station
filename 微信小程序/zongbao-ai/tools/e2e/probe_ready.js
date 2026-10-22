const automator = require('miniprogram-automator');
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
  const mp = await automator.connect({ wsEndpoint: 'ws://127.0.0.1:9420' });
  for (let i = 0; i < 20; i++) {
    let stack = [];
    try { stack = await mp.pageStack(); } catch (e) { console.log('pageStack ERR', String(e).slice(0, 80)); }
    console.log(`t=${i * 3}s stack=${stack.length} [${stack.map((p) => p.path).join(',')}]`);
    if (stack.length) {
      const p = await mp.switchTab('/pages/zhiku/zhiku').catch(() => null);
      console.log('switchTab ->', p && p.path, 'has$=', !!(p && p.$));
      process.exit(0);
    }
    await sleep(3000);
  }
  console.log('APP NEVER READY');
  process.exit(1);
})().catch((e) => { console.error('ERR', e.message); process.exit(1); });
