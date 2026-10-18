// e2e_v090_walk.mjs — v0.9.0 模拟器全链走查（页面不存在复现 + 商城三页结构验证）
// 纪律：结构级走查，不发真咨询（不烧 KB 积分），不触发真实支付。
import automator from 'miniprogram-automator';

const PROJECT = 'E:\\AI-Station\\WeAppForge\\projects\\zongbao-ai';
const CLI = 'E:\\WeChatDevTools\\cli.bat';
const SHOT_DIR = 'E:\\AI-Station\\WeAppForge\\work\\e2e_v090_shots';
import fs from 'node:fs';
fs.mkdirSync(SHOT_DIR, { recursive: true });

const errors = [];
const consoleErrors = [];
const results = [];
const note = (name, ok, detail = '') => {
  results.push({ name, ok, detail });
  console.log(`${ok ? 'PASS' : 'FAIL'} ${name}${detail ? ' | ' + detail : ''}`);
};

const mp = await automator.launch({
  cliPath: CLI,
  projectPath: PROJECT,
  port: 9420,
  timeout: 180000,
});
mp.on('exception', (err) => errors.push(String(err && err.message || err)));
mp.on('console', (msg) => {
  if (msg.type === 'error') consoleErrors.push(String(msg.args).slice(0, 300));
});

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

// 1) 入口页 = ask（pages[0]）
await sleep(3000);
let page = await mp.currentPage();
note('entry_is_ask', page.path === 'pages/ask/ask', page.path);

// 2) home 跳板：显式进 home 必须落到 ask（404 根治机制在 0.9.0 仍活）
page = await mp.reLaunch('/pages/home/home');
await sleep(3500);
page = await mp.currentPage();
note('home_trampoline_to_ask', page.path === 'pages/ask/ask', 'landed=' + page.path);

// 3) 五个 tab 页逐一走
for (const p of ['pages/ask/ask', 'pages/pot/pot', 'pages/zhiku/zhiku',
                 'pages/research/research', 'pages/my/my']) {
  try {
    page = await mp.switchTab('/' + p);
    await sleep(2500);
    const cur = await mp.currentPage();
    note('tab_' + p, cur.path === p, 'landed=' + cur.path);
  } catch (e) {
    note('tab_' + p, false, String(e).slice(0, 160));
  }
}

// 4) 研究页：报告列表渲染（生产 API /api/reports）
try {
  page = await mp.switchTab('/pages/research/research');
  await sleep(4500);
  const items = await page.$$('.report-card, .rpt-card, .report-item');
  const text = await page.data ? '' : '';
  note('research_list_rendered', items.length > 0, 'cards=' + items.length);
  await mp.screenshot({ path: `${SHOT_DIR}\\research.png` });
} catch (e) {
  note('research_list_rendered', false, String(e).slice(0, 160));
}

// 5) 报告详情页（页面级，非 tab）：拿一个 sku 进 detail+试读
try {
  const rp = await mp.switchTab('/pages/research/research');
  await sleep(3000);
  const data = await rp.data();
  const first = data && (data.reports || data.list || [])[0];
  const sku = first && (first.sku || first.id);
  if (sku) {
    page = await mp.navigateTo('/pages/report/report?sku=' + sku);
    await sleep(4000);
    const cur = await mp.currentPage();
    note('report_detail_open', cur.path === 'pages/report/report', 'sku=' + sku + ' landed=' + cur.path);
    await mp.screenshot({ path: `${SHOT_DIR}\\report_detail.png` });
    await mp.navigateBack();
  } else {
    note('report_detail_open', false, 'no sku from research page data');
  }
} catch (e) {
  note('report_detail_open', false, String(e).slice(0, 160));
}

// 6) legal 页（隐私）可开
try {
  page = await mp.navigateTo('/pages/legal/privacy');
  await sleep(2000);
  const cur = await mp.currentPage();
  note('legal_privacy_open', cur.path === 'pages/legal/privacy', 'landed=' + cur.path);
  await mp.navigateBack();
} catch (e) {
  note('legal_privacy_open', false, String(e).slice(0, 160));
}

// 7) 全程零 JS 异常
await sleep(1500);
note('zero_exception', errors.length === 0, errors.slice(0, 3).join(' ;; ').slice(0, 300));
note('zero_console_error', consoleErrors.length === 0,
     consoleErrors.slice(0, 3).join(' ;; ').slice(0, 300));

const failed = results.filter((r) => !r.ok);
console.log('\n==== E2E v0.9.0 WALK: ' +
  `${results.length - failed.length}/${results.length} PASS ====`);
fs.writeFileSync('E:\\AI-Station\\WeAppForge\\work\\e2e_v090_result.json',
  JSON.stringify({ results, errors, consoleErrors }, null, 2));
await mp.close();
process.exit(failed.length ? 1 : 0);
