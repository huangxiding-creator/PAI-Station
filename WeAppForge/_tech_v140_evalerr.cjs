const automator = require('miniprogram-automator');
(async () => {
  const mini = await automator.connect({ wsEndpoint: 'ws://localhost:9421' });
  const r = await mini.evaluate(() => {
    const out = {};
    try { out.catalog = require('../../content/catalog.json').reports.length; }
    catch (e) { out.catalog = 'ERR:' + e.message.slice(0, 80); }
    try { require('../../pages/index/index.js'); out.indexMod = 'loaded'; }
    catch (e) { out.indexMod = 'ERR:' + e.message.slice(0, 120); }
    try { const app = getApp(); out.appKeys = Object.keys(app || {}).slice(0, 8); }
    catch (e) { out.app = 'ERR:' + e.message.slice(0, 60); }
    const ps = getCurrentPages();
    out.pageRoute = ps[ps.length - 1] && ps[ps.length - 1].route;
    out.pageDataKeys = Object.keys((ps[ps.length - 1] || {}).data || {});
    return out;
  });
  console.log(JSON.stringify(r, null, 1));
  await mini.disconnect(); process.exit(0);
})().catch((e) => { console.error('FATAL', e.message); process.exit(1); });
