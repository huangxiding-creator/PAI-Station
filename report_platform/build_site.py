# -*- coding: utf-8 -*-
"""build_site — 研究报告发布平台站点生成器 (旗舰 F5a).

吃 content/report.json (商品配置·徽章·目录·试读文件) → 生成 site/:
  index.html  详情页 (hero/信任徽章/简介/目录手风琴/试读卡/购买区/预售卡)
  sample.html 试读页 (阅读排版+尾部转化钩子)
  admin.html  数据台 (漏斗+订单表, token 保护)
零外部依赖 (无 CDN/字体/框架), 移动优先, 微信内打开即用; QR 码位:
content/qr_wechat.png / qr_alipay.png 存在即展示, 缺席显示占位 (码后补零改动).

用法: python build_site.py [--content content] [--out site]
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
from template import page  # noqa: E402


def md_to_html(md: str) -> str:
    """mini markdown → HTML (标题/列表/段落/加粗) — 零依赖阅读页."""
    out: list[str] = []
    in_list = False

    def inline(s: str) -> str:
        s = re.sub(r"\*\*(.+?)\*\*", r"<strong>\1</strong>", s)
        return s

    for raw in md.split("\n"):
        line = raw.rstrip()
        if not line.strip():
            if in_list:
                out.append("</ul>")
                in_list = False
            continue
        m = re.match(r"^(#{1,2})\s+(.*)", line)
        if m:
            if in_list:
                out.append("</ul>")
                in_list = False
            tag = "h1" if m.group(1) == "#" else "h2"
            out.append(f"<{tag}>{inline(m.group(2))}</{tag}>")
        elif line.lstrip().startswith("- "):
            if not in_list:
                out.append("<ul>")
                in_list = True
            out.append(f"<li>{inline(line.lstrip()[2:])}</li>")
        else:
            if in_list:
                out.append("</ul>")
                in_list = False
            out.append(f"<p>{inline(line)}</p>")
    if in_list:
        out.append("</ul>")
    return "\n".join(out)


def _qr_slot(img_dir: Path, name: str, label: str) -> str:
    img = img_dir / f"qr_{name}.png"
    if img.is_file():
        inner = f'<img src="assets/qr_{name}.png" alt="{label}收款码">'
    else:
        inner = ('<div class="ph">收款码待接入<br>(码图就位后自动展示)</div>')
    return f'<div class="qr">{inner}<div class="qt">{label}</div></div>'


def _nav(cfg: dict, current_sku: str) -> str:
    """详情/试读页 → 目录页回链 + 系列标签."""
    cur = next((x for x in cfg["reports"] if x["sku"] == current_sku), {})
    cat = cur.get("cat_name", "")
    return ('<div class="wrap" style="padding:10px 20px 0;font-size:13px;'
            'color:var(--mut)"><a href="index.html">← 总包智库 · 全部报告</a>'
            + (f" · {cat}" if cat else "") + "</div>")


def build_catalog(cfg: dict, content: Path) -> str:
    """目录首页: 旗舰推荐 + 系列分组卡片墙."""
    reps = [r for r in cfg["reports"] if not r.get("coming_soon")]
    soon = next((x for x in cfg["reports"] if x.get("coming_soon")), None)
    feat = [r for r in reps if r.get("cat") == "flagship"]
    groups: list[tuple[str, list]] = []
    for cat in ("ent", "prov", "topic", "excl"):
        g = [r for r in reps if r.get("cat") == cat]
        if g:
            groups.append((g[0].get("cat_name", cat), g))
    rest = [r for r in reps if not r.get("cat")]
    if rest:
        groups.append(("更多研究报告", rest))
    total_w = sum(r.get("words_wan", 0) for r in reps)

    def _card(r: dict) -> str:
        chips = f"{len(r['chapters'])} 章 · {r['words_wan']} 万字"
        if len(r.get("badges", [])) > 2:
            chips += f" · {r['badges'][2]['v']}"
        slug = r["sku"].lower()
        return (f'<div class="card"><div class="ct">'
                f'{r["title"].strip("《》")}</div><div class="cm">{chips}</div>'
                f'<div class="cp"><span class="pr">¥{r["price"]:,}</span>'
                f'<span class="lk"><a href="{slug}.html">详情</a> · '
                f'<a href="sample_{slug}.html" data-ev="read_sample">试读</a>'
                "</span></div></div>")

    def _feat(r: dict) -> str:
        chips = "".join(f"<b>{b['v']}</b>{b['k']}　" for b in r["badges"][:4])
        slug = r["sku"].lower()
        return (f'<div class="feat"><h3>{r["title"]}</h3>'
                f'<div class="fm">{r["subtitle"]}</div>'
                f'<div class="fb">{chips}</div>'
                f'<div class="fl"><span class="pr">¥{r["price"]:,}</span>'
                f'<span><a class="gold" href="sample_{slug}.html"'
                f' data-ev="read_sample">免费试读</a>&nbsp;&nbsp;'
                f'<a href="{slug}.html">详情</a></span></div></div>')

    feat_html = "".join(_feat(r) for r in feat)
    soon_html = (
        f'<div class="soon-band"><div class="st"><b>{soon["title"]}</b>'
        f'<br>{soon.get("subtitle", "")} · 意向登记已开放</div>'
        f'<a href="{reps[0]["sku"].lower()}.html#soon">登记意向 →</a></div>'
    ) if soon else ""
    secs = "".join(
        f'<section><h2 class="sec"><em>{cn}</em>{name}'
        f'<span class="cat-count">{len(g)} 份</span></h2>'
        f'<div class="cards">{"".join(_card(r) for r in g)}</div></section>'
        for cn, (name, g) in zip("贰叁肆伍", groups))
    body = f"""
