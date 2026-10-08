# -*- coding: utf-8 -*-
"""template — 发布平台 HTML 模板（移动优先·微信内打开·零外部依赖）.

1008 v2 设计语言「档案级研究所」(用户令: 站点须达世界顶级审美):
宋体大字排印 × 发丝铜线 × 点线目录 × 朱砂印章 × 大号衬线数字——
证据级研报的典籍气质, 而非电商模板脸. 内联 CSS, 无任何 CDN/外链/
字体请求; 交互用原生 JS; 动效纯 CSS (repose 慢仪表/入场升起/印章斜置),
prefers-reduced-motion 全局降级.
"""
from __future__ import annotations

import html

CSS = """
:root{
--ink:#0D2136;--ink2:#14335A;--ink3:#1B4370;
--paper:#F7F3EA;--card:#FCFAF3;
--brass:#96763A;--brass2:#C9A876;--brass3:#E6D3A8;
--verm:#A63A22;
--text:#292418;--mut:#8A7E66;--faint:#C4B89E;
--line:rgba(13,33,54,.15);--hair:rgba(201,168,118,.35);
--serif:"Songti SC","Noto Serif CJK SC","STZhongsong","SimSun",serif;
--sans:-apple-system,BlinkMacSystemFont,"PingFang SC","HarmonyOS Sans SC",
"Microsoft YaHei",sans-serif;
--shadow:0 20px 48px -20px rgba(13,33,54,.32)}
*{margin:0;padding:0;box-sizing:border-box;-webkit-tap-highlight-color:transparent}
html{scroll-behavior:smooth}
body{font-family:var(--sans);color:var(--text);font-size:16px;line-height:1.8;
background-color:var(--paper);
background-image:radial-gradient(130% 90% at 50% -10%,#FCF9F1 0%,
rgba(252,249,241,0) 58%),
repeating-linear-gradient(0deg,rgba(13,33,54,.013) 0 1px,transparent 1px 3px)}
.serif{font-family:var(--serif)}
a{color:var(--ink)}
.wrap{max-width:680px;margin:0 auto;padding:0 22px}

/* ── 动效底座 ─────────────────────────────── */
@keyframes rise{from{opacity:0;transform:translateY(16px)}to{opacity:1;transform:none}}
@keyframes fadein{from{opacity:0;transform:translateY(-4px)}to{opacity:1;transform:none}}
@keyframes dial{to{transform:rotate(360deg)}}
@keyframes barup{from{transform:translateY(102%)}to{transform:none}}
.rv{animation:rise .55s cubic-bezier(.2,.7,.3,1) both}
@media(prefers-reduced-motion:reduce){*{animation:none!important;transition:none!important}}

/* ── 印章 (品牌记忆点, 每页至多两枚) ────────── */
.seal{width:56px;height:56px;background:var(--verm);border-radius:7px 3px 8px 4px;
transform:rotate(-5deg);display:flex;align-items:center;justify-content:center;
box-shadow:inset 0 0 0 2.5px rgba(247,243,234,.34),
inset 0 0 0 6px rgba(247,243,234,.10),0 3px 14px rgba(13,33,54,.30)}
.seal span{display:block;font-family:var(--serif);font-weight:700;font-size:19px;
line-height:1.14;letter-spacing:.02em;color:#F7F3EA}

/* ── 墨色刊头 (masthead) ───────────────────── */
.mast{position:relative;overflow:hidden;color:#F3EDE0;padding-bottom:40px;
background-color:var(--ink);
background-image:radial-gradient(120% 130% at 16% -22%,var(--ink3) 0%,
var(--ink) 60%)}
.rg{position:absolute;border-radius:50%;border:1px solid rgba(201,168,118,.42);
border-top-color:transparent;border-right-color:rgba(201,168,118,.12);
animation:dial 70s linear infinite}
.rg1{width:300px;height:300px;right:-96px;top:-116px}
.rg2{width:188px;height:188px;right:-18px;top:-34px;animation-duration:45s;
animation-direction:reverse}
.mast .top{display:flex;justify-content:space-between;align-items:baseline;
padding:22px 0 14px;border-bottom:1px solid var(--hair);
font-size:11px;letter-spacing:.34em;color:var(--brass2)}
.mast .top .r{letter-spacing:.16em;color:#8FA3B8}
.mast h1{font-family:var(--serif);font-weight:700;color:#F8F3E7;
font-size:clamp(30px,8.2vw,42px);line-height:1.42;letter-spacing:.05em;
margin:30px 0 0;padding-right:66px}
.mast .sub{margin:13px 0 0;font-size:14px;color:#B9C7D6;letter-spacing:.02em}
.mast .meta{margin-top:28px;padding-top:16px;border-top:1px solid var(--hair);
display:flex;align-items:baseline;gap:16px;flex-wrap:wrap}
.mast .price{font-family:var(--serif);font-size:36px;font-weight:700;
color:var(--brass2);line-height:1.2}
.mast .price small{font-size:17px;font-weight:400;margin-right:2px}
.mast .tag{font-size:11.5px;color:#9FB0C2;letter-spacing:.14em;
border:1px solid var(--hair);padding:4px 12px;border-radius:2px}
.mast .m-seal{position:absolute;right:24px;bottom:104px}

/* 数据条: 大号衬线数字 + 发丝分隔 (替代徽章小方块) */
.strip{display:flex;overflow-x:auto;scrollbar-width:none;
border-top:1px solid var(--hair);background:rgba(20,51,90,.38);
padding:18px 22px 8px;margin-top:34px}
.strip::-webkit-scrollbar{display:none}
.badge{flex:1 0 auto;min-width:106px;padding:2px 18px;
border-left:1px solid rgba(201,168,118,.22)}
.badge:first-child{border-left:none;padding-left:0}
.badge .v{font-family:var(--serif);font-size:29px;font-weight:700;
color:var(--brass2);line-height:1.25;white-space:nowrap}
.badge .k{font-size:10.5px;color:#8FA3B8;letter-spacing:.22em;margin-top:3px}

/* 刊头统计 (目录页) */
.stats{display:flex;margin-top:26px;border-top:1px solid var(--hair);padding-top:16px}
.stat{flex:1;padding-right:10px}
.stat+.stat{border-left:1px solid rgba(201,168,118,.22);padding-left:16px}
.stat b{display:block;font-family:var(--serif);font-size:26px;font-weight:700;
color:var(--brass2);line-height:1.3;white-space:nowrap}
.stat span{font-size:10.5px;color:#8FA3B8;letter-spacing:.18em}

/* ── 章节骨架 ──────────────────────────────── */
section{padding:30px 0 8px}
h2.sec{font-family:var(--serif);font-size:23px;font-weight:700;color:var(--ink);
letter-spacing:.1em;display:flex;align-items:center;gap:13px}
h2.sec em{font-style:normal;font-size:14px;color:var(--brass);letter-spacing:.06em}
h2.sec::after{content:"";flex:1;border-top:1px solid var(--line);
transform:translateY(-3px)}
.sec-sub{font-size:12.5px;color:var(--mut);margin:9px 0 20px;letter-spacing:.05em}
.crumbbar{font-size:12.5px;color:var(--mut);padding:16px 22px 0}
.crumbbar a{color:var(--ink);text-decoration:none;
border-bottom:1px solid var(--brass2)}

/* 简介引文 */
.lede{margin:20px 0;padding:4px 0 4px 20px;border-left:2px solid var(--brass);
font-family:var(--serif);font-size:18.5px;line-height:2;color:var(--ink);
letter-spacing:.02em}
.blurb p{margin:13px 0;font-size:15px;color:#3A3428;line-height:1.95}
.blurb strong{color:var(--ink)}

/* 目录: 书目点线 (book TOC) */
details.toc{border-bottom:1px solid var(--line)}
details.toc summary{list-style:none;display:flex;align-items:baseline;gap:12px;
padding:13px 2px;cursor:pointer}
details.toc summary::-webkit-details-marker{display:none}
.no{font-family:var(--serif);color:var(--brass);font-size:14px;flex:0 0 30px;
letter-spacing:.04em}
summary .t,.toc-flat .t{font-size:15.5px;font-weight:600;color:var(--ink);
letter-spacing:.02em;line-height:1.6}
.dots{flex:1;min-width:24px;border-bottom:1px dotted var(--faint);
transform:translateY(-4px)}
.car{color:var(--brass);font-size:11px;transition:transform .25s}
details.toc[open] .car{transform:rotate(90deg)}
.toc-body{padding:2px 2px 15px 42px;font-size:13.5px;color:var(--mut);
line-height:1.9;animation:fadein .35s ease-out both}
.toc-body div{padding:2px 0}
.toc-flat{display:flex;align-items:baseline;gap:12px;padding:12px 2px;
border-bottom:1px solid var(--line)}
.toc-flat .t{font-size:14.5px}

/* 试读卡 (墨面) */
.sample-card{position:relative;overflow:hidden;color:#F3EDE0;
padding:34px 26px;border-radius:3px;box-shadow:var(--shadow);
background-color:var(--ink);
background-image:radial-gradient(120% 130% at 14% -22%,var(--ink3) 0%,
var(--ink) 62%)}
.sample-card::after{content:"试读";position:absolute;right:6px;top:-8px;
font-family:var(--serif);font-size:94px;font-weight:700;
color:rgba(201,168,118,.10);letter-spacing:.04em}
.sample-card h3{font-family:var(--serif);font-size:21px;letter-spacing:.06em}
.sample-card p{font-size:13.5px;color:#B9C7D6;margin:10px 0 24px;line-height:1.9}

/* ── 按钮 / 表单 ──────────────────────────── */
.btn{display:inline-block;color:#FFF;border:none;border-radius:2px;cursor:pointer;
background:linear-gradient(180deg,#B8934F,#9C7A3A);
padding:14px 34px;font-size:15.5px;font-weight:600;letter-spacing:.14em;
text-decoration:none;font-family:inherit;
box-shadow:0 8px 20px -8px rgba(150,118,58,.55),
inset 0 1px 0 rgba(255,255,255,.25);
transition:transform .15s,box-shadow .15s}
.btn:active{transform:translateY(1px)}
.btn.ghost{background:transparent;border:1px solid var(--brass2);
color:var(--brass2);box-shadow:none;letter-spacing:.1em}
.finput{width:100%;padding:13px 14px;border:1px solid rgba(13,33,54,.30);
border-radius:2px;font-size:15px;background:#FFF;font-family:inherit;
color:var(--text);margin-bottom:9px}
.finput::placeholder{color:#9C8F76;opacity:1}
.finput:focus{outline:none;border-color:var(--brass)}

/* 购买区: 白卡 + 四角挂钉 QR 挂载 + 衬线步骤 */
.buy-box{background:var(--card);border:1px solid var(--line);border-radius:3px;
padding:30px 24px;box-shadow:0 12px 32px -20px rgba(13,33,54,.22)}
.buy-box h3{font-family:var(--serif);font-size:19px;color:var(--ink);
letter-spacing:.08em;padding-bottom:12px;border-bottom:1px solid var(--line);
margin-bottom:14px}
.perk{display:flex;gap:11px;padding:7px 0;font-size:14px;color:#3A3428;
line-height:1.85}
.perk .ck{color:var(--brass);font-weight:700}
.qr-row{display:flex;gap:14px;margin:24px 0 10px}
.qr{flex:1;text-align:center;background:#FFF;border:1px solid var(--line);
border-radius:2px;padding:24px 12px 14px;position:relative}
.qr::before,.qr::after{content:"";position:absolute;width:16px;height:16px;
border:2px solid var(--brass)}
.qr::before{top:7px;left:7px;border-right:none;border-bottom:none}
.qr::after{bottom:7px;right:7px;border-left:none;border-top:none}
.qr img{width:152px;height:152px;display:block;margin:0 auto}
.qr .ph{width:152px;height:152px;margin:0 auto;display:flex;align-items:center;
justify-content:center;font-size:12px;color:var(--mut);
background:repeating-linear-gradient(45deg,#F1EADD 0 8px,#FAF6EC 8px 16px)}
.qr .qt{font-size:12px;color:var(--mut);margin-top:12px;letter-spacing:.1em}
.flow{display:flex;gap:10px;margin-top:20px}
.flow .st{flex:1;padding:12px 6px 10px;font-size:11.5px;color:var(--mut);
text-align:center;line-height:1.6;border-top:2px solid var(--brass2)}
.flow .st b{display:block;font-family:var(--serif);color:var(--ink);
font-size:13.5px;margin-bottom:3px;letter-spacing:.04em}

/* 预售 */
.soon{border:1px dashed rgba(150,118,58,.55);padding:26px 22px;
background:rgba(201,168,118,.06)}
.soon h3{color:var(--ink);font-size:18px;font-family:var(--serif);
letter-spacing:.04em}
.soon .vols{display:flex;flex-wrap:wrap;gap:8px;margin:14px 0}
.soon .vol{font-size:12.5px;background:#FFF;border:1px solid var(--line);
padding:5px 14px;color:var(--ink);letter-spacing:.08em}
.soon-band{border:1px dashed rgba(150,118,58,.55);padding:16px 18px;
margin:4px 0 12px;display:flex;align-items:center;gap:12px;
justify-content:space-between;background:rgba(201,168,118,.06)}
.soon-band .st{font-size:13px;color:var(--ink);line-height:1.7}
.soon-band .st b{font-size:14.5px;font-family:var(--serif)}
.soon-band a{font-size:12px;color:var(--brass);white-space:nowrap;
text-decoration:none;border-bottom:1px solid var(--brass)}

/* 吸底栏 */
.bar{position:fixed;left:0;right:0;bottom:0;z-index:50;
background:linear-gradient(180deg,rgba(13,33,54,.97),var(--ink));
border-top:1px solid var(--hair);padding:10px 22px
calc(10px + env(safe-area-inset-bottom));display:flex;align-items:center;
gap:14px;justify-content:space-between;animation:barup .5s .25s ease-out both}
.bar .bp{color:#F3EDE0}
.bar .bp .n{font-family:var(--serif);font-size:23px;font-weight:700;
color:var(--brass2)}
.bar .bp .o{font-size:11px;color:#7E92A8;text-decoration:line-through;
margin-left:8px}
.bar .btn{padding:12px 28px;font-size:14.5px}
.pad-bottom{height:92px}

/* ── 阅读页 (书页排印) ─────────────────────── */
.reader{padding:34px 0 60px}
.reader .crumb{font-size:12px;color:var(--mut);letter-spacing:.04em;
margin-bottom:20px}
.reader h1{font-family:var(--serif);font-size:26px;color:var(--ink);
line-height:1.55;letter-spacing:.04em;margin-bottom:0}
.reader .rule{height:3px;margin:16px 0 28px;
background:linear-gradient(90deg,var(--brass) 0 56px,var(--line) 56px)}
#gate .rule{margin:14px 0 16px}
.reader h2{font-family:var(--serif);font-size:19.5px;color:var(--ink);
margin:34px 0 12px;letter-spacing:.03em}
.reader p{margin:14px 0;font-size:16.5px;line-height:2.05;color:#2E2A20}
.reader ul{margin:14px 0 14px 4px;list-style:none}
.reader li{margin:8px 0;font-size:15.5px;line-height:1.9;padding-left:20px;
position:relative}
.reader li::before{content:"";position:absolute;left:0;top:.85em;width:9px;
height:1.5px;background:var(--brass)}
.doc>p:first-of-type::first-letter{font-family:var(--serif);font-size:2.35em;
line-height:1;color:var(--ink);float:left;padding:5px 9px 0 0;font-weight:700}
.cta-end{color:#F3EDE0;text-align:center;padding:36px 22px;margin-top:42px;
border-radius:3px;box-shadow:var(--shadow);background-color:var(--ink);
background-image:radial-gradient(120% 130% at 50% -30%,var(--ink3) 0%,
var(--ink) 65%)}
.cta-end p{font-size:13px;color:#B9C7D6;margin-bottom:18px;letter-spacing:.05em}

/* admin */
.admin{padding:26px 0 60px}
.fb-policy{border-left:2px solid var(--brass);padding:6px 0 6px 18px;
font-size:13px;color:#4A4436;line-height:2}
.fb-policy b{color:var(--ink);font-family:var(--serif);letter-spacing:.06em}
.stars{display:flex;align-items:center}
.star{font-size:30px;color:var(--faint);cursor:pointer;margin-right:4px;
transition:color .15s}
.star.on{color:var(--brass)}
#doc{margin-top:10px}
table.a{width:100%;border-collapse:collapse;font-size:12.5px;background:#FFF;
border:1px solid var(--line)}
table.a th{background:var(--ink);color:#E6DCC8;padding:10px;text-align:left;
font-weight:500;letter-spacing:.08em}
table.a td{padding:9px 10px;border-bottom:1px solid var(--line)}
.funn{display:flex;flex-wrap:wrap;gap:8px;margin:16px 0}
.funn .f{background:#FFF;border:1px solid var(--line);padding:12px 16px;
font-size:12px;color:var(--mut)}
.funn .f b{display:block;font-family:var(--serif);font-size:22px;color:var(--ink)}

/* ── 目录页 (catalog) ──────────────────────── */
.feat{position:relative;color:#F3EDE0;padding:26px 22px;margin-bottom:14px;
border-radius:3px;box-shadow:var(--shadow);overflow:hidden;
background-color:var(--ink);
background-image:radial-gradient(120% 130% at 12% -22%,var(--ink3) 0%,
var(--ink) 62%)}
.feat::before{content:"";position:absolute;inset:7px;border:1px solid
rgba(201,168,118,.22);border-radius:2px;pointer-events:none}
.feat h3{font-family:var(--serif);font-size:19px;letter-spacing:.04em;
line-height:1.55;padding-right:66px;position:relative}
.feat .fm{font-size:12.5px;color:#B9C7D6;margin-top:7px;line-height:1.75;
position:relative}
.feat .fb{display:flex;flex-wrap:wrap;gap:4px 16px;margin-top:11px;
font-size:11px;color:#8FA3B8;letter-spacing:.08em;position:relative}
.feat .fb b{font-family:var(--serif);font-size:15px;color:var(--brass2);
margin-right:4px;font-weight:700}
.feat .fl{display:flex;align-items:center;justify-content:space-between;
margin-top:18px;padding-top:14px;border-top:1px solid rgba(201,168,118,.22);
position:relative}
.feat .pr{font-family:var(--serif);font-size:22px;color:var(--brass2);
font-weight:700}
.feat .fl a{font-size:12.5px;color:#E6DCC8;text-decoration:none;
letter-spacing:.12em;padding:8px 18px;border:1px solid rgba(201,168,118,.5);
border-radius:2px}
.feat .fl a.gold{background:linear-gradient(180deg,#B8934F,#9C7A3A);
border-color:transparent;font-weight:600}
.feat .m-seal{position:absolute;right:20px;top:20px;bottom:auto}
.feat .m-seal.seal{width:48px;height:48px}
.feat .m-seal.seal span{font-size:16px}
.cards{display:grid;grid-template-columns:1fr 1fr;gap:12px}
.card{background:var(--card);border:1px solid var(--line);border-radius:2px;
padding:16px 14px 12px;display:flex;flex-direction:column;
transition:transform .2s,box-shadow .2s}
.card:hover{transform:translateY(-3px);
box-shadow:0 16px 32px -18px rgba(13,33,54,.32)}
.card .idx{font-family:var(--serif);font-size:11px;color:var(--brass);
letter-spacing:.18em;margin-bottom:8px}
.card .ct{font-family:var(--serif);font-size:15px;font-weight:700;
color:var(--ink);line-height:1.6;letter-spacing:.02em;flex:1}
.card .cm{font-size:11px;color:var(--mut);margin-top:8px;letter-spacing:.03em}
.card .cp{display:flex;align-items:baseline;justify-content:space-between;
margin-top:12px;padding-top:10px;border-top:1px solid var(--line)}
.card .cp .pr{font-family:var(--serif);color:var(--brass);font-weight:700;
font-size:17px}
.card .cp .lk{font-size:11.5px;letter-spacing:.06em}
.card .cp .lk a{color:var(--ink);text-decoration:none;
border-bottom:1px solid var(--brass2)}
.cat-count{font-size:11.5px;color:var(--mut);letter-spacing:.1em;
margin-left:auto;padding-left:10px}

footer{padding:42px 0 48px;text-align:center;font-size:11.5px;color:var(--mut);
letter-spacing:.1em;margin-top:34px;border-top:1px solid var(--line)}
footer .serif{display:block;font-family:var(--serif);color:var(--ink);
font-size:20px;font-weight:700;letter-spacing:.5em;margin-bottom:12px;
text-indent:.5em}
footer .fseal{display:inline-flex;margin-bottom:14px;transform:rotate(-5deg)}

/* 在线支付 (自动解锁, F5d) */
.autopay{margin:20px 0 4px}
.btn.wide{display:block;width:100%;padding:17px 20px;font-size:17px;
letter-spacing:.22em;text-align:center;
box-shadow:0 14px 30px -12px rgba(112,86,40,.62),
inset 0 1px 0 rgba(255,255,255,.25)}
.ap-note{font-size:12px;color:var(--mut);margin-top:10px;text-align:center;
letter-spacing:.05em;text-wrap:balance}
.pp{margin-top:18px;text-align:center;background:#FFF;border:1px solid var(--line);
border-radius:3px;padding:24px 16px 20px;animation:fadein .35s ease-out both}
.pp .amt{font-family:var(--serif);font-size:26px;color:var(--ink);
font-weight:700;letter-spacing:.06em}
.pp img{width:212px;height:212px;display:block;margin:14px auto 0;
border:1px solid var(--line)}
.pp .hint{font-size:12px;color:var(--mut);margin-top:10px;letter-spacing:.04em}
.pp-wait{font-size:13px;color:var(--brass);margin-top:12px;letter-spacing:.04em}
.pp-wait::before{content:"";display:inline-block;width:9px;height:9px;
border-radius:50%;border:2px solid var(--brass2);border-top-color:transparent;
margin-right:8px;vertical-align:-1px;animation:dial 1s linear infinite}
.pp .okmark{display:none;font-family:var(--serif);font-size:21px;color:var(--ink);
letter-spacing:.12em;padding:14px 0}
.pp.ok{border-color:var(--brass2);background:rgba(201,168,118,.10)}
.pp.ok img,.pp.ok .pp-wait,.pp.ok .amt,.pp.ok .hint{display:none}
.pp.ok .okmark{display:block}
.alt-pay{margin-top:20px;border-top:1px dashed var(--faint);padding-top:15px}
.alt-pay summary{list-style:none;cursor:pointer;font-size:12.5px;
color:#5F543F;letter-spacing:.08em}
.alt-pay summary::-webkit-details-marker{display:none}
.alt-pay summary::before{content:"›";display:inline-block;font-size:16px;
color:var(--brass);margin-right:5px;transform:translateY(-1px)}

/* 桌面 ≥900px: 展开展示 */
@media(min-width:900px){
.wrap{max-width:880px}
.cards{grid-template-columns:repeat(3,1fr)}
.mast h1{font-size:46px;padding-right:90px}
.flow .st{font-size:12.5px}
}
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


PAY_JS = """
(function(){                                    /* 在线支付 (自动解锁, F5d) */
 if(!document.getElementById('payWxBtn')){return;}
 var sku=document.body.getAttribute('data-sku')||'';
 var price=window.RP_PRICE||0;
 var isWx=/MicroMessenger/i.test(navigator.userAgent);
 var busy=false,timer=null,ticks=0;
 function t(e,x){try{fetch('/api/track',{method:'POST',
  headers:{'Content-Type':'application/json'},
  body:JSON.stringify({event:e,sku:sku,extra:(x||'').slice(0,120)})});}catch(_){}}
 function msg(m,bad){var el=document.getElementById('payMsg');
  if(el){el.textContent=m||'';el.style.color=bad?'#A63A22':'#8A7E66';}}
 function ensureReady(cb){if(window.RP_READY){cb(window.RP_READY);return;}
  fetch('/api/pay/ready').then(function(r){return r.json();})
  .then(function(rd){window.RP_READY=rd||{};cb(window.RP_READY);})
  .catch(function(){window.RP_READY={};cb(window.RP_READY);});}
 function poll(no,ck){if(timer){clearInterval(timer);}
  timer=setInterval(function(){ticks++;
   if(ticks>360){clearInterval(timer);msg('等待超时 — 付款后可在「读者通道」用订单号解锁',1);return;}
   fetch('/api/pay/status?order_no='+encodeURIComponent(no)+'&ck='+encodeURIComponent(ck))
   .then(function(r){return r.json();})
   .then(function(j){if(j&&j.ok&&j.state==='paid'){clearInterval(timer);paid(j);}})
   .catch(function(){});},2500);}
 function paid(j){var p=document.getElementById('payPanel');
  if(p){p.hidden=false;p.classList.add('ok');}
  msg('');
  t('pay_success');
  setTimeout(function(){location.href=j.reader_url||'/reader.html';},1000);}
 function showPanel(){var p=document.getElementById('payPanel');
  if(p){p.hidden=false;}
  var h=document.querySelector('.pp .hint');
  if(h){h.textContent=isWx?'长按识别二维码完成支付':'微信扫一扫完成支付';}
  t('show_qr');}
 function startNative(){if(busy){return;}busy=true;msg('正在生成支付订单…');
  fetch('/api/pay/create',{method:'POST',headers:{'Content-Type':'application/json'},
   body:JSON.stringify({sku:sku,channel:'wxpay'})})
  .then(function(r){return r.json();})
  .then(function(j){busy=false;
   if(!j||!j.ok){fallback(j&&j.error);return;}
   t('order_created');
   var im=document.getElementById('payQr');if(im){im.src=j.qr_url;}
   showPanel();msg('订单 '+j.order_no.slice(-8)+' · 支付后自动解锁');
   poll(j.order_no,j.ck);})
  .catch(function(){busy=false;fallback('网络异常');});}
 function startJsapi(pt){msg('正在拉起微信支付…');
  fetch('/api/pay/jsapi',{method:'POST',headers:{'Content-Type':'application/json'},
   body:JSON.stringify({sku:sku,pt:pt})})
  .then(function(r){return r.json();})
  .then(function(j){
   if(!j||!j.ok){fallback(j&&j.error);return;}
   t('order_created');poll(j.order_no,j.ck);
   function invoke(){WeixinJSBridge.invoke('getBrandWCPayRequest',j.payParams,
    function(res){
     if(res&&res.err_msg==='get_brand_wcpay_request:ok'){msg('支付成功 · 正在解锁…');}
     else if(res&&res.err_msg==='get_brand_wcpay_request:cancel'){msg('已取消 — 可重新点击支付');}
     else{msg('未完成 — 可重试或长按二维码支付',1);startNative();}});}
   if(typeof WeixinJSBridge==='undefined'){
    document.addEventListener('WeixinJSBridgeReady',invoke,false);}
   else{invoke();}})
  .catch(function(){fallback('网络异常');});}
 function fallback(err){msg((err?err+' — ':'')+'在线支付暂不可用, 已展开转账登记备用通道',1);
  var d=document.getElementById('altPay');if(d){d.open=true;}}
 document.getElementById('payWxBtn').addEventListener('click',function(){
  ensureReady(function(rd){
   if(rd.wxpay&&rd.jsapi&&isWx){
    location.href='/api/pay/wxlogin?sku='+encodeURIComponent(sku);return;}
   if(rd.wxpay){startNative();return;}
   fallback('在线支付未开通');});});
 var bb=document.getElementById('buyBtn');
 if(bb){bb.addEventListener('click',function(){
  ensureReady(function(rd){if(rd.wxpay){
   setTimeout(function(){var b=document.getElementById('payWxBtn');
    if(b&&!busy){b.click();}},350);}});});}
 var qs=new URLSearchParams(location.search),pt=qs.get('pt');
 if(pt){history.replaceState({},'',location.pathname);
  ensureReady(function(rd){if(rd.jsapi){startJsapi(pt);}});}
})();
"""


SITE_BASE = "https://report.yrecepc.cn"  # F5d https 正式口 (LE 证书 2027-01-06 到期, 80 自动 301)
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
