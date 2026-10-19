const automator = require('miniprogram-automator');
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
  const mini = await automator.connect({ wsEndpoint: 'ws://localhost:9420' });
  const page = await mini.currentPage();
  await sleep(2000);
  const btn = await page.$('.rp-ask-buy');
  console.log('btn found:', !!btn);
  if (btn) console.log('btn text:', (await btn.text()).trim());
  await mini.disconnect(); process.exit(0);
})().catch((e) => { console.error('ERR', e.message); process.exit(1); });
