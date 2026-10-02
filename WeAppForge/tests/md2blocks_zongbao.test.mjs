// md2blocks 解析器单测 — 总包学园（zongbao）Phase 7
// 自 biaoxun tests/md2blocks.test.mjs 迁移（10/10 向量原样，仅改 require 路径到 zongbao）
// node:test 零依赖；Windows 坑=require 不吃 file:// 须原生路径（zongbao 首夜教训）
import { test } from 'node:test';
import assert from 'node:assert/strict';
import { createRequire } from 'node:module';

const require = createRequire(import.meta.url);
const { md2blocks, parseInline } = require('E:/AI-Station/WeAppForge/projects/zongbao/utils/md2blocks.js');

test('标题分级 h1/h2/h3', () => {
  const b = md2blocks('# 一级\n## 二级\n### 三级\n#### 四级降为 h3');
  assert.equal(b[0].t, 'h1');
  assert.equal(b[1].t, 'h2');
  assert.equal(b[2].t, 'h3');
  assert.equal(b[3].t, 'h3');
  assert.equal(b[0].inl[0].v, '一级');
});

test('行内：加粗/斜体/行内代码/链接，无裸符号', () => {
  const segs = parseInline('常规**重点**与*补充*及`条款号`和[规定](https://x.cn)结尾');
  assert.equal(segs[0].k, 't'); assert.equal(segs[0].v, '常规');
  assert.equal(segs[1].k, 'b'); assert.equal(segs[1].v, '重点');
  assert.equal(segs[2].k, 't'); assert.equal(segs[2].v, '与');
  assert.equal(segs[3].k, 'i'); assert.equal(segs[3].v, '补充');
  assert.equal(segs[4].k, 't'); assert.equal(segs[4].v, '及');
  assert.equal(segs[5].k, 'c'); assert.equal(segs[5].v, '条款号');
  assert.equal(segs[6].k, 't'); assert.equal(segs[6].v, '和');
  assert.equal(segs[7].k, 'l'); assert.equal(segs[7].v, '规定');
  const flat = segs.map((s) => s.v).join('');
  assert.ok(!flat.includes('**') && !flat.includes('`'), '符号必须被吃掉');
});

test('无序/有序列表', () => {
  const b = md2blocks('- 甲项\n- 乙项\n\n1. 第一步\n2. 第二步\n3. 第三步');
  assert.equal(b[0].t, 'ul');
  assert.equal(b[0].items.length, 2);
  assert.equal(b[1].t, 'ol');
  assert.deepEqual(b[1].nums, ['1', '2', '3']);
  assert.equal(b[1].items.length, 3);
});

test('表格：表头+分隔行+数据行', () => {
  const b = md2blocks('| 指标 | 限额 |\n|---|---|\n| 保证金 | 80万 |\n| 工期 | 720天 |');
  assert.equal(b[0].t, 'table');
  assert.equal(b[0].head.length, 2);
  assert.equal(b[0].head[0][0].v, '指标');
  assert.equal(b[0].rows.length, 2, 'rows=' + JSON.stringify(b[0].rows));
  assert.equal(b[0].rows[1][1][0].v, '720天', 'rows=' + JSON.stringify(b[0].rows));
});

test('引用/分隔线/代码围栏', () => {
  const b = md2blocks('> 依据《招标投标法》第46条\n\n---\n\n```\nIF 条款 THEN 拒绝\n```');
  assert.equal(b[0].t, 'quote');
  assert.ok(b[0].inl[0].v.includes('第46条'));
  assert.equal(b[1].t, 'hr');
  assert.equal(b[2].t, 'code');
  assert.ok(b[2].text.includes('THEN'));
});

test('中文软换行拼段 + 西文补空格', () => {
  const b = md2blocks('投标人不得\n低于成本报价。\nmin price\nrule');
  assert.equal(b.length, 1, '连续行=同一段');
  assert.equal(b[0].t, 'p');
  assert.equal(b[0].inl[0].v, '投标人不得低于成本报价。min price rule');
});

test('HTML 兜底：<br> 换行 / 实体解码 / 图片降级 alt', () => {
  const b = md2blocks('第一行<br>第二行&nbsp;补充');
  assert.equal(b.length, 2);
  assert.equal(b[1].inl[0].v, '第二行 补充');
  const segs = parseInline('见![示意图](http://x/a.png)如下');
  assert.ok(!JSON.stringify(segs).includes('http'));
});

test('截断容错：围栏未闭合/表格缺尾行/星号未闭合', () => {
  const fence = md2blocks('```\n被截断的代码');
  assert.equal(fence[0].t, 'code');
  const tbl = md2blocks('| a | b |\n|---|---|\n| 1 ');
  assert.equal(tbl[0].t, 'table');
  assert.equal(tbl[0].rows.length, 1);
  const bold = parseInline('未闭合**星号保持原样');
  assert.equal(bold[0].v, '未闭合**星号保持原样');
});

test('空输入/纯空白不炸', () => {
  assert.deepEqual(md2blocks(''), []);
  assert.deepEqual(md2blocks('\n\n  \n'), []);
});

test('KB 真实形态综合样例', () => {
  const kb = `## 投标保证金规定\n\n根据《招标投标法实施条例》**第26条**：\n\n- 保证金不得超过项目估算价的 2%\n- 境内投标以现金或支票形式提交的，应当从基本账户转出\n\n1. 查招标文件专用合同条款\n2. 核对金额上限\n\n> 注意：\n\n| 情形 | 限额 |\n|---|---|\n| 依法必须招标 | 2% |\n`;
  const b = md2blocks(kb);
  assert.deepEqual(b.map((x) => x.t), ['h2', 'p', 'ul', 'ol', 'quote', 'table']);
});
