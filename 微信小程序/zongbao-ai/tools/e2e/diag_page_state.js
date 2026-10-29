const automator = require('miniprogram-automator');
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
  const mp = await automator.connect({ wsEndpoint: 'ws://127.0.0.1:9420' });
  for (let i = 0; i < 10; i++) { const s = await mp.pageStack().catch(() => []); if (s.length) break; await sleep(2000); }
  // 找 kbfactory
  let page = null;
  for (let i = 0; i < 4 && !page; i++) {
    const stack = await mp.pageStack().catch(() => []);
    const kb = stack.find((p) => String(p.path || '').indexOf('kbfactory') >= 0 && typeof p.$ === 'function');
    if (kb) { page = kb; break; }
    const zh = stack.find((p) => String(p.path || '').indexOf('zhiku') >= 0 && typeof p.$ === 'function');
    let entry = null;
    if (zh) { try { entry = await zh.$('.kbf-entry'); } catch (e) {} }
    if (entry) { await entry.tap(); await sleep(2000); }
  }
  if (!page) { console.log('page not found'); process.exit(1); }
  console.log('page:', page.path);
  const d = await page.data();
  console.log('data keys:', Object.keys(d).join(', '));
  console.log('building:', d.building, 'built:', d.built, 'bp:', !!d.bp);
  console.log('ratioSegs:', JSON.stringify(d.ratioSegs).slice(0, 100));
  // 试直接调 onGenerate
  try {
    await page.callMethod('onGenerate');
    console.log('callMethod OK');
  } catch (e) {
    console.log('callMethod FAIL:', String(e).slice(0, 100));
  }
  // 看页面是否有 JS 错误
  const err = await mp.evaluate(() => {
    const pages = getCurrentPages();
    const p = pages[pages.length - 1];
    return {
      route: p && p.route,
      hasOnGenerate: typeof p.onGenerate === 'function',
      hasBuildRatio: typeof p._buildRatioSegs === 'function',
      proto: Object.getOwnPropertyNames(Object.getPrototypeOf(p)).slice(0, 15).join(','),
    };
  }, null).catch((e) => ({ evalErr: String(e).slice(0, 100) }));
  console.log('page proto:', JSON.stringify(err));
  process.exit(0);
})().catch((e) => { console.error('ERR', e.message); process.exit(1); });
