// vhash.js — verbatim port of the challenge's v() hash + vy() integrity math.
// Usage: node vhash.js <challenge.html>            → verify vL==0 on original
//        node vhash.js --patch <in.js> <out.js>    → patch source's embedded constant so vL stays 0
'use strict';
const fs = require('fs');

// v(D) — copied verbatim from script2 (the function body), only reformatted:
function v(D) {
  var Z = D.length & 3, d = D.length - Z,
      w = 0x1 * -0x359651b + -0x46a0389 + 0x1 * 0xad061bf,
      p = -0x80e3c3 * 0x1d8 + 0x1 * -0x3d4b18f3 + 0x1f78d35cc,
      a = -0x416f99b * -0x5 + -0x2820c45b + 0xe93f3 * 0x33d,
      E = 0x1edf + -0x114e * 0x2 + -0x57 * -0xb;
  while (E < d) {
    var S = D.charCodeAt(E) & 0xff | (D.charCodeAt(++E) & 0xff) << 8 |
            (D.charCodeAt(++E) & 0xff) << 16 | (D.charCodeAt(++E) & 0xff) << 24;
    ++E;
    S = (S & 0xffff) * p + (((S >>> 16) * p & 0xffff) << 16) & 0xffffffff;
    S = S << 15 | S >>> 17;
    S = (S & 0xffff) * a + (((S >>> 16) * a & 0xffff) << 16) & 0xffffffff;
    w ^= S;
    w = w << 13 | w >>> 19;
    w = w * 5 + 0xe6546b64 & 0xffffffff;
  }
  var z = 0;
  switch (Z) {
    case 3: z ^= (D.charCodeAt(E + 2) & 0xff) << 16;
    case 2: z ^= (D.charCodeAt(E + 1) & 0xff) << 8;
    case 1: z ^= D.charCodeAt(E) & 0xff,
            z = (z & 0xffff) * p + (((z >>> 16) * p & 0xffff) << 16) & 0xffffffff,
            z = z << 15 | z >>> 17,
            z = (z & 0xffff) * a + (((z >>> 16) * a & 0xffff) << 16) & 0xffffffff,
            w ^= z;
  }
  w ^= D.length;
  w ^= w >>> 16;
  w = (w & 0xffff) * 0x85ebca6b + (((w >>> 16) * 0x85ebca6b & 0xffff) << 16) & 0xffffffff;
  w ^= w >>> 13;
  w = (w & 0xffff) * 0xc2b2ae35 + (((w >>> 16) * 0xc2b2ae35 & 0xffff) << 16) & 0xffffffff;
  w ^= w >>> 16;
  return w >>> 0;
}

// vy(D, Z, d) — integrity: hash of source-with-number-removed minus embedded constant
function vy(src, fnName, dHex) {
  const w = src.indexOf('0x' + dHex);
  const p = src.indexOf('-', w), a = src.indexOf(';', p);
  const E = src.substring(0, w);
  const z = src.substring(p + 1, a).trim();
  const S = src.substring(a + 1);
  const X = v(E + S + 'undefined'); // typeof window[fnName] === 'undefined' in browser AND our vm
  return { vL: X - parseInt(z, 10), constStr: z, hash: X };
}

if (process.argv[2] === '--patch') {
  const src = fs.readFileSync(process.argv[3], 'utf8');
  // find current constant pattern: cWSHDg=0x<hex>-<dec>;
  const mre = src.match(/cWSHDg=0x([0-9a-f]+)-(\d+);/);
  if (!mre) { console.error('no cWSHDg pattern'); process.exit(1); }
  const hex = mre[1];
  const w = src.indexOf('0x' + hex);
  const p = src.indexOf('-', w), a = src.indexOf(';', p);
  const E = src.substring(0, w);
  const z = src.substring(p + 1, a).trim();
  const S = src.substring(a + 1);
  const newHash = v(E + S + 'undefined');
  // rebuild: replace only the hex literal with hash (keeps decimal part meaning)
  const newHex = newHash.toString(16);
  const newSrc = src.slice(0, w) + '0x' + newHex + src.slice(w + 2 + hex.length);
  // verify
  const chk = vy(newSrc, 'xXRQBR', newHex);
  fs.writeFileSync(process.argv[4], newSrc);
  console.log(JSON.stringify({ oldHex: hex, newHex, verify_vL: chk.vL }));
  process.exit(0);
}

// default: verify original
const html = fs.readFileSync(process.argv[2] || '../captures/challenge_h1.html', 'utf8');
const script2 = [...html.matchAll(/<script[^>]*>([\s\S]*?)<\/script>/g)].map(m => m[1])[1];
const r = vy(script2, 'xXRQBR', '2deacaf');
console.log(JSON.stringify(r));
console.log('vL==0:', r.vL === 0);
