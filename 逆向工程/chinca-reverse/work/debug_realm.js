// debug_realm.js — does an in-vm Function.prototype.toString patch intercept vm-declared function toString?
const vm = require('vm');
const sb = { Function }; // explicitly provide HOST Function like the challenge harness
const ctx = vm.createContext(sb);
vm.runInContext(`
  globalThis.__hits = [];
  var __ts = Function.prototype.toString;
  Function.prototype.toString = function () {
    var r = __ts.call(this);
    globalThis.__hits.push(String(r).slice(0, 40));
    return r;
  };
  // probe: what Function do vm-declared functions use?
  globalThis.__probe = {
    fnProtoSame: (function () {}).constructor === Function,
    toStringCaught: false,
  };
  function victim() { var cWSHDg = 1; }
  globalThis.__res = victim.toString().length;
`, ctx, { filename: 'p.js' });
console.log('hits:', sb.__hits);
console.log('probe:', sb.__probe, 'res:', sb.__res);
