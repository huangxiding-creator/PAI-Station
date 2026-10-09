// e2e_quota_probe.mjs — 额度扣减/赠送端到端探针（用户缺陷报告 1009：免费咨询后额度貌似没扣）
// 对生产引擎真链路验证：login→quota(q1)→真实咨询一次→回ask页quota(q2)→断言 total-1 且 free-1；
// 再进答案页点「有用」→回ask页quota(q3)→断言 total+1（新答案首次赠次必 granted）。
import automator from 'miniprogram-automator';
import fs from 'node:fs';

const RESULT = 'E:\\AI-Station\\WeAppForge\\work\\e2e_quota_probe_result.json';
const errors = [];
const results = [];
const note = (name, ok, detail = '') => {
  results.push({ name, ok: !!ok, detail });
  console.log(`${ok ? 'PASS' : 'FAIL'} ${name}${detail ? ' | ' + detail : ''}`);
};
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
const dataOf = async (page) => (await page.data()) || {};

const mp = await automator.connect({ wsEndpoint: 'ws://127.0.0.1:9420' });
mp.on('exception', (err) => errors.push(String((err && err.message) || err)));

// ── S1 · 登录态 + 初始额度（q1，服务端真值）──
await mp.callWxMethod('setStorageSync', 'qw_privacy_ok', 1);
await mp.reLaunch('/pages/ask/ask');
await sleep(1600);
let ask = await mp.currentPage();
let ad = await dataOf(ask);
for (let i = 0; i < 12 && !(ad.loginReady && ad.quota); i++) {
  await sleep(800);
  ad = await dataOf(ask);
}
note('quota_initial_loaded', !!(ad.loginReady && ad.quota),
  `loginReady=${ad.loginReady} quota=${JSON.stringify(ad.quota)}`);

const q1 = ad.quota;
if (!(q1 && q1.total_left > 0)) {
  console.log(`SKIP 主链：今日额度已尽 q1=${JSON.stringify(q1)}（诚实跳过，逻辑已由 pytest 覆盖）`);
  fs.writeFileSync(RESULT, JSON.stringify({ results, errors, skipped: true }, null, 2));
  await mp.disconnect();
  process.exit(0);
}

// ── S2 · 真实咨询一次（生产链：consume_one 先扣）──
const ta = await ask.$('.ask-input');
await ta.input('工程合同争议解决方式有哪些？仲裁和诉讼各有什么优劣？');
await sleep(400);
const btn = await ask.$('.ask-btn');
await btn.tap();
let ans = null;
let aid = '';
for (let i = 0; i < 25; i++) {
  await sleep(1000);
  const cur = await mp.currentPage();
  if (cur.path === 'pages/answer/answer') { ans = cur; aid = (await dataOf(cur)).id || ''; break; }
}
note('ask_navigated_to_answer', !!ans && !!aid, `aid=${aid}`);

if (ans && aid) {
  // ── S3 · 回 ask 页读扣减后额度（q2：applyQuota 已设 + onShow 再拉服务端真值）──
  await mp.switchTab('/pages/ask/ask');
  await sleep(1400);
  ask = await mp.currentPage();
  let ad2 = await dataOf(ask);
  await sleep(1200);   // onShow refreshQuota 二次落定再读一次（取末值）
  ad2 = await dataOf(ask);
  const q2 = ad2.quota;
  const freePath = q1.free_left > 0
    && q2.free_left === q1.free_left - 1
    && q2.bonus_left === q1.bonus_left;
  const bonusPath = q1.free_left === 0
    && q2.bonus_left === q1.bonus_left - 1
    && q2.free_left === 0;
  note('quota_decremented_after_ask',
    q2.total_left === q1.total_left - 1 && (freePath || bonusPath),
    `q1=${JSON.stringify(q1)} q2=${JSON.stringify(q2)} free=${freePath} bonus=${bonusPath}`);

  // ── S4 · 有用赠次（新答案首次点必 granted → +1 bonus）──
  await mp.navigateTo('/pages/answer/answer?id=' + aid);
  await sleep(1800);
  const ans2 = await mp.currentPage();
  let liked = false;
  for (let i = 0; i < 15 && !liked; i++) {
    const pills = await ans2.$$('.pill');
    let likePill = null;
    for (const p of pills) {
      const t = String(await p.text() || '');
      if (t.indexOf('有用') >= 0) { likePill = p; break; }
    }
    if (likePill) {
      await likePill.tap();
      await sleep(1200);
      liked = !!(await dataOf(ans2)).liked;
      if (!liked) break;   // 点过仍非 liked=异常，不重试
    } else {
      await sleep(1000);   // 页面还在载入，等 pill 出现
    }
  }
  note('like_tapped_and_liked', liked, `liked=${liked}`);

  await mp.switchTab('/pages/ask/ask');
  await sleep(1500);
  ask = await mp.currentPage();
  await sleep(1200);
  const q3 = (await dataOf(ask)).quota;
  note('quota_granted_after_like',
    !!q3 && q3.total_left === q2.total_left + 1 && q3.bonus_left === q2.bonus_left + 1
    && q3.free_left === q2.free_left,
    `q2=${JSON.stringify(q2)} q3=${JSON.stringify(q3)}`);
}

note('zero_exception', errors.length === 0, errors.slice(0, 2).join(' ;; ').slice(0, 200));
const failed = results.filter((r) => !r.ok);
console.log('\n==== QUOTA PROBE: ' + (results.length - failed.length) + '/' + results.length + ' PASS ====');
fs.writeFileSync(RESULT, JSON.stringify({ results, errors }, null, 2));
await mp.disconnect();
process.exit(failed.length ? 1 : 0);
