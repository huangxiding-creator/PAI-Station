// instrument3.js — full deep instrumentation with correct realm handling:
//  - sandbox does NOT provide Function (vm-intrinsic Function used for vm-declared functions)
//  - vm-intrinsic Function.prototype.toString patched: stage A captures xXRQBR source;
//    stage B spoofs it back so modified script2 still computes vL=239.
'use strict';
const fs = require('fs');
const vm = require('vm');

const htmlPath = process.argv[2];
const arg1Override = process.argv[3] || null;
let html = fs.readFileSync(htmlPath, 'utf8');
const [s1, s2orig] = [...html.matchAll(/<script[^>]*>([\s\S]*?)<\/script>/g)].map(m => m[1]);
const rdmatch = html.match(/<textarea id="renderData"[^>]*>([\s\S]*?)<\/textarea>/);
let renderDataJSON = rdmatch[1];
let arg1 = JSON.parse(renderDataJSON).l1.match(/var arg1='([0-9A-Fa-f]+)';/)[1];
if (arg1Override) {
  renderDataJSON = JSON.stringify({ l1: `var arg1='${arg1Override}';` });
  arg1 = arg1Override;
}

function makeCtx(renderData, cap, LOG) {
  const jar = [];
  const loc = { href: 'https://www.chinca.org/', reload() {}, replace() {}, assign() {}, toString() { return 'https://www.chinca.org/'; } };
  // NOTE: no Function / Error / RegExp etc in sandbox — vm intrinsics are used and patchable.
  // We DO provide Math (host) so Math.random is the host native (deterministic under --det).
  const sb = {
    Math, JSON, console: { log() {}, error() {} },
    navigator: {
      userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36',
      language: 'zh-CN', languages: ['zh-CN'], platform: 'Win32', webdriver: true,
      plugins: { length: 5 }, mimeTypes: { length: 2 }, product: 'Gecko', vendor: 'Google Inc.',
    },
    screen: { width: 1920, height: 1080, availWidth: 1920, availHeight: 1040, colorDepth: 24, pixelDepth: 24 },
    location: loc, setTimeout() {}, setInterval() { return 0; }, clearTimeout() {}, clearInterval() {},
    addEventListener() {}, removeEventListener() {},
    encodeURIComponent, decodeURIComponent,
    __I: (name, val) => LOG.push({ t: name, v: typeof val === 'object' ? JSON.parse(JSON.stringify(val)) : val }),
    __CAP: cap,
  };
  sb.document = {
    getElementById(id) { return id === 'renderData' ? { innerHTML: renderData } : null; },
    getElementsByTagName() { return []; },
    createElement() { return { style: {}, setAttribute() {}, appendChild() {} }; },
    head: { appendChild() {} }, body: { appendChild() {} }, documentElement: { style: {} }, referrer: '', location: loc,
  };
  Object.defineProperty(sb.document, 'cookie', { get() { return jar.join('; '); }, set(v) { jar.push(String(v)); }, configurable: true });
  sb.window = sb; sb.self = sb; sb.top = sb; sb.parent = sb; sb.frames = sb; sb.globalThis = sb;
  const ctx = vm.createContext(sb);
  const prelude = `
    var __ts = Function.prototype.toString;
    Function.prototype.toString = function () {
      var r = __ts.call(this);
      if (r.indexOf('cWSHDg') > -1 && r.indexOf('xXRQBR') > -1) {
        if (!globalThis.__CAP.orig) globalThis.__CAP.orig = r;
        if (r.indexOf('globalThis.__I') > -1) return globalThis.__CAP.orig; // spoof instrumented copy
      }
      return r;
    };
  `;
  vm.runInContext(prelude, ctx, { filename: 'prelude.js' });
  return { ctx, jar, sb };
}

// ---- Stage A: original run, capture xXRQBR source ----
const capA = { orig: null };
const LOGA = [];
const A = makeCtx(renderDataJSON, capA, LOGA);
let errA = null;
try {
  vm.runInContext(s1, A.ctx, { filename: 'https://www.chinca.org/' });
  vm.runInContext(s2orig, A.ctx, { filename: 'https://www.chinca.org/' });
} catch (e) { errA = String(e && e.message || e); }
let acwA = null;
for (const c of A.jar) { const mm = c.match(/acw_sc__v2=([^;]*)/); if (mm) acwA = mm[1]; }

if (!capA.orig) {
  console.log(JSON.stringify({ error: 'stageA no capture', errA, acwA }, null, 1));
  process.exit(2);
}

// ---- Stage B: instrumented run ----
let mod = s2orig;
const anchors = [
  ["t=new RegExp(E[D1(vQ.m)],'gm')", "globalThis.__I('S_F',F),t=new RegExp(E[D1(vQ.m)],'gm')", "S_F"],
  ["Math[D8(vW.c)]=E[D8(vW.m)](c,R);", "globalThis.__I('SEED',{R:R,S:JSON.parse(JSON.stringify(S))}),Math[D8(vW.c)]=E[D8(vW.m)](c,R);", "SEED"],
  ["var M=E[P(vv.z)](0x49b8*-0xae+-0x2c5819+0x77d935,E[P(vv.S)](E[P(vv.X)](s())[P(vv.o)](0x76e84f5*-0x1+0x1dc*0x100aa8+-0x5e1b5d*-0x9),-(-0x1a3a+0x6*0x66a+-0xd30+vL)))", "var M=E[P(vv.z)](0x49b8*-0xae+-0x2c5819+0x77d935,E[P(vv.S)](E[P(vv.X)](s())[P(vv.o)](0x76e84f5*-0x1+0x1dc*0x100aa8+-0x5e1b5d*-0x9),-(-0x1a3a+0x6*0x66a+-0xd30+vL)));globalThis.__I('C_M',{M:M,s_len:s().length})", "C_M"],
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
fs.writeFileSync('../captures/instrumented_script2_v3.js', mod);

const capB = { orig: capA.orig };
const LOGB = [];
const B = makeCtx(renderDataJSON, capB, LOGB);
let errB = null;
try {
  vm.runInContext(s1, B.ctx, { filename: 'https://www.chinca.org/' });
  vm.runInContext(mod, B.ctx, { filename: 'https://www.chinca.org/' });
} catch (e) { errB = String(e && e.message || e); }
let acwB = null;
for (const c of B.jar) { const mm = c.match(/acw_sc__v2=([^;]*)/); if (mm) acwB = mm[1]; }

console.log(JSON.stringify({
  arg1, acwA, acwB, errA, errB, anchors_missed: miss,
  orig_src_len: capA.orig.length,
  stable_equal: acwA && acwB && acwA.slice(0, 46) === acwB.slice(0, 46),
  logB: LOGB,
}, null, 1));
