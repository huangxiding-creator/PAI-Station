// vhash2.js — extract the VERBATIM v() function text from the challenge and reuse it.
'use strict';
const fs = require('fs');
const vm = require('vm');

const html = fs.readFileSync(process.argv[2] || '../captures/challenge_h1.html', 'utf8');
const script2 = [...html.matchAll(/<script[^>]*>([\s\S]*?)<\/script>/g)].map(m => m[1])[1];

// grab "function v(D){ ... }var vL;" verbatim
const start = script2.indexOf('function v(D){');
const end = script2.indexOf('var vL;', start);
if (start < 0 || end < 0) { console.error('v() not found'); process.exit(1); }
const vSrc = script2.slice(start, end);
console.error('v() source len:', vSrc.length);

const sb = { Math, String };
const v = vm.runInNewContext('(' + vSrc + ')', sb);

function vy(src, dHex) {
  const w = src.indexOf('0x' + dHex);
  const p = src.indexOf('-', w), a = src.indexOf(';', p);
  const E = src.substring(0, w);
  const z = src.substring(p + 1, a).trim();
  const S = src.substring(a + 1);
  const X = v(E + S + 'undefined');
  return { vL: X - parseInt(z, 10), embedded: parseInt(z, 10), hash: X };
}

const r = vy(script2, '2deacaf');
console.log(JSON.stringify(r));
console.log('vL==0:', r.vL === 0);
// sanity: hash a known string
console.log('v(hello):', v('hello'));
