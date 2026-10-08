// dump 弹出的应用列表（浮层里含多个小程序条目）
var out = {layers: []};
var els = document.querySelectorAll('div, a, li');
for (var i = 0; i < els.length; i++) {
  var el = els[i];
  var cls = (el.className || '').toString();
  var r = el.getBoundingClientRect();
  if (r.width < 100 || r.height < 30) continue;
  if (cls.indexOf('menu_box_wrapper') >= 0 || cls.indexOf('col_side') >= 0) continue;
  var t = (el.innerText || '').replace(/\s+/g, ' ').trim();
  if (!t || t.length > 120) continue;
  if (t.indexOf('顾问') >= 0 || t.indexOf('AI') >= 0 || t.indexOf('总包') >= 0 || t.indexOf('学园') >= 0 || t.indexOf('科技') >= 0 || cls.indexOf('app_list') >= 0 || cls.indexOf('appList') >= 0 || cls.indexOf('logo') >= 0) {
    out.layers.push({cls: cls.slice(0, 48), t: t.slice(0, 100), x: Math.round(r.x), y: Math.round(r.y), w: Math.round(r.width)});
  }
}
var seen = {};
out.layers = out.layers.filter(function(p) { var k = p.cls + p.t; if (seen[k]) return false; seen[k] = 1; return true; });
return JSON.stringify(out);
