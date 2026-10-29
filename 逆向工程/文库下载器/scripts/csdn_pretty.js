// Make the deobfuscated csdn.js readable: strip string-array fn, add newlines.
const fs = require('fs');
let s = fs.readFileSync(process.argv[2], 'utf8');
const a = s.indexOf('function _0xfe81(){');
const b = s.indexOf('return _0xfe81();}', a);
s = s.slice(0, a) + '/* [STRING ARRAY STRIPPED] */' + s.slice(b + 'return _0xfe81();}'.length);
s = s.replace(/(;)(?=\s*(?:const|let|var|async|function|return|if|for|while|try|throw|}))/g, '$1\n');
fs.writeFileSync(process.argv[3], s, 'utf8');
console.log('ok', s.length);
