"""零服务器方案书城（M7.4 / PROPOSAL_M7 §5.1，微信读书网页版形态）。

书城结构（对标 weread.qq.com）：
左侧固定导航（书城/书架/笔记）· 封面卡网格 + 思想密度榜 ·
详情页左封面右信息（推荐值 % + 神作/好评如潮标签 + 折叠目录）·
阅读器式试读排版（字号 A-/A+ · 纸白/护眼/夜间三主题，localStorage 记忆）·
笔记页（工厂成果展示：技能卡/学习笔记）。
纯标准库生成 HTML（内联 CSS/JS，零依赖零服务器，月成本 ¥0——免费极限工程学）。
真实性纪律：推荐值=思想密度分（真实）、标签按分数档映射、不虚构评分人数/销量。
"""

import html
import json
import math
import os

_PREVIEW_RATIO = 0.2  # 免费试读比例（转录原案）

# 微信读书式评分档（推荐值→标签，真实映射不虚构）
_TAG_MASTERPIECE, _TAG_GREAT, _TAG_WORTHY = 85, 70, 60


def rating_tag(score: int) -> str:
    """思想密度分 → 微信读书式档位标签。"""
    if score >= _TAG_MASTERPIECE:
        return "神作"
    if score >= _TAG_GREAT:
        return "好评如潮"
    if score >= _TAG_WORTHY:
        return "值得一读"
    return "重锻中"


_TAG_COLOR = {"神作": "#b8860b", "好评如潮": "#07c160", "值得一读": "#576b95",
              "重锻中": "#999"}


def _fit_title(title: str) -> tuple[str, str]:
    """竖排书名适配封面高度：≤14 字防溢出，字号随长度自适应（8.5-13px）。

    视觉验收实锤缺陷修复：12 字 × (13px+2 字距) = 180px 溢出封面、压住底部
    水印行；改为 n × (fs+2) ≤ 148px 收敛，西文用 text-orientation:upright 直立。
    """
    text = title[:14]
    # 末尾悬挂的西文/空格回退到汉字边界（视觉验收：孤立 "A"/"F" 断行难看）
    while text and text[-1].isascii() and (text[-1].isalnum() or text[-1].isspace()):
        text = text[:-1]
    if not text:
        text = title[:10]
    fs = max(8.5, round(min(13, 144 / max(len(text), 1) - 2), 1))
    return text, str(fs)


def _cover_svg(title: str, score: int, slug: str) -> str:
    """程序化竖版书封（渐变底 + 竖排书名 + 推荐值角标）。"""
    hue = sum(ord(c) for c in slug) % 360
    raw, fs = _fit_title(title)
    t = html.escape(raw)
    tag = rating_tag(score)
    return (
        f'<svg class="cover" viewBox="0 0 150 210" role="img" aria-label="{t}">'
        f'<defs><linearGradient id="g{slug}" x1="0" y1="0" x2="1" y2="1">'
        f'<stop offset="0" stop-color="hsl({hue},52%,42%)"/>'
        f'<stop offset="1" stop-color="hsl({(hue + 40) % 360},58%,26%)"/>'
        f'</linearGradient></defs>'
        f'<rect width="150" height="210" rx="8" fill="url(#g{slug})"/>'
        f'<rect x="6" y="6" width="138" height="198" rx="5" fill="none" '
        f'stroke="rgba(255,255,255,.35)"/>'
        f'<text x="118" y="32" fill="#fff" font-size="{fs}" font-weight="bold" '
        f'letter-spacing="2" '
        f'style="writing-mode:vertical-rl;text-orientation:upright">{t}</text>'
        f'<text x="22" y="192" fill="rgba(255,255,255,.92)" font-size="11">'
        f'PAI-Station 铸造厂</text>'
        f'<rect x="10" y="10" width="52" height="20" rx="10" '
        f'fill="{_TAG_COLOR[tag]}"/>'
        f'<text x="36" y="24" fill="#fff" font-size="11" text-anchor="middle">'
        f'{score}</text></svg>')


