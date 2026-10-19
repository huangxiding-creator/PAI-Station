# -*- coding: utf-8 -*-
"""feishu_wiki_upload — 研报上架总包智库飞书知识库「研报库」(1019 用户令接入 S4 链).

在「📚 AI总包创新院研报」节点下创建 docx 子节点 + 上传报告 PDF。
幂等：同标题节点已存在则跳过创建，仅补传 PDF。

用法: py -X utf8 tools/feishu_wiki_upload.py --sku BID26-2026 --title "《xxx》" [--pdf path]
      py -X utf8 tools/feishu_wiki_upload.py --list  # 列已有节点
"""
from __future__ import annotations

import argparse
import json
import subprocess
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]
LARK = (r"C:\Users\91216\AppData\Roaming\npm\node_modules"
        r"\@larksuite\cli\bin\lark-cli.exe")
SPACE = "7689289338592431383"       # 总包智库
PARENT = "Fi4fwMG8FiQ3hik7p3kcByp8n6c"  # 📚 AI总包创新院研报


def run(*args: str) -> dict:
    cp = subprocess.run([LARK, *args, "--as", "user"],
                        capture_output=True, text=True, encoding="utf-8", timeout=300)
    try:
        return json.loads(cp.stdout)
    except Exception:
        return {"ok": False, "error": {"message": cp.stdout[:200]}}


def list_children() -> list[dict]:
    d = run("wiki", "+node-list", "--space-id", SPACE,
            "--parent-node-token", PARENT)
    return (d.get("data") or {}).get("nodes") or []


def find_or_create(title: str) -> str | None:
    for n in list_children():
        if n.get("title") == title:
            return n.get("node_token")
    d = run("wiki", "+node-create", "--space-id", SPACE,
            "--parent-node-token", PARENT,
            "--title", title, "--obj-type", "docx")
    return (d.get("data") or {}).get("node_token") if d.get("ok") else None


def upload_pdf(node_token: str, pdf_path: Path) -> bool:
    # lark-cli 要求相对路径 → 切 cwd 到 repo
    rel = pdf_path.resolve().relative_to(REPO)
    d = subprocess.run(
        [LARK, "drive", "+upload", "--file", str(rel),
         "--wiki-token", node_token, "--as", "user"],
        capture_output=True, text=True, encoding="utf-8",
        timeout=300, cwd=str(REPO))
    try:
        r = json.loads(d.stdout)
        return bool(r.get("ok"))
    except Exception:
        return False


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--sku", help="报告 SKU (PDF 文件名)")
    ap.add_argument("--title", help="节点标题（书名）")
    ap.add_argument("--pdf", default="", help="PDF 路径（缺省 report_platform/content/full/{sku}.pdf）")
    ap.add_argument("--list", action="store_true")
    ns = ap.parse_args()
    if ns.list:
        for n in list_children():
            print(f"  {n.get('title','?')} | {n.get('node_token','')}")
        return 0
    if not ns.sku or not ns.title:
        print("需 --sku + --title")
        return 1
    pdf = Path(ns.pdf) if ns.pdf else REPO / "report_platform" / "content" / "full" / f"{ns.sku}.pdf"
    if not pdf.exists():
        print(f"[feishu] PDF 不存在: {pdf}")
        return 1
    nt = find_or_create(ns.title)
    if not nt:
        print(f"[feishu] 节点创建失败: {ns.title}")
        return 1
    ok = upload_pdf(nt, pdf)
    print(f"[feishu] {ns.sku} → 「{ns.title}」 node={nt[:16]} upload={'✅' if ok else '❌'}")
    return 0 if ok else 1


if __name__ == "__main__":
    raise SystemExit(main())
