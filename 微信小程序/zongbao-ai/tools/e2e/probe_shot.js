const automator = require('miniprogram-automator');
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
  const mp = await automator.connect({ wsEndpoint: 'ws://127.0.0.1:9420' });
  for (let i = 0; i < 10; i++) { const s = await mp.pageStack().catch(() => []); if (s.length) break; await sleep(2000); }
  let stack = await mp.pageStack();
  let kb = stack.find((p) => String(p.path || '').indexOf('kbfactory') >= 0);
  if (!kb) {
    const zh = await mp.switchTab('/pages/zhiku/zhiku').catch(() => null);
    await sleep(1200);
    let entry = null;
    if (zh) { try { entry = await zh.$('.kbf-entry'); } catch (e) {} }
    if (entry) { await entry.tap(); await sleep(2200); }
    stack = await mp.pageStack();
    kb = stack.find((p) => String(p.path || '').indexOf('kbfactory') >= 0);
  }
  if (!kb) { console.log('no kbfactory on stack:', stack.map((p) => p.path).join(',')); process.exit(1); }
  try { console.log('before shot: data.building =', (await kb.data()).building); } catch (e) { console.log('before shot data ERR:', String(e).slice(0, 90)); }
  try { await mp.screenshot({ path: 'shots/probe.png' }); console.log('shot OK'); } catch (e) { console.log('shot ERR:', String(e).slice(0, 90)); }
  await sleep(800);
  try { console.log('after shot: data.building =', (await kb.data()).building); } catch (e) { console.log('after shot data ERR:', String(e).slice(0, 90)); }
  process.exit(0);
})().catch((e) => { console.error('ERR', e.message); process.exit(1); });
