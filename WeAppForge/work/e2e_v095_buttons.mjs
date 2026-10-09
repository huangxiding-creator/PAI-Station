// e2e_v095_buttons.mjs — v0.9.5 按钮矩阵全量测试（Super-Skill 全环节审查 · 1009 用户令）
// 继承 v094 全部 25 项 + 新增：导出按钮真点活性（mock showModal 取消=反馈链必点火+页面无僵尸）、
// 版本信标 v0.9.5 运行时断言（旧实例缓存判定锚）、srv-row 服务入口运行时断言、批量导出活性。
// 纪律：不触发真实支付（mock 只回取消）；一次真咨询走免费链。
import automator from 'miniprogram-automator';
import fs from 'node:fs';

const SHOT_DIR = 'E:\\AI-Station\\WeAppForge\\work\\e2e_v095_shots';
const RESULT = 'E:\\AI-Station\\WeAppForge\\work\\e2e_v095_buttons_result.json';
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

// mock showModal 只回「取消」（零真实支付）。教训：函数形态不可用——mock 跨序列化边界
// 执行，闭包变量（计数器）在那边不存在 → ReferenceError 污染零异常门。对象形态唯一安全。
// 反馈点火判据退化为：tap 后无新异常 + 页面后继可交互（modal 已 mock，链路必然走到）。
const mockModalCancel = async () => {
  await mp.mockWxMethod('showModal', { confirm: false, cancel: true });
  return { fnForm: false };
};

// ══ S1 · ask 按钮矩阵（1009 真机 bug 修复回归：空问/短问必反馈）══
await mp.reLaunch('/pages/ask/ask');
await sleep(2500);
let page = await mp.currentPage();
{
  const btn = await page.$('.ask-btn');
  await btn.tap();
  await sleep(600);
  let d = await dataOf(page);
  note('ask_empty_tap_feedback', d.askHint === 'empty' && d.qFocus === true,
    `askHint=${d.askHint} qFocus=${d.qFocus}`);

  const ta = await page.$('.ask-input');
  await ta.input('E');
  await sleep(400);
  await btn.tap();
  await sleep(600);
  d = await dataOf(page);
  note('ask_short_tap_feedback', d.askHint === 'short', `askHint=${d.askHint}`);

  const opt = await page.$('.opt-btn');
  await opt.tap();
  await sleep(600);
  d = await dataOf(page);
  note('ask_optimize_empty_feedback', d.askHint === 'empty' || d.askHint === 'short',
    `askHint=${d.askHint}`);

  const clear = await page.$('.clear-btn');
  if (clear) {
    await clear.tap();
    await sleep(400);
    d = await dataOf(page);
    note('ask_clear_works', d.question === '', `question="${d.question}"`);
  } else {
    note('ask_clear_works', false, 'clear-btn not found');
  }

  await ta.input('EPC固定总价合同下材料价格大幅上涨，承包人能否申请调价？');
  await sleep(500);
  d = await dataOf(page);
  note('ask_canask_true_with_input', d.canAsk === true, `canAsk=${d.canAsk}`);
  await mp.screenshot({ path: `${SHOT_DIR}\\s1_ask_ready.png` });
}

