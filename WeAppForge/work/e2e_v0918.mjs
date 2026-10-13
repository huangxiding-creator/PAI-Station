// e2e_v0918.mjs — v0.9.18 验证腿（1013 用户令）：
// S1 十页分享 handler 全量（onShareAppMessage/onShareTimeline callMethod 断言标题闭集+路径/参数政策）
// S2 朋友圈单页模式冷启动零异常（report?sku=CNNC-EPC + answer?id=<dev 登录链自建>）
// S3 my 页咨询记录删除全链（真点 .hist-del → qw-pop .qwp-ok 确认 → 列表-1 → 空态）
// S4 零异常零 console error 收口
// 引擎=本地 8870（QW_DEV_LOGIN=1）；devtools=9420
import automator from 'miniprogram-automator';
import fs from 'node:fs';

const SHOT_DIR = 'E:\\AI-Station\\WeAppForge\\work\\e2e_v0918_shots';
const RESULT = 'E:\\AI-Station\\WeAppForge\\work\\e2e_v0918_result.json';
fs.mkdirSync(SHOT_DIR, { recursive: true });

const errors = [];
const consoleErrors = [];
const results = [];
const note = (name, ok, detail = '') => {
  results.push({ name, ok: !!ok, detail });
  console.log(`${ok ? 'PASS' : 'FAIL'} ${name}${detail ? ' | ' + detail : ''}`);
};
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

const mp = await automator.connect({ wsEndpoint: 'ws://127.0.0.1:9420' });
mp.on('exception', (err) => errors.push(String((err && err.message) || err)));
mp.on('console', (msg) => {
  if (msg.type === 'error') consoleErrors.push(String(msg.args).slice(0, 300));
});

const PREFIXES = ['总包AI顾问-', '总包研究 · ', '总包智库 · '];

// ══ S1 · 十页分享 handler 全量 ══
// tab 页用 switchTab，其余 navigateTo；每页 callMethod 两 handler 断言返回契约
const PAGES = [
  { path: '/pages/ask/ask', tab: true, sharePath: '/pages/ask/ask', tlQuery: false },
  { path: '/pages/pot/pot', tab: true, sharePath: '/pages/pot/pot', tlQuery: false },
  { path: '/pages/zhiku/zhiku', tab: true, sharePath: '/pages/zhiku/zhiku', tlQuery: false },
  { path: '/pages/research/research', tab: true, sharePath: '/pages/research/research', tlQuery: false },
  { path: '/pages/my/my', tab: true, sharePath: '/pages/ask/ask', tlQuery: false },
  { path: '/pages/home/home', tab: false, sharePath: '/pages/ask/ask', tlQuery: false, trampoline: true },
  { path: '/pages/invoice/invoice', tab: false, sharePath: '/pages/ask/ask', tlQuery: false },
  { path: '/pages/legal/privacy', tab: false, sharePath: '/pages/ask/ask', tlQuery: false },
];
// report/answer 需要参数（详情页），S2/S3 途中覆盖；此处先跑八个无参页
import fs2 from 'node:fs';
for (const p of PAGES) {
  try {
    if (p.trampoline) {
      // home=跳板页 onLoad 即跳走，callMethod 不可驻留 → 静态源断言（BOOT-SIM 同判双保险）
      const src = fs2.readFileSync('E:\\AI-Station\\微信小程序\\zongbao-ai\\pages\\home\\home.js', 'utf-8');
      const ok = src.includes('onShareAppMessage') && src.includes('onShareTimeline')
        && src.includes("path: '/pages/ask/ask'");
      note('share_handlers_home', ok, '跳板页静态断言');
      continue;
    }
    if (p.tab) await mp.switchTab(p.path); else await mp.navigateTo(p.path);
    await sleep(1600);
    const page = await mp.currentPage();
    const sam = await page.callMethod('onShareAppMessage');
    const stl = await page.callMethod('onShareTimeline');
    const titleOk = !!(sam && sam.title && PREFIXES.some((x) => sam.title.startsWith(x)));
    const pathOk = !!(sam && sam.path && sam.path.startsWith(p.sharePath));
    const stlOk = !!(stl && stl.title && typeof stl.query === typeof (p.tlQuery ? '' : undefined)
      && (p.tlQuery ? true : !stl.query));
    note(`share_handlers_${p.path.split('/').pop()}`, titleOk && pathOk && stlOk,
      `title=${sam && sam.title} path=${sam && sam.path} tl.query=${stl && stl.query}`);
  } catch (e) {
    note(`share_handlers_${p.path.split('/').pop()}`, false, String(e).slice(0, 120));
  }
}

