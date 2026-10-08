# -*- coding: utf-8 -*-
"""template — 发布平台 HTML 模板（移动优先·微信内打开·零外部依赖）.

frontend-design 规范: 「总包智库」编辑部风——墨蓝×铜金×纸白, 中文衬线
大标题, 内联 CSS, 无任何 CDN/外链/字体请求; 交互用原生 JS (<90 行).
"""
from __future__ import annotations

import html

CSS = """
:root{--ink:#0F2A43;--ink2:#16385C;--brass:#B08D57;--brass2:#C9A876;
--paper:#FAF7F2;--text:#2B2B2B;--mut:#7A7264;--line:#E7DFD2;}
*{margin:0;padding:0;box-sizing:border-box;-webkit-tap-highlight-color:transparent}
html{scroll-behavior:smooth}
body{font-family:-apple-system,PingFang SC,Microsoft YaHei,sans-serif;
background:var(--paper);color:var(--text);font-size:16px;line-height:1.75}
.serif{font-family:Songti SC,STSong,SimSun,serif}
a{color:var(--ink)}
.wrap{max-width:680px;margin:0 auto;padding:0 20px}

/* hero */
.hero{background:linear-gradient(160deg,var(--ink) 0%,var(--ink2) 100%);
color:#fff;padding:52px 0 96px;position:relative;overflow:hidden}
.hero::after{content:"";position:absolute;right:-70px;top:-70px;width:260px;height:260px;
border:1px solid rgba(176,141,87,.35);border-radius:50%}
.hero::before{content:"";position:absolute;right:-30px;top:-30px;width:180px;height:180px;
border:1px solid rgba(176,141,87,.2);border-radius:50%}
.hero .brand{font-size:12px;letter-spacing:.35em;color:var(--brass2);margin-bottom:26px}
.hero h1{font-size:29px;line-height:1.45;font-weight:700;letter-spacing:.02em}
.hero .sub{margin-top:14px;font-size:14px;color:#C8D4E0}
.hero .pricebar{margin-top:26px;display:flex;align-items:baseline;gap:12px}
.hero .price{font-size:34px;color:var(--brass2);font-weight:700}
.hero .price small{font-size:15px;font-weight:400}
.hero .tag{font-size:12px;border:1px solid var(--brass);color:var(--brass2);
padding:3px 10px;border-radius:99px}

/* 徽章横滑 */
.badges{display:flex;gap:10px;overflow-x:auto;padding:14px 20px 4px;
margin-top:-58px;position:relative;scrollbar-width:none}
.badges::-webkit-scrollbar{display:none}
.badge{flex:0 0 auto;background:var(--ink);color:#fff;border-radius:10px;
padding:12px 16px;min-width:118px;border-bottom:3px solid var(--brass)}
.badge .v{font-size:19px;font-weight:700;color:var(--brass2)}
.badge .k{font-size:11px;color:#9FB0C2;margin-top:2px;letter-spacing:.05em}

/* 区块 */
section{padding:34px 0}
h2.sec{font-size:21px;color:var(--ink);margin-bottom:6px}
h2.sec em{font-style:normal;color:var(--brass);margin-right:8px;font-family:Songti SC,serif}
.sec-sub{font-size:13px;color:var(--mut);margin-bottom:18px}

/* 简介 */
.lede{border-left:3px solid var(--brass);padding:2px 0 2px 16px;margin:18px 0;
font-family:Songti SC,STSong,serif;font-size:17px;color:var(--ink);line-height:1.9}
.blurb p{margin:12px 0}
.blurb strong{color:var(--ink)}

/* 目录手风琴 */
details.toc{border:1px solid var(--line);border-radius:12px;background:#fff;
margin-bottom:10px;overflow:hidden}
details.toc summary{list-style:none;padding:15px 16px;display:flex;gap:12px;
align-items:baseline;cursor:pointer;font-weight:600;color:var(--ink)}
details.toc summary::-webkit-details-marker{display:none}
details.toc summary .no{font-family:Songti SC,serif;color:var(--brass);
font-size:14px;flex:0 0 34px}
details.toc summary .t{flex:1;font-size:15px}
details.toc summary .car{color:var(--brass);transition:transform .25s;font-size:12px}
details.toc[open] summary .car{transform:rotate(90deg)}
.toc-body{padding:0 16px 14px 62px;font-size:13.5px;color:var(--mut)}
.toc-body div{padding:3px 0}

/* 试读卡 */
.sample-card{background:linear-gradient(150deg,var(--ink),var(--ink2));border-radius:16px;
color:#fff;padding:30px 24px;position:relative;overflow:hidden}
.sample-card::after{content:"试读";position:absolute;right:14px;top:10px;
font-family:Songti SC,serif;font-size:76px;color:rgba(176,141,87,.14);font-weight:700}
.sample-card h3{font-size:20px;margin-bottom:8px}
.sample-card p{font-size:13.5px;color:#C8D4E0;margin-bottom:20px}
.btn{display:inline-block;background:var(--brass);color:#fff;text-decoration:none;
padding:13px 30px;border-radius:99px;font-size:16px;font-weight:600;
border:none;cursor:pointer;font-family:inherit}
.btn:active{background:var(--brass2)}
.btn.ghost{background:transparent;border:1px solid var(--brass);color:var(--brass2)}

/* 购买区 */
.buy-box{background:#fff;border:1px solid var(--line);border-radius:16px;padding:26px 22px}
.buy-box h3{font-size:19px;color:var(--ink);margin-bottom:14px}
.perk{display:flex;gap:10px;padding:7px 0;font-size:14.5px}
.perk .ck{color:var(--brass);font-weight:700}
.qr-row{display:flex;gap:14px;margin:22px 0 6px}
.qr{flex:1;text-align:center;background:var(--paper);border:1px dashed var(--line);
border-radius:12px;padding:16px 10px}
.qr img{width:132px;height:132px;border-radius:8px}
.qr .ph{width:132px;height:132px;margin:0 auto;border-radius:8px;background:
repeating-linear-gradient(45deg,#F2EDE4 0 10px,#FAF7F2 10px 20px);
display:flex;align-items:center;justify-content:center;font-size:12px;color:var(--mut)}
.qr .qt{font-size:12.5px;margin-top:10px;color:var(--mut)}
.flow{display:flex;gap:8px;margin-top:18px}
.flow .st{flex:1;background:var(--paper);border-radius:10px;padding:10px 8px;
font-size:11.5px;color:var(--mut);text-align:center;line-height:1.5}
.flow .st b{display:block;color:var(--ink);font-size:13px;margin-bottom:2px}

/* 预告卡 */
.soon{border:1px dashed var(--brass);border-radius:16px;padding:24px 20px;
background:rgba(176,141,87,.05)}
.soon h3{color:var(--ink);font-size:18px}
.soon .vols{display:flex;flex-wrap:wrap;gap:8px;margin:14px 0}
.soon .vol{font-size:12.5px;background:#fff;border:1px solid var(--line);
padding:5px 12px;border-radius:99px;color:var(--ink)}

/* 吸底栏 */
.bar{position:fixed;left:0;right:0;bottom:0;background:var(--ink);z-index:50;
padding:10px 20px calc(10px + env(safe-area-inset-bottom));
display:flex;align-items:center;gap:14px;justify-content:space-between}
.bar .bp{color:#fff}
.bar .bp .n{font-size:21px;font-weight:700;color:var(--brass2)}
.bar .bp .o{font-size:11px;color:#9FB0C2;text-decoration:line-through}
.bar .btn{padding:11px 26px;font-size:15px}
.pad-bottom{height:88px}

/* 阅读页 */
.reader{padding:30px 0 60px}
.reader .crumb{font-size:12.5px;color:var(--mut);margin-bottom:16px}
.reader h1{font-family:Songti SC,STSong,serif;font-size:24px;color:var(--ink);
line-height:1.5;margin-bottom:24px;padding-bottom:14px;border-bottom:2px solid var(--brass)}
.reader h2{font-family:Songti SC,STSong,serif;font-size:19px;color:var(--ink);
margin:30px 0 12px}
.reader p{margin:13px 0;font-size:16.5px;line-height:1.95;color:#333}
.reader ul{margin:13px 0 13px 22px}
.reader li{margin:6px 0;font-size:15.5px;line-height:1.85}
.cta-end{background:linear-gradient(150deg,var(--ink),var(--ink2));border-radius:14px;
color:#fff;padding:26px 22px;text-align:center;margin-top:36px}
.cta-end p{font-size:13.5px;color:#C8D4E0;margin-bottom:16px}

/* admin */
.admin{padding:26px 0 60px}
.fb-policy{background:#fff;border:1px solid var(--line);border-left:3px solid
 var(--brass);border-radius:10px;padding:12px 14px;font-size:13px;
 color:var(--mut);line-height:1.8}
.fb-policy b{color:var(--ink)}
.stars{display:flex;align-items:center}
.star{font-size:30px;color:var(--line);cursor:pointer;margin-right:4px;
 transition:color .15s}
.star.on{color:var(--brass)}
#doc{margin-top:10px}
table.a{width:100%;border-collapse:collapse;font-size:13px;background:#fff;
border-radius:10px;overflow:hidden}
table.a th{background:var(--ink);color:#fff;padding:9px 10px;text-align:left;font-weight:500}
table.a td{padding:8px 10px;border-bottom:1px solid var(--line)}
.funn{display:flex;flex-wrap:wrap;gap:8px;margin:16px 0}
.funn .f{background:#fff;border:1px solid var(--line);border-radius:10px;
padding:10px 14px;font-size:12.5px}
.funn .f b{display:block;font-size:20px;color:var(--ink)}

footer{padding:30px 0 40px;text-align:center;font-size:12px;color:var(--mut);
border-top:1px solid var(--line)}
footer .serif{color:var(--brass);letter-spacing:.2em}

/* 目录页 (catalog) */
.cat-hero{background:linear-gradient(160deg,var(--ink) 0%,var(--ink2) 100%);
color:#fff;padding:46px 0 40px;position:relative;overflow:hidden}
.cat-hero::after{content:"";position:absolute;right:-70px;top:-70px;width:260px;
height:260px;border:1px solid rgba(176,141,87,.35);border-radius:50%}
.cat-hero::before{content:"";position:absolute;right:-30px;top:-30px;width:180px;
height:180px;border:1px solid rgba(176,141,87,.2);border-radius:50%}
.cat-hero .brand{font-size:12px;letter-spacing:.35em;color:var(--brass2);margin-bottom:20px}
.cat-hero h1{font-size:26px;line-height:1.45;font-weight:700}
.cat-hero .sub{margin-top:12px;font-size:14px;color:#C8D4E0}
.cat-hero .stats{display:flex;gap:26px;margin-top:22px;flex-wrap:wrap}
.cat-hero .stat b{display:block;font-size:22px;color:var(--brass2);font-weight:700}
.cat-hero .stat span{font-size:11.5px;color:#9FB0C2;letter-spacing:.05em}
.feat{background:linear-gradient(150deg,var(--ink),var(--ink2));border-radius:14px;
color:#fff;padding:22px 18px;margin-bottom:12px;position:relative;overflow:hidden}
.feat::after{content:"旗舰";position:absolute;right:10px;top:6px;font-family:
Songti SC,STSong,serif;font-size:44px;color:rgba(176,141,87,.16);font-weight:700}
.feat h3{font-size:17.5px;line-height:1.5;padding-right:56px}
.feat .fm{font-size:12.5px;color:#C8D4E0;margin-top:6px;line-height:1.7}
.feat .fb{display:flex;gap:14px;margin-top:8px;font-size:11.5px;color:#9FB0C2}
.feat .fb b{color:var(--brass2)}
.feat .fl{display:flex;align-items:center;justify-content:space-between;margin-top:14px}
.feat .pr{font-size:20px;color:var(--brass2);font-weight:700}
.feat .fl a{font-size:13px;color:#fff;text-decoration:none;border:1px solid
var(--brass);padding:7px 16px;border-radius:99px}
.feat .fl a.gold{background:var(--brass);font-weight:600}
.soon-band{border:1px dashed var(--brass);border-radius:12px;padding:14px 16px;
background:rgba(176,141,87,.05);display:flex;align-items:center;gap:12px;
justify-content:space-between;margin-bottom:6px}
.soon-band .st{font-size:13px;color:var(--ink);line-height:1.6}
.soon-band .st b{font-size:14.5px}
.soon-band a{font-size:12px;color:var(--brass);white-space:nowrap;
text-decoration:none;border-bottom:1px solid var(--brass)}
.cards{display:grid;grid-template-columns:1fr 1fr;gap:11px}
.card{background:#fff;border:1px solid var(--line);border-radius:12px;
padding:13px 12px 11px;display:flex;flex-direction:column}
.card .ct{font-size:13.5px;font-weight:600;color:var(--ink);line-height:1.55}
.card .cm{font-size:11.5px;color:var(--mut);margin-top:6px;line-height:1.6}
.card .cp{display:flex;align-items:baseline;justify-content:space-between;
margin-top:auto;padding-top:10px}
.card .cp .pr{color:var(--brass);font-weight:700;font-size:16px}
.card .cp .lk{font-size:12px}
.card .cp .lk a{color:var(--ink);text-decoration:none;border-bottom:1px
solid var(--brass)}
.cat-count{font-size:12px;color:var(--mut);float:right;margin-top:4px}
.toc-flat{display:flex;gap:12px;align-items:baseline;background:#fff;
border:1px solid var(--line);border-radius:10px;padding:11px 14px;margin-bottom:7px}
.toc-flat .no{font-family:Songti SC,serif;color:var(--brass);font-size:13px;flex:0 0 30px}
.toc-flat .t{font-size:14.5px;font-weight:600;color:var(--ink)}
"""

