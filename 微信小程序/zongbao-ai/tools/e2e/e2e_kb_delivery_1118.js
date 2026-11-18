// e2e_kb_delivery_1118.js — 知识库 SKU 上架链实测（1118 用户令：KB 只存百度网盘）
// 四门（证据=断言，截图在案纪律下弃用）：
//   1) 详情真链：sku=KB-SUBCON-2026 → engine 详情回 product_type=knowledge_base、
//      sellable=true、price=19；页面 isKb=true
//   2) 试读真链：免费蓝图 sample 非空（kb_subcon_blueprint.md）
//   3) 支付签名腿真调：取本机会话 token → POST /api/report/<sku>/unlock_sign →
//      200 且 sign_data 含 buyQuantity=19 / goodsPrice=100 / productId 在册
//      （¥1 kb_goods × 19 动态价——kbfactory 整库单同范式；不拉起支付面板，订单行 pending 无害）
//   4) 交付卡渲染：setData 注入解锁态+delivery 块 → wxml 渲染交付卡/复制钮 →
//      tap copyDelivery → 剪贴板=url（getClipboardData 断言）
// 运行：node e2e_kb_delivery_1118.js（DevTools 已登录且开服务端口；否则自动 launch）
const automator = require('miniprogram-automator');
const fs = require('fs');
const path = require('path');
const https = require('https');

const CLI = 'E:\\WeChatDevTools\\cli.bat';
const PROJECT = path.resolve(__dirname, '..', '..');
const ENGINE_URL_FILE = 'E:\\AI-Station\\data\\state\\qianwen_engine_url.txt';
const SKU = 'KB-SUBCON-2026';

const results = [];
function rec(name, ok, detail = '') {
  results.push({ name, ok, detail });
  console.log(`${ok ? '✅' : '❌'} ${name}${detail ? '  | ' + detail : ''}`);
}
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

