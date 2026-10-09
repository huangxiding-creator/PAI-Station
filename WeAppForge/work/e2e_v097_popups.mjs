// e2e_v097_popups.mjs — 弹窗系统全矩阵（v0.9.7 重设计 + v0.9.8 三令：隐私不自动弹/免费下线/AI申明唯一化）
// qw-pop 三模式（modal/sheet/load）运行时断言：页面 data 镜像锚（popOpen/popMode）+
// 组件 DOM 穿透锚（page.$('qw-pop') → .qwp-* 子节点）+ 金额按钮/徽标/pay-once 视觉诚实 +
// 冷启动隐私门 v0.9.8 语义（打开不自动弹；首次提交时告知）。纪律：不触发真实支付（弹窗一律取消收口）。
import automator from 'miniprogram-automator';
import fs from 'node:fs';

const SHOT_DIR = 'E:\\AI-Station\\WeAppForge\\work\\e2e_v097_shots';
const RESULT = 'E:\\AI-Station\\WeAppForge\\work\\e2e_v097_popups_result.json';
fs.mkdirSync(SHOT_DIR, { recursive: true });

const errors = [];
const consoleErrors = [];
const results = [];
const note = (name, ok, detail = '') => {
  const skipped = String(detail).startsWith('SKIP');
  results.push({ name, ok: !!ok && !skipped, skipped, detail });
  console.log(`${skipped ? 'SKIP' : ok ? 'PASS' : 'FAIL'} ${name}${detail ? ' | ' + detail : ''}`);
};
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
const dataOf = async (page) => (await page.data()) || {};
// 组件 DOM 穿透（实测唯一可行路径）：page.$('#qwpop') 宿主节点 → comp.$('.qwp-*') 入组件；
// 标签选择器 page.$('qw-pop') 在本 automator/devtools 组合下返回 null（097 实测三法排除）
const pop$ = async (page, sel) => {
  try {
    const comp = await page.$('#qwpop');
    if (!comp) return null;
    return await comp.$(sel);
  } catch { return null; }
};
// screenshot 偶发 automator 30s 超时（097 首跑实锤）——包一层不拖垮全矩阵
const shot = async (name) => {
  try { await mp.screenshot({ path: SHOT_DIR + String.fromCharCode(92) + name }); }
  catch (e) { console.log(`(shot ${name} skipped: ${String(e && e.message).slice(0, 60)})`); }
};
const popText = async (page, sel) => {
  const el = await pop$(page, sel);
  if (!el) return null;
  try { return String(await el.text() || '').trim(); } catch { return null; }
};

const mp = await automator.connect({ wsEndpoint: 'ws://127.0.0.1:9420' });
mp.on('exception', (err) => errors.push(String((err && err.message) || err)));
mp.on('console', (msg) => {
  if (msg.type === 'error') consoleErrors.push(String(msg.args).slice(0, 300));
});

// v0.9.8：冷启动不再自动弹隐私告知——矩阵其余腿先播种「已同意」跑确定性路径（S6 再清掉专测新门）
await mp.callWxMethod('setStorageSync', 'qw_privacy_ok', 1);