_CSS = """
 :root{--bg:#f6f7f9;--fg:#24292f;--card:#fff;--side:#2e2f33;--side-fg:#cfd3d9;
       --accent:#07c160;--muted:#6a737d;--line:#e4e7eb;--reader:#fff}
 [data-theme="dark"]{--bg:#1b1d21;--fg:#d8dce1;--card:#24262b;--side:#141518;
       --side-fg:#9aa0a8;--accent:#2ea86e;--muted:#8a9099;--line:#33363c;
       --reader:#24262b}
 body{margin:0;font-family:'Microsoft YaHei',system-ui,sans-serif;background:var(--bg);
      color:var(--fg)}
 .side{position:fixed;left:0;top:0;bottom:0;width:190px;background:var(--side);
       color:var(--side-fg);padding:22px 0;box-sizing:border-box;z-index:9}
 .side .logo{color:#fff;font-weight:bold;font-size:18px;padding:0 20px 18px;
       border-bottom:1px solid rgba(255,255,255,.08);margin-bottom:14px}
 .side a{display:block;color:var(--side-fg);text-decoration:none;padding:11px 20px;
       font-size:15px}
 .side a.on{color:var(--accent);background:rgba(255,255,255,.06);
       border-right:3px solid var(--accent)}
 .main{margin-left:190px;padding:28px 36px;max-width:1040px;box-sizing:border-box}
 h1{font-size:26px} h2{font-size:19px;border-bottom:2px solid var(--line);
       padding-bottom:6px} h3{font-size:16px}
 .meta{color:var(--muted);font-size:13px}
 .banner{background:linear-gradient(120deg,#1f3a5f,#2e6e5e);color:#fff;
       border-radius:12px;padding:26px 30px;margin-bottom:26px}
 .banner p{color:rgba(255,255,255,.85);font-size:14px}
 .grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(168px,1fr));
       gap:18px;margin:18px 0 34px}
 .book{text-align:center}
 .book a{color:inherit;text-decoration:none}
 .book .t{font-size:14px;font-weight:600;margin:8px 2px 2px;
       overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
 .book .p{color:#c0392b;font-weight:bold;font-size:15px}
 .cover{width:100%;max-width:150px;box-shadow:0 4px 12px rgba(0,0,0,.18);
       border-radius:8px;transition:transform .15s}
 .book:hover .cover{transform:translateY(-4px)}
 .rank{background:var(--card);border:1px solid var(--line);border-radius:12px;
       padding:18px 24px;margin-bottom:30px}
 .rank ol{margin:8px 0 0;padding-left:0;list-style:none}
 .rank li{display:flex;gap:12px;padding:9px 4px;border-bottom:1px dashed var(--line);
       font-size:14px;align-items:baseline}
 .rank .no{color:#c0392b;font-weight:800;width:38px}
 .rank a{color:var(--fg);text-decoration:none;flex:1}
 .rank .sc{color:var(--accent);font-weight:bold}
 .card{background:var(--card);border:1px solid var(--line);border-radius:12px;
       padding:20px 24px;margin:16px 0}
 .detail{display:flex;gap:28px;align-items:flex-start;margin-bottom:8px}
 .detail .cover{width:170px;flex:none}
 .tag{display:inline-block;color:#fff;border-radius:12px;padding:2px 12px;
       font-size:13px;margin-right:8px}
 .price{color:#c0392b;font-size:24px;font-weight:bold;margin:8px 0}
 .cta{background:#07c160;color:#fff;border-radius:8px;padding:10px 26px;
       text-decoration:none;font-weight:bold;display:inline-block}
 .lock{color:var(--muted);background:var(--bg);border-radius:6px;
       padding:8px 14px;margin:6px 0;font-size:14px}
 .note{color:#8a6d3b;background:#fcf8e3;border:1px solid #faebcc;border-radius:6px;
       padding:10px 14px;font-size:13px}
 [data-theme="dark"] .note{background:#33301d;border-color:#57502e;color:#d8c88a}
 .comp{display:inline-block;background:color-mix(in srgb,var(--accent) 12%,transparent);
       border-radius:4px;padding:1px 8px;margin:2px;font-size:12px;
       color:var(--accent)}
 details{border:1px solid var(--line);border-radius:8px;padding:10px 16px;
       margin:8px 0;background:var(--card)}
 summary{cursor:pointer;font-weight:600}
 details .meta{margin-left:1.2em}
 .reader{background:var(--reader);border:1px solid var(--line);border-radius:12px;
       padding:34px 40px;line-height:1.95;font-size:18px;
       font-family:Georgia,'Songti SC','SimSun',serif}
 .reader h3,.reader h4{font-family:inherit}
 .tools{display:flex;gap:8px;align-items:center;margin:12px 0;flex-wrap:wrap}
 .tools button,.tools .chip{background:var(--card);border:1px solid var(--line);
       border-radius:16px;padding:4px 14px;font-size:13px;cursor:pointer;
       color:var(--fg)}
 .tools .chip.on{border-color:var(--accent);color:var(--accent)}
 .reader.sepia{background:#f8f1e3;color:#423a2c}
 .reader.nightmode{background:#1c1e22;color:#c9cdd3}
 blockquote{border-left:3px solid var(--accent);margin:8px 0;padding:2px 12px;
       color:var(--muted)}
 footer{color:var(--muted);font-size:12px;margin-top:40px;border-top:1px solid var(--line);
       padding-top:12px}
 @media(max-width:800px){.side{position:static;width:auto;display:flex;gap:4px;
       padding:8px;align-items:center}.side .logo{border:none;padding:6px 12px;margin:0}
       .main{margin:0;padding:14px}.detail{flex-direction:column}}
"""

