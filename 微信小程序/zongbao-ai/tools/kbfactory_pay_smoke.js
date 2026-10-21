// tools/kbfactory_pay_smoke.js — W6 冒烟：mock wx 跑支付三分支 + 订单域
// 覆盖：① payKbOrder 成功（签名→支付→查单核验）② 取消 ③ 签名腿 409 已付收口
//       ④ payBlueprintExport 成功 ⑤ payload 四键组装/摘要确定性/三版本价/邮箱校验
//       ⑥ 履约单提交：服务端 502 → 本地订单箱排队；恢复 → 直交成功
// 用法：node tools/kbfactory_pay_smoke.js（于 zongbao-ai 根目录）
'use strict';
var assert = require('assert');

// ── mock wx（须在 require 业务模块前置备：pay.js 在模块加载期探测平台）──
var store = {};
var httpHandler = null;   // (o) => void：按 url+method 回包
var vpayBehavior = null;  // (o) => void：虚拟支付面板行为
global.wx = {
  getDeviceInfo: function () { return { platform: 'android' }; },
  requestVirtualPayment: function (o) { vpayBehavior(o); },
  request: function (o) { httpHandler(o); },
  getStorageSync: function (k) { return (k in store) ? store[k] : ''; },
  setStorageSync: function (k, v) { store[k] = v; },
  removeStorageSync: function (k) { delete store[k]; }
};

var pay = require('../utils/pay');
var kbp = require('../utils/kbfactory_pay');

function httpOk(o, data) { o.success({ statusCode: 200, data: data }); }
function httpStatus(o, code, detail) { o.success({ statusCode: code, data: { detail: detail } }); }

var SIGN = {
  mode: 'short_series',
  sign_data: '{"offerId":"kb","buyQuantity":1,"env":0,"currencyType":"CNY","outTradeNo":"__NO__"}',
  pay_sig: 'sig-pay', signature: 'sig-total', out_trade_no: 'KBTEST-0001'
};

function routeHttp(map) {
  httpHandler = function (o) {
    var url = String(o.url || '');
    if (url.indexOf('/api/telemetry') >= 0) { httpOk(o, {}); return; }
    for (var k in map) {
      if (url.indexOf(k) >= 0) { map[k](o); return; }
    }
    httpStatus(o, 404, 'no route for ' + url);
  };
}

// 蓝图夹具（对齐 sample_water 真值）
var BP = {
  domain: '水利EPC施工',
  stats: { files: 3136, gb: 4.64, dir_count: 224 },
  ratio: { core: 57, field: 36, guide: 7 },
  quote: { base: 29, per_gb: 2, md_factor: 1.5, total: 38.3, import_add: 19 },
  provenance: { engine_version: 'kb-cat/1.0.0' }
};
var NEED = '给水利EPC项目团队建一个施工知识库';

var PASS = 0, FAIL = 0;
function ok(name, cond, detail) {
  if (cond) { PASS++; console.log('[PASS] ' + name); }
  else { FAIL++; console.log('[FAIL] ' + name + (detail ? ' · ' + detail : '')); }
}

