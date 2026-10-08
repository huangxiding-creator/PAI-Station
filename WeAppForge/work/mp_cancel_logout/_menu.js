var out = {url: location.href.slice(0, 140), title: document.title.slice(0, 40)};
// 会话 appid 证据：INITIAL_STATE 或页面里的 appid
var body = (document.body.textContent || '');
var m = body.match(/"appid":"(wx[0-9a-f]{16})"/);
out.appid = m ? m[1] : null;
var m2 = body.match(/"nickName":"([^"]{1,24})"/);
out.nick = m2 ? m2[1] : null;
// 版本块
var logs = document.querySelectorAll('.code_version_log');
out.n_logs = logs.length;
var rows = [];
for (var i = 0; i < Math.min(logs.length, 3); i++) rows.push(logs[i].textContent.replace(/\s+/g, ' ').slice(0, 110));
out.rows = rows;
// 灰度横幅
var banner = [];
var els = document.querySelectorAll('div, p, span');
for (var j = 0; j < els.length; j++) {
  var own = '';
  for (var k = 0; k < els[j].childNodes.length; k++) {
    var n = els[j].childNodes[k];
    if (n.nodeType === 3) own += n.textContent;
  }
  own = own.replace(/\s+/g, ' ').trim();
  if (own.indexOf('灰度') >= 0 && own.length < 160) banner.push(own);
}
out.banner = banner;
return JSON.stringify(out);