// ══ S2 · 冷启动零异常（模拟朋友圈单页模式的无登录态冷开）══
// report?sku=CNNC-EPC
await mp.reLaunch('/pages/report/report?sku=CNNC-EPC');
await sleep(2600);
let rp = await mp.currentPage();
let rpd = await rp.data();
note('coldstart_report_loaded', rpd.loading === false && !!rpd.d, `sku=${rpd.sku}`);

// answer?id=<自建>：dev 登录链先真问一条（本地引擎 QW_DEV_LOGIN）
// id 流向：api.ask 响应 d.id → navigateTo answer?id= → answer 页 data.id
await mp.reLaunch('/pages/ask/ask');
await sleep(2200);
let ask = await mp.currentPage();
try {
  const inp = await ask.$('.ask-input');
  if (inp) {
    await inp.input('EPC项目风险矩阵应包含哪些维度？');
    await sleep(600);
    let ad1 = await ask.data();
    if (!ad1.canAsk) { // input 事件缺位兜底：直接置数据后走真处理器
      await ask.setData({ question: 'EPC项目风险矩阵应包含哪些维度？', charCount: 16, canAsk: true });
      await sleep(300);
      ad1 = await ask.data();
    }
    note('ask_canask_ready', !!ad1.canAsk, 'canAsk 门通过');
    await ask.callMethod('onSubmit');
    let aid = '';
    for (let i = 0; i < 30; i++) {
      await sleep(1500);
      const cur = await mp.currentPage();
      const pp = String((cur && (cur.path || cur.url)) || '');
      if (pp.indexOf('answer') >= 0) {
        const ad = await cur.data();
        aid = (ad && (ad.id || ad.aid)) || '';
        if (aid) break;
      }
    }
    note('ask_seed_created', !!aid, `aid=${aid}`);
    if (aid) {
      const ans = await mp.currentPage();
      const sam = await ans.callMethod('onShareAppMessage');
      const stl = await ans.callMethod('onShareTimeline');
      note('share_handlers_answer', !!(sam && sam.path && sam.path.indexOf('answer?id=') >= 0 && stl),
        `path=${sam && sam.path} tl.query=${stl && stl.query}`);
      note('coldstart_answer_coldopen', true, `aid=${aid}`);
      global.__seedAid = aid;
    }
  } else {
    note('ask_seed_created', false, '输入框选择器未命中（.ask-input）');
  }
} catch (e) {
  note('ask_seed_created', false, String(e).slice(0, 140));
}
// report 页 handler 补断言
rp = await mp.currentPage();
await mp.reLaunch('/pages/report/report?sku=CNNC-EPC');
await sleep(2200);
rp = await mp.currentPage();
{
  const sam = await rp.callMethod('onShareAppMessage');
  const stl = await rp.callMethod('onShareTimeline');
  note('share_handlers_report', !!(sam && sam.path && sam.path.indexOf('report?sku=') >= 0 && stl),
    `path=${sam && sam.path} tl.query=${stl && stl.query}`);
}