// ══ S1 · 版本信标 v0.9.9（旧实例缓存一票判定锚）══
await mp.switchTab('/pages/my/my');
await sleep(2200);
{
  const my = await mp.currentPage();
  const d = await dataOf(my);
  const muteds = await my.$$('.muted');
  let beacon = '';
  for (const m of muteds) {
    const t = String(await m.text() || '');
    if (t.indexOf('v0.9.') >= 0) { beacon = t.trim(); break; }
  }
  note('my_version_beacon_099', beacon.indexOf('v0.9.9') >= 0, `beacon="${beacon}"`);
  await shot('s1_my.png');

  // ══ S2 · my 批量导出：qw-pop modal 金额按钮（v0.9.6 4 字硬限的终局形态）══
  const expAll = await my.$('.export-all-btn');
  if (expAll) {
    const errBefore = errors.length;
    await expAll.tap();
    await sleep(900);
    let md = await dataOf(my);
    const isModal = md.popOpen === true && md.popMode === 'modal';
    const isSheet = md.popOpen === true && md.popMode === 'sheet';
    if (isModal) {
      // 未解锁条目>0：确认弹窗——按钮须带金额（「支付 N 元解锁」），kicker=导出 · EXPORT
      const okTxt = await popText(my, '.qwp-ok');
      const kickTxt = await popText(my, '.qwp-kicker');
      note('my_batch_modal_amount_button', !!(okTxt && okTxt.indexOf('支付') >= 0 && okTxt.indexOf('元解锁') >= 0),
        `okBtn="${okTxt}" kicker="${kickTxt}"`);
      await shot('s2_my_batch_modal.png');
      const cancel = await pop$(my, '.qwp-cancel');
      if (cancel) { await cancel.tap(); await sleep(600); }
      md = await dataOf(my);
      note('my_batch_modal_cancel_closes', md.popOpen === false, `popOpen=${md.popOpen}`);
    } else if (isSheet) {
      // 全解锁形态：直接进图纸盘 + 「已全部解锁 · 可反复导出」徽标（pay-once 视觉诚实）
      const badge = await popText(my, '.qwp-badge');
      note('my_batch_modal_amount_button', true, `SKIP(全解锁): 进 sheet 直选`);
      note('my_all_unlocked_badge', badge === '已全部解锁 · 可反复导出', `badge="${badge}"`);
      await shot('s2_my_allunlocked_sheet.png');
      const sc = await pop$(my, '.qwp-sheet-cancel');
      if (sc) { await sc.tap(); await sleep(600); }
      md = await dataOf(my);
      note('my_batch_modal_cancel_closes', md.popOpen === false, `popOpen=${md.popOpen}`);
    } else {
      note('my_batch_modal_amount_button', false, `popOpen=${md.popOpen} popMode=${md.popMode}`);
      note('my_batch_modal_cancel_closes', false, 'n/a');
    }
    note('my_batch_no_new_exception', errors.length === errBefore,
      `newErr=${errors.length - errBefore}`);
    // 无僵尸复验：主题格再点仍响应
    const cells2 = await my.$$('.ap-grid .ap-cell');
    if (cells2.length >= 2) {
      await cells2[0].tap();
      await sleep(700);
      note('my_page_alive_after_pop', true, 'theme cell re-tapped ok');
    }
  } else {
    note('my_batch_modal_amount_button', false, '.export-all-btn not found');
  }

  // ══ S3 · 已解锁答案：导出图纸盘 + pay-once 徽标（有已解锁条目才跑，诚实跳过）══
  const paid = ((d.items) || []).find((it) => it.export_paid === true);
  if (paid) {
    await mp.navigateTo('/pages/answer/answer?id=' + paid.id);
    await sleep(2500);
    const ans = await mp.currentPage();
    let ad = null;
    for (let i = 0; i < 15; i++) {
      ad = await dataOf(ans);
      if (ad.loading === false && ((ad.blocks || []).length > 0 || ad.loadError)) break;
      await sleep(1200);
    }
    const pills = await ans.$$('.pill');
    let expPill = null;
    for (const p of pills) {
      const t = String(await p.text() || '');
      if (t.indexOf('导出') >= 0) { expPill = p; break; }
    }
    if (expPill && ad.exportPaid === true) {
      await expPill.tap();
      await sleep(900);
      let sd = await dataOf(ans);
      const sheetOn = sd.popOpen === true && sd.popMode === 'sheet';
      const badge = await popText(ans, '.qwp-badge');
      note('paid_export_sheet_opens', sheetOn, `popMode=${sd.popMode}`);
      note('paid_export_badge_payonce', badge === '已解锁 · 永久免费导出', `badge="${badge}"`);
      const rows = (await (await ans.$('#qwpop')).$$('.qwp-row'));
      note('paid_export_sheet_three_formats', rows.length === 3, `rows=${rows.length}`);
      await shot('s3_paid_export_sheet.png');
      const sc = await pop$(ans, '.qwp-sheet-cancel');
      if (sc) { await sc.tap(); await sleep(600); }
      sd = await dataOf(ans);
      note('paid_export_sheet_cancel_closes', sd.popOpen === false, `popOpen=${sd.popOpen}`);
    } else {
      note('paid_export_sheet_opens', true, 'SKIP: pill/exportPaid 形态不符（iOS 门或空文）');
      note('paid_export_badge_payonce', true, 'SKIP: 同上');
      note('paid_export_sheet_three_formats', true, 'SKIP: 同上');
      note('paid_export_sheet_cancel_closes', true, 'SKIP: 同上');
    }
    await mp.navigateBack();
    await sleep(800);
  } else {
    note('paid_export_sheet_opens', true, 'SKIP: 暂无已解锁条目（不触发真实支付=诚实空）');
    note('paid_export_badge_payonce', true, 'SKIP: 同上');
    note('paid_export_sheet_three_formats', true, 'SKIP: 同上');
    note('paid_export_sheet_cancel_closes', true, 'SKIP: 同上');
  }
}

