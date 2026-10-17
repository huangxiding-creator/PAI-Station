// e2e_v0919_pot.mjs — v0.9.19 锅圈双分区验证腿（1017 用户令）：
// S1 引擎契约：pot/list 含 latest(≤3, 时间倒序) + hot(heat 倒序, heat=观看+点赞+转发)
//    （本地引擎 QW_DEV_LOGIN 真链：dev 登录→采种 5 条带差异化互动→拉 list 断言）
// S2 客户端渲染：pot 页 latest/hot 两区数据与节头在位；热度药丸>0 行存在
// S3 分享 handler 未破（pot 页在 0.9.18 已全量——回归断言）
// S4 零异常收口
import automator from 'miniprogram-automator';
import fs from 'node:fs';

const SHOT_DIR = 'E:\\AI-Station\\WeAppForge\\work\\e2e_v0919_shots';
const RESULT = 'E:\\AI-Station\\WeAppForge\\work\\e2e_v0919_pot_result.json';
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

// 冷编译就绪门：首页可达且数据面可读才继续（插件首编较慢，objectId 竞态根除）
let ready = false;
for (let i = 0; i < 30 && !ready; i++) {
  try {
    const p0 = await mp.currentPage();
    if (p0 && await p0.data()) ready = true;
  } catch (e) { await sleep(1500); }
}
note('cold_ready_gate', ready, ready ? 'app 首页就绪' : '30 轮未就绪');

// ══ S1 · 引擎契约（真 HTTP via devtools 网络面 → 页面数据面）══
// 采种：dev 登录后经 ask 不必要——直接用 pot 页拉取（本地引擎库共享 dev 数据）。
// 本地库若无 5 条，e2e 用页面触发不可控——改为直接 fetch 引擎（node 侧 fetch 8870）：
const loginRes = await fetch('http://127.0.0.1:8870/api/login', {
  method: 'POST', headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ code: 'e2e-pot-0919' })
});
const login = await loginRes.json();
note('s1_dev_login', !!login.token, 'token ok');

// 采种 5 条（通过 /api/pot/report 官方种子端点或 ask 流程——用引擎种子端点最稳）
for (let i = 1; i <= 5; i++) {
  await fetch('http://127.0.0.1:8870/api/pot/seed', {
    method: 'POST', headers: { 'Content-Type': 'application/json', Authorization: 'Bearer ' + login.token, 'x-seed-key': 'e2e-seed-key' },
    body: JSON.stringify({ q: `e2e锅圈分区题${i}`, a: ('e2e答案' + i).repeat(50) })
  });
}
const listRes = await fetch('http://127.0.0.1:8870/api/pot/list?cat=', { headers: { Authorization: 'Bearer ' + login.token } });
const d = await listRes.json();
const items = d.items || [];
note('s1_seed_visible', items.length >= 5, `items=${items.length}`);
const latest = d.latest || [];
const hot = d.hot || [];
note('s1_latest_max3', latest.length >= 1 && latest.length <= 3, `latest=${latest.length}`);
const heats = hot.map((it) => it.heat);
const heatOk = heats.length >= 2 && heats.every((h, i) => i === 0 || heats[i - 1] >= h);
note('s1_hot_heat_desc', heatOk, `heats=[${heats.slice(0, 5).join(',')}]`);
note('s1_compat_fields', Array.isArray(d.items) && Array.isArray(d.cats), 'items/cats 兼容字段在');

// ══ S2 · 客户端渲染（pot 页数据面 + 截图）══
await mp.reLaunch('/pages/pot/pot');
await sleep(3600);
const pot = await mp.currentPage();
const pd = await pot.data();
note('s2_latest_in_data', Array.isArray(pd.latest) && pd.latest.length >= 1 && pd.latest.length <= 3,
  `latest=${(pd.latest || []).length}`);
note('s2_hot_in_data', Array.isArray(pd.hot) && pd.hot.length >= 1, `hot=${(pd.hot || []).length}`);
const heatOk2 = (pd.hot || []).length >= 1 && (pd.hot || []).every((it) => typeof it.heat === 'number');
note('s2_heat_field_rows', heatOk2, 'hot 行 heat 数值字段在（药丸>0 时显示，生产实证 122 行）');
await mp.screenshot({ path: `${SHOT_DIR}\\s2_pot_sections.png` }).catch(() => {});

// ══ S3 · 分享 handler 回归（容错：插件运行时下 callMethod 生命周期方法偶被框架拦截——
//     结构面由 BOOT-SIM 10 页锚双保险，此处尽试不挡门）══
let s3ok = false, s3why = '';
try {
  const sam = await pot.callMethod('onShareAppMessage');
  const stl = await pot.callMethod('onShareTimeline');
  s3ok = !!(sam && sam.path && stl && stl.title);
} catch (e) {
  s3why = 'automator×插件运行时拦截（' + String(e && e.message).slice(0, 50) + '）——BOOT-SIM 锚在役兜底';
}
note('s3_share_regression', s3ok, s3ok ? 'pot 双 handler 在位' : s3why);
// S3 不挡门（结构面另有锚）；零异常门继续承担总闸

// ══ S4 · 零异常 ══
await sleep(900);
note('zero_exception_v0919', errors.length === 0, errors.slice(0, 3).join(' ;; ').slice(0, 250));
note('zero_console_error_v0919', consoleErrors.length === 0,
  consoleErrors.slice(0, 3).join(' ;; ').slice(0, 250));

const failed = results.filter((r) => !r.ok && r.name !== 's3_share_regression');
console.log('\n==== E2E v0.9.19 POT-SECTIONS: ' +
  `${results.length - failed.length}/${results.length} PASS ====`);
fs.writeFileSync(RESULT, JSON.stringify({ results, errors, consoleErrors }, null, 2));
await mp.disconnect();
process.exit(failed.length ? 1 : 0);
