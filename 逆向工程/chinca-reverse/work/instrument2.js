// instrument2.js v2 — deep-instrumented challenge run, toString patched INSIDE the vm.
// Stage A: run original script2, capture xXRQBR source via in-vm toString hook.
// Stage B: fresh context, run instrumented script2, spoof toString (in-vm) to return the captured original.
'use strict';
const fs = require('fs');
const vm = require('vm');

const htmlPath = process.argv[2];
const arg1Override = process.argv[3] || null;
let html = fs.readFileSync(htmlPath, 'utf8');
const scriptBlocks = [...html.matchAll(/<script[^>]*>([\s\S]*?)<\/script>/g)].map(m => m[1]);
const script1 = scriptBlocks[0], script2 = scriptBlocks[1];
const m = html.match(/<textarea id="renderData"[^>]*>([\s\S]*?)<\/textarea>/);
let renderDataJSON = m[1];
let arg1 = JSON.parse(renderDataJSON).l1.match(/var arg1='([0-9A-Fa-f]+)';/)[1];
if (arg1Override) {
  renderDataJSON = JSON.stringify({ l1: `var arg1='${arg1Override}';` });
  arg1 = arg1Override;
}

function makeCtx(renderData, opts) {
  const LOG = opts.log || [];
  const jar = [];
  const loc = { href: 'https://www.chinca.org/', reload() {}, replace() {}, assign() {}, toString() { return 'https://www.chinca.org/'; } };
  const sb = {
    Math, JSON, Array, Object, String, Number, Boolean, Date, Symbol, Promise, Proxy, Reflect,
    parseInt, parseFloat, isNaN, isFinite, NaN, Infinity, undefined,
    encodeURIComponent, decodeURIComponent, Error, TypeError, RangeError, Function, RegExp,
    console: { log() {}, error() {} },
    navigator: {
      userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36',
      language: 'zh-CN', languages: ['zh-CN'], platform: 'Win32', webdriver: true,
      plugins: { length: 5 }, mimeTypes: { length: 2 }, product: 'Gecko', vendor: 'Google Inc.',
    },
    screen: { width: 1920, height: 1080, availWidth: 1920, availHeight: 1040, colorDepth: 24, pixelDepth: 24 },
    location: loc, setTimeout() {}, setInterval() { return 0; }, clearTimeout() {}, clearInterval() {},
    addEventListener() {}, removeEventListener() {},
    __I: (name, val) => LOG.push({ t: name, v: typeof val === 'object' ? JSON.parse(JSON.stringify(val)) : val }),
    __CAP: opts.cap || null, // {orig: null}
  };
  sb.document = {
    getElementById(id) { return id === 'renderData' ? { innerHTML: renderData } : null; },
    getElementsByTagName() { return []; },
    createElement() { return { style: {}, setAttribute() {}, appendChild() {} }; },
    head: { appendChild() {} }, body: { appendChild() {} }, documentElement: { style: {} }, referrer: '', location: loc,
  };
  Object.defineProperty(sb.document, 'cookie', {
    get() { return jar.join('; '); }, set(v) { jar.push(String(v)); }, configurable: true,
  });
  sb.window = sb; sb.self = sb; sb.top = sb; sb.parent = sb; sb.frames = sb; sb.globalThis = sb;
  const ctx = vm.createContext(sb);
  const prelude = `
    var __ts = Function.prototype.toString;
    Function.prototype.toString = function () {
      var r = __ts.call(this);
      globalThis.__CAP.hits = globalThis.__CAP.hits || []; globalThis.__CAP.hits.push(String(r.length) + ':' + String(r).slice(0, 40)); if (r.indexOf('cWSHDg') > -1 && r.indexOf('xXRQBR') > -1) {
        if (!globalThis.__CAP.orig) globalThis.__CAP.orig = r;
        if (r.indexOf('__I(') > -1) return globalThis.__CAP.orig;
      }
      return r;
    };
  `;
  vm.runInContext(prelude, ctx, { filename: 'prelude.js' });
  return { ctx, sb, jar, LOG };
}

// Stage A
const capA = { orig: null };
const A = makeCtx(renderDataJSON, { cap: capA });
let errA = null;
try {
  vm.runInContext(script1, A.ctx, { filename: 'https://www.chinca.org/' });
  vm.runInContext(script2, A.ctx, { filename: 'https://www.chinca.org/' });
} catch (e) { errA = String(e && e.message || e); }
let acwA = null;
for (const c of A.jar) { const mm = c.match(/acw_sc__v2=([^;]*)/); if (mm) acwA = mm[1]; }
if (!capA.orig) { console.log(JSON.stringify({ error: 'stageA no capture', errA, acwA, hits: (capA.hits||[]).slice(0,20) }, null, 1)); process.exit(2); }

