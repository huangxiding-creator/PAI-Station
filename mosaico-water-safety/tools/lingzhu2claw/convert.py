# -*- coding: utf-8 -*-
"""lingzhu2claw 转换器: assets/ + secrets/ + knowledge/ → firmware .recovery 预烧资产包。

幂等: 重复运行结果一致。产物清单打印 + 校验。
用法: py tools/lingzhu2claw/convert.py [--fw <firmware_dir>] [--max-kb 64]
"""
from __future__ import annotations

import argparse
import json
import os
import re
import shutil
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ASSETS = os.path.join(ROOT, "assets")
SECRETS = os.path.join(ROOT, "secrets", "webhooks.json")
KNOWLEDGE = os.path.join(ASSETS, "knowledge")


def load_webhooks() -> dict:
    if not os.path.exists(SECRETS):
        return {}
    with open(SECRETS, encoding="utf-8") as f:
        d = json.load(f)
    return {k: v for k, v in d.items() if not k.startswith("_")}


def validate_skill(path: str) -> list[str]:
    """按 esp-claw skill-package-spec 校验, 返回错误列表。"""
    errs = []
    d = os.path.dirname(path)
    name = os.path.basename(d)
    text = open(path, encoding="utf-8").read()
    m = re.match(r"^---\s*\n(.*?)\n---\s*\n", text, re.S)
    if not m:
        return [f"{name}: 缺 frontmatter"]
    try:
        fm = json.loads(m.group(1))
    except Exception as e:
        return [f"{name}: frontmatter 非法 JSON: {e}"]
    if fm.get("name") != name:
        errs.append(f"{name}: frontmatter name '{fm.get('name')}' != 目录名")
    if not fm.get("description"):
        errs.append(f"{name}: 缺 description")
    h1 = re.findall(r"^# .+$", text, re.M)
    if len(h1) != 1:
        errs.append(f"{name}: H1 数量 {len(h1)} != 1")
    cg = (fm.get("metadata") or {}).get("cap_groups")
    if cg is not None and (not isinstance(cg, list) or not all(isinstance(x, str) for x in cg)):
        errs.append(f"{name}: cap_groups 非法")
    return errs


def knowledge_sections(max_bytes: int) -> str:
    """knowledge/*.md → 拼接为分节文本(带字数预算)。"""
    parts = []
    if not os.path.isdir(KNOWLEDGE):
        return "（知识语料尚未蒸馏，当前仅含技能行为规则）"
    total = 0
    for fn in sorted(os.listdir(KNOWLEDGE)):
        if not fn.endswith(".md"):
            continue
        t = open(os.path.join(KNOWLEDGE, fn), encoding="utf-8").read().strip()
        if not t:
            continue
        total += len(t.encode("utf-8"))
        parts.append(f"### {fn[:-3]}\n\n{t}")
    if not parts:
        return "（知识语料尚未蒸馏，当前仅含技能行为规则）"
    if total > max_bytes:
        print(f"[warn] 知识总量 {total//1024}KB 超预算 {max_bytes//1024}KB, 截断到最后完整节")
        acc = 0
        keep = []
        for p in parts:
            if acc + len(p.encode()) > max_bytes:
                break
            keep.append(p)
            acc += len(p.encode())
        parts = keep
    return "\n\n".join(parts)


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--fw", default=os.path.join(ROOT, "firmware"))
    ap.add_argument("--max-kb", type=int, default=96)
    args = ap.parse_args()

    rec = os.path.join(args.fw, "fatfs_image", "system", ".recovery")
    if not os.path.isdir(rec):
        print(f"[err] 固件 .recovery 不存在: {rec}")
        return 2

    # 1. 校验技能
    skills_dir = os.path.join(ASSETS, "skills")
    errs = []
    for s in sorted(os.listdir(skills_dir)):
        p = os.path.join(skills_dir, s, "SKILL.md")
        if os.path.exists(p):
            errs += validate_skill(p)
    if errs:
        print("[FAIL] 技能校验未过:")
        for e in errs:
            print("  -", e)
        return 1
    print(f"[ok] {len(os.listdir(skills_dir))} 个技能校验通过")

    # 2. 渲染变量
    hooks = load_webhooks()
    kn = knowledge_sections(args.max_kb * 1024)
    def render(text: str) -> str:
        for k, v in hooks.items():
            text = text.replace("{{" + k + "}}", v)
        text = text.replace("{{KNOWLEDGE_SECTIONS}}", kn)
        return text

    # 3. 拷贝 memory
    n = 0
    for fn in ("identity.md", "soul.md", "user.md"):
        src = os.path.join(ASSETS, "memory", fn)
        dst = os.path.join(rec, "memory", fn)
        shutil.copyfile(src, dst)
        n += 1
    print(f"[ok] memory {n} 件")

    # 4. 渲染技能 → .recovery/skills/
    made = []
    for s in sorted(os.listdir(skills_dir)):
        src = os.path.join(skills_dir, s)
        dst = os.path.join(rec, "skills", s)
        os.makedirs(dst, exist_ok=True)
        for fn in os.listdir(src):
            shutil.copyfile(os.path.join(src, fn), os.path.join(dst, fn))
        p = os.path.join(dst, "SKILL.md")
        if os.path.exists(p):
            txt = open(p, encoding="utf-8").read()
            open(p, "w", encoding="utf-8", newline="\n").write(render(txt))
            made.append((s, os.path.getsize(p)))
    for s, sz in made:
        print(f"[ok] skill {s}: {sz//1024}KB")
        if sz > 128 * 1024:
            print(f"[warn] {s} 超128KB, 可能超注入预算")

    # 5. router_rules 保持出厂种子(不动)
    print("[ok] router_rules 沿用出厂种子")
    print("[done] 预烧资产包就绪:", rec)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