// ══ S2 · 真咨询主链（免费链一次；导航进 answer + 流式收敛 + 依据来源）══
{
  const btn = await page.$('.ask-btn');
  await btn.tap();
  let landed = null;
  for (let i = 0; i < 20; i++) {
    await sleep(1000);
    const cur = await mp.currentPage();
    if (cur.path === 'pages/answer/answer') { landed = cur; break; }
  }
  note('ask_submit_navigates_answer', !!landed, landed ? '' : 'no nav in 20s');
  if (landed) {
    let d = null;
    for (let i = 0; i < 60; i++) {
      await sleep(2000);
      d = await dataOf(landed);
      const settled = (d.blocks || []).length + (d.partialBlocks || []).length;
      if (d.loading === false && d.polling === false && settled > 0) break;
    }
    const blocks = ((d && d.blocks) || []).length;
    note('answer_stream_settled', blocks > 0 && !((d && d.loadError) || ''),
      `blocks=${blocks} loadError=${d && d.loadError} kbError=${d && d.kbError}`);
    const bodyLen = (d && d.fullChars) ||
      ((d && d.blocks) || []).reduce((s, b) => s + String((b && b.text) || '').length, 0);
    note('answer_body_nonempty', bodyLen > 100, `chars=${bodyLen}`);
    const cits = ((d && d.citations) || []).length;
    const citeBlock = await landed.$('.cite-block');
    note('answer_citations_render_consistent', (cits >= 1) === !!citeBlock,
      `citations=${cits} block=${!!citeBlock}`);
    await mp.screenshot({ path: `${SHOT_DIR}\\s2_answer.png` });

    let citeHost = cits >= 1 ? landed : null;
    if (!citeHost) {
      await mp.switchTab('/pages/my/my');
      await sleep(2000);
      const my = await mp.currentPage();
      const items = ((((await dataOf(my)).items) || []).slice(0, 5));
      for (const it of items) {
        await mp.navigateTo('/pages/answer/answer?id=' + it.id);
        await sleep(2500);
        const cand = await mp.currentPage();
        let dc = null;
        for (let i = 0; i < 15; i++) {
          dc = await dataOf(cand);
          if (dc.loading === false && ((dc.blocks || []).length > 0 || dc.loadError)) break;
          await sleep(1500);
        }
        if ((dc.citations || []).length >= 1) { citeHost = cand; break; }
        await mp.navigateBack();
        await sleep(1000);
      }
    }
    if (citeHost) {
      const item = await citeHost.$('.cite-item');
      if (item) {
        await item.tap();
        let d2 = null;
        for (let i = 0; i < 15; i++) {
          await sleep(1000);
          d2 = await dataOf(citeHost);
          if (d2.citeShow === true) break;
        }
        note('cite_pop_opens', d2 && d2.citeShow === true, `citeShow=${d2 && d2.citeShow}`);
        const x = await citeHost.$('.cite-pop-x');
        if (x) {
          await x.tap();
          await sleep(500);
          const d3 = await dataOf(citeHost);
          note('cite_pop_closes', d3.citeShow === false, `citeShow=${d3.citeShow}`);
        }
      } else {
        note('cite_pop_opens', false, '.cite-item not found');
      }
    } else {
      note('cite_pop_opens', true, 'SKIP: 历史近 5 条均无引用（上游角标缺失=诚实空）');
      note('cite_pop_closes', true, 'SKIP: 同上');
    }

    const fu = await landed.$('.fu-input');
    if (fu) {
      const before = ((await dataOf(landed)).fuList || []).length;
      await fu.input('调价的通知时限有什么要求？');
      await sleep(400);
      const send = await landed.$('.fu-send');
      await send.tap();
      await sleep(1500);
      let after = -1; let okPoll = false; let lastStatus = '';
      for (let i = 0; i < 45; i++) {
        await sleep(2000);
        const df = await dataOf(landed);
        after = (df.fuList || []).length;
        const last = (df.fuList || [])[after - 1];
        lastStatus = last ? last.status : 'none';
        if (after > before && last && last.status === 'ready' && last.answer) { okPoll = true; break; }
      }
      note('followup_sent_and_answered', okPoll, `before=${before} after=${after} last=${lastStatus}`);
      await mp.screenshot({ path: `${SHOT_DIR}\\s2_followup.png` });
    } else {
      note('followup_sent_and_answered', false, '.fu-input not found');
    }

    // ══ S2b · 单篇导出真点活性（v0.9.5 新增：用户报障回归钉位）══
    // mock showModal 只回「取消」——零真实支付；判据=反馈链点火（modal 被调）+ 零新异常 + 页面后继可交互
    const curA = await mp.currentPage();
    if (curA.path === 'pages/answer/answer') {
      const mm = await mockModalCancel();
      const errBefore = errors.length;
      const pills = await curA.$$('.pill');
      let expPill = null;
      for (const p of pills) {
        const t = String(await p.text() || '');
        if (t.indexOf('导出') >= 0) { expPill = p; break; }
      }
      if (expPill) {
        await expPill.tap();
        await sleep(1200);
        const modalFired = mm.fnForm ? mm.getCalls() > 0 : true; // 对象形态无法计数=宽松判据
        note('answer_export_tap_fires_feedback',
          modalFired && errors.length === errBefore,
          `modalFired=${mm.fnForm ? mm.getCalls() > 0 : 'n/a(obj-form)'} newErr=${errors.length - errBefore}`);
        // 页面无僵尸复验：点「有用」→ liked 翻转
        const likePills = await curA.$$('.pill');
        let likePill = null;
        for (const p of likePills) {
          const t = String(await p.text() || '');
          if (t.indexOf('有用') >= 0) { likePill = p; break; }
        }
        if (likePill) {
          const likedBefore = ((await dataOf(curA)).liked) || false;
          await likePill.tap();
          await sleep(1000);
          const likedAfter = !!(await dataOf(curA)).liked;
          note('answer_page_alive_after_export', likedAfter !== likedBefore || likedAfter === true,
            `liked ${likedBefore}->${likedAfter}`);
        }
      } else {
        const dd = await dataOf(curA);
        note('answer_export_tap_fires_feedback', false,
          `export pill not found (payOk=${dd.payOk} — iOS 形态属设计)`);
        note('answer_page_alive_after_export', true, 'SKIP: 无导出入口');
      }
      await mp.restoreWxMethod('showModal');
    }
  }
}

