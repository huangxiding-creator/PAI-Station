// 逻辑回归 harness — 总包标讯 v0.2.0
// wx 桩 + Page 桩 + 真引擎（QW_DEV_LOGIN/QW_FAKE_ASK 双闸进程）
// 场景A 全链：登录→配额→canAsk→提问→答案页(全文/引用/点赞)→我的页(历史/时间格式化)
// 场景B 配额耗尽：第4问→402→点赞引导弹窗
// 场景C 空态：全新 openid→历史空→去提问 CTA 数据就绪
const assert = require('assert');

// 指到本机带闸测试实例（8870），生产 8869 不受扰
global.__QW_BASE__ = process.env.QW_HARNESS_BASE || 'http://127.0.0.1:8870';
const BASE = require('E:/AI-Station/WeAppForge/projects/biaoxun/utils/config.js').BASE_URL;
const api = require('E:/AI-Station/WeAppForge/projects/biaoxun/utils/api.js');
let RUN_CODE = 'harness-a-' + Date.now();

const toasts = [];
const modals = [];
const navs = [];

global.wx = {
  _store: {},
  getStorageSync(k) { return k in this._store ? this._store[k] : ''; },
  setStorageSync(k, v) { this._store[k] = v; },
  removeStorageSync(k) { delete this._store[k]; },
  login(o) { o.success({ code: RUN_CODE }); },
  request(o) {
    fetch(o.url, {
      method: o.method,
      headers: o.header,
      body: o.data ? JSON.stringify(o.data) : undefined
    }).then(async (r) => {
      const text = await r.text();
      let data;
      try { data = JSON.parse(text); } catch (e) { data = text; }
      o.success({ statusCode: r.status, data });
    }).catch((e) => o.fail({ errMsg: String(e) }));
  },
  showToast(o) { toasts.push(o.title); },
  showModal(o) { modals.push(o.title); if (o.success) o.success({ confirm: true, content: '测试反馈' }); },
  showLoading() {}, hideLoading() {},
  navigateTo(o) { navs.push(o.url); },
  switchTab(o) { navs.push('TAB:' + o.url); },
  setNavigationBarTitle() {},
  setClipboardData(o) { if (o.success) o.success(); },
  stopPullDownRefresh() {}
};
global.getCurrentPages = () => [];

let cfg = null;
global.Page = (c) => { cfg = c; };

function makePage(c) {
  const p = Object.create(c);
  p.data = JSON.parse(JSON.stringify(c.data || {}));
  p.setData = function (patch) { Object.assign(this.data, patch); };
  return p;
}

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
async function until(fn, ms) {
  ms = ms || 10000;
  const t0 = Date.now();
  while (Date.now() - t0 < ms) { if (fn()) return true; await sleep(100); }
  return false;
}