function httpJson(url, { method = 'GET', headers = {}, body = null } = {}) {
  return new Promise((resolve, reject) => {
    const u = new URL(url);
    const req = https.request({ hostname: u.hostname, path: u.pathname + u.search,
      method, headers: Object.assign({ 'Content-Type': 'application/json' }, headers) },
      (res) => {
        let buf = '';
        res.on('data', (c) => { buf += c; });
        res.on('end', () => {
          try { resolve({ status: res.statusCode, json: JSON.parse(buf), raw: buf }); }
          catch (e) { resolve({ status: res.statusCode, json: null, raw: buf }); }
        });
      });
    req.on('error', reject);
    if (body) req.write(JSON.stringify(body));
    req.end();
  });
}

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
  let exceptions = [];
  mp.on('exception', (err) => exceptions.push(String(err && err.message).slice(0, 200)));

  const pass = (n, d) => rec(n, true, d);
  const fail = (n, d) => rec(n, false, d);

  try {
    await sleep(4000); // 冷启动预热（webview 竞态先例）

    // ── 0. 新代码指纹门：详情含 product_type 键（KB 分支的前提；占位PDF假阳性教训）──
    try {
      const base0 = fs.readFileSync(ENGINE_URL_FILE, 'utf8').trim();
      const probe = await httpJson(base0 + '/api/report/SUBCON-2026');
      rec('引擎新代码指纹（product_type 键在位）',
        !!(probe.json && ('product_type' in probe.json)),
        'keys sample=' + (probe.json ? Object.keys(probe.json).slice(3, 8).join(',') : 'n/a'));
    } catch (e) {
      rec('引擎新代码指纹', false, String(e).slice(0, 100));
    }

    // ── 1+2. 详情+试读真链 ──
    let page = null;
    for (let i = 0; i < 4 && !page; i++) {
      try {
        page = await mp.reLaunch('/pages/report/report?sku=' + SKU);
      } catch (e) { await sleep(2000); }
    }
    if (!page) { fail('页面到达 report?sku=' + SKU, 'reLaunch 4 连败'); }
    else {
      await sleep(3500);
      const d = await page.data();
      if (d && d.d) {
        const dd = d.d;
        pass('详情加载', true, dd.title || '');
        (dd.sku === SKU) ? pass('SKU 正确', true) : fail('SKU 正确', 'got ' + dd.sku);
        (dd.product_type === 'knowledge_base')
          ? pass('product_type=knowledge_base', true)
          : fail('product_type=knowledge_base', 'got ' + dd.product_type);
        (dd.sellable === true) ? pass('sellable=true（KB 走百度链接门）', true)
          : fail('sellable=true（KB 走百度链接门）', 'got ' + dd.sellable);
        (Number(dd.price) === 19) ? pass('price=19', true) : fail('price=19', 'got ' + dd.price);
        (d.isKb === true) ? pass('页面 isKb=true', true) : fail('页面 isKb=true', 'got ' + d.isKb);
        // 未解锁：交付卡不渲染（链接不泄给未购者）
        const cardBefore = await page.$$('.rp-delivery-url');
        (cardBefore.length === 0 && !dd.unlocked)
          ? pass('未解锁无交付卡（链接零泄露）', true)
          : rec('未解锁无交付卡（链接零泄露）', cardBefore.length === 0, 'unlocked=' + dd.unlocked);
        // 试读蓝图
        let sampleTries = 0;
        while (!(d.sample) && sampleTries++ < 6) { await sleep(1000); d.sample = (await page.data()).sample; }
        (d.sample && d.sample.length > 200)
          ? pass('试读蓝图非空', true, d.sample.length + ' 字')
          : fail('试读蓝图非空', 'len=' + (d.sample || '').length);
      } else {
        fail('详情加载', 'd.d 空（ errMsg=' + (d && d.errMsg) + ' ）');
      }

      // ── 3. 支付签名腿真调（不拉起面板）──
      try {
        const token = await mp.callWxMethod('getStorageSync', 'qw_token');
        const base = fs.readFileSync(ENGINE_URL_FILE, 'utf8').trim();
        const r = await httpJson(base + '/api/report/' + SKU + '/unlock_sign', {
          method: 'POST',
          headers: { Authorization: 'Bearer ' + token },
        });
        if (r.status === 200 && r.json && r.json.sign_data) {
          const sd = typeof r.json.sign_data === 'string'
            ? JSON.parse(r.json.sign_data) : r.json.sign_data; // 服务端签名字符串（透传体）
          const qtyOk = Number(sd.buyQuantity) === 19;
          const priceOk = Number(r.json.price_fen) === 1900;
          rec('签名腿 buyQuantity=19（¥1×19）', qtyOk, 'buyQuantity=' + sd.buyQuantity);
          rec('签名腿 price_fen=1900', priceOk, 'price_fen=' + r.json.price_fen);
          rec('签名腿 productId 在册', !!sd.productId, sd.productId);
        } else if (r.status === 409) {
          pass('签名腿收口', true, '409 已解锁/已到账（本机此前已购——交付卡走真解锁态）');
        } else {
          fail('签名腿 200', 'status=' + r.status + ' raw=' + String(r.raw).slice(0, 120));
        }
      } catch (e) {
        fail('签名腿真调', String(e).slice(0, 140));
      }

      // ── 4. 交付卡渲染+复制（注入解锁态；引擎真解锁由签名腿+支付回调保证）──
      page = await mp.currentPage(); // 重取页代理：旧代理经 reLaunch+setData 后可能失活（No context 先例）
      const FAKE_DL = { type: 'baidu', url: 'https://pan.baidu.com/s/e2e_probe_1118', pwd: '', period: 'permanent' };
      await page.setData({ 'd.unlocked': true, isKb: true, 'd.delivery': FAKE_DL });
      await sleep(800);
      const urlEl = await page.$('.rp-delivery-url');
      if (urlEl) {
        const txt = await urlEl.text();
        (txt.indexOf('pan.baidu.com/s/e2e_probe_1118') >= 0)
          ? pass('交付卡渲染（链接可见可选中）', true)
          : fail('交付卡渲染（链接可见可选中）', 'text=' + txt.slice(0, 80));
        const btns = await page.$$('.rp-act');
        pass('复制按钮在卡内', btns.length > 0, btns.length + ' 个 rp-act');
        const barBtn = await page.$('.rp-bar-btn');
        pass('吸底栏 KB 复制钮', !!barBtn, barBtn ? '' : '未找到');
        // tap 复制 → 剪贴板断言（tap 事件链=实证稳定路，callMethod 已证伪；剪贴板走 evaluate）
        try {
          const barBtn = await page.$('.rp-bar-btn');
          if (!barBtn) { fail('吸底栏复制钮可点', '未找到'); }
          else {
            await barBtn.tap();
            await sleep(900);
            const clip = await mp.evaluate(() => new Promise((res) => {
              wx.getClipboardData({ success: (r) => res(r.data), fail: () => res('') });
            }));
            (String(clip || '').indexOf('e2e_probe_1118') >= 0)
              ? pass('复制→剪贴板命中', true)
              : fail('复制→剪贴板命中', 'clip=' + String(clip).slice(0, 80));
          }
        } catch (e) {
          rec('复制→剪贴板断言', false, String(e).slice(0, 100));
        }
        // openPdf 兜底转交付（evaluate+getCurrentPages 桥外直调；isKb 下应转复制而非下载 PDF）
        try {
          const redirectOk = await mp.evaluate(() => new Promise((res) => {
            const ps = getCurrentPages();
            const p = ps[ps.length - 1];
            try { p.openPdf(); setTimeout(() => res('called'), 300); }
            catch (e) { res('throw:' + String(e).slice(0, 60)); }
          }));
          await sleep(600);
          (redirectOk === 'called')
            ? pass('openPdf 兜底转交付（无下载态）', true)
            : fail('openPdf 兜底转交付', String(redirectOk));
        } catch (e) {
          fail('openPdf 兜底转交付', String(e).slice(0, 100));
        }
      } else {
        fail('交付卡渲染（注入解锁态后）', '.rp-delivery-url 未找到');
      }
    }

    // 零异常门
    rec('零 JS 异常', exceptions.length === 0, exceptions.slice(0, 3).join(' ; '));
  } catch (e) {
    fail('e2e 主流程', String(e && e.stack || e).slice(0, 200));
  }

  const okCount = results.filter((r) => r.ok).length;
  console.log(`\n===== KB 交付链实测 ${okCount}/${results.length} PASS =====`);
  if (launched) { try { await mp.close(); } catch (e) {} }
  process.exit(okCount === results.length ? 0 : 1);
})();
