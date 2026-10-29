// probe7: kill the vr() ternary (force 'oTP+ef0' literal) — does vL computation matter in this env?
// Also: log Math.random set/restore via defineProperty, and dump PRNG draws.
'use strict';
const fs = require('fs');
const vm = require('vm');

const htmlPath = process.argv[2] || '../captures/challenge_h1.html';
const mode = process.argv[3] || 'vrkill'; // vrkill | orig
const html = fs.readFileSync(htmlPath, 'utf8');
const [s1, s2orig] = [...html.matchAll(/<script[^>]*>([\s\S]*?)<\/script>/g)].map(m => m[1]);
const rd = html.match(/<textarea id="renderData"[^>]*>([\s\S]*?)<\/textarea>/)[1];

let s2 = s2orig;
if (mode === 'vrkill') {
  const target = "typeof vr===[]+[][[]]?'oTP+ef0':vr()";
  if (!s2.includes(target)) { console.error('vr ternary not found'); process.exit(1); }
  s2 = s2.replace(target, "'oTP+ef0'");
}

const jar = [];
const LOG = [];
const loc = { href: 'https://www.chinca.org/', reload() {}, replace() {}, assign() {}, toString() { return 'https://www.chinca.org/'; } };
const sb = {
  Math, JSON, Array, Object, String, Number, Boolean, Date, Symbol, Promise, Proxy, Reflect,
  parseInt, parseFloat, isNaN, isFinite, NaN, Infinity, undefined, encodeURIComponent, decodeURIComponent,
  Error, TypeError, RangeError, Function, RegExp, console: { log() {} },
  navigator: { userAgent: 'x', language: 'zh-CN', languages: ['zh-CN'], platform: 'Win32', webdriver: true, plugins: { length: 5 }, mimeTypes: { length: 2 }, product: 'Gecko', vendor: 'G' },
  screen: { width: 1920, height: 1080, availWidth: 1920, availHeight: 1040, colorDepth: 24, pixelDepth: 24 },
  location: loc, setTimeout() {}, setInterval() { return 0; }, clearTimeout() {}, clearInterval() {},
  addEventListener() {}, removeEventListener() {},
  __LOG: LOG,
};
sb.document = {
  getElementById(id) { return id === 'renderData' ? { innerHTML: rd } : null; },
  getElementsByTagName() { return []; }, createElement() { return { style: {}, setAttribute() {}, appendChild() {} }; },
  head: { appendChild() {} }, body: { appendChild() {} }, documentElement: { style: {} }, referrer: '', location: loc,
};
Object.defineProperty(sb.document, 'cookie', { get() { return jar.join('; '); }, set(v) { jar.push(String(v)); }, configurable: true });
sb.window = sb; sb.self = sb; sb.top = sb; sb.parent = sb; sb.frames = sb; sb.globalThis = sb;

// trap Math.random set/restore + draw log
const ctx = vm.createContext(sb);
const prelude = `
  globalThis.__rd = Math.random;
  var __mr = Math.random, __cnt = 0;
  Object.defineProperty(Math, 'random', {
    configurable: true,
    get: function () { return __mr; },
    set: function (v) { __cnt++; globalThis.__LOG.push({ t: 'RANDOM_SET', n: __cnt, isOrig: v === __mr }); __mr = v; }
  });
`;
vm.runInContext(prelude, ctx, { filename: 'p.js' });
vm.runInContext(s1, ctx, { filename: 'https://www.chinca.org/' });
let err = null;
try { vm.runInContext(s2, ctx, { filename: 'https://www.chinca.org/' }); } catch (e) { err = String(e && e.message || e); }
let acw = null;
for (const c of jar) { const mm = c.match(/acw_sc__v2=([^;]*)/); if (mm) acw = mm[1]; }
console.log(JSON.stringify({ mode, acw, err, random_sets: LOG.filter(l => l.t === 'RANDOM_SET') }, null, 1));