<div class="cat-hero"><div class="wrap">
  <div class="brand">总包智库 · TONGBAO RESEARCH</div>
  <h1>工程总承包研究报告 · 直接买</h1>
  <div class="sub">企业拆解 / 省份市场 / 专题实战 · 全部免费试读 · 不满意按档退款</div>
  <div class="stats">
    <div class="stat"><b>{len(reps)}</b><span>在售研究报告</span></div>
    <div class="stat"><b>{total_w:.0f} 万字+</b><span>成稿总量</span></div>
    <div class="stat"><b>免费</b><span>每份可试读</span></div>
  </div>
</div></div>
<div class="wrap">
<section><h2 class="sec"><em>壹</em>旗舰深度</h2>
<div class="sec-sub">证据级研究 · 每个关键结论标注来源</div>
{feat_html}{soon_html}</section>
{secs}
<section><h2 class="sec"><em>◈</em>购买须知</h2>
<div class="sec-sub">所有报告同一套交付与售后标准</div>
<div class="fb-policy"><b>交付</b>：支付核对后解锁在线阅读 + 完整版 PDF 下载。<br>
<b>退款</b>：严重质量问题全额退；局部缺陷退 40%；轻微问题退 20%；
改进建议不退款、被采纳返券。部分退款不影响阅读权。<br>
<b>试读</b>：每份报告都有免费试读部分——先看再买，看完再付。</div>
</section>
<footer><div class="serif">总包智库</div>研究报告发布平台<br>
© 2026 · {time.strftime('%Y-%m-%d')} 构建</footer>
<div class="pad-bottom"></div></div>"""
    desc = (f"{len(reps)} 份在售研究报告 · 成稿 {total_w:.0f} 万字 · "
            "全部免费试读 · 不满意按档退款")
    return page("总包智库 — 工程总承包研究报告平台", body,
                desc=desc, path="index.html")


def build_report(r: dict, cfg: dict, content: Path) -> str:
    soon = next((x for x in cfg["reports"] if x.get("coming_soon")), None)
    badges = "".join(
        f'<div class="badge"><div class="v">{b["v"]}</div>'
        f'<div class="k">{b["k"]}</div></div>' for b in r["badges"])
    rows = []
    for i, c in enumerate(r["chapters"]):
        if c.get("desc"):
            rows.append(
                f'<details class="toc" open="{i == 0}"><summary>'
                f'<span class="no">{"%02d" % (i + 1)}</span>'
                f'<span class="t">{c["title"]}</span>'
                f'<span class="car">▶</span></summary>'
                f'<div class="toc-body"><div>{c["desc"]}</div></div>'
                "</details>")
        else:
            rows.append(f'<div class="toc-flat"><span class="no">'
                        f'{"%02d" % (i + 1)}</span>'
                        f'<span class="t">{c["title"]}</span></div>')
    toc = "".join(rows)
    vols = "".join(f'<span class="vol">{v}</span>' for v in soon["volumes"]) \
        if soon else ""
    soon_html = (
        f'<section id="soon"><h2 class="sec"><em>肆</em>重磅预售</h2>'
        f'<div class="sec-sub">旗舰五卷本 · 编制中 · 意向登记已开放</div>'
        f'<div class="soon"><h3 class="serif">{soon["title"]}</h3>'
        f'<p style="font-size:13.5px;color:var(--mut);margin-top:6px">'
        f'{soon["subtitle"]}</p><div class="vols">{vols}</div>'
        f'<a class="btn ghost" href="#buy" style="margin-top:8px">登记购买意向</a>'
        f'</div></section>') if soon else ""
    body = f"""
