// chinca-reverse Node harness v3: run the UNMODIFIED challenge JS with DOM shims, capture acw_sc__v2.
// window === globalThis === sandbox (browser semantics).
// Usage: node solver.js <challenge.html> [--det] [arg1Override]
//   --det : deterministic Math.random (mulberry32, fixed seed) -> fully deterministic cookie
'use strict';
const fs = require('fs');
const vm = require('vm');

const args = process.argv.slice(2).filter(a => a !== '--det');
const DET = process.argv.includes('--det');
const htmlPath = args[0];
let html = fs.readFileSync(htmlPath, 'utf8');
let arg1Override = args[1] || null;

const scriptBlocks = [...html.matchAll(/<script[^>]*>([\s\S]*?)<\/script>/g)].map(m => m[1]);
if (scriptBlocks.length < 2) { console.error(JSON.stringify({ error: 'no scripts found' })); process.exit(2); }
const script1 = scriptBlocks[0];
const script2 = scriptBlocks[1];

const m = html.match(/<textarea id="renderData"[^>]*>([\s\S]*?)<\/textarea>/);
if (!m) { console.error(JSON.stringify({ error: 'no renderData' })); process.exit(2); }
let renderDataJSON = m[1];
let arg1;
{
  const rd = JSON.parse(renderDataJSON);
  const mm = rd.l1.match(/var arg1='([0-9A-Fa-f]+)';/);
  arg1 = mm ? mm[1] : null;
}
if (arg1Override) {
  renderDataJSON = JSON.stringify({ l1: `var arg1='${arg1Override}';` });
  arg1 = arg1Override;
}

if (DET) {
  let st = 0x12345678;
  Math.random = function () {
    st = (st + 0x6D2B79F5) >>> 0;
    let t = st;
    t = Math.imul(t ^ (t >>> 15), t | 1);
    t ^= t + Math.imul(t ^ (t >>> 7), t | 61);
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}

const captured = { cookies: [], reloads: [] };
const jar = [];

const locationObj = {
  href: 'https://www.chinca.org/',
  protocol: 'https:', host: 'www.chinca.org', hostname: 'www.chinca.org',
  origin: 'https://www.chinca.org', pathname: '/', search: '', hash: '',
  reload: function () { captured.reloads.push('reload'); },
  replace: function (u) { captured.reloads.push('replace:' + u); },
  assign: function (u) { captured.reloads.push('assign:' + u); },
  toString() { return 'https://www.chinca.org/'; },
};

const sandbox = {
  // Realm alignment (KEY): do NOT provide host Function/Error/RegExp/etc — the vm must use its
  // own intrinsics so the challenge's environment checks see one coherent realm (as in Chrome).
  // Only Math/JSON come from the host (for the --det LCG hook); everything else is vm-intrinsic.
  console: { log() {}, error() {}, warn() {} },
  Math, JSON,
  navigator: {
    userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36',
    language: 'zh-CN', languages: ['zh-CN', 'zh', 'en'], platform: 'Win32',
    webdriver: false, hardwareConcurrency: 8, deviceMemory: 8, maxTouchPoints: 0,
    product: 'Gecko', vendor: 'Google Inc.',
    appVersion: '5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36',
    plugins: { length: 5 }, mimeTypes: { length: 2 },
  },
  screen: { width: 1920, height: 1080, availWidth: 1920, availHeight: 1040, colorDepth: 24, pixelDepth: 24 },
  location: locationObj,
  setTimeout: function () {}, setInterval: function () { return 0; },
  clearTimeout: function () {}, clearInterval: function () {},
  addEventListener: function () {}, removeEventListener: function () {},
  XMLHttpRequest: function () { this.open = function () {}; this.send = function () {}; this.setRequestHeader = function () {}; },
  atob: (s) => Buffer.from(s, 'base64').toString('binary'),
  btoa: (s) => Buffer.from(s, 'binary').toString('base64'),
  performance: { now: () => Date.now() },
  Intl: globalThis.Intl,
};
sandbox.document = {
  getElementById: function (id) {
    if (id === 'renderData') return { innerHTML: renderDataJSON };
    return null;
  },
  getElementsByTagName: function () { return []; },
  createElement: function () { return { style: {}, setAttribute() {}, appendChild() {}, getElementsByTagName() { return []; } }; },
  head: { appendChild() {} }, body: { appendChild() {} },
  documentElement: { style: {} },
  referrer: '',
  location: locationObj,
};
Object.defineProperty(sandbox.document, 'cookie', {
  get() { return jar.join('; '); },
  set(v) { jar.push(String(v)); captured.cookies.push(String(v)); },
  configurable: true,
});
sandbox.window = sandbox;
sandbox.self = sandbox;
sandbox.top = sandbox;
sandbox.parent = sandbox;
sandbox.frames = sandbox;
sandbox.globalThis = sandbox;

const ctx = vm.createContext(sandbox);
let out = { arg1, ok: false, det: DET };
try {
  vm.runInContext(script1, ctx, { filename: 'https://www.chinca.org/challenge1.js' });
  vm.runInContext(script2, ctx, { filename: 'https://www.chinca.org/aliyunwaf.js' });
  out.ok = true;
} catch (e) {
  out.error = String((e && e.message) || e);
}
out.cookies = captured.cookies;
out.reloads = captured.reloads;
let acw = null;
for (const c of captured.cookies) {
  const mm = c.match(/acw_sc__v2=([^;]*)/);
  if (mm) acw = mm[1];
}
out.acw_sc__v2 = acw;
console.log(JSON.stringify(out));