(async () => {
  require('E:/AI-Station/WeAppForge/projects/biaoxun/pages/ask/ask.js');
  const askCfg = cfg; cfg = null;
  require('E:/AI-Station/WeAppForge/projects/biaoxun/pages/answer/answer.js');
  const ansCfg = cfg; cfg = null;
  require('E:/AI-Station/WeAppForge/projects/biaoxun/pages/my/my.js');
  const myCfg = cfg;

  // ---- 场景A：全链 ----
  const ask = Object.create(makePage(askCfg));
  ask.onLoad();
  assert.ok(await until(() => ask.data.loginReady), 'A1 登录完成');
  assert.ok(await until(() => !!ask.data.quota), 'A2 配额已取');
  const total0 = ask.data.quota.total_left;
  assert.ok(typeof total0 === 'number' && total0 >= 0, 'A3 total_left 数值');

  // canAsk 根因回归：输入空白/短文本 → false；有效文本 → true
  ask.onInput({ detail: { value: '   EPC 资质门槛怎么设置？  ' } });
  assert.strictEqual(ask.data.canAsk, true, 'A4 canAsk=true（trim 在 JS）');
  ask.onInput({ detail: { value: '  ' } });
  assert.strictEqual(ask.data.canAsk, false, 'A5 空白 canAsk=false');
  ask.onSample({ currentTarget: { dataset: { q: '联合体投标必备条款？' } } });
  assert.strictEqual(ask.data.canAsk, true, 'A6 样例点击 canAsk=true');

  ask.onSubmit();
  assert.ok(await until(() => navs.some((u) => u.startsWith('/pages/answer/answer?id='))), 'A7 跳答案页');
  assert.strictEqual(ask.data.question, '', 'A8 提问后输入框清空');
  assert.ok(ask.data.quota.total_left === total0 - 1, 'A9 配额 -1');
  const aid = navs[0].split('id=')[1];

  const ans = Object.create(makePage(ansCfg));
  ans.onLoad({ id: aid });
  assert.ok(await until(() => ans.data.loading === false && ans.data.polling === false, 15000), 'A10 答案就绪(轮询收敛)');
  assert.strictEqual(ans.data.kbError, '', 'A11 引擎无错');
  assert.strictEqual(ans.data.loadError, '', 'A11b 网络无错');
  assert.ok(ans.data.progress.length >= 1, 'A11c 过程播报≥1条事件');
  assert.strictEqual(ans.data.unlocked, true, 'A12 配额内=全文');
  assert.ok(ans.data.blocks.length >= 2, 'A13 结构化块>=2');
  assert.ok(ans.data.blocks.some((b) => b.t === 'p' || b.t === 'ul' || b.t === 'h2'), 'A13b 含正文块');
  assert.ok(!JSON.stringify(ans.data.blocks).includes('**'), 'A13c 无裸 Markdown 符号');
  assert.ok(ans.data.fullChars > 100, 'A14 full_chars>100');
  assert.ok(ans.data.citations.length === 1, 'A15 引用1条');
  ans.onLike();
  assert.ok(await until(() => ans.data.liked === true), 'A16 点赞成功');
  ans.onCopy(); // 复制不抛错即过

  const my = Object.create(makePage(myCfg));
  my.onShow();
  assert.ok(await until(() => my.data.loading === false && my.data.items.length >= 1), 'A17 历史加载');
  assert.ok(/^\d{2}-\d{2} |今天 |昨天 /.test(my.data.items[0].timeText), 'A18 时间已格式化: ' + my.data.items[0].timeText);
  // 提问 -1 + 点赞 +1 → 回到 total0
  assert.ok(my.data.quota && my.data.quota.total_left === total0, 'A19 我的页配额同步(问-1+赞+1)');

  // 场景D 虚拟支付端点（v0.2.5）：已解锁答案要签名=409；支付回调=幂等解锁 200
  let payErr = null;
  await api.paySign(aid).catch((e) => { payErr = e; });
  assert.ok(payErr && payErr.statusCode === 409, 'D1 已解锁答案 pay_sign=409');
  const up = await api.unlockPaid(aid, 'harness-otn');
  assert.strictEqual(up.unlocked, true, 'D2 unlock_paid 幂等解锁');

  // ---- 场景B：配额耗尽 → 402 → 引导弹窗 ----
  RUN_CODE = 'harness-b-' + Date.now();
  wx._store = {}; // 清 token，触发重登到新 dev openid
  const ask2 = Object.create(makePage(askCfg));
  ask2.onLoad();
  assert.ok(await until(() => ask2.data.loginReady && !!ask2.data.quota), 'B1 新身份登录');
  const t0 = ask2.data.quota.total_left;
  for (let i = 0; i < t0; i++) {
    ask2.onSample({ currentTarget: { dataset: { q: '耗尽测试' + i } } });
    ask2.onSubmit();
    await until(() => !ask2.data.asking);
    await sleep(300); // 引擎串行闸间隔
  }
  modals.length = 0; navs.length = 0;
  ask2.onSample({ currentTarget: { dataset: { q: '超限第4问' } } });
  ask2.onSubmit();
  assert.ok(await until(() => modals.length === 1), 'B2 402→引导弹窗出现');
  assert.ok(navs.some((u) => u.startsWith('TAB:/pages/my/my')), 'B3 确认后跳「我的」');
  assert.strictEqual(ask2.data.asking, false, 'B4 asking 复位');

  // ---- 场景C：全新身份空态 ----
  RUN_CODE = 'harness-c-' + Date.now();
  wx._store = {};
  const my2 = Object.create(makePage(myCfg));
  my2.onShow();
  assert.ok(await until(() => my2.data.loading === false), 'C1 空态加载完成');
  assert.strictEqual(my2.data.items.length, 0, 'C2 历史为空');
  assert.ok(typeof my2.data.quota.total_left === 'number', 'C3 空态配额仍常显');

  console.log('HARNESS ALL PASS (A19 + B4 + C3 = 26 assertions)');
  process.exit(0);
})().catch((e) => {
  console.error('HARNESS FAIL:', e.message);
  console.error('DEBUG toasts=', toasts, 'modals=', modals, 'navs=', navs);
  process.exit(1);
});
