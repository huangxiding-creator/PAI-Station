// WXML↔JS 绑定审计：每个 bind*/catch* 处理器必须在对应页面 JS 中存在
const fs = require('fs');
const path = require('path');

const ROOT = 'E:/AI-Station/WeAppForge/projects/biaoxun';
const pages = ['pages/ask/ask', 'pages/answer/answer', 'pages/my/my'];
let bad = 0;

for (const pg of pages) {
  const wxml = fs.readFileSync(path.join(ROOT, pg + '.wxml'), 'utf8');
  const js = fs.readFileSync(path.join(ROOT, pg + '.js'), 'utf8');
  const handlers = [...wxml.matchAll(/(?:bind|catch):?[\w]+="(\w+)"/g)].map((m) => m[1]);
  const uniq = [...new Set(handlers)];
  for (const h of uniq) {
    const found = new RegExp(h + '\\s*\\(').test(js);
    console.log(`${found ? 'OK ' : 'MISSING'} ${pg} :: ${h}`);
    if (!found) bad++;
  }
  // tabBar 页禁 fixed（原生 tabBar 会盖住点击）
  const wxss = fs.readFileSync(path.join(ROOT, pg + '.wxss'), 'utf8');
  if (/position:\s*fixed/.test(wxss)) { console.log(`FIXED-ON-TABPAGE ${pg}`); bad++; }
}
const appJson = JSON.parse(fs.readFileSync(path.join(ROOT, 'app.json'), 'utf8'));
for (const t of appJson.tabBar.list) {
  for (const key of ['iconPath', 'selectedIconPath']) {
    if (!fs.existsSync(path.join(ROOT, t[key]))) { console.log(`ICON-MISSING ${t[key]}`); bad++; }
  }
}
console.log(bad === 0 ? 'BINDING AUDIT PASS' : `BINDING AUDIT FAIL (${bad})`);
process.exit(bad === 0 ? 0 : 1);