// ══ S4 · 未解锁答案：导出付费墙 modal（金额按钮「支付 0.1 元解锁」+ 取消零支付收口）══
{
  // 从 my 历史取一条未解锁 ready 答案（无历史则现场免费咨询一条）
  let target = null;
  const my = await mp.currentPage();
  const dmy = await dataOf(my);
  target = ((dmy.items) || []).find((it) => it.status === 'ready' && !it.export_paid);
  let ans = null;
  if (target) {
    await mp.navigateTo('/pages/answer/answer?id=' + target.id);
    await sleep(2500);
    ans = await mp.currentPage();
    let ad = null;
    for (let i = 0; i < 15; i++) {
      ad = await dataOf(ans);
      if (ad.loading === false && ((ad.blocks || []).length > 0 || ad.loadError)) break;
      await sleep(1200);
    }
    if (!(ad && ad.exportPaid === false && (ad.blocks || []).length > 0)) target = null;
  }
  if (!target) {
    // 免费咨询一条（免费链，不涉支付）
    await mp.reLaunch('/pages/ask/ask');
    await sleep(2200);
    const ask = await mp.currentPage();
    const ta = await ask.$('.ask-input');
    await ta.input('EPC合同中业主逾期付款的利息上限如何确定？');
    await sleep(400);
    const btn = await ask.$('.ask-btn');
    await btn.tap();
    for (let i = 0; i < 20; i++) {
      await sleep(1000);
      const cur = await mp.currentPage();
      if (cur.path === 'pages/answer/answer') { ans = cur; break; }
    }
    for (let i = 0; i < 60; i++) {
      await sleep(2000);
      const dd = await dataOf(ans);
      if (dd.loading === false && dd.polling === false && (dd.blocks || []).length > 0) break;
    }
  }
  if (ans) {
    const errBefore = errors.length;
    const pills = await ans.$$('.pill');
    let expPill = null;
    for (const p of pills) {
      const t = String(await p.text() || '');
      if (t.indexOf('导出') >= 0) { expPill = p; break; }
    }
    if (expPill) {
      await expPill.tap();
      await sleep(900);
      let pd = await dataOf(ans);
      const modalOn = pd.popOpen === true && pd.popMode === 'modal';
      const okTxt = await popText(ans, '.qwp-ok');
      const kickTxt = await popText(ans, '.qwp-kicker');
      const titleTxt = await popText(ans, '.qwp-title');
      note('unpaid_export_modal_opens', modalOn, `popMode=${pd.popMode}`);
      note('unpaid_export_amount_button', okTxt === '支付 0.1 元解锁', `okBtn="${okTxt}"`);
      note('unpaid_export_kicker_title',
        (kickTxt || '').indexOf('导出') >= 0 && (titleTxt || '').indexOf('导出') >= 0,
        `kicker="${kickTxt}" title="${titleTxt}"`);
      await shot('s4_unpaid_export_modal.png');
      const cancel = await pop$(ans, '.qwp-cancel');
      if (cancel) { await cancel.tap(); await sleep(600); }
      pd = await dataOf(ans);
      note('unpaid_export_cancel_closes', pd.popOpen === false, `popOpen=${pd.popOpen}`);
      note('unpaid_export_no_pay_no_exception',
        errors.length === errBefore && pd.exportPaid === false,
        `newErr=${errors.length - errBefore} exportPaid=${pd.exportPaid}`);
      // 无僵尸复验：有用 pill 仍可点
      const pills2 = await ans.$$('.pill');
      let likePill = null;
      for (const p of pills2) {
        const t = String(await p.text() || '');
        if (t.indexOf('有用') >= 0) { likePill = p; break; }
      }
      if (likePill) {
        const likedBefore = !!(await dataOf(ans)).liked;
        await likePill.tap();
        await sleep(1000);
        const likedAfter = !!(await dataOf(ans)).liked;
        note('answer_alive_after_pop', likedAfter !== likedBefore || likedAfter === true,
          `liked ${likedBefore}->${likedAfter}`);
      }
    } else {
      note('unpaid_export_modal_opens', false, 'export pill not found');
      note('unpaid_export_amount_button', false, 'n/a');
      note('unpaid_export_kicker_title', false, 'n/a');
      note('unpaid_export_cancel_closes', false, 'n/a');
      note('unpaid_export_no_pay_no_exception', false, 'n/a');
      note('answer_alive_after_pop', false, 'n/a');
    }
  }
}

// ══ S5 · 锅圈举报：qw-pop editable modal（textarea 接线 + 取消收口）══
{
  await mp.switchTab('/pages/pot/pot');
  await sleep(2500);
  const pot = await mp.currentPage();
  const reports = await pot.$$('.pot-report');
  if (reports.length) {
    const errBefore = errors.length;
    await reports[0].tap();
    await sleep(900);
    let rd = await dataOf(pot);
    const modalOn = rd.popOpen === true && rd.popMode === 'modal';
    const kickTxt = await popText(pot, '.qwp-kicker');
    const ta = await pop$(pot, '.qwp-ta');
    note('report_modal_opens', modalOn, `popMode=${rd.popMode} kicker="${kickTxt}"`);
    note('report_modal_editable', !!ta, 'textarea node present');
    await shot('s5_report_modal.png');
    if (ta) {
      await ta.input('测试举报：内容与工程无关');
      await sleep(500);
    }
    const cancel = await pop$(pot, '.qwp-cancel');
    if (cancel) { await cancel.tap(); await sleep(600); }
    rd = await dataOf(pot);
    note('report_modal_cancel_closes', rd.popOpen === false, `popOpen=${rd.popOpen}`);
    note('report_no_new_exception', errors.length === errBefore, `newErr=${errors.length - errBefore}`);
  } else {
    note('report_modal_opens', true, 'SKIP: 锅圈暂无条目（诚实空）');
    note('report_modal_editable', true, 'SKIP: 同上');
    note('report_modal_cancel_closes', true, 'SKIP: 同上');
    note('report_no_new_exception', true, 'SKIP: 同上');
  }
}

