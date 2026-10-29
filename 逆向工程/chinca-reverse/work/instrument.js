// chinca-reverse instrumented harness: run unmodified challenge JS with logging shims to dump
// decoded strings, RegExp patterns, missing-global probes, and cookie output.
// Usage: node instrument.js <challenge.html> [arg1Override] [fakeMessage] [fakeStack]
'use strict';
const fs = require('fs');
const vm = require('vm');

const args = process.argv.slice(2);
const htmlPath = args[0];
let html = fs.readFileSync(htmlPath, 'utf8');
let arg1Override = args[1] || null;
const FAKE_MSG = args[2] || null;   // if set: missing-global probe throws Error with this message
const FAKE_STACK = args[3] || null; // and this stack

const scriptBlocks = [...html.matchAll(/<script[^>]*>([\s\S]*?)<\/script>/g)].map(m => m[1]);
const script1 = scriptBlocks[0], script2 = scriptBlocks[1];
const m = html.match(/<textarea id="renderData"[^>]*>([\s\S]*?)<\/textarea>/);
let renderDataJSON = m[1];
let arg1 = JSON.parse(renderDataJSON).l1.match(/var arg1='([0-9A-Fa-f]+)';/)[1];
if (arg1Override) {
  renderDataJSON = JSON.stringify({ l1: `var arg1='${arg1Override}';` });
  arg1 = arg1Override;
}

const log = { decoded: [], regexps: [], missingGlobals: [], cookies: [], errors: [], throwSite: null };
const jar = [];

// --- instrumented builtins ---
const realDecodeURIComponent = decodeURIComponent;
function decodeHook(s) {
  log.decoded.push(String(s));
  return realDecodeURIComponent(s);
}
const RealRegExp = RegExp;
function RegExpHook(pattern, flags) {
  log.regexps.push({ pattern: String(pattern), flags });
  return new RealRegExp(pattern, flags);
}
RegExpHook.prototype = RealRegExp.prototype;

const locationObj = {
  href: 'https://www.chinca.org/', protocol: 'https:', host: 'www.chinca.org',
  hostname: 'www.chinca.org', origin: 'https://www.chinca.org', pathname: '/', search: '', hash: '',
  reload: function () {}, replace: function () {}, assign: function () {},
  toString() { return 'https://www.chinca.org/'; },
};

const sandbox = {
  console, Math, JSON, Array, Object, String, Number, Boolean, Date, Symbol, Promise, Proxy, Reflect,
  WeakMap, WeakSet, Map, Set, parseInt, parseFloat, isNaN, isFinite, NaN, Infinity, undefined,
  encodeURIComponent: encodeURIComponent, decodeURIComponent: decodeHook,
  encodeURI, decodeURI, escape, unescape,
  RegExp: RegExpHook,
  Error: Error, TypeError: TypeError, RangeError: RangeError, Function: Function,
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
  XMLHttpRequest: function () { this.open = function () {}; this.send = function () {}; },
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
  createElement: function () { return { style: {}, setAttribute() {}, appendChild() {} }; },
  head: { appendChild() {} }, body: { appendChild() {} },
  documentElement: { style: {} },
  referrer: '', location: locationObj,
};
Object.defineProperty(sandbox.document, 'cookie', {
  get() { return jar.join('; '); },
  set(v) { jar.push(String(v)); log.cookies.push(String(v)); },
  configurable: true,
});
sandbox.window = sandbox; sandbox.self = sandbox; sandbox.top = sandbox;
sandbox.parent = sandbox; sandbox.frames = sandbox; sandbox.globalThis = sandbox;

// proto-proxy: log any MISSING global property read (the env probe calls globalThis[fn]())
Object.setPrototypeOf(sandbox, new Proxy({}, {
  get(t, key) {
    if (typeof key === 'string' && key !== 'then' && !key.startsWith('Symbol')) {
      log.missingGlobals.push(key);
    }
    if (FAKE_MSG !== null) {
      const err = new Error(FAKE_MSG);
      if (FAKE_STACK !== null) {
        Object.defineProperty(err, 'stack', { value: FAKE_STACK, configurable: true });
      }
      throw err; // emulate: calling undefined -> throws TypeError w/ controlled message/stack
    }
    return undefined;
  },
  has(t, key) { return false; },
}));

const ctx = vm.createContext(sandbox);
let out = { arg1, ok: false };
try {
  vm.runInContext(script1, ctx, { filename: 'https://www.chinca.org/challenge1.js' });
  vm.runInContext(script2, ctx, { filename: 'https://www.chinca.org/aliyunwaf.js' });
  out.ok = true;
} catch (e) {
  out.error = String((e && e.message) || e);
}
let acw = null;
for (const c of log.cookies) {
  const mm = c.match(/acw_sc__v2=([^;]*)/);
  if (mm) acw = mm[1];
}
out.acw_sc__v2 = acw;
out.decoded_strings = log.decoded;
out.regexps = log.regexps;
out.missing_globals = log.missingGlobals;
console.log(JSON.stringify(out, null, 1));
