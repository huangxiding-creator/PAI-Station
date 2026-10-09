// e2e_v093_walk.mjs — v0.9.3 模拟器全链走查（六库同步验证 + 全页 walk）
// 模式：IDE 已由 cli open 拉起 → cli auto 开自动化口 9420 → automator.connect 挂上。
// 纪律：结构级走查，不发真咨询（不烧 KB 积分），不触发真实支付。
import automator from 'miniprogram-automator';
import fs from 'node:fs';

const SHOT_DIR = 'E:\\AI-Station\\WeAppForge\\work\\e2e_v093_shots';
const RESULT = 'E:\\AI-Station\\WeAppForge\\work\\e2e_v093_result.json';
fs.mkdirSync(SHOT_DIR, { recursive: true });

const errors = [];
const consoleErrors = [];
const results = [];
const note = (name, ok, detail = '') => {
  results.push({ name, ok: !!ok, detail });
  console.log(`${ok ? 'PASS' : 'FAIL'} ${name}${detail ? ' | ' + detail : ''}`);
};
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

// IDE 已开：直连自动化口（由 cli auto --auto-port 9420 先开好）
const mp = await automator.connect({ wsEndpoint: 'ws://127.0.0.1:9420' });
mp.on('exception', (err) => errors.push(String((err && err.message) || err)));
mp.on('console', (msg) => {
  if (msg.type === 'error') consoleErrors.push(String(msg.args).slice(0, 300));
});

// 1) 入口页 = ask（pages[0]；模拟器可能有上轮残留页 → reLaunch 归位后再断言，静态次序门在 bootsim）
await mp.reLaunch('/pages/ask/ask');
await sleep(2500);
let page = await mp.currentPage();
note('entry_is_ask', page.path === 'pages/ask/ask', page.path);

// 2) AI 提示一页一处：ask 无重复 banner，hero 药丸唯一
try {
  const dupFlags = await page.$$('.ai-flag');
  const heroAi = await page.$$('.hero-ai');
  note('ask_ai_notice_single', dupFlags.length === 0 && heroAi.length === 1,
    `ai-flag=${dupFlags.length} hero-ai=${heroAi.length}`);
  await mp.screenshot({ path: `${SHOT_DIR}\\ask.png` });
} catch (e) { note('ask_ai_notice_single', false, String(e).slice(0, 140)); }

// 3) home 跳板：显式进 home 必落 ask（404 根治机制仍在）
page = await mp.reLaunch('/pages/home/home');
await sleep(3000);
page = await mp.currentPage();
note('home_trampoline_to_ask', page.path === 'pages/ask/ask', 'landed=' + page.path);

// 4) 五 tab 逐一走
for (const p of ['pages/ask/ask', 'pages/pot/pot', 'pages/zhiku/zhiku',
                 'pages/research/research', 'pages/my/my']) {
  try {
    page = await mp.switchTab('/' + p);
    await sleep(2200);
    const cur = await mp.currentPage();
    note('tab_' + p.split('/')[1], cur.path === p, 'landed=' + cur.path);
    await mp.screenshot({ path: `${SHOT_DIR}\\${p.split('/')[1]}.png` });
  } catch (e) { note('tab_' + p.split('/')[1], false, String(e).slice(0, 140)); }
}

// 4b) 智库页深查（v0.9.3 六库同步：3+4+7+18+13+4=49 分组 + 新案例库/研报库）
try {
  page = await mp.switchTab('/pages/zhiku/zhiku');
  await sleep(2200);
  const zkPage = await mp.currentPage();
  const hstats = await zkPage.$$('.zk-hs');
  note('zhiku_hero_stats_band', hstats.length === 4, 'cells=' + hstats.length);
  let rows1 = await zkPage.$$('.zk-g-row');
  note('zhiku_accordion_first_open', rows1.length === 3, 'rows=' + rows1.length);
  const tls = await zkPage.$$('.zk-tl-item');
  note('zhiku_timeline_nodes', tls.length === 3, 'nodes=' + tls.length);
  // 六库头部：标题文本应含新库（案例库/研报库）
  const heads = await zkPage.$$('.zk-v-head');
  let headTexts = [];
  for (const h of heads.slice(0, 8)) headTexts.push(String(await h.text()).replace(/\s+/g, ''));
  const sixVaults = heads.length === 6;
  const hasNew = headTexts.some((t) => t.includes('案例库')) && headTexts.some((t) => t.includes('研报库'));
  note('zhiku_six_vaults', sixVaults, 'heads=' + heads.length + ' texts=' + headTexts.join('|').slice(0, 90));
  note('zhiku_new_vaults_present', hasNew, '案例库/研报库 in heads');
  // 点击第二库头部（企业库 4 组）→ 切换展开
  if (heads.length >= 2) {
    await heads[1].tap();
    await sleep(900);
    const zkPage2 = await mp.currentPage();
    const rows2 = await zkPage2.$$('.zk-g-row');
    note('zhiku_accordion_toggle', rows2.length === 4, 'rows2=' + rows2.length);
    await mp.screenshot({ path: `${SHOT_DIR}\\zhiku_accordion.png` });
  } else {
    note('zhiku_accordion_toggle', false, 'heads=' + heads.length);
  }
} catch (e) { note('zhiku_hero_stats_band', false, String(e).slice(0, 140)); }

