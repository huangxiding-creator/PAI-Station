// e2e_fresh_repro.mjs — 真机「按钮失灵」复现：清空存储=全新实例首启路径
// （e2e v095/v096 一直用暖存储跑，恰好漏测这条路径——1009 真机三死象复现腿）
import automator from 'miniprogram-automator';

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
const errors = [];
const consoleMsgs = [];

const mp = await automator.connect({ wsEndpoint: 'ws://127.0.0.1:9420' });
mp.on('exception', (err) => errors.push(String((err && err.message) || err)));
mp.on('console', (msg) => {
  consoleMsgs.push(`[${msg.type}] ${String(msg.args).slice(0, 200)}`);
});

console.log('== [1] 清空全部存储（模拟全新安装首启）==');
await mp.callWxMethod('clearStorageSync');
const left = await mp.callWxMethod('getStorageInfoSync');
console.log('storage after clear: keys =', JSON.stringify(left.keys));

console.log('== [2] reLaunch 咨询首页（触发 onLoad→隐私门→登录链）==');
await mp.reLaunch('/pages/ask/ask');
await sleep(4500); // 隐私弹窗若弹，等它稳定
let page = await mp.currentPage();
console.log('path =', page.path);

// 隐私弹窗处理（wx.showModal 不在 DOM——先看 data 流）
let d = await page.data();
console.log('[ask data] loginReady =', d.loginReady, '| netStatus =', JSON.stringify(d.netStatus),
  '| quotaText =', JSON.stringify(d.quotaText), '| quota =', JSON.stringify(d.quota));

if (!d.loginReady) {
  console.log('== [2b] 未登录——真机首启必经隐私弹窗；devtools 里需手动/程序点同意 ==');
  // wx.showModal 是原生弹窗，automator 无法直接点。改走真实底层：模拟用户已同意状态不可能（那又是暖存储）。
  // 保守路线：直接调页面方法链 onAgree 等价路径 —— setStorage + silentLogin
  console.log('   => 记录形态：全新实例停在隐私门（等待用户同意）。这不是 bug，是真机首次必经交互。');
  console.log('   => 关键判别：真机上用户已点过「同意并继续」（因为我的页有额度=已登录过）');
  console.log('      所以真机 ask 页 loginReady 应为 true。此处 devtools 清存储后停在弹窗属预期。');
  // 恢复到「已同意」状态继续测按钮链：
  await mp.callWxMethod('setStorageSync', 'qw_privacy_ok', 1);
}

console.log('== [3] 标记已同意隐私 → 重新进入 ask 页（模拟第二次进页=真机当前形态）==');
await mp.reLaunch('/pages/ask/ask');
await sleep(4000);
page = await mp.currentPage();
d = await page.data();
console.log('[ask data] loginReady =', d.loginReady, '| netStatus =', JSON.stringify(d.netStatus),
  '| quotaText =', JSON.stringify(d.quotaText), '| quota =', JSON.stringify(d.quota));

console.log('== [4] 输入问题 → 点「免费咨询」==');
const ta = await page.$('.ask-input');
await ta.input('EPC合同工期延误怎么索赔');
await sleep(600);
d = await page.data();
console.log('[after input] canAsk =', d.canAsk, '| question =', JSON.stringify((d.question || '').slice(0, 20)));

const btn = await page.$('.ask-btn');
console.log('ask-btn found =', !!btn, '| class =', btn ? await btn.attribute('class') : '-');
const errBefore = errors.length;
await btn.tap();
await sleep(2500);
d = await page.data();
console.log('[after tap] asking =', d.asking, '| newExceptions =', errors.length - errBefore);
const cur = await mp.currentPage();
console.log('[after tap] currentPage =', cur.path);
for (let i = 0; i < 10 && cur.path === 'pages/ask/ask'; i++) {
  await sleep(1500);
  d = await page.data();
  const c2 = await mp.currentPage();
  console.log(`  poll${i}: path=${c2.path} asking=${d.asking} netStatus=${d.netStatus}`);
  if (c2.path !== 'pages/ask/ask') { cur.path = c2.path; break; }
}

console.log('== [5] 全程异常与 console ==');
console.log('exceptions:', errors.length ? errors : '(none)');
console.log('console:', consoleMsgs.length ? consoleMsgs.slice(0, 12) : '(none)');
await mp.disconnect();
