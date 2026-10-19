const automator = require('miniprogram-automator');
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
  const mini = await automator.connect({ wsEndpoint: 'ws://localhost:9422' });
  const r3 = await (async () => {
    await mini.navigateTo('/pages/product/product?id=glasses');
    await sleep(3000);
    return mini.evaluate(() => {
      const p = getCurrentPages()[getCurrentPages().length - 1];
      return { id: p.data.p.id, timeline: p.onShareTimeline && p.onShareTimeline() };
    });
  })();
  console.log('[4] glasses:', JSON.stringify(r3));
  await mini.navigateBack(); await sleep(1000);
  const r4 = await (async () => {
    await mini.navigateTo('/pages/product/product?id=brain');
    await sleep(3000);
    return mini.evaluate(() => {
      const p = getCurrentPages()[getCurrentPages().length - 1];
      return { id: p.data.p.id, timeline: p.onShareTimeline && p.onShareTimeline() };
    });
  })();
  console.log('[5] brain(fallback):', JSON.stringify(r4));
  const pass = r3.timeline && r3.timeline.imageUrl === '/images/glasses-hero.jpg' &&
               r4.timeline && r4.timeline.imageUrl === '/images/leopard.jpg';
  console.log(pass ? '[6] PART2 100% PASS' : '[6] FAIL');
  await mini.disconnect(); process.exit(pass ? 0 : 1);
})().catch((e) => { console.error('ERR', e.message); process.exit(1); });
