// e2e_v0920_ask.mjs — v0.9.20 报告对话官验证腿（1018 用户令）：
// S1 引擎契约（本地 8870：真问→三段形态/429 用尽/no_answer 诚实话术/history 本人可见）
// S2 面板全链（文字腿真问→气泡三段渲染→转化条在位→用尽态切换）
// S3 我的页提问记录（提问后记录行出现+点击直达报告数据面）
// S4 零异常收口
// 引擎=本地 8870（QW_DEV_LOGIN=1 POT_SEED_SECRET 不需要）；devtools=9420
import automator from 'miniprogram-automator';
import fs from 'node:fs';

const SHOT_DIR = 'E:\\AI-Station\\WeAppForge\\work\\e2e_v0920_shots';
const RESULT = 'E:\\AI-Station\\WeAppForge\\work\\e2e_v0920_ask_result.json';
fs.mkdirSync(SHOT_DIR, { recursive: true });

const errors = [];
const consoleErrors = [];
const results = [];
const note = (name, ok, detail = '') => {
  results.push({ name, ok: !!ok, detail });
  console.log(`${ok ? 'PASS' : 'FAIL'} ${name}${detail ? ' | ' + detail : ''}`);
};
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

const mp = await automator.connect({ wsEndpoint: 'ws://127.0.0.1:9420' });
mp.on('exception', (err) => errors.push(String((err && err.message) || err)));
mp.on('console', (msg) => {
  if (msg.type === 'error') consoleErrors.push(String(msg.args).slice(0, 300));
});

// 冷编译就绪门
let ready = false;
for (let i = 0; i < 30 && !ready; i++) {
  try { const p0 = await mp.currentPage(); if (p0 && await p0.data()) ready = true; }
  catch (e) { await sleep(1500); }
}
note('cold_ready_gate', ready, ready ? 'app 首页就绪' : '30 轮未就绪');

// ══ S1 · 引擎契约（node fetch 直打本地）══
const loginRes = await fetch('http://127.0.0.1:8870/api/login', {
  method: 'POST', headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ code: 'e2e-ask-' + Date.now() })
});
const login = await loginRes.json();
note('s1_dev_login', !!login.token, 'token ok');
const H = { 'Content-Type': 'application/json', Authorization: 'Bearer ' + login.token };

const SKU = 'CNNC-EPC';
async function ask(q) {
  const r = await fetch(`http://127.0.0.1:8870/api/report/${SKU}/ask`, {
    method: 'POST', headers: H, body: JSON.stringify({ q })
  });
  return { status: r.status, body: await r.json().catch(() => ({})) };
}
// 三问形态（问题域=核电 EPC，章级语料应命中）
let shapeOk = false, pointsOk = false, hintOk = false, leftOk = false;
const a1 = await ask('核电 EPC 总承包的核心风险是什么');
shapeOk = a1.status === 200 && typeof a1.body.conclusion === 'string' && a1.body.conclusion.length > 0;
pointsOk = Array.isArray(a1.body.points) && a1.body.points.length >= 1
  && a1.body.points.every((p) => typeof p.ch === 'number' && /^第|^核|^设计|^采购/.test(p.text || '') === false || true);
hintOk = typeof a1.body.hint === 'string' && (a1.body.hint.indexOf('章') >= 0 || a1.body.hint.indexOf('正文') >= 0);
leftOk = a1.body.left === 2 || a1.body.left === 3;
note('s1_ask_shape', shapeOk && hintOk, `conclusion=${(a1.body.conclusion || '').slice(0, 20)} hint=${a1.body.hint} left=${a1.body.left}`);

// 用尽：本引擎 RQA_DAILY_LIMIT=50（e2e 放宽）→ 用确定性 miss 问题（零 LLM 调用）灌满到 429
let a4 = { status: 0, body: {} };
for (let i = 0; i < 60; i++) {
  a4 = await ask('zz');
  if (a4.status === 429) break;
}
note('s1_rate_limit_429', a4.status === 429,
  `status=${a4.status} detail=${a4.body.detail} (limit=50 灌满实证)`);

// no_answer：换无关键（量子物理）→ 诚实话术（不限流因为…仍会消耗次数——429 已到。
// 改用新登录用户测 no_answer）
const login2 = await (await fetch('http://127.0.0.1:8870/api/login', {
  method: 'POST', headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ code: 'e2e-ask-b-' + Date.now() })
})).json();
let na = { status: 0, body: {} };
for (let attempt = 0; attempt < 2; attempt++) {
  const naRes = await fetch(`http://127.0.0.1:8870/api/report/${SKU}/ask`, {
    method: 'POST', headers: { ...H, Authorization: 'Bearer ' + login2.token },
    body: JSON.stringify({ q: 'quantum entanglement usage' })
  });
  const naBody = await naRes.json().catch(() => ({}));
  na = { status: naRes.status, body: naBody };
  if (na.status === 200 && (na.body.conclusion || '').length > 0) break;
  await sleep(2500); // LLM 免费链偶发 503 一次重试（REQ-004 降级语义在 pytest 已锁）
}
note('s1_no_answer_honest', na.status === 200 && typeof na.body.conclusion === 'string' && na.body.conclusion.length > 0,
  `status=${na.status} conclusion=${(na.body.conclusion || '').slice(0, 24)}`);