TRACK_JS = """
(function(){
 var sku=document.body.getAttribute('data-sku')||'';
 var src=new URLSearchParams(location.search).get('src')||document.referrer||'';
 function t(e,x){try{fetch('/api/track',{method:'POST',headers:{'Content-Type':'application/json'},
  body:JSON.stringify({event:e,sku:sku,extra:(x||src).slice(0,120)})});}catch(_){}}
 /* 1008 漏斗去伪: visit 每会话一次 (刷新不再+1, 修双重计数伪影) */
 try{if(!sessionStorage.getItem('v_'+sku)){sessionStorage.setItem('v_'+sku,'1');t('visit');}}catch(_){t('visit');}
 var seen={};window.addEventListener('scroll',function(){
  var d=document.documentElement;var p=(window.scrollY+d.scrollTop)/
  (d.scrollHeight-window.innerHeight)*100;
  [25,50,75,90].forEach(function(m){if(p>=m&&!seen[m]){seen[m]=1;t('scroll_'+m);}});
 },{passive:true});
 document.querySelectorAll('[data-ev]').forEach(function(el){
  el.addEventListener('click',function(){t(el.getAttribute('data-ev'));});});
 var buy=document.getElementById('buyBtn');
 var _buySent=false;
 if(buy){buy.addEventListener('click',function(){
  /* 1008 去伪: 购买意图事件每页只计一次, 滚动行为不受影响 */
  if(!_buySent){_buySent=true;t('click_buy');}
  var p=document.getElementById('buyPanel');
  if(p){p.scrollIntoView({behavior:'smooth'});}
  var o=document.getElementById('orderNo');
  if(o&&!o.textContent){var d=new Date();var s=d.getFullYear()%100*10000000+
   (d.getMonth()+1)*100000+d.getDate()*10000+(d.getHours()*60+d.getMinutes());
   s=String(s)+String(1000+Math.floor(Math.random()*9000)).slice(1);
   o.textContent='订单号 '+s;t('show_qr');}
 });}
 var of=document.getElementById('orderForm');
 if(of){of.addEventListener('submit',function(ev){
  ev.preventDefault();
  var fd=new FormData(of);
  fetch('/api/order',{method:'POST',headers:{'Content-Type':'application/json'},
   body:JSON.stringify({sku:sku,contact:fd.get('contact')||'',
   note:fd.get('note')||'',order_no:document.getElementById('orderNo').textContent.replace('订单号 ','')})})
  .then(function(r){return r.json();})
  .then(function(j){var m=document.getElementById('orderMsg');
   m.textContent=j.ok?'✓ 登记成功，我们核对到账后即刻联系您交付':'提交失败，请重试';
   m.style.color=j.ok?'#2E7D32':'#B3261E';t('order_created');})
  .catch(function(){document.getElementById('orderMsg').textContent='网络异常，请重试';});
 });}
})();
"""


