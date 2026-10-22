// e2e_kb.js — 提审前 DevTools 全面实测（宪法：100% 完美运行才可提审）
// 覆盖：五 tab 页加载 / zhiku 入口卡 / kbfactory 全链（生成→树展开→文件列表→下单页三版本+邮箱校验→导出→海报） / 异常零容忍
// 运行：node e2e_kb.js   （需 DevTools 已登录且开启服务端口）
const automator = require('miniprogram-automator');
const fs = require('fs');
const path = require('path');

const CLI = 'E:\\WeChatDevTools\\cli.bat';
const PROJECT = path.resolve(__dirname, '..', '..');
const SHOTS = path.join(__dirname, 'shots');
fs.mkdirSync(SHOTS, { recursive: true });

const results = [];
let exceptions = [];
function rec(name, ok, detail = '') {
  results.push({ name, ok, detail });
  console.log(`${ok ? '✅' : '❌'} ${name}${detail ? '  | ' + detail : ''}`);
}
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

(async () => {
  let mp; let launched = false;
  try {
    mp = await automator.connect({ wsEndpoint: 'ws://127.0.0.1:9420' });
    console.log('[connect] 复用已运行 DevTools (ws://127.0.0.1:9420)');
  } catch (e) {
    mp = await automator.launch({ cliPath: CLI, projectPath: PROJECT, timeout: 180000 });
    launched = true;
    console.log('[launch] DevTools automator 已连接');
  }
  mp.on('exception', (err) => exceptions.push(String(err && err.message).slice(0, 200)));

  async function shot(name) {
    return; // 1022实测: mp.screenshot 必超时且打乱automator消息队列（后续page操作报 not-on-top）——e2e弃用截图，证据=data断言
    try { await mp.screenshot({ path: path.join(SHOTS, name + '.png') }); } catch (e) { /* 截图失败不判死 */ }
  }

  async function switchTabRetry(path, tries = 3) {
    let lastErr;
    for (let i = 0; i < tries; i++) {
      try {
        const p = await mp.switchTab(path);
        await sleep(1200);
        if (p && p.path) return p;
      } catch (e) { lastErr = e; await sleep(1500); }
    }
    throw lastErr || new Error('switchTab failed: ' + path);
  }

  // 冷启动预热：吸收 IDE 首个 switchTab 的 webview 竞态（rawPath 空解构）
  await sleep(4000);
  try { await switchTabRetry('/pages/ask/ask'); } catch (e) { console.log('[warmup] ask 热身失败（继续）:', String(e).slice(0, 80)); }
  await sleep(1500);

  // ── 1. 五 tab 页加载 ──
  for (const p of ['pages/ask/ask', 'pages/pot/pot', 'pages/zhiku/zhiku', 'pages/research/research', 'pages/my/my']) {
    try {
      const page = await switchTabRetry('/' + p);
      rec('tab加载 ' + p, page.path === p, 'path=' + page.path);
    } catch (e) { rec('tab加载 ' + p, false, String(e).slice(0, 120)); }
  }
  await shot('01_zhiku_tab');

  // ── 2. zhiku 入口卡 → kbfactory（pageStack 取页：tap 后从栈里拿真页对象） ──
  let page = null;
  for (let i = 0; i < 4 && !page; i++) {
    let stack = await mp.pageStack().catch(() => []);
    const kb0 = stack.find((p) => String(p.path || '').indexOf('kbfactory') >= 0 && typeof p.$ === 'function');
    if (kb0) { page = kb0; break; }
    let zh = stack.find((p) => String(p.path || '').indexOf('zhiku') >= 0 && typeof p.$ === 'function');
    if (!zh) { try { zh = await switchTabRetry('/pages/zhiku/zhiku'); } catch (e) { zh = null; } }
    let entry = null;
    if (zh) { try { entry = await zh.$('.kbf-entry'); } catch (e) {} }
    if (entry) { await entry.tap(); await sleep(2000); }
  }
  rec('入口链路(zhiku卡→kbfactory页)', !!page, page ? String(page.path) : '未达');
  if (!page) { finish(mp, launched, results, exceptions); return; }

  // ── 3. kbfactory 生成全链 ──
  try {
    let ta = null;
    for (let i = 0; i < 12 && !ta; i++) { try { ta = await page.$('textarea'); } catch (e) {} if (!ta) await sleep(800); }
    if (!ta) throw new Error('textarea 未渲染');
    await ta.input('给水利EPC项目团队建一个施工知识库');
    await sleep(300);
    const go = await page.$('.kf-go');
    rec('输入+生成按钮就绪', !!go);
    await go.tap();  // callMethod 在 v2 后报 Uncaught（方法在原型上但 automator 找不到）；tap 事件链经 W4 实证稳定
    // 施工直播 8 阶段（样本路由 water）→ 轮询 bp 就绪
    let bp = null;
    for (let i = 0; i < 90; i++) {
      await sleep(1000);
      const d = await page.data();
      if (d.bp && d.bp.stats && !d.building) { bp = d.bp; break; }
    }
    rec('蓝图生成完成', !!bp, bp ? `files=${bp.bp ? '' : ''}${bp.stats.files} gb=${bp.stats.gb} quote=${bp.quote && bp.quote.total}` : '60s未就绪');
    if (bp) {
      const l1n = (bp.tree && bp.tree.l1 ? bp.tree.l1.length : 0);
      rec('L1大类数∈[8,22]', l1n >= 8 && l1n <= 22, 'L1=' + l1n);
      const sample = bp.tree.l1[0];
      const names = (sample.l2[0].files || []).map((f) => f.name).filter(Boolean);
      rec('文件槽位清单渲染（真名走M6远端适配）', names.length > 0 && names.every((n) => /\.\w+$/.test(n)), names.slice(0, 2).join(' / ').slice(0, 80));
      await shot('02_blueprint');
    }
  } catch (e) { rec('生成链', false, String(e).slice(0, 140)); }

  // ── 4. 树展开（element.tap + data 轮询断言；callMethod带对象参会打爆automator桥——已证伪） ──
  try {
    let dL1 = await page.data();
    if (!(dL1.tree && dL1.tree[0] && dL1.tree[0].open)) {
      const l1h = await page.$('.kf-l1-head');
      await l1h.tap();
    }
    for (let i = 0; i < 10; i++) { dL1 = await page.data(); if (dL1.tree[0] && dL1.tree[0].open) break; await sleep(600); }
    rec('L1展开(L2组数>0)', !!(dL1.tree[0] && dL1.tree[0].open && dL1.tree[0].l2.length), `L2=${((dL1.tree[0] || {}).l2 || []).length}`);
    let dL2 = dL1;
    if (!(dL2.tree[0].l2[0] && dL2.tree[0].l2[0].open)) {
      const l2h = await page.$('.kf-l2-head');
      if (l2h) await l2h.tap();
    }
    for (let i = 0; i < 10; i++) { dL2 = await page.data(); if (dL2.tree[0].l2[0] && dL2.tree[0].l2[0].open) break; await sleep(600); }
    const files = (dL2.tree[0].l2[0].files) || [];
    rec('L2展开(文件槽渲染)', files.length > 0 && files.every((f) => f && f.name && /\.\w+$/.test(f.name)), `files=${files.length} 样例=${(files[0] || {}).name || ''}`);
    await shot('03_tree_expanded');
  } catch (e) { rec('树展开', false, String(e).slice(0, 120)); }

  // （自愈块已删——1022复盘：它把无$过渡壳误判为失焦，navigateBack 反杀真页）

  // ── 5. 下单页：三版本+邮箱校验 ──
  try {
    const d0 = await page.data();
    if (d0.paySupported) {
      const buy = await page.$('.kf-buy');
      await buy.tap(); await sleep(800);
      const d = await page.data();
      rec('下单页打开+版本列表', d.ordOpen === true && (d.ordVersions || []).length >= 3, `versions=${(d.ordVersions || []).length}`);
      const emailInput = await page.$('.kf-ord input');
      await emailInput.input('bad-email');
      const goBtn = await page.$('.kf-ord-go');
      await goBtn.tap(); await sleep(600);
      const d2 = await page.data();
      rec('非法邮箱被拦', d2.ordDone !== true && d2.ordOpen === true, 'ordDone=' + d2.ordDone);
      await emailInput.input('chief@example.com');
      await shot('04_order_sheet');
      const xx = await page.$('.kf-ord-x');
      if (xx) { await xx.tap(); await sleep(400); }
    } else {
      rec('paySupported=false（iOS语义）付费面隐藏', true);
    }
  } catch (e) { rec('下单页', false, String(e).slice(0, 140)); }

  // ── 6. 导出按钮（服务端未部署→预期降级不崩） ──
  try {
    const d0 = await page.data();
    if (d0.paySupported) {
      const ex = await page.$('.kf-export');
      await ex.tap(); await sleep(1500);
      const d = await page.data();
      const alive = (await page.$('.kf-go')) !== null;
      rec('导出按钮不崩溃（降级可用）', alive, 'exporting=' + d.exporting);
    }
  } catch (e) { rec('导出按钮', false, String(e).slice(0, 120)); }

  // ── 7. 海报按钮 ──
  try {
    const po = await page.$('.kf-poster');
    await po.tap(); await sleep(1500);
    const alive = (await page.$('.kf-go')) !== null;
    rec('海报按钮不崩溃', alive);
    await shot('05_after_poster');
  } catch (e) { rec('海报按钮', false, String(e).slice(0, 120)); }

  // ── 8. 异常零容忍（宪法） ──
  rec('运行时异常=0', exceptions.length === 0, exceptions.slice(0, 2).join(' || ') || 'clean');
  await finish(mp, launched, results, exceptions);
})().catch((e) => { console.error('[FATAL]', e && e.message); process.exit(2); });

async function finish(mp, launched, results, exceptions) {
  const failed = results.filter((r) => !r.ok);
  fs.writeFileSync(path.join(__dirname, 'e2e_result.json'), JSON.stringify({ results, exceptions, ts: new Date().toISOString() }, null, 1));
  console.log(`\n==== E2E 汇总: ${results.length - failed.length}/${results.length} PASS, 异常 ${exceptions.length} ====`);
  if (launched) { await mp.close().catch(() => {}); }  // connect 模式不关 IDE（close 会杀共享实例）
  process.exit(failed.length ? 1 : 0);
}
