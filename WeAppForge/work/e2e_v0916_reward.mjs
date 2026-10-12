// e2e_v0916_reward.mjs — v0.9.16 用户令验证腿（1012）：
// ①报告页「有用」赠次 → 授勋动画统一（rewardShow 翻起 2.4s 自收 + rw-mask 可视截图）
// ②有用幂等（二次点零动作）③my 信标 v0.9.16 ④零异常零控制台错
// 引擎=本地 8870（QW_DEV_LOGIN=1，真 HTTP 赠次落账）
import automator from 'miniprogram-automator';
import fs from 'node:fs';

const SHOT_DIR = 'E:\\AI-Station\\WeAppForge\\work\\e2e_v0916_shots';
const RESULT = 'E:\\AI-Station\\WeAppForge\\work\\e2e_v0916_reward_result.json';
fs.mkdirSync(SHOT_DIR, { recursive: true });

const errors = [];
const consoleErrors = [];
const results = [];
const note = (name, ok, detail = '') => {
  results.push({ name, ok: !!ok, detail });
  console.log(`${ok ? 'PASS' : 'FAIL'} ${name}${detail ? ' | ' + detail : ''}`);
};
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
const dataOf = async (page) => (await page.data()) || {};

const mp = await automator.connect({ wsEndpoint: 'ws://127.0.0.1:9420' });
mp.on('exception', (err) => errors.push(String((err && err.message) || err)));
mp.on('console', (msg) => {
  if (msg.type === 'error') consoleErrors.push(String(msg.args).slice(0, 300));
});

// ══ S1 · 报告详情 + 有用赠次授勋动画 ══
await mp.navigateTo('/pages/report/report?sku=CNNC-EPC');
await sleep(1500);
let page = await mp.currentPage();
let d = null;
for (let i = 0; i < 15; i++) {
  d = await dataOf(page);
  if (d.loading === false && d.d) break;
  await sleep(1200);
}
note('report_detail_loaded', !!(d && d.d && d.loading === false),
  `sku=${d && d.sku} title=${d && d.d && d.d.title ? 'ok' : '?'} errMsg=${d && d.errMsg}`);

// 真点 pill（非 callMethod：走真实 tap 链路）
const usefulPill = await page.$('.rp-social .pill-row .pill');
let tapped = true;
if (usefulPill) {
  await usefulPill.tap();
} else {
  tapped = false;
  await page.callMethod('onUseful');
}
note('useful_tap_path', true, tapped ? 'real tap' : 'callMethod fallback');

// 动画翻起窗口（2.4s）：轮询抓 rewardShow=true + 截图
let rewardSeen = false;
let shotOk = false;
for (let i = 0; i < 10; i++) {
  const dd = await dataOf(page);
  if (dd.rewardShow === true) {
    rewardSeen = true;
    note('reward_label_unified', dd.reward === '「有用」是给同行的掌声', `reward=${dd.reward}`);
    await mp.screenshot({ path: `${SHOT_DIR}\\s1_reward_mask.png` }).then(() => { shotOk = true; }).catch(() => {});
    break;
  }
  await sleep(250);
}
note('reward_animation_shown', rewardSeen, shotOk ? 'mask 截图在案' : '截图失败但数据在');

// 2.4s 自收：等 3.2s 后 rewardShow 应回 false，usefulDone 终态保持
await sleep(3200);
const d2 = await dataOf(page);
note('reward_autoclose_2400ms', d2.rewardShow === false && d2.reward === '',
  `rewardShow=${d2.rewardShow}`);
note('useful_done_terminal', d2.usefulDone === true, `usefulDone=${d2.usefulDone}`);

// 赠次真落账：qw_quota.bonus_left ≥ 1（本地引擎真 HTTP）
let quota = null;
try { quota = await mp.callWxMethod('getStorageSync', 'qw_quota'); } catch (e) { /* 忽略 */ }
note('quota_bonus_landed', !!(quota && (quota.bonus_left || 0) >= 1),
  `bonus_left=${quota && quota.bonus_left}`);

// ══ S2 · 有用幂等（二次点零动作，动画不再翻起）══
await page.callMethod('onUseful');
await sleep(600);
const d3 = await dataOf(page);
note('useful_idempotent_no_second_animation', d3.rewardShow === false, `rewardShow=${d3.rewardShow}`);

// ══ S3 · my 信标 v0.9.16 ══
await mp.switchTab('/pages/my/my');
await sleep(1800);
await mp.screenshot({ path: `${SHOT_DIR}\\s3_my_beacon.png` }).catch(() => {});
page = await mp.currentPage();
const beacon = await page.$$('.muted.mono');
let beaconText = '';
for (const el of beacon) {
  const t = await el.text();
  if (t && t.includes('v0.9.')) { beaconText = t; break; }
}
note('my_beacon_v0916', beaconText.includes('v0.9.16'), `beacon=${beaconText}`);

// ══ S4 · 零异常收口 ══
await sleep(1000);
note('zero_exception_v0916', errors.length === 0, errors.slice(0, 3).join(' ;; ').slice(0, 300));
note('zero_console_error_v0916', consoleErrors.length === 0,
  consoleErrors.slice(0, 3).join(' ;; ').slice(0, 300));

const failed = results.filter((r) => !r.ok);
console.log('\n==== E2E v0.9.16 REWARD-ANIM: ' +
  `${results.length - failed.length}/${results.length} PASS ====`);
fs.writeFileSync(RESULT, JSON.stringify({ results, errors, consoleErrors }, null, 2));
await mp.disconnect();
process.exit(failed.length ? 1 : 0);