<div class="hero"><div class="wrap">
  <div class="brand">总包智库 · TONGBAO RESEARCH</div>
  <h1 class="serif">{r['title']}</h1>
  <div class="sub">{r['subtitle']}</div>
  <div class="pricebar"><span class="price"><small>¥</small>{r['price']:,}</span>
    <span class="tag">{r['price_label']}</span></div>
</div></div>
{_nav(cfg, r['sku'])}
<div class="badges">{badges}</div>
<div class="wrap">
<section id="intro"><h2 class="sec"><em>壹</em>这是一份什么样的报告</h2>
<div class="sec-sub">{r.get('method_note', '研究型成稿 · 结构化拆解 · 先试读再购买')}</div>
<div class="lede">{r.get('intro_lede', '')}</div>
<p style="font-size:14.5px">{r.get('intro', '')}</p></section>

<section id="toc"><h2 class="sec"><em>贰</em>目录大纲</h2>
<div class="sec-sub">全 {len(r['chapters'])} 章{'' if toc.startswith('<div') else ' · 点击展开每章定位'}</div>
{toc}</section>

<section id="sample"><h2 class="sec"><em>叁</em>免费试读</h2>
<div class="sample-card"><h3>{r['sample_label']}</h3>
<p>目录全览 + 第 1 章开篇片段。看完你会知道两件事：
里面确实有干货，以及干货确实锁着。</p>
<a class="btn" href="sample_{r['sku'].lower()}.html" data-ev="read_sample">开始试读 →</a></div>
</section>
{soon_html}
<section id="buy"><h2 class="sec"><em>伍</em>购买与交付</h2>
<div class="buy-box"><h3>{r['price_label']} · 即买即得</h3>
<div class="perk"><span class="ck">✓</span><span>完整版 {r['words_wan']} 万字 ·
{len(r['chapters'])} 章——解锁在线阅读 + PDF 下载</span></div>
{f'<div class="perk"><span class="ck">✓</span><span>附录：全部关键结论的来源清单（每个数字都能对回出处）</span></div>' if r.get('src_appendix') else ''}
<div class="perk"><span class="ck">✓</span><span>勘误与更新通道（同版次免费更新）</span></div>
<div class="perk"><span class="ck">✓</span><span>买了不满意：按问题分档退款——严重质量问题全额退，
局部缺陷退 40%，轻微问题退 20%；部分退款不影响阅读。</span></div>
<div class="perk"><span class="ck">✓</span><span>适合：{r.get('audience', '工程企业战略/市场负责人、总承包公司经营层、行业投资机构')}</span></div>
<div class="qr-row">{_qr_slot(content, 'wechat', '微信收款（企业微信）')}</div>
<p style="font-size:13px;color:var(--mut)" id="orderNo"></p>
<div class="flow">
<div class="st"><b>① 扫码支付</b>金额 {r['price']:,} 元<br>备注订单号</div>
<div class="st"><b>② 登记凭证</b>下方提交联系方式<br>与订单号</div>
<div class="st"><b>③ 核对解锁</b>核对到账后解锁<br>在线阅读 + PDF</div></div>
<form id="orderForm" style="margin-top:16px">
<input name="contact" required placeholder="您的微信/邮箱（交付用）"
 style="width:100%;padding:12px;border:1px solid var(--line);border-radius:10px;font-size:15px;margin-bottom:8px">
<input name="note" placeholder="订单号/转账尾号（选填，加速核对）"
 style="width:100%;padding:12px;border:1px solid var(--line);border-radius:10px;font-size:15px">
<button class="btn" style="width:100%;margin-top:10px" data-ev="submit_order">提交支付凭证</button>
<p id="orderMsg" style="font-size:13px;margin-top:8px"></p></form>
</div></section>
<footer><div class="serif">总包智库</div>研究报告发布平台 · 每句话可溯源<br>
© 2026 · {time.strftime('%Y-%m-%d')} 构建</footer>
<div class="pad-bottom"></div>
<div class="bar"><div class="bp"><span class="n">¥{r['price']:,}</span>
<span class="o">行业同深度咨询 5 万+</span></div>
<button class="btn" id="buyBtn">立即购买</button></div>
</div>"""
    desc = (f"{r['subtitle']} · 完整版 {r['words_wan']} 万字 · "
            f"免费试读 · ¥{r['price']:,}")
    return page(f"{r['title']} — 总包智库", body, r["sku"],
                desc=desc, path=f"{r['sku'].lower()}.html")


def build_sample(r: dict, cfg: dict, content: Path) -> str:
    md = (content / "sample" / r["sample_file"]).read_text(encoding="utf-8")
    back = f"{r['sku'].lower()}.html"
    body = f"""
