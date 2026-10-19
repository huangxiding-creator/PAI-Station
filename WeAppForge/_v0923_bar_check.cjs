const automator = require('miniprogram-automator');
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
  const mini = await automator.connect({ wsEndpoint: 'ws://localhost:9420' });
  const page = await mini.currentPage();
  await mini.pageScrollTo(20000);
  await sleep(1500);
  await mini.screenshot({ path: 'E:/AI-Station/WeAppForge/_v0923_report_bottom.png' });
  const d = await page.data();
  const a0 = d.asks && d.asks[0];
  console.log('bar-state: askLeft=', d.askLeft, '| unlocked=', d.d && d.d.unlocked);
  if (a0) {
    const c = a0.conclusion || '';
    console.log('conclusion tail 80:', JSON.stringify(c.slice(-80)));
    console.log('has-transition-tail:', /[:：]\s*$/.test(c.trim()));
  }
  await mini.disconnect(); process.exit(0);
})().catch((e) => { console.error('ERR', e.message); process.exit(1); });
