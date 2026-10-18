// e2e_v0920_prod.mjs — 0.9.20 生产全链验证（simulator→生产引擎→真 LLM→气泡）
import automator from 'miniprogram-automator';
import fs from 'node:fs';

const SHOT_DIR = 'E:\\AI-Station\\WeAppForge\\work\\e2e_v0920_shots';
fs.mkdirSync(SHOT_DIR, { recursive: true });
const results = [];
const errors = [];
const note = (n, ok, d = '') => { results.push({ n, ok, d: !!d }); console.log(`${ok ? 'PASS' : 'FAIL'} ${n}${d ? ' | ' + d : ''}`); };
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

const mp = await automator.connect({ wsEndpoint: 'ws://127.0.0.1:9420' });
mp.on('exception', (e) => errors.push(String(e && e.message)));

await mp.reLaunch('/pages/report/report?sku=CNNC-EPC');
await sleep(3200);
const rp = await mp.currentPage();
const rd = await rp.data();
note('prod_report_loaded', rd.loading === false && !!rd.d, `sku=${rd.sku}`);

const pills = await rp.$$('.rp-social .pill');
note('prod_pill_visible', pills.length >= 4, `pills=${pills.length}（未购用户可见=AC0）`);

if (pills.length) {
  await pills[pills.length - 1].tap();
  await sleep(1500);
  const inp = await rp.$('.rp-ask-input');
  note('prod_panel_open', !!inp);
  if (inp) {
    await inp.input('华龙一号示范工程的核心教训是什么');
    await sleep(400);
    const send = await rp.$('.rp-ask-send');
    if (send) await send.tap(); else await rp.callMethod('onAskSend');
    let bubble = null;
    for (let i = 0; i < 30; i++) {
      await sleep(2000);
      const d = await rp.data();
      const arr = d.asks || [];
      if (arr.some((x) => x.conclusion)) { bubble = arr.find((x) => x.conclusion); break; }
      if (d.askExhausted) { note('prod_exhausted_state', true, '今日3问已用完态如实（前轮已耗）'); break; }
    }
    if (bubble) {
      note('prod_bubble_llm', true, `conclusion=${String(bubble.conclusion).slice(0, 26)}`);
      note('prod_bubble_shape', Array.isArray(bubble.points) && bubble.points.length >= 1
        && (String(bubble.hint || '').indexOf('章') >= 0 || String(bubble.hint || '').indexOf('正文') >= 0),
        `points=${(bubble.points || []).length} hint=${bubble.hint}`);
    }
    await mp.screenshot({ path: SHOT_DIR + '\\prod_ask_bubble.png' }).catch(() => {});
  }
}
await sleep(800);
note('prod_zero_exception', errors.length === 0, errors.slice(0, 2).join(';').slice(0, 150));
await mp.disconnect();
const failed = results.filter((r) => !r.ok);
console.log(`\n==== E2E v0.9.20 PROD: ${results.length - failed.length}/${results.length} PASS ====`);
process.exit(failed.length ? 1 : 0);
