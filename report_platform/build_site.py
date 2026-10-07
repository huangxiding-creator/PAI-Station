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


def build_index(cfg: dict, content: Path) -> str:
    r = cfg["reports"][0]
    soon = next((x for x in cfg["reports"] if x.get("coming_soon")), None)
    badges = "".join(
        f'<div class="badge"><div class="v">{b["v"]}</div>'
        f'<div class="k">{b["k"]}</div></div>' for b in r["badges"])
    toc = "".join(
        f'<details class="toc" open="{i == 0}"><summary>'
        f'<span class="no">{"%02d" % (i + 1)}</span>'
        f'<span class="t">{c["title"]}</span><span class="car">▶</span></summary>'
        f'<div class="toc-body"><div>{c.get("desc", "")}</div></div></details>'
        for i, c in enumerate(r["chapters"]))
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
<div class="badges">{badges}</div>
<div class="wrap">
<section id="intro"><h2 class="sec"><em>壹</em>这是一份什么样的报告</h2>
<div class="sec-sub">每句话的证据可审计 · 单源结论强制标注 · 数字 100% 表锚</div>
<div class="lede">大多数研报告诉你结论；这份报告同时告诉你——每个结论踩在几条证据上、
证据是一手还是转载、独立到什么程度、我们自己有多大把握。</div>
<p style="font-size:14.5px">研究对象是中国石化集团南京工程有限公司（国内炼化工程
EPC 第一梯队）。全文 {r['words_wan']} 万字级、{len(r['chapters'])} 章体系化拆解：
股权治理与重组基因、业务版图与战略错位、设计主导型五大体系、概算控造价实务、
合同履约与分拆模式风险……每章末附可操作清单与执行路线。</p></section>

<section id="toc"><h2 class="sec"><em>贰</em>目录大纲</h2>
<div class="sec-sub">全 {len(r['chapters'])} 章 · 点击展开每章定位</div>
{toc}</section>

<section id="sample"><h2 class="sec"><em>叁</em>免费试读</h2>
<div class="sample-card"><h3>{r['sample_label']}</h3>
<p>执行摘要 + 第 1 章《股权治理与重组基因》前半全文开放，
读完再决定是否购买完整版。</p>
<a class="btn" href="sample.html" data-ev="read_sample">开始试读 →</a></div>
</section>
{soon_html}
<section id="buy"><h2 class="sec"><em>伍</em>购买与交付</h2>
<div class="buy-box"><h3>{r['price_label']} · 即买即得</h3>
<div class="perk"><span class="ck">✓</span><span>完整版 PDF（{r['words_wan']} 万字 ·
{len(r['chapters'])} 章）+ 断言账本附录（可信度透明）</span></div>
<div class="perk"><span class="ck">✓</span><span>勘误与更新通道（同版次免费更新）</span></div>
<div class="perk"><span class="ck">✓</span><span>适合：工程企业战略/市场负责人、
总承包公司经营层、行业投资机构</span></div>
<div class="qr-row">{_qr_slot(content, 'wechat', '微信收款')}{_qr_slot(content, 'alipay', '支付宝收款')}</div>
<p style="font-size:13px;color:var(--mut)" id="orderNo"></p>
<div class="flow">
<div class="st"><b>① 扫码支付</b>金额 {r['price']:,} 元<br>备注订单号</div>
<div class="st"><b>② 登记凭证</b>下方提交联系方式<br>与订单号</div>
<div class="st"><b>③ 核对交付</b>人工核销后发送<br>完整版 PDF</div></div>
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
    return page(f"{r['title']} — 总包智库", body, r["sku"])


def build_sample(cfg: dict, content: Path) -> str:
    r = cfg["reports"][0]
    md = (content / "sample" / r["sample_file"]).read_text(encoding="utf-8")
    body = f"""
<div class="wrap reader">
<div class="crumb"><a href="index.html">← 返回详情</a> · {r['sample_label']} · 免费</div>
<h1>{r['title']}</h1>
{md_to_html(md)}
<div class="cta-end"><p>试读到此结束。完整版 {r['words_wan']} 万字 ·
{len(r['chapters'])} 章 · 断言账本附录</p>
<a class="btn" href="index.html#buy" data-ev="cta_buy">解锁完整版 ¥{r['price']:,} →</a></div>
</div><div class="pad-bottom"></div>"""
    return page(f"试读 · {r['title']}", body, r["sku"])


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
    return page("数据台 — 总包智库", body)


def build(content: Path, out: Path) -> dict:
    cfg = json.loads((content / "report.json").read_text(encoding="utf-8"))
    out.mkdir(parents=True, exist_ok=True)
    (out / "assets").mkdir(exist_ok=True)
    (out / "index.html").write_text(build_index(cfg, content), encoding="utf-8")
    (out / "sample.html").write_text(build_sample(cfg, content), encoding="utf-8")
    (out / "admin.html").write_text(build_admin(cfg), encoding="utf-8")
    for name in ("wechat", "alipay"):
        src = content / f"qr_{name}.png"
        if src.is_file():
            (out / "assets" / f"qr_{name}.png").write_bytes(src.read_bytes())
    pages = [p.name for p in out.glob("*.html")]
    return {"pages": pages, "reports": len(cfg["reports"]),
            "qr": [n for n in ("wechat", "alipay")
                   if (out / "assets" / f"qr_{n}.png").is_file()],
            "built": time.strftime("%Y-%m-%d %H:%M")}


def _main(argv: list[str]) -> int:
    ap = argparse.ArgumentParser(description="发布平台站点生成器 (F5a)")
    root = Path(__file__).resolve().parent
    ap.add_argument("--content", default=str(root / "content"))
    ap.add_argument("--out", default=str(root / "site"))
    ns = ap.parse_args(argv)
    r = build(Path(ns.content), Path(ns.out))
    print(f"[site] pages={r['pages']} reports={r['reports']} qr={r['qr']}")
    return 0


if __name__ == "__main__":
    sys.exit(_main(sys.argv[1:]))
