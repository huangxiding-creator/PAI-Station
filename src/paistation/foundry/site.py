"""零服务器方案商店（M7.4 / PROPOSAL_M7 §5.1）——GitHub Pages 静态站。

方案页结构（09-09 晚转录规则）：
推荐序（免费试读 ≈20% 节全文）+ 用户价值陈述 + 三级完整目录
+ 九件套预览 + 购买引导（收款码/企微占位，真实支付 M8 接商户号）+ 反馈返钱入口。
纯标准库生成 HTML（内联 CSS，零 JS 依赖，月成本 ¥0——免费极限工程学宪章）。
"""

import html
import json
import math
import os

_PREVIEW_RATIO = 0.2  # 免费试读比例（转录原案）

_STYLE = """<!DOCTYPE html>
<html lang="zh-CN"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{title} · PAI-Station 方案铸造厂</title>
<style>
 body{{font-family:'Microsoft YaHei',system-ui,sans-serif;max-width:860px;
      margin:0 auto;padding:24px;color:#222;background:#fafafa}}
 h1{{color:#1f3a5f}} h2{{color:#1f3a5f;border-bottom:2px solid #1f3a5f;
      padding-bottom:6px}} h3{{color:#333}}
 .card{{background:#fff;border:1px solid #e5e5e5;border-radius:10px;
      padding:20px 24px;margin:16px 0;box-shadow:0 1px 3px rgba(0,0,0,.06)}}
 .meta{{color:#666;font-size:14px}} .badge{{display:inline-block;background:#1f3a5f;
      color:#fff;border-radius:12px;padding:2px 12px;font-size:13px;margin-left:8px}}
 .price{{color:#c0392b;font-size:22px;font-weight:bold}}
 .lock{{color:#999;background:#f3f3f3;border-radius:6px;padding:10px 14px;margin:8px 0}}
 .note{{color:#8a6d3b;background:#fcf8e3;border:1px solid #faebcc;
      border-radius:6px;padding:10px 14px}}
 .comp{{display:inline-block;background:#eef;border-radius:4px;
      padding:1px 8px;margin:2px;font-size:12px}}
 .cta{{background:#c0392b;color:#fff;border-radius:8px;padding:10px 24px;
      text-decoration:none;font-weight:bold}}
 footer{{color:#999;font-size:12px;margin-top:40px;border-top:1px solid #ddd;
      padding-top:12px}}
</style></head><body>
"""


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