_JS = """
 const KEY='paistation-theme';
 const apply=t=>{document.body.dataset.theme=t;
   document.querySelectorAll('.theme-chip').forEach(c=>
     c.classList.toggle('on',c.dataset.t===t));
   try{localStorage.setItem(KEY,t)}catch(e){}};
 const saved=(()=>{try{return localStorage.getItem(KEY)}catch(e){return null}})();
 if(saved)apply(saved);
 document.addEventListener('click',e=>{const t=e.target;
   if(t.classList&&t.classList.contains('theme-chip'))apply(t.dataset.t);});
 const R=document.querySelector('.reader');
 if(R){const fs=()=>R.style.fontSize||getComputedStyle(R).fontSize;
   const setFs=v=>R.style.fontSize=Math.min(24,Math.max(14,v))+'px';
   document.getElementById('fminus')&&(
     document.getElementById('fminus').onclick=()=>setFs(parseFloat(fs())-2),
     document.getElementById('fplus').onclick=()=>setFs(parseFloat(fs())+2));
   document.querySelectorAll('.read-chip').forEach(c=>c.onclick=()=>{
     R.classList.remove('sepia','nightmode');
     if(c.dataset.r==='sepia')R.classList.add('sepia');
     if(c.dataset.r==='night')R.classList.add('nightmode');
     document.querySelectorAll('.read-chip').forEach(x=>
       x.classList.toggle('on',x===c));});}
"""


def _shell(title: str, active: str, body: str, works: bool = False) -> str:
    """页面骨架：微信读书式左侧导航 + 主题切换。"""
    nav = [("书城", "index.html"), ("书架", "index.html#shelves"),
           ("笔记", "works.html" if works else "works.html")]
    links = "".join(
        f'<a href="{href}"{" class=on" if key == active else ""}>{key}</a>'
        for key, href in nav)
    toggle = ('<a href="javascript:void(0)" class="theme-chip" data-t="dark">'
              "🌙 夜间</a>")
    return (
        f'<!DOCTYPE html>\n<html lang="zh-CN"><head><meta charset="utf-8">\n'
        f'<meta name="viewport" content="width=device-width, initial-scale=1">\n'
        f"<title>{title} · PAI 书城</title>\n<style>{_CSS}</style></head>\n"
        f'<body>\n<nav class="side"><div class="logo">📖 PAI 书城</div>'
        f"{links}<div style='margin-top:24px'>{toggle}</div></nav>\n"
        f'<div class="main">\n{body}\n'
        f"<footer>PAI-Station 方案铸造厂 · 你的电脑替你造钱 · "
        f"零服务器 · GitHub Pages</footer>\n</div>\n<script>{_JS}</script>\n"
        f"</body></html>\n")