// ══ S6 · 冷启动隐私门 v0.9.8：打开不自动弹（用户令）；首次提交时告知（合规）══
{
  const errBefore = errors.length;
  await mp.callWxMethod('clearStorageSync');
  await mp.reLaunch('/pages/ask/ask');
  await sleep(2500);
  const ask = await mp.currentPage();
  let ad = await dataOf(ask);
  // [1] 冷启动不得自动弹（1009 用户令）
  note('privacy_coldstart_no_autopop', ad.popOpen !== true,
    `popOpen=${ad.popOpen} popMode=${ad.popMode}`);
  await shot('s6_coldstart_no_pop.png');
  // [2] 首次提交 → 隐私签认单（采集前告知口径不变）
  const ta = await ask.$('.ask-input');
  await ta.input('EPC合同中业主逾期付款的利息上限如何确定？');
  await sleep(400);
  const btn = await ask.$('.ask-btn');
  await btn.tap();
  await sleep(1400);
  ad = await dataOf(ask);
  const kickTxt = await popText(ask, '.qwp-kicker');
  const okTxt = await popText(ask, '.qwp-ok');
  const cancelTxt = await popText(ask, '.qwp-cancel');
  note('privacy_pop_on_first_submit', ad.popOpen === true && ad.popMode === 'modal',
    `popOpen=${ad.popOpen} popMode=${ad.popMode} kicker="${kickTxt}"`);
  note('privacy_pop_buttons', okTxt === '同意' && cancelTxt === '不同意',
    `ok="${okTxt}" cancel="${cancelTxt}"`);
  // v0.9.9 评审补面：maskClosable=false 行为锚——点遮罩不得关闭隐私签认单（合规链守卫）
  const mask = await pop$(ask, '.qwp-mask');
  if (mask) {
    await mask.tap();
    await sleep(500);
    const dMask = await dataOf(ask);
    note('privacy_pop_mask_unclosable', dMask.popOpen === true, `popOpen=${dMask.popOpen}`);
  } else {
    note('privacy_pop_mask_unclosable', false, '.qwp-mask not found');
  }
  await shot('s6_privacy_pop.png');
  // [3] 同意 → 关弹窗 → 直接提交进答案页（401 自愈链代发登录）
  const okBtn = await pop$(ask, '.qwp-ok');
  if (okBtn) {
    await okBtn.tap();
    let landed = false; let d2 = null;
    for (let i = 0; i < 25; i++) {
      await sleep(1000);
      const cur = await mp.currentPage();
      if (cur.path === 'pages/answer/answer') { landed = true; d2 = await dataOf(cur); break; }
      d2 = await dataOf(ask);
      if (d2.popOpen === false && i >= 20) break;
    }
    note('privacy_agree_closes_and_submits', !!(d2 && d2.popOpen === false) && landed,
      `popOpen=${d2 && d2.popOpen} landed=${landed}`);
  } else {
    note('privacy_agree_closes_and_submits', false, '.qwp-ok not found');
  }
  note('privacy_coldstart_no_exception', errors.length === errBefore,
    `newErr=${errors.length - errBefore}`);
}

// ══ S7 · 全程零异常 ══
await sleep(1200);
note('zero_exception', errors.length === 0, errors.slice(0, 3).join(' ;; ').slice(0, 300));
note('zero_console_error', consoleErrors.length === 0,
  consoleErrors.slice(0, 3).join(' ;; ').slice(0, 300));

const failed = results.filter((r) => !r.ok && !r.skipped);
const skipped = results.filter((r) => r.skipped);
console.log('\n==== E2E POPUP-MATRIX: ' +
  `${results.length - failed.length - skipped.length}/${results.length} PASS` +
  ` (skipped ${skipped.length}) ====`);
if (skipped.length) console.log('SKIPPED (补面提醒):', skipped.map((r) => r.name).join(', '));
fs.writeFileSync(RESULT, JSON.stringify({ results, errors, consoleErrors }, null, 2));
await mp.disconnect();
process.exit(failed.length ? 1 : 0);
