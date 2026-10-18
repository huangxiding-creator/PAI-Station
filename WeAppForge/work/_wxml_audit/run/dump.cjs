const fs = require('fs');
const path = require('path');
const code = fs.readFileSync(path.join(__dirname, 'gen.js'), 'utf8');
global.window = global;
global.window.__webview_engine_version__ = 0.02;
(0, eval)(code);
const render = global.$gwx('pages/report/report.wxml');

const baseD = {
  unlocked: false, sellable: true, price_label: '¥498',
  title: '测试报告题名', cat_name: 'EPC', subtitle: '副题', sku: 'R-TEST-01',
  words_wan: 10, badges: [], chapters: [], intro: '简介正文', intro_lede: '导语',
  audience: '适用人群', sample_label: '试读',
};

// Collect every text string anywhere in the tree
function collectText(node, acc) {
  if (!node || typeof node !== 'object') { if (typeof node === 'string' && node.trim()) acc.push(node.trim()); return; }
  if (Array.isArray(node)) { node.forEach((n) => collectText(n, acc)); return; }
  for (const k of Object.keys(node)) {
    if (k === 'children' || k === 'child') collectText(node[k], acc);
    else if (typeof node[k] === 'string' && node[k].trim() && (k === 'text' || k === 'content')) acc.push(node[k].trim());
    else if (node[k] && typeof node[k] === 'object') collectText(node[k], acc);
  }
}

const scenarios = [
  ['A_iOS_sellable_unpurchased', { d: baseD, paySupported: false, loading: false, errMsg: '' }],
  ['B_android_sellablefalse_preparing', { d: Object.assign({}, baseD, { sellable: false }), paySupported: true, loading: false, errMsg: '' }],
  ['D_control_android_sellable', { d: baseD, paySupported: true, loading: false, errMsg: '' }],
];

for (const [name, over] of scenarios) {
  const env = Object.assign({
    d: baseD, paySupported: true, loading: false, errMsg: '',
    sample: '', sampleBlocks: [], sampleOpen: false, buying: false, opening: false,
    nav: { statusBarHeight: 20, navHeight: 44 }, themeStyle: '',
  }, over);
  const root = render(env, null, {});
  const acc = [];
  collectText(root, acc);
  console.log('== ' + name + ' ==');
  console.log('  ALL TEXT: ' + JSON.stringify(acc));
  console.log('');
}