def _md_lite(text: str) -> str:
    """正文 markdown → HTML（轻子集：标题/粗体/列表/引用/表格线转段落）。"""
    out = []
    for raw in text.splitlines():
        line = raw.strip()
        if not line:
            continue
        if line.startswith("###"):
            out.append(f"<h4>{html.escape(line.lstrip('# '))}</h4>")
        elif line.startswith("##"):
            out.append(f"<h3>{html.escape(line.lstrip('# '))}</h3>")
        elif line.startswith("#"):
            out.append(f"<h3>{html.escape(line.lstrip('# '))}</h3>")
        elif line.startswith("- ") or line.startswith("* "):
            item = html.escape(line[2:])
            out.append(f"<li>{_bold(item)}</li>")
        elif line.startswith(">"):
            out.append(f"<blockquote>{_bold(html.escape(line.lstrip('> ')))}</blockquote>")
        elif line.startswith("|"):
            out.append(f"<code>{html.escape(line)}</code><br>")
        else:
            out.append(f"<p>{_bold(html.escape(line))}</p>")
    return "\n".join(out)


def _bold(escaped: str) -> str:
    return escaped.replace("**", "<b>", 1).replace("**", "</b>") if "**" in escaped \
        else escaped


def _reader_tools() -> str:
    return (
        '<div class="tools"><span class="meta">排版：</span>'
        '<button id="fminus" type="button">A−</button>'
        '<button id="fplus" type="button">A+</button>'
        '<span class="meta" style="margin-left:10px">背景：</span>'
        '<button class="chip read-chip on" data-r="paper" type="button">纸白</button>'
        '<button class="chip read-chip" data-r="sepia" type="button">护眼</button>'
        '<button class="chip read-chip" data-r="night" type="button">夜间</button>'
        '<span class="meta" style="margin-left:10px">字号与背景本机记忆，'
        "试读为全文 20%</span></div>")


