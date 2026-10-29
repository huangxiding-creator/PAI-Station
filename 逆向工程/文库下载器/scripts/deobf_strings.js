// 通用 obfuscator.io 字符串表解码器（零执行原文件逻辑，只 eval 数组+旋转IIFE+解码函数）
// 用法: node deobf_strings.js <file.js> [--replace <out.js>]
const fs = require('fs');
const file = process.argv[2];
const replaceIdx = process.argv.indexOf('--replace');
const outReplace = replaceIdx > 0 ? process.argv[replaceIdx + 1] : null;
const src = fs.readFileSync(file, 'utf-8');

// 1. 结构化切分：数组函数 + 旋转IIFE + 解码函数三件套（花括号/圆括号配平，兼容单行压缩）
function balance(s, start, open, close) {
  let depth = 0, i = start;
  for (; i < s.length; i++) {
    if (s[i] === open) depth++;
    else if (s[i] === close) { depth--; if (depth === 0) return i; }
  }
  return -1;
}
const mFn = src.search(/function\s+_0x[0-9a-f]+\s*\(\s*\)\s*\{/);
if (mFn < 0) { console.error('array fn not found'); process.exit(1); }
const arrEnd = balance(src, src.indexOf('{', mFn), '{', '}');
const arrayFn = src.slice(mFn, arrEnd + 1);
// 旋转 IIFE: (function(...){...}(_0xX,0xV)); 出现在数组函数之后
let rotIIFE = '';
const mRot = src.slice(arrEnd + 1).search(/\(\s*function\s*\(/);
if (mRot >= 0) {
  const rotStart = arrEnd + 1 + mRot;
  const rotEnd = balance(src, rotStart, '(', ')');
  if (rotEnd > 0) rotIIFE = src.slice(rotStart, rotEnd + 1) + ';';
}
let prologue = arrayFn + '\n' + rotIIFE;

// 2. 提取解码函数声明块 `function _0xNNNN(_0xA,_0xB){...}`（找全文件中的 function 声明含 base64 字母表特征）
let decoderName = null, decoderSrc = '';
for (const m of src.matchAll(/function\s+(_0x[0-9a-f]+)\s*\(\s*_0x[0-9a-f]+\s*,\s*_0x[0-9a-f]+\s*\)\s*\{/g)) {
  const start = m.index;
  // 从 { 起配平大括号
  let depth = 0, i = src.indexOf('{', start);
  for (; i < src.length; i++) {
    if (src[i] === '{') depth++;
    else if (src[i] === '}') { depth--; if (depth === 0) break; }
  }
  const block = src.slice(start, i + 1);
  if (block.includes('abcdefghijklmnopqrstuvwxyz') && block.includes('fromCharCode')) {
    decoderName = m[1]; decoderSrc = block; break;
  }
}
if (!decoderName) { console.error('decoder not found'); process.exit(1); }

// 3. eval prologue + decoder（沙箱：无 require/process 依赖即可跑）
const vm = require('vm');
const sandbox = {};
vm.createContext(sandbox);
vm.runInContext(prologue + '\n' + decoderSrc + '\nthis.__dec=' + decoderName + ';', sandbox);
const dec = sandbox.__dec || sandbox[decoderName];
if (typeof dec !== 'function') { console.error('decoder eval failed'); process.exit(1); }

// 4. 全文件收割 (idx,key) 调用对并解码
const calls = new Map();
for (const m of src.matchAll(/(_0x[0-9a-f]+)\(\s*(0x[0-9a-f]+)\s*,\s*'((?:[^'\\]|\\.)*)'\s*\)/g)) {
  const idx = parseInt(m[2], 16), key = m[3];
  const ck = idx + '|' + key;
  if (calls.has(ck)) continue;
  let val;
  try { val = dec(idx, key); } catch (e) { val = '<ERR:' + e.message + '>'; }
  calls.set(ck, val);
}
const results = [...calls.entries()].map(([k, v]) => [k.split('|')[0] * 1, k.split('|')[1], v])
  .sort((a, b) => a[0] - b[0]);
console.log('decoded strings: ' + results.length);
for (const [idx, key, val] of results) {
  console.log('[' + idx.toString(16) + '] ' + JSON.stringify(val));
}

// 5. 可选：内联回源码生成可读版
if (outReplace) {
  let out = src;
  for (const m of src.matchAll(/(_0x[0-9a-f]+)\(\s*(0x[0-9a-f]+)\s*,\s*'((?:[^'\\]|\\.)*)'\s*\)/g)) {
    const idx = parseInt(m[2], 16), key = m[3];
    let val;
    try { val = dec(idx, key); } catch (e) { continue; }
    if (typeof val === 'string') out = out.split(m[0]).join(JSON.stringify(val));
  }
  fs.writeFileSync(outReplace, out);
  console.log('replaced -> ' + outReplace);
}