// Stage B: instrument
let mod = script2;
const anchors = [
  ["t=new RegExp(E[D1(vQ.m)],'gm')", "globalThis.__I('S_F',F),t=new RegExp(E[D1(vQ.m)],'gm')", "S_F"],
  ["Math[D8(vW.c)]=E[D8(vW.m)](c,R);", "globalThis.__I('SEED',{R:R,S:JSON.parse(JSON.stringify(S))}),Math[D8(vW.c)]=E[D8(vW.m)](c,R);", "SEED"],
  ["return t[N(v9.E)](i=t[N(v9.z)](t[N(v9.S)](t[N(v9.X)](M,i),F),j),j);}", "var __r=t[N(v9.E)](i=t[N(v9.z)](t[N(v9.S)](t[N(v9.X)](M,i),F),j),j);globalThis.__I('PRNG_DRAW',{i:i});return __r;}", "PRNG_DRAW"],
  ["var O=window[D5(vK.vA)][D5(vK.vL)](0x32*0x4d+-0xaa3*-0x2+-0x2*0x1228,0x1c5b+0x515*-0x5+-0x2ca)[D5(vK.vy)]('');", "var O=window[D5(vK.vA)][D5(vK.vL)](0x32*0x4d+-0xaa3*-0x2+-0x2*0x1228,0x1c5b+0x515*-0x5+-0x2ca)[D5(vK.vy)]('');globalThis.__I('C4_O_SLICE',{O:O});", "C4_O_SLICE"],
  ["Math[D5(vK.t)]=X,Array[D5(vK.M)][D5(vK.j)]=", "globalThis.__I('C1_O',{O:JSON.parse(JSON.stringify(O))}),Math[D5(vK.t)]=X,Array[D5(vK.M)][D5(vK.j)]=", "C1_O_POST"],
  ["M=E[D5(vK.S)](E[D5(vK.X)](this['p'](),'-'),M[D5(vK.o)+'e']()),", "M=E[D5(vK.S)](E[D5(vK.X)](this['p'](),'-'),M[D5(vK.o)+'e']()),globalThis.__I('C0_FINAL',{M:M}),", "C0_FINAL"],
  ["return E[D4(vc.E)];", "var __pv=E[D4(vc.E)];globalThis.__I('P_VAL',{p:__pv});return __pv;", "P_VAL"],
];
const miss = [];
for (const [find, rep, name] of anchors) {
  if (!mod.includes(find)) miss.push(name);
  else mod = mod.replace(find, rep);
}
{
  const g = "if(E[I(vz.E)](E[I(vz.z)](s())[I(vz.S)](-0x3041df+-0x95*-0x147a8d+0xdf92f7e),-(-0x3e6+-0x1*-0x1c9f+0x88d*-0x3+vL))){";
  const g2 = "}else{if(o)return o[I(vz.F)](this,F,t,M);}";
  if (mod.includes(g)) mod = mod.replace(g, g + "globalThis.__I('M_GATE',{taken:true});"); else miss.push('M_GATE_IF');
  if (mod.includes(g2)) mod = mod.replace(g2, "}else{globalThis.__I('M_GATE',{taken:false});if(o)return o[I(vz.F)](this,F,t,M);}"); else miss.push('M_GATE_ELSE');
  const c5 = "case'5':for(var n=0xcc9*0x2+-0xdf0+0x1*-0xba2;E[D5(vK.vr)](n,O[D5(vK.vb)]);++n)M+=";
  if (mod.includes(c5)) mod = mod.replace(c5, "case'5':globalThis.__I('C5_START',{M:M,O_len:O.length});for(var n=0xcc9*0x2+-0xdf0+0x1*-0xba2;E[D5(vK.vr)](n,O[D5(vK.vb)]);++n)M+="); else miss.push('C5');
  const c3 = "}(O)[D5(vK.J)](''),";
  if (mod.includes(c3)) mod = mod.replace(c3, "}(O)[D5(vK.J)](''),globalThis.__I('C3_DONE',{M:M}),"); else miss.push('C3');
}
fs.writeFileSync('../captures/instrumented_script2.js', mod);

const capB = { orig: capA.orig };
const B = makeCtx(renderDataJSON, { cap: capB });
let errB = null;
try {
  vm.runInContext(script1, B.ctx, { filename: 'https://www.chinca.org/' });
  vm.runInContext(mod, B.ctx, { filename: 'https://www.chinca.org/' });
} catch (e) { errB = String(e && e.message || e); }
let acwB = null;
for (const c of B.jar) { const mm = c.match(/acw_sc__v2=([^;]*)/); if (mm) acwB = mm[1]; }
const out = {
  arg1, acwA, acwB, errA, errB, anchors_missed: miss,
  orig_len: capA.orig.length,
  same_output_as_original: acwA && acwB && acwA.slice(0, -10) === acwB.slice(0, -10),
  log: B.LOG,
};
console.log(JSON.stringify(out, null, 1));