<div class="wrap reader">
<div class="crumb"><a href="{back}">← 返回详情</a> · <a href="index.html">全部报告</a>
 · {r['sample_label']} · 免费</div>
<h1>{r['title']}</h1>
{md_to_html(md)}
<div class="cta-end"><p>试读到此结束。完整版 {r['words_wan']} 万字 ·
{len(r['chapters'])} 章 · 不满意按档退款</p>
<a class="btn" href="{back}#buy" data-ev="cta_buy">解锁完整版 ¥{r['price']:,} →</a></div>
</div><div class="pad-bottom"></div>"""
    desc = (f"免费试读 · {r['subtitle']} · 完整版 {r['words_wan']} 万字"
            f" · 不满意按档退款")
    return page(f"试读 · {r['title']}", body, r["sku"],
                desc=desc, path=f"sample_{r['sku'].lower()}.html")


def build_admin(cfg: dict) -> str:
    body = """
<div class="wrap admin">
<h2 class="sec"><em>◈</em>数据台</h2>
<div class="sec-sub">转化漏斗与订单 · 数据只进自有库</div>
<div class="funn" id="funn"></div>
<table class="a" id="orders"><thead><tr><th>时间</th><th>SKU</th>
<th>订单号</th><th>联系</th><th>备注</th><th>状态</th></tr></thead>
<tbody></tbody></table></div>
<script>
(function(){var q=new URLSearchParams(location.search);var tk=q.get('token')||'';
fetch('/api/stats?token='+encodeURIComponent(tk)).then(function(r){return r.json();})
.then(function(d){if(!d.ok){document.body.innerHTML='<div class="wrap admin">'+
 '<h2 class="sec">token 无效</h2></div>';return;}
 var f=document.getElementById('funn');
 Object.keys(d.funnel).forEach(function(k){f.innerHTML+='<div class="f"><b>'+d.funnel[k]+
 '</b>'+k.replace(/_/g,' ')+'</div>';});
 var tb=document.querySelector('#orders tbody');
 (d.orders||[]).slice(0,50).forEach(function(o){tb.innerHTML+='<tr><td>'+o.created+
 '</td><td>'+o.sku+'</td><td>'+o.order_no+'</td><td>'+o.contact+'</td><td>'+o.note+
 '</td><td>'+o.state+'</td></tr>';});});})();
