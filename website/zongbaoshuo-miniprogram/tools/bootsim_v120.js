// bootsim_v120.js — v1.2.0 结构化版本门 (总包科技 · 旗舰直达)
// 断言不认感觉: JSON/schema/图片路径/WXML lint/品牌清扫/包体积
const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..');
const MP = path.join(ROOT, 'miniprogram');
const APPID = 'wx5cee1574ce45819b';

let pass = 0;
let fail = 0;
const failures = [];

function check(name, cond, detail) {
  if (cond) {
    pass += 1;
    console.log(`  ok   ${name}`);
  } else {
    fail += 1;
    failures.push(`${name}${detail ? ` — ${detail}` : ''}`);
    console.log(`  FAIL ${name}${detail ? ` — ${detail}` : ''}`);
  }
}

function read(p) {
  return fs.readFileSync(p, 'utf8');
}

console.log('== [1] app.json ==');
const appJson = JSON.parse(read(path.join(MP, 'app.json')));
check('title 总包科技', appJson.window.navigationBarTitleText === '总包科技');
check('navigateToMiniProgramAppIdList 含顾问 appid', Array.isArray(appJson.navigateToMiniProgramAppIdList) && appJson.navigateToMiniProgramAppIdList.includes(APPID));
check('pages 完整', JSON.stringify(appJson.pages) === JSON.stringify(['pages/index/index', 'pages/product/product']));
for (const pg of appJson.pages) {
  check(`page 文件齐 ${pg}`, ['js', 'wxml', 'wxss', 'json'].every((ext) => fs.existsSync(path.join(MP, `${pg}.${ext}`))));
}

console.log('== [2] package.json ==');
const pkg = JSON.parse(read(path.join(ROOT, 'package.json')));
check('version 1.2.0', pkg.version === '1.2.0');

console.log('== [3] products.js schema ==');
delete require.cache[require.resolve(path.join(MP, 'utils/products.js'))];
const { products } = require(path.join(MP, 'utils/products.js'));
const ids = products.map((p) => p.id);
check('10 条产品', products.length === 10, `got ${products.length}`);
check('顺序 consultant 首', ids[0] === 'consultant');
check('顺序 aiglasses 尾', ids[ids.length - 1] === 'aiglasses');
check('八线原序不变', ids.slice(1, 9).join(',') === 'leopard,brain,zhiku,factory,aipo,station,glasses,robot');
const consultant = products.find((p) => p.id === 'consultant');
const aiglasses = products.find((p) => p.id === 'aiglasses');
const brain = products.find((p) => p.id === 'brain');
const zhiku = products.find((p) => p.id === 'zhiku');
check('consultant.jump 指向顾问小程序', consultant.jump && consultant.jump.appId === APPID && consultant.jump.path === 'pages/home/home');
check('consultant 无 qr', !consultant.qr);
check('aiglasses.guide 三步', aiglasses.guide && aiglasses.guide.steps.length === 3);
check('aiglasses 审核中口径', /审核中/.test(aiglasses.guide.note));
check('aiglasses mech 六步', aiglasses.mech && aiglasses.mech.length === 6);
check('brain 无 qr / 有 jump', !brain.qr && brain.jump && brain.jump.appId === APPID);
check('zhiku 无 qr / 有 jump', !zhiku.qr && zhiku.jump && zhiku.jump.appId === APPID);
const allText = JSON.stringify(products);
check('products 无 365 元残留', !allText.includes('365'));
check('products 无 608 元残留', !allText.includes('608'));

