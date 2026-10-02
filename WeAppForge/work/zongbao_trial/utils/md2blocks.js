// Markdown → 结构化块渲染器 — 总包AI顾问 v0.2.4
// 零依赖：把工程大脑返回的 Markdown 解析成 WXML 可直接 wx:for 的块数组，
// 从此答案页不再裸露 #、**、|---| 等符号，排版由 WXSS 精细控制。
// 块: {t:'h1'|'h2'|'h3', inl} {t:'p', inl} {t:'quote', inl} {t:'code', text}
//     {t:'ul', items:[[inl]]} {t:'ol', nums:[], items:[[inl]]} {t:'hr'}
//     {t:'table', head:[[inl]], rows:[[[inl]]]}
// 行内段: {k:'t'} 文本 | {k:'b'} 加粗 | {k:'i'} 斜体 | {k:'c'} 行内代码 | {k:'l'} 链接文字
// 容错：预览截断（围栏未闭合/表格缺行）都能安全出块，绝不抛异常。

var ENTITIES = {
  amp: '&', lt: '<', gt: '>', nbsp: ' ', quot: '"', apos: "'",
  hellip: '…', mdash: '—', ndash: '–', middot: '·', bull: '•', times: '×'
};

function decodeEntities(s) {
  return String(s)
    .replace(/&#(\d+);/g, function (m, d) {
      var c = parseInt(d, 10);
      return c > 0 && c < 0x110000 ? String.fromCharCode(c) : m;
    })
    .replace(/&([a-z0-9]+);/gi, function (m, k) {
      var v = ENTITIES[String(k).toLowerCase()];
      return v === undefined ? m : v;
    });
}

function clean(v) {
  return decodeEntities(v).replace(/[​‎‏﻿]/g, '');
}