SITE_BASE = "http://report.yrecepc.cn"   # 二级域名正式口 (F5a-8); 顶级域 301 在此
OG_IMAGE = SITE_BASE + "/assets/og_card.png"


def page(title: str, body: str, sku: str = "", extra_js: str = "",
         desc: str = "", path: str = "", noindex: bool = False) -> str:
    """desc/path 驱动分享卡 (og:) 与 canonical; noindex 用于 admin 等非买家面.

    title/desc 一律 html.escape(quote=True) — 语料章标题惯例含 ASCII 双引号,
    不转义则未来某条副题带引号时会截断 meta 属性 (评审 HIGH 项).
    """
    e_title = html.escape(title, quote=True)
    e_desc = html.escape(desc, quote=True)
    og_url = f"{SITE_BASE}/{path.lstrip('/')}" if path else ""
    meta = []
    if desc:
        meta.append(f'<meta name="description" content="{e_desc}">')
    meta.append(f'<meta property="og:title" content="{e_title}">')
    if desc:
        meta.append(f'<meta property="og:description" content="{e_desc}">')
    meta.append('<meta property="og:type" content="website">')
    if og_url:
        meta.append(f'<meta property="og:url" content="{og_url}">')
        meta.append(f'<link rel="canonical" href="{og_url}">')
    meta.append(f'<meta property="og:image" content="{OG_IMAGE}">')
    if noindex:
        meta.append('<meta name="robots" content="noindex,nofollow">')
    meta_html = "\n".join(meta)
    return f"""<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">
<title>{e_title}</title>
<meta name="format-detection" content="telephone=no">
{meta_html}
<style>{CSS}</style>
</head>
<body data-sku="{sku}">
{body}
<script>{TRACK_JS}</script>
<script>{extra_js}</script>
</body>
</html>"""
