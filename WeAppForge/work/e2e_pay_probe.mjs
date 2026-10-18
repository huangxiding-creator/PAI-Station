// e2e_pay_probe.mjs — 报告支付拉不起来复现探针（用户缺陷 1009 晚：「购买解锁没有拉起支付」）
// 真链路：真登录(真session_key)→report页ENT-01→钩 wx.request/wx.requestVirtualPayment 抓原始回包→tap 购买→取证。
import automator from 'miniprogram-automator';
import fs from 'node:fs';

const RESULT = 'E:\\AI-Station\\WeAppForge\\work\\e2e_pay_probe_result.json';
const errors = [];
const log = [];
const note = (name, ok, detail = '') => {
  log.push({ name, ok: !!ok, detail });
  console.log(`${ok ? 'PASS' : 'INFO'} ${name}${detail ? ' | ' + detail : ''}`);
};
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
const dataOf = async (page) => (await page.data()) || {};

const mp = await automator.connect({ wsEndpoint: 'ws://127.0.0.1:9420' });
mp.on('exception', (err) => errors.push(String((err && err.message) || err)));

// ── S1 · 登录态（真 code2session → 引擎落真 session_key）──
await mp.callWxMethod('setStorageSync', 'qw_privacy_ok', 1);
await mp.reLaunch('/pages/ask/ask');
await sleep(1800);
let ask = await mp.currentPage();
let ad = await dataOf(ask);
for (let i = 0; i < 12 && !(ad.loginReady && ad.quota); i++) {
  await sleep(800);
  ad = await dataOf(ask);
}
note('login_ready', !!(ad.loginReady && ad.quota), `quota=${JSON.stringify(ad.quota)}`);

// ── S2 · 装钩：抓 unlock_sign HTTP 原始回包 + requestVirtualPayment 原始 fail/success ──
await mp.evaluate(() => {
  const g = getApp().globalData;
  g._payTrace = [];
  const origReq = wx.request;
  wx.request = (opt) => {
    const url = String((opt && opt.url) || '');
    if (url.indexOf('unlock_sign') >= 0 || url.indexOf('export_sign') >= 0) {
      const of = opt.fail; const os = opt.success; const oc = opt.complete;
      opt.complete = (res) => {
        try {
          g._payTrace.push({ kind: 'http', url: url.slice(-60), status: res && res.statusCode, body: JSON.stringify(res && res.data).slice(0, 400) });
        } catch (e) { /* noop */ }
        oc && oc(res);
      };
      opt.fail = of; opt.success = os;
    }
    return origReq.call(wx, opt);
  };
  const origVp = wx.requestVirtualPayment;
  if (typeof origVp === 'function') {
    wx.requestVirtualPayment = (opt) => {
      g._payTrace.push({ kind: 'vpay_call', hasSignData: !!(opt && opt.signData), mode: opt && opt.mode });
      const f = opt.fail; const s = opt.success;
      opt.fail = (e) => {
        g._payTrace.push({ kind: 'vpay_fail', raw: JSON.stringify(e).slice(0, 300) });
        f && f(e);
      };
      opt.success = (e) => {
        g._payTrace.push({ kind: 'vpay_ok', raw: JSON.stringify(e).slice(0, 200) });
        s && s(e);
      };
      return origVp.call(wx, opt);
    };
  }
  return 'hooks_set';
});

// ── S3 · 进报告详情 ENT-01，读页面状态 ──
await mp.navigateTo('/pages/report/report?sku=ENT-01');
await sleep(2500);
let rp = await mp.currentPage();
let rd = await dataOf(rp);
for (let i = 0; i < 10 && !rd.d; i++) {
  await sleep(800);
  rd = await dataOf(rp);
}
note('report_loaded', !!rd.d, `sku=${rd.sku} sellable=${rd.d && rd.d.sellable} unlocked=${rd.d && rd.d.unlocked} paySupported=${rd.paySupported} buying=${rd.buying}`);

if (!(rd.d && rd.d.sellable) || (rd.d && rd.d.unlocked)) {
  console.log(`SKIP: sellable=${rd.d && rd.d.sellable} unlocked=${rd.d && rd.d.unlocked}`);
  fs.writeFileSync(RESULT, JSON.stringify({ log, errors, skipped: true }, null, 2));
  await mp.disconnect();
  process.exit(0);
}

// ── S4 · 真点「购买解锁」→ 等 12s 收全链证据 ──
const buyBtn = await rp.$('.rp-bar .btn_primary, .rp-bar button, .rp-bar .buy-btn');
if (!buyBtn) {
  // 兜底：任何带 bindtap buy 的元素
  note('buy_btn_found', false, 'no .rp-bar button selector hit');
} else {
  note('buy_btn_found', true);
  await buyBtn.tap();
  await sleep(12000);
}
rp = await mp.currentPage();
rd = await dataOf(rp);
const trace = await mp.evaluate(() => (getApp().globalData._payTrace || []));
note('trace_captured', trace.length > 0, JSON.stringify(trace).slice(0, 600));
note('page_state_after', true, `buying=${rd.buying} popOpen=${rd.popOpen} popMode=${rd.popMode}`);
fs.writeFileSync(RESULT, JSON.stringify({ log, trace, pageState: { buying: rd.buying, popOpen: rd.popOpen, popMode: rd.popMode }, errors }, null, 2), 'utf8');
await mp.disconnect();
process.exit(0);
