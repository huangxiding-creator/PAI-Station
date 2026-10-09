// e2e_v092_popdown.mjs — v0.9.12 弹窗清理五连令运行时断言（用户令 1011：只留非常必要的弹窗）
// 三腿：①my 页版本信标=v0.9.12（兼磁盘码→devtools 重编译到位的判据）
//      ②ask 冷启动零弹窗 + 内联同意行在 DOM（隐私探窗下线的替代告知）
//      ③my 批量导出 tap → 零前置确认弹窗、直达支付链（loading 拉起支付 → vpay_call）
// 纪律：不做真实发票提交（企微推送副作用）；支付到 vpay 沙箱面板即收（取消路径）。
import automator from 'miniprogram-automator';
import fs from 'node:fs';

const SHOT_DIR = 'E:\\AI-Station\\WeAppForge\\work\\e2e_v092_shots';
const RESULT = 'E:\\AI-Station\\WeAppForge\\work\\e2e_v092_popdown_result.json';
fs.mkdirSync(SHOT_DIR, { recursive: true });

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
const shot = async (name) => {
  try { await mp.screenshot({ path: SHOT_DIR + String.fromCharCode(92) + name }); }
  catch (e) { console.log(`(shot ${name} skipped: ${String(e && e.message).slice(0, 60)})`); }
};

// ── S0 · my 页版本信标（=磁盘新码已进 devtools 的判据）──
await mp.reLaunch('/pages/my/my');
await sleep(2200);
let my = await mp.currentPage();
let md = await dataOf(my);
let beacon = '';
{
  const els = await my.$$('.muted');
  for (const el of els) {
    const t = String(await el.text() || '');
    if (t.indexOf('v0.9.') >= 0) { beacon = t.trim(); break; }
  }
}
note('my_version_beacon_0912', beacon.indexOf('v0.9.12') >= 0, `beacon="${beacon}"`);
await shot('s0_my.png');

// ── S1 · ask 冷启动：零弹窗 + 内联同意行在 DOM ──
await mp.callWxMethod('setStorageSync', 'qw_privacy_ok', 1); // 探针号既有记忆，冷启动直登
await mp.reLaunch('/pages/ask/ask');
await sleep(2400);
const ask = await mp.currentPage();
const ad = await dataOf(ask);
note('ask_coldstart_no_popup', ad.popOpen === false, `popOpen=${ad.popOpen} popMode="${ad.popMode || ''}"`);
let inlineConsent = '';
{
  const hints = await ask.$$('.opt-hint');
  for (const h of hints) {
    const t = String(await h.text() || '');
    if (t.indexOf('提交即同意') >= 0) { inlineConsent = t.trim(); break; }
  }
}
note('ask_inline_consent_visible', inlineConsent.indexOf('提交即同意用户协议与隐私政策') >= 0
  && inlineConsent.indexOf('AI 生成') >= 0, `text="${inlineConsent.slice(0, 50)}"`);
await shot('s1_ask_inline.png');

// ── S2 · my 批量导出：tap → 零确认弹窗，直达支付链 ──
await mp.reLaunch('/pages/my/my');
await sleep(2200);
my = await mp.currentPage();
md = await dataOf(my);
// 装钩：抓 export_all_sign 回包 + vpay 调用（同 pay probe 手法）
await mp.evaluate(() => {
  const g = getApp().globalData;
  g._popTrace = [];
  const origReq = wx.request;
  wx.request = (opt) => {
    const url = String((opt && opt.url) || '');
    if (url.indexOf('export_all_sign') >= 0) {
      const oc = opt.complete;
      opt.complete = (res) => {
        try { g._popTrace.push({ kind: 'http', status: res && res.statusCode }); } catch (e) { /* noop */ }
        oc && oc(res);
      };
    }
    return origReq.call(wx, opt);
  };
  const origVp = wx.requestVirtualPayment;
  if (typeof origVp === 'function') {
    wx.requestVirtualPayment = (opt) => {
      g._popTrace.push({ kind: 'vpay_call', hasSignData: !!(opt && opt.signData) });
      const f = opt.fail;
      opt.fail = (e) => { g._popTrace.push({ kind: 'vpay_fail', raw: JSON.stringify(e).slice(0, 120) }); f && f(e); };
      return origVp.call(wx, opt);
    };
  }
});
const unpaidAll = md.exportUnpaidAll;
const expBtn = await my.$('.export-all-btn');
if (!expBtn) {
  note('my_batch_tap_no_modal', false, '.export-all-btn not found');
} else {
  const errBefore = errors.length;
  await expBtn.tap();
  await sleep(1400);
  md = await dataOf(my);
  // 判据①：无确认 modal/sheet 弹出（loading 态允许——那是支付链 loading，不是确认弹窗）
  const confirmModal = md.popOpen === true && md.popMode === 'modal';
  note('my_batch_tap_no_confirm_modal', confirmModal === false,
    `popOpen=${md.popOpen} popMode="${md.popMode || ''}" unpaidAll=${unpaidAll}`);
  await shot('s2_my_after_tap.png');
  // 判据②：支付链已发动（loading 弹起 或 vpay/签名钩已命中）
  const payLoading = md.popOpen === true && md.popMode === 'load';
  const tr = await mp.evaluate(() => (getApp().globalData._popTrace || []));
  const hitSign = tr.some((t) => t.kind === 'http' && t.status === 200);
  const hitVpay = tr.some((t) => t.kind === 'vpay_call');
  note('my_batch_pay_chain_fired', payLoading || hitSign || hitVpay,
    `loading=${payLoading} sign200=${hitSign} vpay=${hitVpay} trace=${JSON.stringify(tr).slice(0, 160)}`);
  note('my_batch_no_new_exception', errors.length === errBefore, `newErr=${errors.length - errBefore}`);
  // 收口：loading 若仍转，关闭弹层（点 mask 由组件兜底）；native 沙箱面板由 devtools 呈现，reLaunch 即离场
  await sleep(2600);
  md = await dataOf(my);
  if (md.popOpen === true && md.popMode === 'load') {
    note('my_batch_loading_state', true, `still loading after 4s (sandbox panel path) popOpen=${md.popOpen}`);
  }
}

// ── S3 · 收尾：回 ask 页，异常账清零断言 ──
await mp.reLaunch('/pages/ask/ask');
await sleep(1200);
note('no_exceptions_total', errors.length === 0, errors.slice(0, 3).join(' | '));

fs.writeFileSync(RESULT, JSON.stringify({ results, errors }, null, 2));
const fails = results.filter((r) => !r.ok);
console.log(`\nE2E v0.9.12 POPDOWN: ${results.length - fails.length}/${results.length} PASS`);
await mp.disconnect();
process.exit(fails.length ? 1 : 0);