// ── 行内解析：加粗/斜体/行内代码/链接 ──────────────────────
var INLINE_RE = /(\*\*|__)([\s\S]+?)\1|(\*|_)([^*_]+?)\3|`([^`]+)`|!?\[([^\]]*)\]\([^)]*\)/g;

function pushText(segs, s) {
  var v = clean(s);
  if (!v) return;
  var last = segs.length - 1;
  if (last >= 0 && segs[last].k === 't') segs[last].v += v;
  else segs.push({ k: 't', v: v });
}

function parseInline(src) {
  var segs = [];
  var s = String(src || '');
  var last = 0;
  var m;
  INLINE_RE.lastIndex = 0;
  while ((m = INLINE_RE.exec(s))) {
    if (m.index > last) pushText(segs, s.slice(last, m.index));
    if (m[2] !== undefined) segs.push({ k: 'b', v: clean(m[2]) });
    else if (m[4] !== undefined) segs.push({ k: 'i', v: clean(m[4]) });
    else if (m[5] !== undefined) segs.push({ k: 'c', v: clean(m[5]) });
    else if (m[6] !== undefined) {
      // [文字](链接) 取文字；![alt](图) 降级为 alt 文字
      if (m[6]) segs.push({ k: 'l', v: clean(m[6]) });
    }
    last = INLINE_RE.lastIndex;
  }
  if (last < s.length) pushText(segs, s.slice(last));
  return segs;
}

// ── 行工具 ────────────────────────────────────────────────
function joinLines(arr) {
  var out = '';
  for (var i = 0; i < arr.length; i++) {
    var s = String(arr[i] || '').trim();
    if (!s) continue;
    if (!out) { out = s; continue; }
    // 两侧都是西文时补空格；中文软换行直接拼接
    var needSpace = /[A-Za-z0-9,.;:!?)]$/.test(out) && /^[A-Za-z0-9(]/.test(s);
    out += (needSpace ? ' ' : '') + s;
  }
  return out;
}

function splitRow(row) {
  var s = String(row).trim().replace(/^\|/, '').replace(/\|$/, '');
  return s.split('|').map(function (c) { return c.trim(); });
}

function isSepRow(s) {
  return /^\|?[\s:|-]+\|?$/.test(s) && s.indexOf('-') >= 0;
}

var UL_RE = /^[-*•·]\s+(.*)$/;
var OL_RE = /^(\d{1,3})[.、)]\s+(.*)$/;

// ── 块解析 ────────────────────────────────────────────────
function md2blocks(src) {
  var text = String(src || '')
    .replace(/\r\n?/g, '\n')
    .replace(/<br\s*\/?>/gi, '\n\n');
  var lines = text.split('\n');
  var blocks = [];
  var paraBuf = [];

  function flushPara() {
    if (!paraBuf.length) return;
    var joined = joinLines(paraBuf);
    if (joined) blocks.push({ t: 'p', inl: parseInline(joined) });
    paraBuf = [];
  }

  var i = 0;
  while (i < lines.length) {
    var t = lines[i].trim();

    if (!t) { flushPara(); i++; continue; }

    // 代码围栏（未闭合也能收——预览截断容错）
    if (t.charCodeAt(0) === 96 && t.charCodeAt(1) === 96 && t.charCodeAt(2) === 96) {
      flushPara();
      var code = [];
      i++;
      while (i < lines.length && lines[i].trim().indexOf('```') !== 0) { code.push(lines[i]); i++; }
      i++;
      blocks.push({ t: 'code', text: decodeEntities(code.join('\n')) });
      continue;
    }

    // 标题 # ~ ######
    if (t.charAt(0) === '#') {
      var h = /^(#{1,6})\s+(.*?)\s*#*\s*$/.exec(t);
      if (h) {
        flushPara();
        var lv = h[1].length <= 1 ? 'h1' : (h[1].length === 2 ? 'h2' : 'h3');
        blocks.push({ t: lv, inl: parseInline(h[2]) });
        i++;
        continue;
      }
    }

    // 分隔线
    if (/^(-{3,}|\*{3,}|_{3,})$/.test(t)) { flushPara(); blocks.push({ t: 'hr' }); i++; continue; }

    // 引用
    if (t.charAt(0) === '>') {
      flushPara();
      var q = [];
      while (i < lines.length && lines[i].trim().charAt(0) === '>') {
        q.push(lines[i].trim().replace(/^>\s?/, ''));
        i++;
      }
      blocks.push({ t: 'quote', inl: parseInline(joinLines(q)) });
      continue;
    }

    // 表格：| 开头 且下一行是 |---| 分隔行
    if (t.charAt(0) === '|' && t.indexOf('|', 1) >= 0) {
      var next = i + 1 < lines.length ? lines[i + 1].trim() : '';
      if (isSepRow(next)) {
        flushPara();
        var head = splitRow(t).map(parseInline);
        var rows = [];
        i += 2;
        while (i < lines.length) {
          var rt = lines[i].trim();
          if (!rt) break;
          if (rt.charAt(0) !== '|') break;
          if (!isSepRow(rt)) rows.push(splitRow(rt).map(parseInline));
          i++;
        }
        blocks.push({ t: 'table', head: head, rows: rows });
        continue;
      }
    }

    // 列表
    var mu = UL_RE.exec(t);
    var mo = OL_RE.exec(t);
    if (mu || mo) {
      flushPara();
      var isOl = !mu && !!mo;
      var items = [];
      var nums = [];
      while (i < lines.length) {
        var lt = lines[i].trim();
        var u = UL_RE.exec(lt);
        var o = OL_RE.exec(lt);
        if (isOl && o) { nums.push(o[1]); items.push(o[2]); }
        else if (!isOl && u) { items.push(u[1]); }
        else break;
        i++;
      }
      blocks.push(isOl
        ? { t: 'ol', nums: nums, items: items.map(parseInline) }
        : { t: 'ul', items: items.map(parseInline) });
      continue;
    }

    paraBuf.push(lines[i]);
    i++;
  }
  flushPara();
  return blocks;
}

module.exports = { md2blocks: md2blocks, parseInline: parseInline, decodeEntities: decodeEntities };
