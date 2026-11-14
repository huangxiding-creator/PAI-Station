const automator = require('miniprogram-automator');
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
  const mini = await automator.connect({ wsEndpoint: 'ws://localhost:9420' });
  const sys = await mini.systemInfo();
  console.log('sdk:', sys.SDKVersion);
  const stack = await mini.pageStack();
  console.log('stack:', stack.map((p) => p.path));
  await sleep(3000);
  const d = await mini.evaluate(() => {
    const ps = getCurrentPages();
    const p = ps[ps.length - 1];
    return { route: p && p.route, hasOnPoster: typeof p.onPoster === 'function',
             hasSave: typeof p._savePosterAlbum === 'function',
             hasShare: typeof p._sharePoster === 'function' };
  });
  console.log('page:', JSON.stringify(d));
  await mini.disconnect(); process.exit(0);
})().catch((e) => { console.error('ERR', e.message); process.exit(1); });
