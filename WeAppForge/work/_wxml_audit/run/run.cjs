// Adversarial verification: does report.wxml render BOTH the full report content
// AND the "报告不存在" error card when d is loaded but rp-bar's wx:if is false?
// Ground truth = wcc.exe (official WeChat WXML compiler) output executed in node.
const fs = require('fs');
const path = require('path');

const code = fs.readFileSync(path.join(__dirname, 'gen.js'), 'utf8');
global.window = global;
global.window.__webview_engine_version__ = 0.02; // return raw root tree
(0, eval)(code); // indirect eval: non-strict, defines $gwx on globalThis

const render = $gwx('pages/report/report.wxml');
if (typeof render !== 'function') throw new Error('$gwx did not return render fn');

const baseD = {
  unlocked: false, sellable: true, price_label: '¥498',
  title: '测试报告题名', cat_name: 'EPC', subtitle: '副题', sku: 'R-TEST-01',
  words_wan: 10, badges: [], chapters: [], intro: '简介正文', intro_lede: '导语',
  audience: '适用人群', sample_label: '试读',
};

function mkEnv(over) {
  return Object.assign({
    d: baseD, paySupported: true, loading: false, errMsg: '',
    sample: '', sampleBlocks: [], sampleOpen: false, buying: false, opening: false,
    nav: { statusBarHeight: 20, navHeight: 44 }, themeStyle: '',
  }, over);
}

const scenarios = [
  ['A_iOS_sellable_unpurchased', mkEnv({ paySupported: false })],
  ['B_android_preparing_sellablefalse', mkEnv({ d: Object.assign({}, baseD, { sellable: false }) })],
  ['C_loading_d_null', mkEnv({ d: null, loading: true })],
  ['D_android_sellable_unpurchased_CONTROL', mkEnv({ paySupported: true })],
  ['E_error_d_null', mkEnv({ d: null, loading: false, errMsg: '网络异常' })],
];

// Collect tags/classes/texts from the rendered tree
function walk(node, out) {
  if (!node) return;
  if (Array.isArray(node)) { node.forEach((n) => walk(n, out)); return; }
  if (node.tag) {
    const cls = node.attr && node.attr.class;
    out.nodes.push(node.tag + (cls ? '.' + String(cls).split(' ').join('.') : ''));
  }
  if (node.children) node.children.forEach((c) => walk(c, out));
  // raw text nodes: compiled as {text: ...} or tag undefined with content
  if (!node.tag && typeof node.text === 'string') out.texts.push(node.text);
}

for (const [name, env] of scenarios) {
  let root;
  try {
    root = render(env, null, {});
  } catch (e) {
    console.log('== ' + name + ' == RENDER THREW: ' + e.message);
    continue;
  }
  const out = { nodes: [], texts: [] };
  walk(root, out);
  const flat = out.nodes.join(' | ');
  const hasMainContent = out.nodes.some((n) => /rp-title|hero-kicker/.test(n)) ||
    out.texts.some((t) => t.indexOf('测试报告题名') >= 0);
  const hasErrorCard = out.nodes.some((n) => /rp-state$|rp-state\b/.test(n)) ||
    out.texts.some((t) => t.indexOf('报告不存在') >= 0 || t.indexOf('报告加载中') >= 0);
  const hasRpBar = out.nodes.some((n) => n.indexOf('rp-bar') >= 0);
  const errText = out.texts.find((t) => t.indexOf('报告不存在') >= 0);
  console.log('== ' + name + ' ==');
  console.log('  mainContent=' + hasMainContent + '  rpBar=' + hasRpBar + '  stateCard=' + hasErrorCard + (errText ? '  errCardText="' + errText + '"' : ''));
  console.log('  texts: ' + JSON.stringify(out.texts.slice(0, 14)));
  console.log('  classes containing "rp-state" or "page": ' + out.nodes.filter((n) => /rp-state|^view\.page|page-has-bar/.test(n)).join(' ; '));
}