def _plan_page(plan: dict, meta: dict) -> str:
    """单方案页：试读 + 价值 + 三级目录 + 购买/反馈。"""
    title = html.escape(plan.get("title", ""))
    price = meta.get("price", "")
    total = sum(len(c.get("sections", [])) for c in plan.get("chapters", []))
    free_n = max(1, math.ceil(total * _PREVIEW_RATIO)) if total else 0
    seen = 0

    parts = [_STYLE.format(title=title), f"<h1>{title}</h1>"]
    score = plan.get("score", 0)
    badge = '<span class="badge">通过密度闸门</span>' if plan.get("passed") else ""
    parts.append(f'<p class="meta">思想密度分 <b>{score}</b>/100 {badge}'
                 f'{" · 九件套可抄作业" if total else ""}</p>')
    if plan.get("corpus_note"):
        parts.append(f'<div class="note">{html.escape(plan["corpus_note"])}</div>')
    if price:
        parts.append(f'<p class="price">¥{price}</p>')
    parts.append('<div class="card"><h2>为什么值得（用户价值）</h2>'
                 "<p>这不是一份「看看就好」的报告，而是一套<b>能直接搬走执行</b>的作业："
                 "每章标注思维模型、每节至少 2 件抄作业组件（WBS/业务公式/避坑清单/"
                 "实操武器库/小案例…），四前提（标准化/流程化/数据化/知识化）逐节落位。"
                 "读完不满意？<b>写下真诚反馈，按时长返钱</b>（15 分钟 ¥100 起，"
                 "70 分钟以上全退）——你的每条反馈都会变成下一版的免疫规则。</p></div>")

    parts.append('<div class="card"><h2>推荐序 · 免费试读（约 20%）</h2>')
    for ch in plan.get("chapters", []):
        ch_frame = html.escape(ch.get("framework", ""))
        parts.append(f"<h3>{html.escape(ch.get('title', ''))}"
                     f"<span class='meta'>（章框架：{ch_frame}）</span></h3>")
        for sec in ch.get("sections", []):
            seen += 1
            if seen <= free_n:
                comps = "".join(f'<span class="comp">{html.escape(c)}</span>'
                                for c in sec.get("components", []))
                parts.append(f"<h4>{html.escape(sec.get('title', ''))}</h4>"
                             f"<p class='meta'>节框架：{html.escape(sec.get('framework', ''))}"
                             f" {comps}</p>" + _md_lite(sec.get("content", "")))
                if sec.get("degraded"):
                    parts.append(f'<div class="note">⚠ {html.escape(sec["degrade_note"])}</div>')
            else:
                parts.append(f'<div class="lock">🔒 {html.escape(sec.get("title", ""))}'
                             " —— 购买后解锁</div>")
    parts.append("</div>")

    toc_html = ['<div class="card"><h2>三级完整目录</h2>']
    for ch in plan.get("chapters", []):
        toc_html.append(f"<p><b>{html.escape(ch.get('title', ''))}</b>"
                        f"<span class='meta'>（{html.escape(ch.get('framework', ''))}）</span></p>")
        for sec in ch.get("sections", []):
            toc_html.append(f"<p class='meta' style='margin-left:1.5em'>"
                            f"{html.escape(sec.get('title', ''))}</p>")
    toc_html.append("</div>")
    parts.append("".join(toc_html))

    parts.append('<div class="card"><h2>购买引导</h2>'
                 "<p>支付占位（真实支付随 M8 商户号接入）：<br>"
                 "① 微信/支付宝收款码位置 —— 付款后截图 <br>"
                 "② 企业微信扫码加好友 —— 发送付款截图与邮箱，24 小时内交付"
                 "完整版 MD + DOCX 双格式。</p>"
                 f'<p><a class="cta" href="javascript:void(0)">扫码购买'
                 f'（¥{price if price else "详见客服"}）</a></p></div>')
    parts.append('<div class="card"><h2>反馈返钱（写反馈 = 挣钱 = 训练下一版）</h2>'
                 "<p>购买后通过企业微信发送反馈：写清用时时长与具体问题。"
                 "三维 AI 评分（真诚度/具体性/可行动性）定返款成色："
                 "＞15 分钟 ¥100 · ＞30 分钟 ¥200 · ＞60 分钟 ¥400 · ＞70 分钟全退"
                 "（灌水三折，真诚满档）。</p></div>")
    parts.append("<footer>PAI-Station 方案铸造厂 · 你的电脑替你造钱 · "
                 "GitHub Pages 零服务器成本运营</footer></body></html>")
    return "\n".join(parts)


def _index_page(entries: list[dict]) -> str:
    default_tagline = "三层思维模型 × 抄作业九件套，能直接搬走用的行业 AI 转型方案。"
    cards = []
    for e in entries:
        price = f"¥{e['price']}" if e.get("price") else "价格见方案页"
        note = (f'<div class="note">{html.escape(e["corpus_note"])}</div>'
                if e.get("corpus_note") else "")
        tagline = e.get("tagline", default_tagline)
        cards.append(
            f'<div class="card"><h2><a href="plans/{e["slug"]}.html">'
            f'{html.escape(e["title"])}</a></h2>'
            f'<p class="meta">思想密度 {e["score"]}/100 · {e["n_chapters"]} 章 · '
            f'{e["n_sections"]} 节</p>{note}'
            f'<p class="price">{price}</p>'
            f'<p>{html.escape(tagline)}</p></div>')
    return _STYLE.format(title="方案商店") + (
        "<h1>PAI-Station 方案铸造厂</h1>"
        '<p class="meta">FDE 行业 AI 转型实施方案 · 每份方案经思想密度计闸门'
        "（≥60 分方可出厂）· 反馈即返钱</p>" + "".join(cards) +
        "<footer>零服务器 · GitHub Pages · 免费极限工程学</footer></body></html>")


def build_site(plans_dir: str, docs_dir: str, catalog: dict | None = None) -> dict:
    """扫描 plans_dir/*/plan.json → docs/index.html + docs/plans/{slug}.html。"""
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
        page_path = os.path.join(plans_out, f"{slug}.html")
        with open(page_path, "w", encoding="utf-8") as f:
            f.write(_plan_page(plan, meta))
        entries.append({"slug": slug, "title": plan.get("title", slug),
                        "score": plan.get("score", 0),
                        "corpus_note": plan.get("corpus_note", ""),
                        "price": meta.get("price", ""),
                        "tagline": meta.get("tagline", ""),
                        "n_chapters": len(plan.get("chapters", [])),
                        "n_sections": sum(len(c.get("sections", []))
                                          for c in plan.get("chapters", []))})
        written.append(page_path)
    with open(os.path.join(docs_dir, "index.html"), "w", encoding="utf-8") as f:
        f.write(_index_page(entries))
    return {"plans": entries, "written": written,
            "index": os.path.join(docs_dir, "index.html")}