async function main() {
  var PAYLOAD = kbp.buildOrderPayload(BP, NEED, 'md', '  chief@example.com  ');

  // ① 支付成功：签名 200 → 面板 success → 查单核验 200
  routeHttp({
    '/api/kb/order_sign': function (o) { httpOk(o, SIGN); },
    '/api/kb/order_paid': function (o) { httpOk(o, { ok: 1, out_trade_no: o.data.out_trade_no }); }
  });
  vpayBehavior = function (o) { o.success({}); };
  var r1 = await pay.payKbOrder(PAYLOAD);
  ok('① 支付成功分支 ok=true 且带回执', r1.ok === true && r1.confirm && r1.confirm.ok === 1, JSON.stringify(r1));

  // ② 取消：面板 fail cancel → 轻提示不弹错
  vpayBehavior = function (o) { o.fail({ errMsg: 'requestVirtualPayment:fail cancel', errCode: 1 }); };
  var r2 = await pay.payKbOrder(PAYLOAD);
  ok('② 取消分支 ok=false 文案=已取消支付', r2.ok === false && r2.message === '已取消支付', JSON.stringify(r2));

  // ③ 签名腿 409：服务端判定已付 → 直接收口，面板不拉起
  var vpayCalled = false;
  routeHttp({ '/api/kb/order_sign': function (o) { httpStatus(o, 409, 'kb_order already reconciled'); } });
  vpayBehavior = function () { vpayCalled = true; };
  var r3 = await pay.payKbOrder(PAYLOAD);
  ok('③ 409 分支 ok=true already=true 且未拉面板', r3.ok === true && r3.already === true && !vpayCalled, JSON.stringify(r3));

  // ④ 蓝图导出（¥0.1，blueprint_export）：成功链
  routeHttp({
    '/api/kb/blueprint_sign': function (o) { httpOk(o, SIGN); },
    '/api/kb/blueprint_paid': function (o) { httpOk(o, { ok: 1 }); }
  });
  vpayBehavior = function (o) { o.success({}); };
  var r4 = await pay.payBlueprintExport(kbp.buildExportPayload(BP, NEED));
  ok('④ 蓝图导出成功链 ok=true', r4.ok === true && r4.confirm && r4.confirm.ok === 1, JSON.stringify(r4));

  // ⑤ 订单 payload 组装
  var keys = Object.keys(PAYLOAD).sort();
  ok('⑤a payload 恰四键 need_text/blueprint/email/version',
    JSON.stringify(keys) === '["blueprint","email","need_text","version"]', JSON.stringify(keys));
  ok('⑤b payload 值：need_text 原句 / email 去空白 / version 透传',
    PAYLOAD.need_text === NEED && PAYLOAD.email === 'chief@example.com' && PAYLOAD.version === 'md');
  var bk = Object.keys(PAYLOAD.blueprint).sort();
  ok('⑤c 蓝图摘要五键 domain/files/gb/total/version_sha',
    JSON.stringify(bk) === '["domain","files","gb","total","version_sha"]', JSON.stringify(bk));
  ok('⑤d 摘要值=引擎真值', PAYLOAD.blueprint.domain === BP.domain && PAYLOAD.blueprint.files === 3136
    && PAYLOAD.blueprint.gb === 4.64 && PAYLOAD.blueprint.total === 38.3);
  var p2 = kbp.buildOrderPayload(BP, NEED, 'original', 'chief@example.com');
  var p3 = kbp.buildOrderPayload(BP, NEED, 'original', 'chief@example.com');
  ok('⑤e version_sha 确定性（同蓝图恒同值）', p2.blueprint.version_sha === p3.blueprint.version_sha
    && /^[0-9a-f]{8}$/.test(p2.blueprint.version_sha), p2.blueprint.version_sha);
  var BP2 = JSON.parse(JSON.stringify(BP)); BP2.stats.files = 4000;
  ok('⑤f 蓝图变则 sha 变（订单绑定版本）',
    kbp.buildOrderPayload(BP2, NEED, 'original', 'a@b.co').blueprint.version_sha !== p2.blueprint.version_sha);
  var prO = kbp.priceOf(BP, 'original'), prM = kbp.priceOf(BP, 'md'), prI = kbp.priceOf(BP, 'import');
  ok('⑤g 三版本价：原文件=38.3 / 阅读=×1.5 / 导入包=+19',
    prO.amount === 38.3 && Math.abs(prM.amount - BP.quote.total * 1.5) < 0.1 && prI.amount === 57.3,
    prO.amount + '/' + prM.amount + '/' + prI.amount);
  ok('⑤h 邮箱校验 正例/反例/空',
    kbp.isValidEmail('chief@example.com') === true && kbp.isValidEmail('chief@example') === false
    && kbp.isValidEmail('') === false && kbp.isValidEmail('  chief@example.cn  ') === true);

  // ⑥ 履约单提交：服务端未配套（502）→ 本地订单箱排队；恢复 → 直交成功
  routeHttp({ '/api/kb/order': function (o) { httpStatus(o, 502, 'server not deployed'); } });
  var s1 = await kbp.submitOrder(PAYLOAD);
  var box1 = kbp.localOrders();
  ok('⑥a 服务端 502 → 本地订单箱排队不丢单',
    s1.ok === true && s1.queued_local === true && box1.length === 1
    && box1[0].status === 'queued_local' && box1[0].payload.email === PAYLOAD.email,
    JSON.stringify(s1));
  routeHttp({ '/api/kb/order': function (o) { httpOk(o, { order_id: 'KB-20261022-01' }); } });
  var s2 = await kbp.submitOrder(PAYLOAD);
  ok('⑥b 服务端恢复 → 直交成功带回单号',
    s2.ok === true && !s2.queued_local && s2.order && s2.order.order_id === 'KB-20261022-01',
    JSON.stringify(s2));

  console.log(FAIL === 0
    ? 'ALL PASS (' + PASS + '/' + (PASS + FAIL) + ') · W6 支付/订单冒烟绿'
    : 'FAILED (' + FAIL + '/' + (PASS + FAIL) + ')');
  process.exit(FAIL === 0 ? 0 : 1);
}

main().catch(function (e) {
  console.log('[FAIL] 冒烟异常 · ' + (e && e.stack ? e.stack : e));
  process.exit(1);
});