console.log('== [4] 图片路径存在 ==');
const imgs = new Set();
for (const p of products) {
  if (p.image && p.image.src) imgs.add(p.image.src);
  if (Array.isArray(p.images)) p.images.forEach((m) => imgs.add(m.src));
  if (p.qr && p.qr.src) imgs.add(p.qr.src);
}
for (const src of imgs) {
  check(`img ${src}`, fs.existsSync(path.join(MP, src.replace(/^\//, ''))));
}

console.log('== [5] content.js ==');
delete require.cache[require.resolve(path.join(MP, 'utils/content.js'))];
const content = require(path.join(MP, 'utils/content.js'));
check('flagship 导出', content.flagship && content.flagship.cards.length === 2);
check('flagship card1 jump / card2 product', content.flagship.cards[0].type === 'jump' && content.flagship.cards[1].type === 'product');
check('business card1 = 总包AI顾问', content.business.cards[0].h === '总包AI顾问' && content.business.cards[0].id === 'consultant');
check('business card3 ¥498 起', content.business.cards[2].price === '¥498');
check('contact qr 仍为总包君', content.contact.qr === '/images/qr-zongbaojun.jpg');
check('footer 品牌 总包+科技', content.footer.zh + content.footer.zhEm + content.footer.zhTail === '总包科技');
check('dwg 编号 2026-10', content.dwg.no === 'DWG-2026-10');
check('content 图片存在', fs.existsSync(path.join(MP, content.contact.qr.replace(/^\//, ''))));

console.log('== [6] 品牌清扫 (总包说 → 0) ==');
const sweepFiles = [];
(function walk(dir) {
  for (const f of fs.readdirSync(dir)) {
    const fp = path.join(dir, f);
    if (fs.statSync(fp).isDirectory()) walk(fp);
    else if (/\.(js|wxml|wxss|json)$/.test(f)) sweepFiles.push(fp);
  }
})(MP);
const offenders = sweepFiles.filter((fp) => read(fp).includes('总包说'));
check('全包 0 处「总包说」', offenders.length === 0, offenders.map((f) => path.relative(MP, f)).join(', '));

console.log('== [7] WXML lint ==');
for (const wxml of ['pages/index/index.wxml', 'pages/product/product.wxml']) {
  const txt = read(path.join(MP, wxml));
  const opens = (txt.match(/<view\b[^>]*[^/]>/g) || []).length;
  const selfClosed = (txt.match(/<view\b[^>]*\/>/g) || []).length;
  const closes = (txt.match(/<\/view>/g) || []).length;
  check(`${wxml} view 标签平衡`, opens === closes, `open=${opens} self=${selfClosed} close=${closes}`);
  const methodCall = txt.match(/\{\{[^}]*\w+\([^)}]*\)[^}]*\}\}/);
  check(`${wxml} 无方法调用绑定`, !methodCall, methodCall ? methodCall[0] : '');
  const wxforKey = !/\bwx:for=(?!"|')/.test(txt);
  check(`${wxml} wx:for 均带引号`, wxforKey);
}
const idxWxml = read(path.join(MP, 'pages/index/index.wxml'));
check('index 含旗舰直达块', idxWxml.includes('flagship') && idxWxml.includes('onFlagship'));
const prodWxml = read(path.join(MP, 'pages/product/product.wxml'));
check('product 含 jump-cta/guide 块', prodWxml.includes('jump-cta') && prodWxml.includes('p.jump') && prodWxml.includes('p.guide'));

console.log('== [8] JS handler 接线 ==');
const idxJs = read(path.join(MP, 'pages/index/index.js'));
check('index.js onFlagship + navigateToMiniProgram', idxJs.includes('onFlagship') && idxJs.includes('wx.navigateToMiniProgram') && idxJs.includes(APPID));
const prodJs = read(path.join(MP, 'pages/product/product.js'));
check('product.js onJump + navigateToMiniProgram', prodJs.includes('onJump') && prodJs.includes('wx.navigateToMiniProgram'));
check('product.js 标题后缀 总包科技', prodJs.includes('· 总包科技'));
const idxWxss = read(path.join(MP, 'pages/index/index.wxss'));
check('index.wxss fcard 样式', idxWxss.includes('.fcard') && idxWxss.includes('.fcard.live'));
const prodWxss = read(path.join(MP, 'pages/product/product.wxss'));
check('product.wxss jump/guide 样式', prodWxss.includes('.jump-cta') && prodWxss.includes('.jc-btn') && prodWxss.includes('.gstep'));
check('qr-inline 样式已清', !prodWxss.includes('.qr-inline') && !prodWxml.includes('qr-inline'));

console.log('== [9] 包体积 ==');
let total = 0;
(function walkSize(dir) {
  for (const f of fs.readdirSync(dir)) {
    const fp = path.join(dir, f);
    const st = fs.statSync(fp);
    if (st.isDirectory()) walkSize(fp);
    else total += st.size;
  }
})(MP);
check(`miniprogram/ ${Math.round(total / 1024)}KB < 2048KB`, total < 2 * 1024 * 1024);

console.log(`\n== RESULT: ${pass} ok / ${fail} fail ==`);
if (fail > 0) {
  console.log(failures.map((f) => `  - ${f}`).join('\n'));
  process.exit(1);
}
