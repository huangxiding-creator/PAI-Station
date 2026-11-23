# -*- coding: utf-8 -*-
"""factory_export_promo — 把6篇宣传稿导出为可直接导入公众号的独立文件.
每篇: {SKU}_{号}.md (含标题/正文/海报引用). 输出到 data/factory/promo_export/.
"""
import hashlib, json, os, re, html as H
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
PROMO = REPO / "report_platform" / "promo"
OUT = REPO / "data" / "factory" / "promo_export"
OUT.mkdir(parents=True, exist_ok=True)

JOBS = [
    {"sku": "ZHAOBIAO-2026", "campaign": "首产招投标",
     "posts": [
         {"acct": "acct05-总包之声", "md": PROMO / "2026-11-22_zbzs_zhaobiao_launch.md" if (PROMO / "2026-11-22_zbzs_zhaobiao_launch.md").exists() else None},
     ]},
    {"sku": "JES2-2026", "campaign": "第21份司法解释二",
     "posts": [
         {"acct": "acct05-总包之声", "md": PROMO / "2026-11-20_zbzs_jes2_launch.md"},
         {"acct": "acct01-总包说", "md": PROMO / "2026-11-20_zbshuo_jes2_lc.md"},
         {"acct": "acct07-工程行业大脑", "md": PROMO / "2026-11-20_dt_jes2_tk.md"},
     ]},
    {"sku": "TAX-2026", "campaign": "第22份税务",
     "posts": [
         {"acct": "acct05-总包之声", "md": PROMO / "2026-11-21_zbzs_tax_launch.md"},
         {"acct": "acct01-总包说", "md": PROMO / "2026-11-21_zbshuo_tax_clause.md"},
         {"acct": "acct07-工程行业大脑", "md": PROMO / "2026-11-21_dt_tax_invoice.md"},
     ]},
]

manifest = []
for j in JOBS:
    for post in j["posts"]:
        md = post.get("md")
        if not md or not Path(md).is_file():
            continue
        t = Path(md).read_text(encoding="utf-8")
        m = re.match(r"^#\s*(.+)$", t, re.M)
        title = m.group(1).strip() if m else Path(md).stem
        # 导出为纯文本 + HTML 两种格式
        plain = re.sub(r"<[^>]+>", "", t)
        out_name = re.sub(r'[\\/:*?"<>|]', '_', f"{post['acct'].split('-')[0]}_{title[:20]}.md")
        out_html = re.sub(r'[\\/:*?"<>|]', '_', f"{post['acct'].split('-')[0]}_{title[:20]}.html")
        (OUT / out_name).write_text(t, encoding="utf-8")
        # 简易 HTML (正文段落)
        html_parts = [f"<h1>{title}</h1>"]
        for ln in t.splitlines():
            s = ln.strip()
            if s.startswith("## "):
                html_parts.append(f"<h2>{H.escape(s[3:])}</h2>")
            elif s.startswith("> "):
                html_parts.append(f"<p><em>{H.escape(s[2:])}</em></p>")
            elif s.startswith("!["):
                html_parts.append('<p>[海报图片位置]</p>')
            elif s:
                import re as R
                t2 = R.sub(r"\*\*(.+?)\*\*", r"<strong>\1</strong>", H.escape(s))
                html_parts.append(f"<p>{t2}</p>")
        (OUT / out_html).write_text("\n".join(html_parts), encoding="utf-8")
        manifest.append({"sku": j["sku"], "campaign": j["campaign"], "acct": post["acct"],
                         "title": title[:60], "md": out_name, "html": out_html})
        print(f"  导出: {post['acct']} → {out_name}")

(OUT / "manifest.json").write_text(json.dumps(manifest, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"\n导出 {len(manifest)} 篇 → {OUT}")
