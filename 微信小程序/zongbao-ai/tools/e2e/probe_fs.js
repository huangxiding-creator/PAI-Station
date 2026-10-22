const automator = require('miniprogram-automator');
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
  const mp = await automator.connect({ wsEndpoint: 'ws://127.0.0.1:9420' });
  for (let i = 0; i < 10; i++) { const s = await mp.pageStack().catch(() => []); if (s.length) break; await sleep(2000); }
  const out = await mp.evaluate(() => new Promise((resolve) => {
    const fs = wx.getFileSystemManager();
    const tries = ['/pages/kbfactory/samples/sample_water.json', 'pages/kbfactory/samples/sample_water.json'];
    const results = [];
    const next = (i) => {
      if (i >= tries.length) { resolve(results); return; }
      fs.readFile({ filePath: tries[i], encoding: 'utf-8',
        success: (r) => { results.push(tries[i] + ' -> OK len=' + r.data.length); next(i + 1); },
        fail: (e) => { results.push(tries[i] + ' -> FAIL ' + (e && e.errMsg)); next(i + 1); } });
    };
    next(0);
  }), null);
  console.log(JSON.stringify(out, null, 1));
  process.exit(0);
})().catch((e) => { console.error('ERR', e.message); process.exit(1); });