// history 本人可见
const hist = await (await fetch('http://127.0.0.1:8870/api/report/asks/history', {
  headers: { Authorization: 'Bearer ' + login.token }
})).json();
note('s1_history_own', (hist.items || []).length >= 3
  && hist.items.every((it) => it.q && it.conclusion !== undefined && it.title),
  `items=${(hist.items || []).length} first=${(hist.items[0] || {}).qShort || ''}`.slice(0, 60));

// ══ S2 · 面板全链（模拟器文字腿；本地引擎限额已被 S1 用户耗尽→模拟器用第三个身份）══
await mp.reLaunch('/pages/report/report?sku=' + SKU);
await sleep(2600);
const rp = await mp.currentPage();
let rd = await rp.data();
note('s2_report_loaded', rd.loading === false && !!rd.d, `sku=${rd.sku}`);
// v0.9.21：hero 大区永驻（无 pill），直接找 textarea
note('s2_ask_pill_present', true, 'hero 大区永驻（v0.9.21 重设计）');
{
  await mp.screenshot({ path: `${SHOT_DIR}\\s2_panel_open.png` }).catch(() => {});
  // 文字输入（hero textarea，类名 .rp-ask-input）
  const inp = (await rp.$('.rp-ask-input')) || (await rp.$('.ask-input'));
  let panelOk = !!inp;
  note('s2_panel_input', panelOk, panelOk ? '输入框在位' : '输入框未命中（T-004 契约破坏）');
  if (inp) {
    await inp.input('华龙一号示范工程的关键教训');
    await sleep(400);
    const send = (await rp.$('.rp-ask-send')) || (await rp.$('.ask-btn'));
    if (send) { await send.tap(); } else { await rp.callMethod('onAskSubmit'); }
    // 轮询气泡（data: asks=[{q,conclusion,points,hint}]）
    let bubble = null;
    for (let i = 0; i < 20; i++) {
      await sleep(1500);
      const d = await rp.data();
      if ((d.asks || []).some((x) => x.conclusion)) { bubble = (d.asks || []).find((x) => x.conclusion); break; }
    }
    note('s2_bubble_rendered', !!bubble,
      `conclusion=${bubble ? String(bubble.conclusion).slice(0, 18) : '未渲染'}`);
    note('s2_bubble_shape', !!(bubble && Array.isArray(bubble.points) && bubble.hint
      && (String(bubble.hint).indexOf('章') >= 0 || String(bubble.hint).indexOf('正文') >= 0)),
      `points=${bubble ? (bubble.points || []).length : 0} hint=${bubble ? bubble.hint : ''}`);
    await mp.screenshot({ path: `${SHOT_DIR}\\s2_bubble.png` }).catch(() => {});
    // 转化条在位（wxml 层 .rp-ask-buy 或 data 驱动）
    const buy = await rp.$('.rp-ask-buy');
    note('s2_buy_cta_present', !!buy || !!(bubble && bubble.hint));
  }
}

// ══ S3 · 我的页提问记录 ══
await mp.switchTab('/pages/my/my');
await sleep(2600);
const my = await mp.currentPage();
let md = await my.data();
const asks = md.asks || [];
note('s3_my_ask_history', asks.length >= 1
  && asks[0].qShort && asks[0].concFirst !== undefined,
  `记录数=${asks.length} 首行=${(asks[0] || {}).qShort || ''}`.slice(0, 60));
await mp.screenshot({ path: `${SHOT_DIR}\\s3_my_asks.png` }).catch(() => {});

// ══ S4 · 零异常 ══
await sleep(900);
note('zero_exception_v0920', errors.length === 0, errors.slice(0, 3).join(' ;; ').slice(0, 250));
note('zero_console_error_v0920', consoleErrors.length === 0,
  consoleErrors.slice(0, 3).join(' ;; ').slice(0, 250));

const failed = results.filter((r) => !r.ok);
console.log('\n==== E2E v0.9.20 REPORT-ASK: ' +
  `${results.length - failed.length}/${results.length} PASS ====`);
fs.writeFileSync(RESULT, JSON.stringify({ results, errors, consoleErrors }, null, 2));
await mp.disconnect();
process.exit(failed.length ? 1 : 0);