def _plan_page(plan: dict, meta: dict, others: list[dict]) -> str:
    """方案详情页（微信读书书籍详情页形态）。"""
    title = html.escape(plan.get("title", ""))
    slug = plan.get("slug", "")
    score = plan.get("score", 0)
    price = meta.get("price", "")
    tag = rating_tag(score)
    total = sum(len(c.get("sections", [])) for c in plan.get("chapters", []))
    free_n = max(1, math.ceil(total * _PREVIEW_RATIO)) if total else 0
    seen = 0
    n_frames = len({c.get("framework", "") for c in plan.get("chapters", [])})

    head = [f'<div class="detail">{_cover_svg(title, score, slug)}<div>',
            f"<h1>{title}</h1>",
            f'<p style="font-size:15px;margin:6px 0">'
            f'<span style="color:var(--accent);font-weight:800;font-size:22px">'
            f"推荐值 {score}%</span>"
            f'<span class="tag" style="background:{_TAG_COLOR[tag]}">{tag}</span>'
            f'<span class="tag" style="background:#576b95">通过密度闸门</span></p>'
            if plan.get("passed") else
            f'<p><span class="meta">推荐值 {score}%</span></p>',
            f'<p class="meta">{total} 节 · {len(plan.get("chapters", []))} 章 · '
            f"{n_frames} 种思维模型框架 · 抄作业九件套逐节落位</p>"]
    if plan.get("corpus_note"):
        head.append(f'<div class="note">{html.escape(plan["corpus_note"])}</div>')
    if price:
        head.append(f'<p class="price">¥{price}'
                    '<span class="meta" style="font-size:13px">（反馈可返钱）</span></p>'
                    f'<a class="cta" href="#buy">立即购买</a>'
                    '<span class="meta" style="margin-left:12px">'
                    "付款后 24 小时内交付 MD + DOCX</span>")
    head.append("</div></div>")
    parts = head

    tagline = meta.get("tagline", "")
    if tagline:
        parts.append(f'<div class="card"><h2>简介</h2><p>{html.escape(tagline)}</p>'
                     "<p>这不是一份「看看就好」的报告，而是一套<b>能直接搬走执行</b>的作业："
                     "每章标注思维模型、每节至少 2 件抄作业组件（WBS/业务公式/避坑清单/"
                     "实操武器库/小案例…），四前提（标准化/流程化/数据化/知识化）逐节落位。"
                     "读完不满意？<b>写下真诚反馈，按时长返钱</b>（15 分钟 ¥100 起，"
                     "70 分钟以上全退）。</p></div>")

    toc = ['<div class="card"><h2>目录（点击展开）</h2>']
    for ch in plan.get("chapters", []):
        frame = html.escape(ch.get('framework', ''))
        toc.append(f"<details><summary>{html.escape(ch.get('title', ''))}"
                   f"<span class='meta'>（{frame}）</span></summary>")
        for sec in ch.get("sections", []):
            toc.append(f'<p class="meta">{html.escape(sec.get("title", ""))}</p>')
        toc.append("</details>")
    toc.append("</div>")
    parts.append("".join(toc))

    parts.append('<div class="card"><h2>免费试读（约 20%）</h2>')
    parts.append(_reader_tools())
    parts.append('<article class="reader">')
    for ch in plan.get("chapters", []):
        for sec in ch.get("sections", []):
            seen += 1
            if seen <= free_n:
                comps = "".join(f'<span class="comp">{html.escape(c)}</span>'
                                for c in sec.get("components", []))
                parts.append(f"<h3>{html.escape(sec.get('title', ''))}</h3>"
                             f"<p class='meta'>节框架：{html.escape(sec.get('framework', ''))}"
                             f" {comps}</p>" + _md_lite(sec.get("content", "")))
                if sec.get("degraded"):
                    parts.append(f'<div class="note">⚠ {html.escape(sec["degrade_note"])}</div>')
            else:
                parts.append(f'<div class="lock">🔒 {html.escape(sec.get("title", ""))}'
                             " —— 购买后解锁</div>")
    parts.append("</article></div>")

    parts.append('<div class="card" id="buy"><h2>购买引导</h2>'
                 "<p>支付占位（真实支付随 M8 商户号接入）：<br>"
                 "① 微信/支付宝收款码位置 —— 付款后截图 <br>"
                 "② 企业微信扫码加好友 —— 发送付款截图与邮箱，24 小时内交付"
                 "完整版 MD + DOCX 双格式。</p></div>")
    parts.append('<div class="card"><h2>反馈返钱（写反馈 = 挣钱 = 训练下一版）</h2>'
                 "<p>购买后通过企业微信发送反馈：写清用时时长与具体问题。"
                 "三维 AI 评分（真诚度/具体性/可行动性）定返款成色："
                 "＞15 分钟 ¥100 · ＞30 分钟 ¥200 · ＞60 分钟 ¥400 · ＞70 分钟全退"
                 "（灌水三折，真诚满档）。</p></div>")

    if others:
        rel = "".join(
            f'<li><a href="{o["slug"]}.html">{html.escape(o["title"])}</a>'
            f'<span class="meta"> · 推荐值 {o["score"]}% · '
            f'{rating_tag(o["score"])}</span></li>' for o in others)
        parts.append(f'<div class="card"><h2>猜你喜欢</h2><ul>{rel}</ul></div>')
    return _shell(title, "书城", "\n".join(parts))


def _index_page(entries: list[dict]) -> str:
    ranked = sorted(entries, key=lambda e: -e["score"])
    grid = []
    for e in entries:
        price = f"¥{e['price']}" if e.get("price") else "价格见详情"
        note = (f'<div class="note" style="font-size:12px;text-align:left">'
                f'{html.escape(e["corpus_note"])}</div>'
                if e.get("corpus_note") else "")
        grid.append(
            f'<div class="book"><a href="plans/{e["slug"]}.html">'
            f"{_cover_svg(e['title'], e['score'], e['slug'])}"
            f'<div class="t">{html.escape(e["title"])}</div>'
            f'<div class="meta">推荐值 {e["score"]}% · {e["n_sections"]} 节</div>'
            f'<div class="p">{price}</div></a>{note}</div>')
    rank_items = "".join(
        f'<li><span class="no">No.{i}</span>'
        f'<a href="plans/{e["slug"]}.html">{html.escape(e["title"])}</a>'
        f'<span class="sc">{e["score"]}</span>'
        f'<span class="meta">{rating_tag(e["score"])}</span></li>'
        for i, e in enumerate(ranked, 1))
    body = (
        '<div class="banner"><h1>PAI 书城 · 方案铸造厂</h1>'
        "<p>FDE 行业 AI 转型实施方案 · 每份方案经思想密度计闸门（≥60 分方可出厂）"
        "· 推荐值即思想密度分 · 反馈即返钱</p></div>"
        '<div class="rank"><h2>📉 思想密度榜</h2>'
        f"<ol>{rank_items}</ol></div>"
        '<h2 id="shelves">📚 编辑推荐</h2>'
        f'<div class="grid">{"".join(grid)}</div>')
    return _shell("书城", "书城", body)


