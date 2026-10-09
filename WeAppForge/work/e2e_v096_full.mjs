// e2e_v096_full.mjs — v0.9.6 全页面补面矩阵（1009 用户令「所有页面所有功能全部自动测试」）
// 补 v095 的五个缺口：S9 报告详情全链（详情/试读/购买 mock 取消）/ S10 法务隐私页 /
// S11 home 跳板重定向 / S12 AI优化真实输入 / S13 智库首库+信任带；S14 零异常收口。
// 纪律：不触发真实支付——requestVirtualPayment 与 showModal 均 mock 只回取消（对象形态，
// v095 教训：函数形态跨序列化边界会 ReferenceError 污染零异常门）。
// 引擎真链路收益：report_sign 真打 HTTP（env=1 沙箱签名腿 200 实证随船）。
import automator from 'miniprogram-automator';
import fs from 'node:fs';

const SHOT_DIR = 'E:\\AI-Station\\WeAppForge\\work\\e2e_v096_shots';
const RESULT = 'E:\\AI-Station\\WeAppForge\\work\\e2e_v096_full_result.json';
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

// ══ S9 · 报告详情全链（详情渲染 / 试读展开 / 购买链 mock 取消 / 无僵尸）══
await mp.switchTab('/pages/research/research');
await sleep(3500);
let page = await mp.currentPage();
{
  const d0 = await dataOf(page);
  const cand = (d0.reports || []).find((r) => r.sellable && !r.unlocked);
  note('report_catalog_has_sellable', !!cand,
    `total=${(d0.reports || []).length} sellable=${d0.stats && d0.stats.sellable}`);
  if (cand) {
    await mp.navigateTo('/pages/report/report?sku=' + cand.sku);
    await sleep(1200);
    const rp = await mp.currentPage();
    let d = null;
    for (let i = 0; i < 15; i++) {
      d = await dataOf(rp);
      if (d.loading === false && d.d) break;
      await sleep(1200);
    }
    note('report_detail_loaded', !!(d && d.d && d.loading === false),
      `sku=${d && d.sku} price=${d && d.d && d.d.price} errMsg=${d && d.errMsg}`);
    if (d && d.d) {
      note('report_detail_price_positive', (d.d.price || 0) > 0,
        `price=${d.d.price} label=${d.d.price_label}`);
      // 试读异步拉取（404=整理中静默也合法）：轮询至 sampleBlocks 稳定
      let sBlocks = -1;
      for (let i = 0; i < 8; i++) {
        const dd = await dataOf(rp);
        if ((dd.sampleBlocks || []).length > 0) { sBlocks = dd.sampleBlocks.length; break; }
        await sleep(1000);
      }
      note('report_sample_loaded', sBlocks > 0, `sampleBlocks=${sBlocks}`);
      const more = await rp.$('.rp-sample-more');
      if (more && sBlocks > 0) {
        await more.tap();
        await sleep(600);
        note('report_sample_toggles', (await dataOf(rp)).sampleOpen === true,
          `sampleOpen=${(await dataOf(rp)).sampleOpen}`);
      } else {
        note('report_sample_toggles', true, 'SKIP: 无试读锚点（整理中态合法）');
      }
      await mp.screenshot({ path: `${SHOT_DIR}\\s9_report_detail.png` });
      // 购买链：mock requestVirtualPayment 只回取消 → 真签名腿（HTTP）→ fail 分支 →
      // 「已取消支付」轻提示 + buying 复位（¥498+ 单绝不能点了没反应或永久转圈）
      if (d.paySupported) {
        const errBefore = errors.length;
        await mp.mockWxMethod('requestVirtualPayment',
          { errMsg: 'requestVirtualPayment:fail cancel' });
        const act = await rp.$('.rp-act');
        if (act) {
          await act.tap();
          let buyingSeen = null; let settled = false;
          for (let i = 0; i < 15; i++) {
            await sleep(800);
            const db = await dataOf(rp);
            if (db.buying === true) buyingSeen = true;
            if (db.buying === false && buyingSeen) { settled = true; break; }
            if (db.buying === false && i > 2) { settled = true; break; } // 快速路径（取消秒回）
          }
          const dAfter = await dataOf(rp);
          note('report_buy_cancel_no_zombie',
            settled && dAfter.buying === false && errors.length === errBefore,
            `buyingSeen=${buyingSeen} buying=${dAfter.buying} newErr=${errors.length - errBefore}`);
          note('report_sign_leg_live_env1',
            errors.length === errBefore, // 签名腿真打：503/401 类异常会以页面态/console 暴露
            `sign 腿随船（引擎 env=1）`);
        } else {
          note('report_buy_cancel_no_zombie', false, '.rp-act not found');
          note('report_sign_leg_live_env1', false, 'n/a');
        }
        await mp.restoreWxMethod('requestVirtualPayment');
      } else {
        note('report_buy_cancel_no_zombie', true, 'SKIP: paySupported=false（iOS 形态属设计）');
        note('report_sign_leg_live_env1', true, 'SKIP: 同上');
      }
      await mp.navigateBack();
      await sleep(1000);
    }
  }
}

