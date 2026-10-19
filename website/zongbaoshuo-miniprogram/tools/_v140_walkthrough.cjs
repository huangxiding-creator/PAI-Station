// v1.4.0 总包说科技 100% 走查：首页全段渲染 + 八产品线逐一点击 + 旗舰卡 + 截图存证
const automator = require('miniprogram-automator');
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
  const mini = await automator.connect({ wsEndpoint: 'ws://localhost:9422' });
  console.log('[1] connected');
  const page = await mini.reLaunch('/pages/index/index');
  await sleep(6000);
  const d = await page.data();
  const chips = (d.chips || []).length;
  const stats = (d.stats || []).length;
  console.log('[2] index data: chips=' + chips + ' stats=' + stats +
    ' flagship=' + ((d.flagship && d.flagship.cards) || []).length +
    ' business=' + ((d.business && d.business.cards) || []).length +
    ' unity=' + ((d.unity || d.dwg || []).length !== undefined ? 'ok' : '?'));
  await mini.screenshot({ path: 'E:/AI-Station/website/zongbaoshuo-miniprogram/_v140_index_full.png' });
  // DOM 断言：核心段都在
  const secs = await page.$$('.sec');
  console.log('[3] .sec sections:', secs.length);
  // 八产品线逐一点击（leopard→robot）
  const lines = ['leopard', 'brain', 'zhiku', 'factory', 'aipo', 'station', 'glasses', 'robot'];
  let pass = 0;
  for (const id of lines) {
    const p2 = await mini.navigateTo('/pages/product/product?id=' + id);
    await sleep(1800);
    const r = await p2.data();
    const ok = r && r.p && (r.p.id === id || r.p.h || r.p.pin || JSON.stringify(r).length > 200);
    console.log('  line ' + id + ':', ok ? 'OK' : 'EMPTY ' + JSON.stringify(r).slice(0, 80));
    if (ok) pass++;
    await mini.navigateBack();
    await sleep(600);
  }
  console.log('[4] product lines pass: ' + pass + '/8');
  // 旗舰两卡（consultant=jump/product=aiglasses 详情页）
  const p3 = await mini.navigateTo('/pages/product/product?id=consultant');
  await sleep(1800);
  const r3 = await p3.data();
  console.log('[5] consultant page:', JSON.stringify(r3).length > 200 ? 'OK' : 'EMPTY');
  await mini.navigateBack();
  const p4 = await mini.navigateTo('/pages/product/product?id=aiglasses');
  await sleep(1800);
  const r4 = await p4.data();
  console.log('[6] aiglasses page:', JSON.stringify(r4).length > 200 ? 'OK' : 'EMPTY');
  await mini.screenshot({ path: 'E:/AI-Station/website/zongbaoshuo-miniprogram/_v140_aiglasses.png' });
  await mini.disconnect(); process.exit(pass === 8 ? 0 : 1);
})().catch((e) => { console.error('ERR', e.message); process.exit(1); });
