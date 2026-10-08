// 找新弹出的浮层（非抽屉）：含 小程序列表/切换/管理 关键词的可见容器
var out = [];
var els = document.querySelectorAll('div');
for (var i = 0; i < els.length; i++) {
  var el = els[i];
  var cls = (el.className || '').toString();
  var r = el.getBoundingClientRect();
  if (r.width < 120 || r.height < 60) continue;
  var t = (el.innerText || '').replace(/\s+/g, ' ').trim();
  if (!t || t.length > 300) continue;
  if (cls.indexOf('menu_box') >= 0) continue;
  if (t.indexOf('切换') >= 0 || t.indexOf('小程序') >= 0 && t.indexOf('管理') >= 0 || t.indexOf('账号') >= 0 && t.length < 200) {
    out.push({cls: cls.slice(0, 50), t: t.slice(0, 160), x: Math.round(r.x), y: Math.round(r.y)});
  }
}
var seen = {};
out = out.filter(function(p) { var k = p.cls + p.t; if (seen[k]) return false; seen[k] = 1; return true; });
return JSON.stringify(out.slice(0, 10));