def _works_page(works: list[dict]) -> str:
    """笔记页：工厂成果展示（技能卡/学习笔记——全部真实产出）。"""
    cards = "".join(
        f'<div class="card"><h2><a href="works/w{i}.html" '
        f'style="color:inherit;text-decoration:none">{html.escape(w["title"])}</a>'
        f'<span class="tag" style="background:#576b95">{html.escape(w["type"])}</span></h2>'
        f'<p class="meta">{html.escape(w.get("desc", ""))}</p></div>'
        for i, w in enumerate(works))
    body = ("<h1>✍️ 笔记 · 工厂成果</h1>"
            '<p class="meta">知识环的真实产出：从混沌学园课程语料蒸馏的技能卡与'
            "学习笔记——方案商店的供给侧地基。</p>" + cards)
    return _shell("笔记", "笔记", body, works=True)


def _work_page(work: dict) -> str:
    body = (f'<h1>{html.escape(work["title"])}</h1>'
            f'<p class="meta">{html.escape(work.get("desc", ""))}</p>'
            f'<div class="card"><article class="reader">'
            f'{_md_lite(work.get("content", ""))}</article></div>')
    return _shell(work["title"], "笔记", body, works=True)


def build_site(plans_dir: str, docs_dir: str, catalog: dict | None = None,
               works: list[dict] | None = None) -> dict:
    """扫描 plans_dir/*/plan.json → 书城（index + plans/* + works/*）。"""
    catalog = catalog or {}
    entries, written = [], []
    plans_out = os.path.join(docs_dir, "plans")
    os.makedirs(plans_out, exist_ok=True)
    for name in sorted(os.listdir(plans_dir)):
        path = os.path.join(plans_dir, name, "plan.json")
        if not os.path.isfile(path):
            continue
        plan = json.load(open(path, encoding="utf-8"))
        slug = plan.get("slug", name)
        meta = catalog.get(slug, {})
        entries.append({"slug": slug, "title": plan.get("title", slug),
                        "score": plan.get("score", 0),
                        "corpus_note": plan.get("corpus_note", ""),
                        "price": meta.get("price", ""),
                        "tagline": meta.get("tagline", ""),
                        "n_chapters": len(plan.get("chapters", [])),
                        "n_sections": sum(len(c.get("sections", []))
                                          for c in plan.get("chapters", []))})
    for e in entries:
        others = [o for o in entries if o["slug"] != e["slug"]]
        plan = json.load(open(os.path.join(plans_dir, e["slug"], "plan.json"),
                              encoding="utf-8"))
        page_path = os.path.join(plans_out, f"{e['slug']}.html")
        with open(page_path, "w", encoding="utf-8") as f:
            f.write(_plan_page(plan, catalog.get(e["slug"], {}), others))
        written.append(page_path)
    with open(os.path.join(docs_dir, "index.html"), "w", encoding="utf-8") as f:
        f.write(_index_page(entries))
    if works:
        works_dir = os.path.join(docs_dir, "works")
        os.makedirs(works_dir, exist_ok=True)
        for i, w in enumerate(works):
            p = os.path.join(works_dir, f"w{i}.html")
            with open(p, "w", encoding="utf-8") as f:
                f.write(_work_page(w))
            written.append(p)
        with open(os.path.join(docs_dir, "works.html"), "w", encoding="utf-8") as f:
            f.write(_works_page(works))
    return {"plans": entries, "written": written,
            "index": os.path.join(docs_dir, "index.html")}
