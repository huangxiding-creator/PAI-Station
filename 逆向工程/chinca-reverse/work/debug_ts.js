// debug_ts.js — check in-vm Function.prototype.toString patching mechanics
const vm = require('vm');
const sb = {};
const ctx = vm.createContext(sb);
const prelude = [
  'globalThis.__hits = [];',
  'var __ts = Function.prototype.toString;',
  'Function.prototype.toString = function () {',
  '  var r = __ts.call(this);',
  '  globalThis.__hits.push(String(r.length) + ":" + String(r).slice(0, 30).replace(/[\\n]/g, " "));',
  '  return r;',
  '};',
].join('\n');
vm.runInContext(prelude, ctx, { filename: 'p.js' });
const code = [
  'function xXRQBR(){ var cWSHDg=1; return xXRQBR.toString().length; }',
  'globalThis.__res = xXRQBR();',
].join('\n');
vm.runInContext(code, ctx, { filename: 'c.js' });
console.log('result:', sb.__res);
console.log('hits:', sb.__hits);