</script>"""
    return page("数据台 — 总包智库", body, noindex=True)   # 不带 path: noindex 页不发 canonical


READER_JS = """
(function(){
 var Q=new URLSearchParams(location.search);
 var o=Q.get('o')||'',s=Q.get('s')||'';
 var gate=document.getElementById('gate'),full=document.getElementById('full');
 function t(e,x){try{fetch('/api/track',{method:'POST',
  headers:{'Content-Type':'application/json'},
  body:JSON.stringify({event:e,sku:window.SKU||'',extra:x||''})});}catch(_){}}
 function loadFull(no,sig){
  fetch('/api/reader/content?o='+encodeURIComponent(no)+'&s='+encodeURIComponent(sig))
  .then(function(r){if(!r.ok){throw 0;}return r.text();})
  .then(function(html){
   gate.style.display='none';full.style.display='block';
   document.getElementById('doc').innerHTML=html;
   var pd=document.getElementById('pdfBtn');
   if(pd){pd.href='/api/full.pdf?o='+encodeURIComponent(no)+'&s='+encodeURIComponent(sig);}
   var sel=document.getElementById('fbChapter'),seen={};
   var hs=document.querySelectorAll('#doc h2');
   hs.forEach(function(h,i){
    var opt=document.createElement('option');opt.textContent=h.textContent;
    sel.appendChild(opt);
    (function(ch){var ob=new IntersectionObserver(function(en){
     if(en[0].isIntersecting&&!seen[ch]){seen[ch]=1;t('read_chapter',ch);}
    },{rootMargin:'0px 0px -60% 0px'});ob.observe(h);})(h.textContent);
   });
   t('reader_open');
  })
  .catch(function(){document.getElementById('gateMsg').textContent=
   '解锁失败：订单未支付或签名失效';});
 }
 if(o&&s){loadFull(o,s);}
 else{
  var f=document.getElementById('lookupForm');
  f.addEventListener('submit',function(ev){ev.preventDefault();
   var no=document.getElementById('luNo').value.trim(),
       tl=document.getElementById('luTail').value.trim();
   fetch('/api/order/query?order_no='+encodeURIComponent(no)+'&tail='+encodeURIComponent(tl))
   .then(function(r){return r.json();})
   .then(function(j){
    var m=document.getElementById('gateMsg');
    if(!j.ok){m.textContent=j.error||'查询失败';return;}
    if(j.reader_url){location.href=j.reader_url;return;}
    m.textContent='订单状态：'+j.state+'（支付核对中，稍后再查）';
   }).catch(function(){document.getElementById('gateMsg').textContent='网络异常';});
  });
 }
 var ff=document.getElementById('fbForm');
 ff.addEventListener('submit',function(ev){ev.preventDefault();
  var st=[0,0,0,0,0].map(function(_,i){return document.getElementById('st'+(i+1));});
  var rating=st.filter(function(el){return el.classList.contains('on');}).length;
  fetch('/api/feedback',{method:'POST',headers:{'Content-Type':'application/json'},
   body:JSON.stringify({order_no:o||document.getElementById('luNo').value.trim(),
    rating:rating,chapter:document.getElementById('fbChapter').value,
    category:document.getElementById('fbCat').value,
    content:document.getElementById('fbText').value})})
  .then(function(r){return r.json();})
  .then(function(j){var m=document.getElementById('fbMsg');
   if(!j.ok){m.textContent=j.error||'提交失败';m.style.color='#B3261E';return;}
   m.style.color='#2E7D32';
   if(j.refund){m.textContent='✓ 反馈已受理（'+j.grade.severity+'档）。已按 '
    +j.refund.pct+'% 比例退款 ¥'+(j.refund.fen/100).toFixed(2)+
    '，原路退回，阅读权保留。感谢帮我们变好。';}
   else if(j.grade&&j.grade.pct>0){m.textContent='✓ 反馈已受理（'+j.grade.severity+
    '档）。'+(j.note||'');}
   else{m.textContent='✓ 感谢反馈！已进入改进清单，被采纳将获返券。';}
   t('feedback_sent');})
  .catch(function(){document.getElementById('fbMsg').textContent='网络异常';});
 });
 var stars=[0,0,0,0,0].map(function(_,i){return document.getElementById('st'+(i+1));});
 stars.forEach(function(el,i){el.addEventListener('click',function(){
  stars.forEach(function(e2,j){e2.classList.toggle('on',j<=i);});});});
})();
"""


def build_reader(cfg: dict) -> str:
    body = f"""
<div class="wrap reader">
<div class="crumb"><a href="index.html">← 返回详情</a> · 读者通道</div>
<div id="gate">
<h1>读者解锁</h1>
<p style="font-size:14px;color:var(--mut)">支付成功后凭订单号+支付尾号解锁全文；
或直接打开支付成功页返回的专属链接。</p>
<form id="lookupForm" style="margin-top:14px">
<input id="luNo" required placeholder="订单号" style="width:100%;padding:12px;
 border:1px solid var(--line);border-radius:10px;font-size:15px;margin-bottom:8px">
<input id="luTail" required placeholder="支付尾号（后4位）" style="width:100%;padding:12px;
 border:1px solid var(--line);border-radius:10px;font-size:15px">
<button class="btn" style="width:100%;margin-top:10px">解锁阅读</button>
<p id="gateMsg" style="font-size:13px;margin-top:8px"></p></form>
</div>
<div id="full" style="display:none">
<h1>完整版 · 已解锁</h1>
<a id="pdfBtn" class="btn" style="margin:6px 0 18px">下载完整 PDF</a>
<div id="doc"></div>
<section id="feedback"><h2 class="sec"><em>◈</em>质量反馈</h2>
<div class="sec-sub">真实的问题，按档退款致谢 · 反馈将核对阅读记录后处理</div>
<div class="fb-policy"><b>退款政策（按问题精细分档）</b>：
严重质量问题（内容缺失/严重不符）→全额退 100%；
局部缺陷（数据错误/过时）→退 40%；轻微问题→退 20%；
改进建议→不退款，被采纳返券。部分退款不影响阅读权。</div>
<form id="fbForm" style="margin-top:14px">
<div class="stars" id="starRow">
<span class="star" id="st1">★</span><span class="star" id="st2">★</span>
<span class="star" id="st3">★</span><span class="star" id="st4">★</span>
<span class="star" id="st5">★</span>
<span style="font-size:12px;color:var(--mut);margin-left:8px">综合评分</span></div>
<select id="fbChapter" required style="width:100%;padding:12px;border:1px solid
 var(--line);border-radius:10px;font-size:15px;margin:10px 0">
