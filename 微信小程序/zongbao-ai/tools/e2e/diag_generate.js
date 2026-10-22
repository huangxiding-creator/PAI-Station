const automator = require('miniprogram-automator');
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
  const mp = await automator.connect({ wsEndpoint: 'ws://127.0.0.1:9420' });
  // NOTE: console 监听疑似毒源（注册后 switchTab 应答丢失）——已摘除验证
  // mp.on('console', (msg) => { ... });
  let page;
  await sleep(2500);
  // 就绪闸门（探针验证过的序列：pageStack 先行，等 App 完全起）
  for (let i = 0; i < 20; i++) {
    let stack = [];
    try { stack = await mp.pageStack(); } catch (e) {}
    if (stack.length) break;
    await sleep(3000);
  }
  for (let i = 0; i < 4; i++) {
    try {
      page = await mp.switchTab('/pages/zhiku/zhiku');
      console.log(`[gate] switchTab#${i} ->`, page ? `path=${page.path} $=${typeof page.$}` : 'null');
    } catch (e) { console.log(`[gate] switchTab#${i} THREW:`, String(e).slice(0, 100)); await sleep(2000); continue; }
    await sleep(1500);
    if (page && typeof page.$ === 'function') break;
  }
  // 取 kbfactory 页：优先 pageStack 里现成的（旧导航遗产常驻），没有再从入口卡进
  page = null;
  for (let i = 0; i < 4 && !page; i++) {
    const stack = await mp.pageStack().catch(() => []);
    const kb = stack.find((p) => String(p.path || '').indexOf('kbfactory') >= 0 && typeof p.$ === 'function');
    if (kb) { page = kb; break; }
    const zh = stack.find((p) => String(p.path || '').indexOf('zhiku') >= 0 && typeof p.$ === 'function');
    if (zh) {
      let entry = null;
      try { entry = await zh.$('.kbf-entry'); } catch (e) {}
      if (entry) { await entry.tap(); await sleep(2000); }
    }
  }
  console.log('page ready =', String(page && page.path));
  let ta = null;
  for (let i = 0; i < 12 && !ta; i++) {
    try { ta = await page.$('textarea'); } catch (e) {}
    if (!ta) { await sleep(800); try { const s = await mp.pageStack(); const kb = s.find((p) => String(p.path || '').indexOf('kbfactory') >= 0 && typeof p.$ === 'function'); if (kb) page = kb; } catch (e) {} }
  }
  if (!ta) { console.log('textarea 未出现'); process.exit(1); }
  await ta.input('给水利EPC项目团队建一个施工知识库');
  await sleep(300);
  const go = await page.$('.kf-go');
  console.log('kf-go text =', await go.text());
  await page.callMethod('onGenerate');  // 直调绕开tap事件链（tap是否触发另行判定）
  for (let i = 0; i < 30; i++) {
    await sleep(2000);
    const d = await page.data();
    const stages = (d.stages || []).map((s) => s.state[0] || '-').join('');
    if (d.genErr) console.log('GENERR =', d.genErr);
    console.log(`t=${(i + 1) * 2}s building=${d.building} built=${d.built} bp=${!!d.bp} stages=[${stages}] need="${String(d.needText).slice(0, 12)}"`);
    if (d.bp || d.built) { console.log('DONE: files=', d.bp && d.bp.stats && d.bp.stats.files); break; }
    if (!d.building && !d.built && i > 2) { console.log('STUCK-idle: building=false 且无bp（生成早退/被catch）'); break; }
  }
  process.exit(0);
})().catch((e) => { console.error('ERR', e.message); process.exit(1); });
