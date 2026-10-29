# -*- coding: utf-8 -*-
"""Fixture v2: Chrome-side probes — capture s()'s error string, match results, Math.random set events, cookie."""
import os, re

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
FIX = os.path.join(BASE, "work", "fixture")
os.makedirs(FIX, exist_ok=True)

html = open(os.path.join(BASE, "captures", "challenge_h1.html"), encoding="utf-8").read()

m = re.search(r"<script>(function getRenderData.*?)</script>", html, re.S)

new_script1 = r'''function getRenderData(){return document.getElementById("renderData").innerHTML}
var renderData=JSON.parse(getRenderData()),arg1=renderData.l1.slice(10,60);
function setCookie(e,r){var t=new Date;t.setTime(t.getTime()+36e5),document.cookie=e+"="+r+";expires="+t.toGMTString()+";max-age=3600;path=/"}
function reload(e){setCookie("acw_sc__v2",e);console.log("CHINCA_ACWV2:"+e);}
(function(){
var _match = String.prototype.match;
String.prototype.match = function(re){
  var r = _match.call(this, re);
  try { if (typeof this === "string" && this.length > 20 && /SVGAnimate|TypeError|at /.test(this)) {
    console.log("PROBE_MATCH_ARG:" + JSON.stringify(this));
    console.log("PROBE_MATCH_RESULT:" + JSON.stringify(r && r.slice ? r.slice(0, 20) : r));
  } } catch(e) {}
  return r;
};
var _mr = Math.random, _mrCount = 0;
try { Object.defineProperty(Math, "random", {
  configurable: true,
  get: function(){ return _mr; },
  set: function(v){ _mrCount++; console.log("PROBE_RANDOM_SET#" + _mrCount + ":" + (v === _mr)); }
}); } catch(e) { console.log("PROBE_RANDOM_HOOK_FAIL"); }
console.log("PROBE_BOOT:ua=" + navigator.userAgent.slice(-30) + ":wd=" + navigator.webdriver);
})();'''

html2 = html.replace(m.group(1), new_script1, 1)
assert "PROBE_MATCH_ARG" in html2
with open(os.path.join(FIX, "challenge2.html"), "w", encoding="utf-8") as f:
    f.write(html2)
print("fixture2 written", len(html2))