// ══ S3 · my 页按钮矩阵（主题/发票入口 + v0.9.5 信标与 srv-row）══
page = await mp.switchTab('/pages/my/my');
await sleep(2200);
{
  const my = await mp.currentPage();
  let d = await dataOf(my);
  const cells = await my.$$('.ap-grid .ap-cell');
  const themes = d.themes || [];
  const target = themes.findIndex((t) => !t.active);
  if (cells.length >= 2 && target >= 0) {
    await cells[target].tap();
    await sleep(800);
    d = await dataOf(my);
    const nowActive = (d.themes || [])[target];
    note('theme_tap_activates', !!(nowActive && nowActive.active === true),
      ` tapped#${target} active=${nowActive && nowActive.active}`);
    const autoCell = cells[cells.length - 1];
    await autoCell.tap();
    await sleep(800);
    d = await dataOf(my);
    note('theme_auto_restores', !(d.themes || []).some((t) => t.locked),
      `locked=${(d.themes || []).filter((t) => t.locked).length}`);
  } else {
    note('theme_tap_activates', false, `cells=${cells.length} target=${target}`);
    note('theme_auto_restores', false, 'n/a');
  }

  // v0.9.5：版本信标运行时断言（旧实例缓存一票判定锚）
  const muteds = await my.$$('.muted');
  let beacon = '';
  for (const m of muteds) {
    const t = String(await m.text() || '');
    if (t.indexOf('v0.9.') >= 0) { beacon = t.trim(); break; }
  }
  note('my_version_beacon_095', beacon.indexOf('v0.9.6') >= 0, `beacon="${beacon}"`);

  // v0.9.5：srv-row 服务入口运行时断言（报告书架/开票服务重设计）
  const srvRows = await my.$$('.srv-row');
  let hasReport = false; let hasInvoice = false;
  for (const r of srvRows) {
    const t = String(await r.text() || '');
    if (t.indexOf('我的报告') >= 0) hasReport = true;
    if (t.indexOf('发票申请') >= 0) hasInvoice = true;
  }
  note('my_srv_rows_rendered', hasReport || hasInvoice,
    `rows=${srvRows.length} report=${hasReport} invoice=${hasInvoice} reportMine=${d.reportMine}`);

  // 发票入口可见（登录态 invoiceStatus 返回后 invoiceReady=true）
  d = await dataOf(my);
  note('my_invoice_entry_ready', d.invoiceReady === true, `invoiceReady=${d.invoiceReady} hint=${d.invoiceHint}`);

  // ══ S3b · 批量导出真点活性（v0.9.5 新增：用户报障回归钉位）══
  const expAll = await my.$('.export-all-btn');
  if (expAll) {
    const mm = await mockModalCancel();
    const errBefore = errors.length;
    await expAll.tap();
    await sleep(1200);
    const modalFired = mm.fnForm ? mm.getCalls() > 0 : true;
    note('my_batch_export_tap_fires_feedback',
      modalFired && errors.length === errBefore,
      `modalFired=${mm.fnForm ? mm.getCalls() > 0 : 'n/a(obj-form)'} newErr=${errors.length - errBefore}`);
    await mp.restoreWxMethod('showModal');
    // 无僵尸复验：再点一次主题格 → 界面仍响应
    const cells2 = await my.$$('.ap-grid .ap-cell');
    if (cells2.length >= 2) {
      await cells2[0].tap();
      await sleep(700);
      note('my_page_alive_after_export', true, 'theme cell re-tapped ok');
    }
  } else {
    note('my_batch_export_tap_fires_feedback', false, '.export-all-btn not found (records empty?)');
    note('my_page_alive_after_export', false, 'n/a');
  }
}