<option value="">问题所在章节（必选·真实定位）</option></select>
<select id="fbCat" style="width:100%;padding:12px;border:1px solid var(--line);
 border-radius:10px;font-size:15px;margin-bottom:10px">
<option value="quality">质量问题（可按档退款）</option>
<option value="suggest">改进建议（采纳有奖）</option></select>
<textarea id="fbText" required rows="4" placeholder="具体问题描述：哪个数字/结论/章节位置有什么问题…" style="width:100%;padding:12px;border:1px solid var(--line);border-radius:10px;font-size:15px"></textarea>
<button class="btn" style="width:100%;margin-top:10px">提交反馈</button>
<p id="fbMsg" style="font-size:13px;margin-top:8px"></p></form>
</section>
</div></div><div class="pad-bottom"></div>"""
    r = cfg["reports"][0]
    return page("读者通道 — 总包智库", body, r["sku"],
                extra_js=READER_JS,
                desc="已购读者凭订单号解锁完整版阅读与 PDF 下载 · 总包智库",
                path="reader.html")





def build(content: Path, out: Path) -> dict:
    cfg = json.loads((content / "report.json").read_text(encoding="utf-8"))
    out.mkdir(parents=True, exist_ok=True)
    (out / "assets").mkdir(exist_ok=True)
    (out / "index.html").write_text(build_catalog(cfg, content),
                                    encoding="utf-8")
    for r in cfg["reports"]:
        if r.get("coming_soon"):
            continue
        slug = r["sku"].lower()
        (out / f"{slug}.html").write_text(build_report(r, cfg, content),
                                          encoding="utf-8")
        (out / f"sample_{slug}.html").write_text(build_sample(r, cfg, content),
                                                 encoding="utf-8")
    (out / "admin.html").write_text(build_admin(cfg), encoding="utf-8")
    (out / "reader.html").write_text(build_reader(cfg), encoding="utf-8")
    for name in ("wechat", "alipay"):
        src = content / f"qr_{name}.png"
        if src.is_file():
            (out / "assets" / f"qr_{name}.png").write_bytes(src.read_bytes())
    og = content / "og_card.png"
    if og.is_file():
        (out / "assets" / "og_card.png").write_bytes(og.read_bytes())
    # 下架 SKU 的残留页清场 (评审 MEDIUM: 覆盖式解压永不删旧页, 下架品会带购买钮永挂线上)
    expected = {"index.html", "admin.html", "reader.html"}
    for r in cfg["reports"]:
        if r.get("coming_soon"):
            continue
        expected |= {f"{r['sku'].lower()}.html",
                     f"sample_{r['sku'].lower()}.html"}
    for f in out.glob("*.html"):
        if f.name not in expected:
            f.unlink()
    pages = sorted(p.name for p in out.glob("*.html"))
    return {"pages": pages, "reports": len(cfg["reports"]),
            "qr": [n for n in ("wechat", "alipay")
                   if (out / "assets" / f"qr_{n}.png").is_file()],
            "og_card": (out / "assets" / "og_card.png").is_file(),
            "built": time.strftime("%Y-%m-%d %H:%M")}


def _main(argv: list[str]) -> int:
    ap = argparse.ArgumentParser(description="发布平台站点生成器 (F5a)")
    root = Path(__file__).resolve().parent
    ap.add_argument("--content", default=str(root / "content"))
    ap.add_argument("--out", default=str(root / "site"))
    ns = ap.parse_args(argv)
    r = build(Path(ns.content), Path(ns.out))
    if not r["og_card"]:
        print("[site] ! content/og_card.png 缺席 — 全站 og:image 将 404;"
              " 先跑 tools/gen_og_card.py 再构建 (硬门, 评审 MEDIUM)")
        return 1
    print(f"[site] pages={r['pages']} reports={r['reports']} qr={r['qr']}")
    return 0


if __name__ == "__main__":
    sys.exit(_main(sys.argv[1:]))
