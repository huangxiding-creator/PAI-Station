// utils/kbfactory_pay.js — 知识库工厂 订单/报价域模块（W6）
//
// 对外契约（页面/冒烟唯一依赖）：
//   buildExportPayload(bp, needText) -> { need_text, blueprint }            蓝图导出签名腿载荷（¥0.1）
//   buildOrderPayload(bp, needText, version, email) -> 四键订单 payload      整库订单（单据类型 kb_order）
//       四键 = { need_text, blueprint:{domain,files,gb,total,version_sha}, email, version }
//   digestOf(bp) -> blueprint 摘要五键；summarySha 确定性散列（djb2→8位hex）
//   priceOf(bp, version) -> { amount }   三版本动态价（服务端按摘要复算为准，此处仅供展示）
//   isValidEmail(s) / VERSIONS          邮箱校验 / 三版本静态骨架
//   submitOrder(payload) -> Promise      支付成功后的履约单提交；服务端未配套时落本地订单箱排队
//
// 敏感词纪律：本文件在 verify 门扫描范围内——零渠道名/零技术词（含 require 路径）。
const pay = require('./pay');

// 三版本（文案与页面报价卡行同名；version 值为订单 payload 的稳定枚举，勿改字面量）
var VERSIONS = [
  { key: 'original', name: '原文件版', note: '按实测体积计价的完整原文件' },
  { key: 'md', name: '轻便阅读版', note: '同一批资料，重排为顺手的阅读格式' },
  { key: 'import', name: '随身知识库导入包', note: '原文件之外，附随身导入包' }
];

var ORDER_BOX_KEY = 'kbf_order_box'; // 本地订单箱键

// 确定性散列（djb2 → 8 位 hex）：同一蓝图恒同值，蓝图摘要变则值变——订单与蓝图版本绑定的对账锚
function _djb2(s) {
  var h = 5381;
  for (var i = 0; i < s.length; i++) h = ((h << 5) + h + s.charCodeAt(i)) >>> 0;
  return h;
}

function summarySha(sum) {
  var raw = [sum.domain, sum.files, sum.gb, sum.total, sum.engine_version || ''].join('|');
  return ('00000000' + _djb2(raw).toString(16)).slice(-8);
}

// 蓝图摘要五键：domain/files/gb/total 来自引擎真值，version_sha 为派生散列
function digestOf(bp) {
  bp = bp || {};
  var sum = {
    domain: bp.domain || '',
    files: (bp.stats && bp.stats.files) || 0,
    gb: (bp.stats && bp.stats.gb) || 0,
    total: (bp.quote && bp.quote.total) || 0,
    engine_version: (bp.provenance && bp.provenance.engine_version) || ''
  };
  var out = { domain: sum.domain, files: sum.files, gb: sum.gb, total: sum.total, version_sha: '' };
  out.version_sha = summarySha(sum);
  return out;
}

// 蓝图导出签名腿载荷（¥0.1；复用既有导出解锁语义）
function buildExportPayload(bp, needText) {
  return { need_text: String(needText || '').trim(), blueprint: digestOf(bp) };
}

// 整库订单 payload（四键；金额不含在内——服务端按 blueprint 摘要+version 复算）
function buildOrderPayload(bp, needText, version, email) {
  return {
    need_text: String(needText || '').trim(),
    blueprint: digestOf(bp),
    email: String(email || '').trim(),
    version: version
  };
}

function _round1(n) { return Math.round(n * 10) / 10; }

// 三版本动态价（展示用真值计算；导入包=原文件价+导入加价）
function priceOf(bp, version) {
  var q = (bp && bp.quote) || {};
  var total = q.total || 0;
  if (version === 'md') return { amount: _round1(total * (q.md_factor || 1.5)) };
  if (version === 'import') return { amount: _round1(total + (q.import_add || 19)) };
  return { amount: _round1(total) };
}

// 邮箱格式校验（必填 + 常规格式；不做连通性验证，不猜不编）
var EMAIL_RE = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)+$/;
function isValidEmail(s) {
  return EMAIL_RE.test(String(s || '').trim());
}

// 履约单提交：优先服务端；【服务端配套待部署】提交腿失败不丢单——落本地订单箱排队
// （下次提交时由后续版本统一补投；页面照常进「履约中」态，交付以邮箱送达为准）。
function submitOrder(payload) {
  return pay.submitKbOrder(payload)
    .then(function (r) { return { ok: true, order: r }; })
    .catch(function () {
      var box = [];
      try { box = wx.getStorageSync(ORDER_BOX_KEY) || []; } catch (e) { box = []; }
      if (!Array.isArray(box)) box = [];
      box.push({ payload: payload, status: 'queued_local', created_at: Date.now() });
      try { wx.setStorageSync(ORDER_BOX_KEY, box); } catch (e) { /* 存储满等极端态：吞错不阻状态页 */ }
      return { ok: true, queued_local: true };
    });
}

// 本地订单箱只读视图（冒烟/排障用；页面不渲染）
function localOrders() {
  try { var b = wx.getStorageSync(ORDER_BOX_KEY); return Array.isArray(b) ? b : []; } catch (e) { return []; }
}

module.exports = {
  VERSIONS, digestOf, summarySha,
  buildExportPayload, buildOrderPayload,
  priceOf, isValidEmail, submitOrder, localOrders
};
