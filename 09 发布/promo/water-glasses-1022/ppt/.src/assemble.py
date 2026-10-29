# -*- coding: utf-8 -*-
"""装配器 — 上游 assemble_deck.mjs 行为契约的本地实现:
1. 读 deck.json 清单, 校验每个 slide 文件存在、恰好一个 <section class="slide" id="<id>">
2. 强制 CSS 作用域: slide 内 <style> 的选择器必须以 #<id> 开头(允许 @page/:root 之外的全局由 deck.css 承担)
3. 禁止外链资产: 不得出现 http:// https:// file:// 或相对 media 引用(图片须 data: URI)
4. 产出合并 .src/index.html (deck.css 内联在最前, 按 deck.json 顺序拼接)
非零退出 = 不可交付。
"""
import json
import re
import sys
from pathlib import Path

SRC = Path(__file__).resolve().parent
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
errors = []


def check(cond, msg):
    if not cond:
        errors.append(msg)


manifest = json.loads((SRC / "inlined" / "deck.json").read_text(encoding="utf-8"))
deck_css = (SRC / "inlined" / "deck.css").read_text(encoding="utf-8")
parts = [f"<!doctype html><html lang=\"zh-CN\"><meta charset=\"utf-8\"><title>{manifest['main_title']}</title>",
         f"<style>{deck_css}</style>"]

for s in manifest["slides"]:
    sid = s["id"]
    f = SRC / "inlined" / f"{sid}.html"
    check(f.exists(), f"缺 slide 文件: {f.name}")
    if not f.exists():
        continue
    t = f.read_text(encoding="utf-8")
    check(t.count('<section class="slide"') == 1, f"{sid}: 必须恰好一个 section.slide")
    check(f'id="{sid}"' in t, f"{sid}: section id 必须为 {sid}")
    check(sid != "index", "index 保留给合并文档")
    for bad in ("http://", "https://", "file://"):
        check(bad not in t, f"{sid}: 禁止外链 {bad}")
    check(not re.search(r'src="(?!data:)[^"]+"', t), f"{sid}: img src 必须 data: URI")
    check(not re.search(r'url\("(?!data:)[^"]+"\)', t), f"{sid}: CSS url() 必须 data: URI")
    # scoped <style>
    for m in re.finditer(r"<style>([\s\S]*?)</style>", t):
        css = m.group(1)
        for sel in re.findall(r"(?:^|\})\s*([^{}@]+)\{", css):
            sel_clean = sel.strip()
            if not sel_clean or sel_clean.startswith("/*"):
                continue
            check(sel_clean.startswith(f"#{sid}") or sel_clean.startswith(f"# {sid}"),
                  f"{sid}: <style> 选择器必须以 #{sid} 开头, 实际: {sel_clean[:50]}")
    check("letter-spacing" not in t and "text-transform" not in t, f"{sid}: 禁止 letter-spacing / text-transform")
    body = re.search(r"<body>([\s\S]*)</body>", t)
    parts.append(body.group(1) if body else t)

parts.append("</html>")
if errors:
    print("ASSEMBLE FAILED:")
    for e in errors:
        print(" -", e)
    sys.exit(1)

(SRC / "index.html").write_text("\n".join(parts), encoding="utf-8")
print(f"assembled {len(manifest['slides'])} slides -> .src/index.html")