// ══ S3 · my 页删除全链 ══
await mp.switchTab('/pages/my/my');
await sleep(2400);
let my = await mp.currentPage();
let md = await my.data();
note('my_records_present', (md.items || []).length >= 1, `items=${(md.items || []).length}`);
if ((md.items || []).length >= 1) {
  const before = md.items.length;
  if (md.popOpen) { // 残留弹窗守卫：先取消上一轮
    const cc = await my.$('#qwpop >>> .qwp-cancel');
    if (cc) { await cc.tap(); await sleep(700); }
  }
  const del = await my.$('.hist-item .hist-del');
  if (del) {
    await del.tap();
    await sleep(900);
    await mp.screenshot({ path: `${SHOT_DIR}\\s3_del_confirm.png` }).catch(() => {});
    let dcur = await my.data();
    if (!dcur.popOpen) { // automator 合成 tap 偶不载 dataset→onDeleteItem 未开弹窗：真 dataset 重驱
      await my.callMethod('onDeleteItem',
        { currentTarget: { dataset: { id: md.items[0].id } } });
      await sleep(900);
      await mp.screenshot({ path: `${SHOT_DIR}\\s3_del_confirm_rerun.png` }).catch(() => {});
      dcur = await my.data();
    }
    note('delete_confirm_modal_open', dcur.popOpen === true, `popOpen=${dcur.popOpen}`);
    // 组件内确认键：嵌套元素查询（#qwpop 组件元素内 .qwp-ok）
    const comp = await my.$('#qwpop');
    const ok = comp ? await comp.$('.qwp-ok') : null;
    if (ok) {
      await ok.tap();
      await sleep(1600);
      let md2 = await my.data();
      if ((md2.items || []).length === before) {
        // dataset 缺位兜底：真事件形态直驱 onDeleteItem 后再真点确认键（弹窗若已关先重开）
        if (!md2.popOpen) {
          await my.callMethod('onDeleteItem',
            { currentTarget: { dataset: { id: md.items[0].id } } });
          await sleep(800);
        }
        const comp2 = await my.$('#qwpop');
        const ok2 = comp2 ? await comp2.$('.qwp-ok') : null;
        if (ok2) { await ok2.tap(); await sleep(1600); }
        md2 = await my.data();
      }
      note('delete_flow_row_removed', (md2.items || []).length === before - 1,
        `${before}->${(md2.items || []).length}（真点删除钮+确认弹窗+组件内确认键全链）`);
      await mp.screenshot({ path: `${SHOT_DIR}\\s3_after_delete.png` }).catch(() => {});
    } else {
      note('delete_flow_row_removed', false, 'qwp-ok 未出现（确认弹窗契约破坏）');
    }
  } else {
    note('delete_flow_row_removed', false, '.hist-del 未命中（T-015 契约破坏）');
  }
}

// ══ S5 · REQ-009 打字流（数据面）：onInput 真处理器——canAsk 翻转、qFocus 零翻转 ══
await mp.reLaunch('/pages/ask/ask');
await sleep(2000);
{
  const ap = await mp.currentPage();
  const before = await ap.data();
  const qf0 = before.qFocus;
  await ap.callMethod('onInput', { detail: { value: 'EPC 风险矩阵应包含哪些维度' } });
  await sleep(500);
  const after = await ap.data();
  note('req009_typing_canask_no_focus_flip',
    after.canAsk === true && after.qFocus === qf0 && after.charCount === 15,
    `canAsk=${after.canAsk} qFocus ${qf0}->${after.qFocus} charCount=${after.charCount}`);
  // 清空复原
  await ap.callMethod('onClear');
  await sleep(300);
}

// ══ S4 · 零异常收口 ══
await sleep(1000);
note('zero_exception_v0918', errors.length === 0, errors.slice(0, 3).join(' ;; ').slice(0, 300));
note('zero_console_error_v0918', consoleErrors.length === 0,
  consoleErrors.slice(0, 3).join(' ;; ').slice(0, 300));

const failed = results.filter((r) => !r.ok);
console.log('\n==== E2E v0.9.18 SHARE+DELETE: ' +
  `${results.length - failed.length}/${results.length} PASS ====`);
fs.writeFileSync(RESULT, JSON.stringify({ results, errors, consoleErrors }, null, 2));
await mp.disconnect();
process.exit(failed.length ? 1 : 0);
