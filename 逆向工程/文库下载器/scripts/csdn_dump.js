// Standalone string-array dumper for csdn.js (javascript-obfuscator RC4 mode)
// Usage: node csdn_dump.js <input.js> <out.strings.json> <out.deobf.js>
const fs = require('fs');
const vm = require('vm');

const src = fs.readFileSync(process.argv[2], 'utf8');

// 1) Extract head = decoder fn + array fn + rotation IIFE (up to and incl. the checksum marker)
const marker = '0xf1d89));';
const mi = src.indexOf(marker);
if (mi < 0) throw new Error('rotation marker not found');
const head = src.slice(0, mi + marker.length);

// The array function _0xfe81 is defined later in the file (hoisted there); extract it.
const feStart = src.indexOf('function _0xfe81(){');
const feEndMarker = 'return _0xfe81();}';
const feEnd = src.indexOf(feEndMarker, feStart);
if (feStart < 0 || feEnd < 0) throw new Error('_0xfe81 not found');
const fe81fn = src.slice(feStart, feEnd + feEndMarker.length);

const ctx = { console: { log() {} } };
vm.createContext(ctx);
vm.runInContext(fe81fn, ctx); // define global _0xfe81 first
vm.runInContext(head, ctx);   // then decoder + rotation IIFE (rotates the real array)
vm.runInContext('globalThis.__arr=_0xfe81', ctx);
const arr = ctx.__arr();
console.error('array length =', arr.length);

// 2) Re-implement the decoder (no cache): slot = arr[idx-0x17b]; b64(custom alphabet)+URI -> rc4(key)
function b64(s) {
  const C = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+/=';
  let o = '', t = '';
  for (let c = 0, i, j, k = 0; (j = s.charAt(k++)); ~(j) && ((i = c % 4 ? i * 64 + j : j), c++ % 4) ? (o += String.fromCharCode(0xff & (i >> ((-2 * c) & 6)))) : 0) { j = C.indexOf(j); }
  for (let a = 0; a < o.length; a++) t += '%' + ('00' + o.charCodeAt(a).toString(16)).slice(-2);
  return decodeURIComponent(t);
}
function rc4(slot, key) {
  const s = b64(slot);
  const S = []; let j = 0, x, y = '';
  for (let i = 0; i < 256; i++) S[i] = i;
  for (let i = 0; i < 256; i++) { j = (j + S[i] + key.charCodeAt(i % key.length)) % 256; x = S[i]; S[i] = S[j]; S[j] = x; }
  let i2 = 0, j2 = 0;
  for (let k = 0; k < s.length; k++) {
    i2 = (i2 + 1) % 256; j2 = (j2 + S[i2]) % 256; x = S[i2]; S[i2] = S[j2]; S[j2] = x;
    y += String.fromCharCode(s.charCodeAt(k) ^ S[(S[i2] + S[j2]) % 256]);
  }
  return y;
}
function dec(idx, key) { return rc4(arr[idx - 0x17b], key); }
function score(s) {
  if (!s) return -1;
  let ok = 0; const cps = [...s];
  for (const ch of cps) { const c = ch.codePointAt(0); if ((c >= 32 && c < 127) || (c >= 0x4e00 && c <= 0x9fff) || c === 10 || c === 13 || c === 9) ok++; }
  return ok / cps.length;
}

// 3) Find all call sites: _0xNAME(0xHEX,'key')
const callRe = /_0x[0-9a-fA-F]{4,8}\(\s*0x([0-9a-fA-F]+)\s*,\s*'((?:[^'\\]|\\.)*)'\s*\)/g;
const perCall = []; // {raw, idx, key, s, sc}
let m;
while ((m = callRe.exec(src))) {
  const idx = parseInt(m[1], 16);
  const key = m[2].replace(/\\'/g, "'").replace(/\\\\/g, '\\');
  let s = null, sc = -1;
  try { s = dec(idx, key); sc = score(s); } catch (e) { }
  perCall.push({ raw: m[0], idx, key, s, sc });
}
console.error('call sites =', perCall.length);

// 4) Best string per index (readable pick, for the JSON dump)
const byIdx = {};
for (const c of perCall) {
  if (c.sc < 0) continue;
  if (!byIdx[c.idx] || c.sc > byIdx[c.idx].sc) byIdx[c.idx] = c;
}
const dump = {};
for (const [i, c] of Object.entries(byIdx).sort((a, b) => a[0] - b[0])) dump['0x' + Number(i).toString(16)] = { key: c.key, score: +c.sc.toFixed(2), s: c.s };
fs.writeFileSync(process.argv[3], JSON.stringify(dump, null, 1), 'utf8');

// 5) Inline substitution: replace each call with its decoded literal (good calls only)
let out = src, replaced = 0;
for (const c of perCall) {
  if (c.sc >= 0.85 && c.raw.length) { out = out.split(c.raw).join(JSON.stringify(c.s)); replaced++; }
}
fs.writeFileSync(process.argv[4], out, 'utf8');
console.error('replaced', replaced, 'of', perCall.length, 'call sites');
