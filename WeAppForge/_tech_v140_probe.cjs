const automator = require('miniprogram-automator');
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
  const mini = await automator.connect({ wsEndpoint: 'ws://localhost:9421' });
  const sys = await mini.systemInfo();
  console.log('sdk:', sys.SDKVersion);
  const cur = await mini.pageStack();
  console.log('stack:', cur.map(p => p.path));
  const page = cur[cur.length - 1];
  if (page) {
    await sleep(3000);
    const d = await page.data();
    console.log('page:', page.path, '| keys:', Object.keys(d).slice(0, 10));
  }
  await mini.disconnect(); process.exit(0);
})().catch((e) => { console.error('ERR', e.message); process.exit(1); });