// 4c) my 页版本标记 + 外观沉底顺序（1009 用户令：高频在上，外观设置区沉底）
try {
  page = await mp.switchTab('/pages/my/my');
  await sleep(1800);
  const myPage = await mp.currentPage();
  const all = await myPage.$$('view');
  let ver = '';
  for (const v of all) {
    const t = String(await v.text() || '');
    if (/v0\.9\.\d/.test(t)) { ver = (t.match(/v0\.9\.\d[^\s]*[^\n]{0,10}/) || [''])[0]; break; }
  }
  note('my_version_marker', ver.includes('v0.9.4'), 'marker=' + ver.trim());
  const kickers = await myPage.$$('.kicker');
  const ktexts = [];
  for (const k of kickers) ktexts.push(String(await k.text() || '').trim());
  const iRec = ktexts.findIndex((t) => t.includes('RECORDS'));
  const iAp = ktexts.findIndex((t) => t.includes('APPEARANCE'));
  note('my_appearance_at_bottom', iRec >= 0 && iAp > iRec, 'kickers=' + ktexts.join('|'));
} catch (e) { note('my_version_marker', false, String(e).slice(0, 140)); }

// 5) 研究页：列表渲染 + 标签非空
try {
  page = await mp.switchTab('/pages/research/research');
  await sleep(4500);
  const items = await page.$$('.rs-item');
  note('research_list_rendered', items.length > 0, 'cards=' + items.length);
  const badges = await page.$$('.rs-badge');
  let emptyBadge = 0;
  for (const b of badges.slice(0, 30)) {
    const t = await b.text();
    if (!t || !t.trim()) emptyBadge++;
  }
  note('research_badges_nonempty', badges.length > 0 && emptyBadge === 0,
    `badges=${badges.length} empty=${emptyBadge}`);
  const hs = await page.$$('.rs-hs');
  note('research_hero_stats', hs.length === 3, 'cells=' + hs.length);
  await mp.screenshot({ path: `${SHOT_DIR}\\research.png` });
} catch (e) { note('research_list_rendered', false, String(e).slice(0, 140)); }

// 6) 报告详情：开页 + 试读结构化渲染（无裸 md 符号）
try {
  const rp = await mp.switchTab('/pages/research/research');
  await sleep(2500);
  const data = await rp.data();
  const first = (data && (data.shown || data.reports || []))[0];
  const sku = first && (first.sku || first.id);
  if (sku) {
    page = await mp.navigateTo('/pages/report/report?sku=' + sku);
    await sleep(4500);
    const cur = await mp.currentPage();
    note('report_detail_open', cur.path === 'pages/report/report', 'sku=' + sku);
    const ddata = await cur.data();
    const blocks = (ddata && ddata.sampleBlocks) || [];
    const mdNodes = await cur.$$('.rp-sample .md-p, .rp-sample .md-h1, .rp-sample .md-h2');
    note('report_sample_md_blocks', blocks.length > 0 && mdNodes.length > 0,
      `blocks=${blocks.length} rendered=${mdNodes.length}`);
    const raw = await cur.$('.rp-sample');
    const rawText = raw ? String(await raw.text()) : '';
    const bareMd = /(^|\n)\s*#{1,3}\s|\*\*/.test(rawText.slice(0, 3000));
    note('report_sample_no_bare_markdown', !bareMd,
      bareMd ? 'raw md symbols still visible' : 'clean render');
    const bar = await cur.$('.rp-bar');
    const barBtn = bar ? await bar.$('.rp-bar-btn') : null;
    const barTxt = barBtn ? String(await barBtn.text()) : '';
    note('report_sticky_buy_bar', !!bar && /购买解锁|打开 PDF/.test(barTxt), 'btn=' + barTxt.trim());
    await mp.screenshot({ path: `${SHOT_DIR}\\report_fold.png` });
    const more = await cur.$('.rp-sample-more');
    if (more) { await more.tap(); await sleep(1200); }
    await mp.screenshot({ path: `${SHOT_DIR}\\report_open.png` });
    await mp.navigateBack();
  } else {
    note('report_detail_open', false, 'no sku from research page data');
  }
} catch (e) { note('report_detail_open', false, String(e).slice(0, 160)); }

// 7) legal 隐私页可开
try {
  page = await mp.navigateTo('/pages/legal/privacy');
  await sleep(2000);
  const cur = await mp.currentPage();
  note('legal_privacy_open', cur.path === 'pages/legal/privacy', 'landed=' + cur.path);
  await mp.navigateBack();
} catch (e) { note('legal_privacy_open', false, String(e).slice(0, 140)); }

// 8) 全程零 JS 异常 / 零 console error
await sleep(1200);
note('zero_exception', errors.length === 0, errors.slice(0, 3).join(' ;; ').slice(0, 300));
note('zero_console_error', consoleErrors.length === 0,
  consoleErrors.slice(0, 3).join(' ;; ').slice(0, 300));

const failed = results.filter((r) => !r.ok);
console.log('\n==== E2E v0.9.3 WALK: ' +
  `${results.length - failed.length}/${results.length} PASS ====`);
fs.writeFileSync(RESULT, JSON.stringify({ results, errors, consoleErrors }, null, 2));
await mp.disconnect();
process.exit(failed.length ? 1 : 0);