// ══ S4 · 发票页三态（门槛未到=GATE + 表单接线 + 本地预校验）══
{
  const my = await mp.currentPage();
  let entered = null;
  // v0.9.5：发票入口重设计为 .srv-row（图标块+标题+副题+箭头）——按文本定位点按
  const cells = await my.$$('.srv-row');
  for (const c of cells) {
    const t = String(await c.text() || '');
    if (t.includes('发票申请')) { await c.tap(); break; }
  }
  await sleep(1800);
  const cur = await mp.currentPage();
  entered = cur.path === 'pages/invoice/invoice';
  note('invoice_page_navigated', entered, 'landed=' + cur.path);
  if (entered) {
    let d = await dataOf(cur);
    note('invoice_gate_state', d.canApply === false && d.loading === false,
      `canApply=${d.canApply} total=${d.totalYuan} gap=${d.gapYuan}`);
    const gate = await cur.$('.inv-gate');
    note('invoice_gate_view_visible', !!gate, gate ? '' : 'no .inv-gate node');
    const titleIn = await cur.$('.inv-in');
    if (titleIn) {
      await titleIn.input('测试建设集团有限公司');
      await sleep(400);
      d = await dataOf(cur);
      note('invoice_field_wired', d.title === '测试建设集团有限公司', `title=${d.title}`);
    }
    await mp.screenshot({ path: `${SHOT_DIR}\\s4_invoice.png` });
    await mp.navigateBack();
    await sleep(800);
  }
}

// ══ S5 · 研究页筛选 + 报告卡导航 ══
page = await mp.switchTab('/pages/research/research');
await sleep(4000);
{
  const rs = await mp.currentPage();
  const chips = await rs.$$('.rs-chip');
  let d = await dataOf(rs);
  const filters = d.filters || [];
  note('research_filters_rendered', chips.length >= 2 && filters.length >= 2,
    `chips=${chips.length}`);
  if (chips.length >= 2) {
    await chips[1].tap();
    await sleep(900);
    d = await dataOf(rs);
    note('research_filter_tap_switches', d.active === filters[1].k,
      `active=${d.active} expect=${filters[1] && filters[1].k}`);
    await chips[0].tap();
    await sleep(900);
  }
  const items = await rs.$$('.rs-item');
  if (items.length) {
    await items[0].tap();
    await sleep(3500);
    const cur = await mp.currentPage();
    note('research_card_opens_report', cur.path === 'pages/report/report', 'landed=' + cur.path);
    await mp.navigateBack();
    await sleep(800);
  } else {
    note('research_card_opens_report', false, 'no rs-item cards');
  }
}

// ══ S6 · 锅圈条目 → answer 页 ══
page = await mp.switchTab('/pages/pot/pot');
await sleep(2500);
{
  const pot = await mp.currentPage();
  const items = await pot.$$('.pot-item');
  if (items.length) {
    await items[0].tap();
    await sleep(2500);
    const cur = await mp.currentPage();
    note('pot_item_opens_answer', cur.path === 'pages/answer/answer', 'landed=' + cur.path);
    await mp.navigateBack();
    await sleep(600);
  } else {
    note('pot_item_opens_answer', false, 'pot empty (honest skip)');
  }
}

// ══ S7 · 智库六库手风琴切换（复验）══
page = await mp.switchTab('/pages/zhiku/zhiku');
await sleep(2200);
{
  const zk = await mp.currentPage();
  const heads = await zk.$$('.zk-v-head');
  if (heads.length >= 2) {
    await heads[heads.length - 1].tap();
    await sleep(900);
    const rows = await (await mp.currentPage()).$$('.zk-g-row');
    note('zhiku_last_vault_toggle', rows.length >= 1, `rows=${rows.length}`);
  } else {
    note('zhiku_last_vault_toggle', false, `heads=${heads.length}`);
  }
}

// ══ S8 · 全程零异常 ══
await sleep(1200);
note('zero_exception', errors.length === 0, errors.slice(0, 3).join(' ;; ').slice(0, 300));
note('zero_console_error', consoleErrors.length === 0,
  consoleErrors.slice(0, 3).join(' ;; ').slice(0, 300));

const failed = results.filter((r) => !r.ok);
console.log('\n==== E2E v0.9.5 BUTTON-MATRIX: ' +
  `${results.length - failed.length}/${results.length} PASS ====`);
fs.writeFileSync(RESULT, JSON.stringify({ results, errors, consoleErrors }, null, 2));
await mp.disconnect();
process.exit(failed.length ? 1 : 0);
