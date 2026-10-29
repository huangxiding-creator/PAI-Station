const automator = require('miniprogram-automator');
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
  const mp = await automator.connect({ wsEndpoint: 'ws://127.0.0.1:9420' });
  await sleep(2000);
  // 直接导航到 kbfactory
  await mp.navigateTo('/pages/kbfactory/kbfactory').catch((e) => console.log('nav:', String(e).slice(0, 80)));
  await sleep(3000);
  const out = await mp.evaluate(() => {
    const pages = getCurrentPages();
    const p = pages[pages.length - 1];
    if (!p) return { error: 'no page' };
    const proto = Object.getPrototypeOf(p);
    const methods = Object.getOwnPropertyNames(proto).filter(n => typeof proto[n] === 'function');
    return {
      route: p.route,
      data_keys: Object.keys(p.data).slice(0, 8).join(','),
      methods: methods.join(','),
      hasOnGenerate: methods.includes('onGenerate'),
      hasBuildRatio: methods.includes('_buildRatioSegs'),
      hasToggleL1: methods.includes('toggleL1'),
    };
  }, null);
  console.log(JSON.stringify(out, null, 1));
  process.exit(0);
})().catch((e) => { console.error('ERR', e.message); process.exit(1); });