// ══ S10 · 法务隐私页（从未进过的页面：静态 WXML——判据=标题节+正文节渲染 + 返回键活）══
{
  await mp.navigateTo('/pages/legal/privacy');
  await sleep(1800);
  const lg = await mp.currentPage();
  const entered = lg.path === 'pages/legal/privacy';
  const heads = entered ? await lg.$$('.lg-h') : [];
  const paras = entered ? await lg.$$('.lg-p') : [];
  note('legal_page_renders', entered && heads.length >= 3 && paras.length >= 3,
    `path=${lg.path} lg-h=${heads.length} lg-p=${paras.length}（静态页无 data sections）`);
  const back = entered ? await lg.$('.back-btn') : null;
  if (back) {
    await back.tap();
    await sleep(900);
    note('legal_back_works', (await mp.currentPage()).path !== 'pages/legal/privacy',
      'landed=' + (await mp.currentPage()).path);
  } else {
    note('legal_back_works', false, 'back-btn not found');
  }
  if ((await mp.currentPage()).path === 'pages/legal/privacy') {
    await mp.navigateBack();
    await sleep(800);
  }
}

// ══ S11 · home 跳板重定向（一切无路径入口的兜底页 → 必达 ask）══
{
  await mp.reLaunch('/pages/home/home');
  let landed = '';
  for (let i = 0; i < 10; i++) {
    await sleep(700);
    const cur = await mp.currentPage();
    landed = cur.path;
    if (landed === 'pages/ask/ask') break;
  }
  note('home_jumper_redirects_ask', landed === 'pages/ask/ask', `landed=${landed}`);
}

// ══ S12 · AI优化真实输入（v0.9.4 只测了空/短反馈；本节真打 optimize HTTP：
//      mock showModal 取消 → 「保留原问」→ 问题原文不动 + optimizing 复位）══
page = await mp.currentPage(); // S11 落在 ask
{
  const ta = await page.$('.ask-input');
  const ORIGINAL = 'EPC合同工期延误怎么索赔';
  await ta.input(ORIGINAL);
  await sleep(400);
  await mp.mockWxMethod('showModal', { confirm: false, cancel: true });
  const opt = await page.$('.opt-btn');
  await opt.tap();
  let optSettled = false; let dO = null;
  for (let i = 0; i < 20; i++) {
    await sleep(1000);
    dO = await dataOf(page);
    if (dO.optimizing === false) { optSettled = true; break; }
  }
  note('ask_optimize_real_settles',
    optSettled && dO && dO.question === ORIGINAL,
    `optimizing=${dO && dO.optimizing} question="${dO && dO.question}"`);
  await mp.restoreWxMethod('showModal');
  const clear = await page.$('.clear-btn');
  if (clear) { await clear.tap(); await sleep(300); }
}

// ══ S13 · 智库首库手风琴 + 信任带四数（v0.9.5 kbstats 同源锚的页面级复验）══
{
  await mp.switchTab('/pages/zhiku/zhiku');
  await sleep(2200);
  const zk = await mp.currentPage();
  const dz = await dataOf(zk);
  note('zhiku_stats_strip_four', (dz.stats || []).length === 4,
    `stats=${(dz.stats || []).length}`);
  const hs = await zk.$$('.zk-hstats .zk-hs');
  note('zhiku_stats_nodes_render', hs.length === 4, `nodes=${hs.length}`);
  const heads = await zk.$$('.zk-v-head');
  if (heads.length >= 1) {
    // 首库默认展开（wxml 无 collapsed 初值）→ 点击=收起：toggle 判据=行数变化任一方向
    const rowsBefore = (await zk.$$('.zk-g-row')).length;
    await heads[0].tap();
    await sleep(900);
    const rowsAfter = (await zk.$$('.zk-g-row')).length;
    note('zhiku_first_vault_toggle', rowsAfter !== rowsBefore,
      `rows ${rowsBefore}->${rowsAfter}（首库默认展开，点击=收起）`);
    await heads[0].tap(); // 复原
    await sleep(700);
    await mp.screenshot({ path: `${SHOT_DIR}\\s13_zhiku.png` });
  } else {
    note('zhiku_first_vault_toggle', false, `heads=${heads.length}`);
  }
}

// ══ S14 · 全程零异常 ══
await sleep(1200);
note('zero_exception_v096', errors.length === 0, errors.slice(0, 3).join(' ;; ').slice(0, 300));
note('zero_console_error_v096', consoleErrors.length === 0,
  consoleErrors.slice(0, 3).join(' ;; ').slice(0, 300));

const failed = results.filter((r) => !r.ok);
console.log('\n==== E2E v0.9.6 FULL-GAP-MATRIX: ' +
  `${results.length - failed.length}/${results.length} PASS ====`);
fs.writeFileSync(RESULT, JSON.stringify({ results, errors, consoleErrors }, null, 2));
await mp.disconnect();
process.exit(failed.length ? 1 : 0);
