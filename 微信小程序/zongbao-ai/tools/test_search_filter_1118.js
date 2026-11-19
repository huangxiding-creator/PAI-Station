// 1118 检索逻辑冒烟：把 research.applyFilter 的过滤谓词原样抽出，跑用例集
// （与页面代码同构拷贝——改页面时本文件同步，锚=四字段小写包含+分类叠加）
const assert = require('assert');

// 与 pages/research/research.js applyFilter 同构（1119 用户令：load 层先剔除 KB SKU——知识库归智库页市场）
function loadExcludeKb(list) {
  return list.filter((r) => r.product_type !== 'knowledge_base');
}
function filter(hot, active, query) {
  const q = String(query || '').trim().toLowerCase();
  let shown = hot;
  if (q) {
    shown = shown.filter((r) => (
      (r.title || '').toLowerCase().indexOf(q) >= 0
      || (r.subtitle || '').toLowerCase().indexOf(q) >= 0
      || (r.cat_name || '').toLowerCase().indexOf(q) >= 0
      || (r.sku || '').toLowerCase().indexOf(q) >= 0
    ));
  }
  if (active === 'mine') shown = shown.filter((r) => r.unlocked);
  else if (active !== 'all') shown = shown.filter((r) => r.cat === active);
  return shown;
}

const RAW = [
  { sku: 'EPC-ESS-2026', title: '储能光伏EPC研究报告', subtitle: '新能源总承包', cat: 'ent', cat_name: '企业研究', unlocked: true },
  { sku: 'EPC-SUBCON-2026', title: '分包合同研报', subtitle: 'EPC分包攻防', cat: 'legal', cat_name: '法务专题', unlocked: false },
  { sku: 'KB-SUBCON-2026', title: 'EPC分包知识库', subtitle: '全过程文件库', cat: 'topic', cat_name: '知识库', product_type: 'knowledge_base', unlocked: false },
  { sku: 'AUDIT-2026', title: '审计2026', subtitle: 'SUBCON audit trail', cat: 'topic', cat_name: '专题研究', unlocked: false },
];
// 1119：load 层剔除 KB → research 页视图源
const CAT = loadExcludeKb(RAW);

// 0) KB 剔除门（知识库归智库页市场，研究页任何筛/检不可见）
assert.strictEqual(CAT.length, 3, 'load excludes kb sku');
assert.strictEqual(loadExcludeKb(RAW).filter(r => r.sku === 'KB-SUBCON-2026').length, 0, 'kb gone');
// 智库市场分流：同一 RAW 里 KB 恰好被市场位收编
const MARKET = RAW.filter(r => r.product_type === 'knowledge_base');
assert.deepStrictEqual(MARKET.map(r => r.sku), ['KB-SUBCON-2026'], 'market picks up kb');

// 1) 空查询=全量（剔后 3）
assert.strictEqual(filter(CAT, 'all', '').length, 3, 'empty query = all');
assert.strictEqual(filter(CAT, 'all', '  ').length, 3, 'blank query = all');
// 2) 标题命中（中文；知识库已剔——「分包」只剩研报）
assert.strictEqual(filter(CAT, 'all', '分包').length, 1, 'title: 分包 → 研报 only');
// 3) subtitle 命中
assert.strictEqual(filter(CAT, 'all', '新能源').length, 1, 'subtitle hit');
// 4) 1119 反转：研究页检索「知识库」=0 命中（KB 归智库市场）
assert.strictEqual(filter(CAT, 'all', '知识库').length, 0, 'kb query now empty in research');
// 5) sku 命中（大小写不敏感；KB 已剔 → 2 条）
assert.deepStrictEqual(filter(CAT, 'all', 'subcon').map(r => r.sku).sort(), ['AUDIT-2026', 'EPC-SUBCON-2026'], 'sku case-insensitive');
assert.deepStrictEqual(filter(CAT, 'all', 'SUBCON').map(r => r.sku).sort(), ['AUDIT-2026', 'EPC-SUBCON-2026'], 'sku uppercase');
// 6) 英文 sku/subtitle 命中（行级：同一条多字段命中只计一次）
assert.strictEqual(filter(CAT, 'all', 'audit').length, 1, 'audit row-level single hit');
// 7) 检索+分类叠加
assert.strictEqual(filter(CAT, 'mine', '知识库').length, 0, 'query+mine overlay');
assert.strictEqual(filter(CAT, 'mine', '储能').length, 1, 'query+mine overlay hit');
// 8) 无命中
assert.strictEqual(filter(CAT, 'all', '不存在词').length, 0, 'no hit');
// 9) 分类单独作用（不叠加查询时原语义不变）
assert.strictEqual(filter(CAT, 'ent', '').length, 1, 'cat filter intact');
assert.strictEqual(filter(CAT, 'mine', '').length, 1, 'mine filter intact');

console.log('search filter (1119 kb-to-zhiku): 15/15 PASS');
