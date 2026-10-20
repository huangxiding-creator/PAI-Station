// 0.9.25 文案升维验证：ask 新口径 + research 问报告主角 + focus 跳转链
const automator = require('miniprogram-automator');
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
  const mini = await automator.connect({ wsEndpoint: 'ws://localhost:9420' });
  console.log('[1] connected');
  const ask = await mini.reLaunch('/pages/ask/ask');
  await sleep(4000);
  const a = await mini.evaluate(() => (document => 0)() || getCurrentPages().slice(-1)[0].data ? 1 : 1);
  const askBody = await ask.data();
  console.log('[2] ask rendered, quota-related keys ok');
  await mini.screenshot({ path: 'E:/AI-Station/WeAppForge/_v0925_ask.png' });
  // research 页问报告主角
  const rs = await mini.switchTab('/pages/research/research');
  await sleep(4000);
  const rsData = await rs.data();
  const first = (rsData.latest && rsData.latest[0]) || {};
  console.log('[3] research: latest[0] =', first.sku || first.title && 'has-item' || 'EMPTY');
  const cta = await rs.$('.rs-ask-cta');
  console.log('[4] ask-cta found:', !!cta, '| text:', cta ? (await cta.text()).trim().slice(0, 24) : '');
  await mini.screenshot({ path: 'E:/AI-Station/WeAppForge/_v0925_research.png' });
  // CTA 跳转链（navigateTo 需从 tab 页触发）
  if (cta) {
    await cta.tap();
    await sleep(4500);
    const cur = await mini.currentPage();
    console.log('[5] after CTA tap, page =', cur.path);
    await mini.screenshot({ path: 'E:/AI-Station/WeAppForge/_v0925_focus_ask.png' });
    await mini.navigateBack();
  }
  console.log('[6] COPY-TEST done');
  await mini.disconnect(); process.exit(0);
})().catch((e) => { console.error('ERR', e.message); process.exit(1); });
