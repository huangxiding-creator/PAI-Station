// v0.9.23 客户端 DevTools 冒烟：报告页初始态（配额实值化）+ 一轮问答（统一池/长结论/无限问徽标）
const automator = require('miniprogram-automator');
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
  const mini = await automator.connect({ wsEndpoint: 'ws://localhost:9420' });
  console.log('[1] connected');
  const sys = await mini.systemInfo();
  console.log('[1] sdk:', sys.SDKVersion, 'platform:', sys.platform);
  const page = await mini.reLaunch('/pages/report/report?sku=JSFDD-2026');
  await sleep(6000); // 详情+配额腿
  let d = await page.data();
  console.log('[2] initial: unlocked=', d.d && d.d.unlocked,
              '| askLeft=', d.askLeft, '| askUnlimited=', d.askUnlimited, '| askExhausted=', d.askExhausted);
  await mini.screenshot({ path: 'E:/AI-Station/WeAppForge/_v0923_report_initial.png' });
  // 填问题并发送
  const ta = await page.$('.rp-ask-input');
  if (!ta) { console.log('[3] FAIL: textarea not found'); process.exit(1); }
  await ta.input('工程价款司法鉴定的流程怎么走');
  const btn = await page.$('.rp-ask-hero-btn, [bindtap="onAskSend"]');
  const sendBtn = (await page.$$('view')).filter(v => v).length; // fallback probe
  console.log('[3] input filled; send button found:', !!btn);
  // 用事件直发最稳（automator 对动态 class 的 view 命中不稳时走 page.callMethod）
  const send = await page.$('.rp-ask-hero-send'); // 真点发送钮（callMethod 路在 devtools 3.17 不稳）
  if (!send) { console.log('[3] FAIL: send btn not found'); process.exit(1); }
  await send.tap();
  // 等 LLM 长回答（真引擎 2048 token）
  for (let i = 0; i < 30; i++) {
    await sleep(2000);
    d = await page.data();
    const done = d.asks.length > 0 && !d.asks[0].loading;
    if (done) break;
  }
  const a0 = d.asks && d.asks[0];
  console.log('[4] after ask: askLeft=', d.askLeft, '| askUnlimited=', d.askUnlimited,
              '| conclusion_len=', a0 ? (a0.conclusion || '').length : 'n/a',
              '| paragraphs=', a0 ? (a0.conclusion || '').split('\n').length : 'n/a',
              '| points=', a0 ? (a0.points || []).length : 'n/a',
              '| hint=', a0 ? a0.hint : 'n/a');
  await mini.screenshot({ path: 'E:/AI-Station/WeAppForge/_v0923_report_after_ask.png' });
  console.log('[5] smoke done');
  await mini.disconnect();
  process.exit(0);
})().catch((e) => { console.error('SMOKE_ERR', e.message); process.exit(1); });
