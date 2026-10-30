# -*- coding: utf-8 -*-
"""_freekey_mail_harvest_1026 — 免费钥申领波·邮件收割 (密钥直落secret文件, 永不打印全文).

用法: python _freekey_mail_harvest_1026.py <from_or_subject_kw> <secret_path> <extract_regex> [link_click]
  - envelope list --since 24h 按 kw 过滤 → message show (stdout 捕获不落终端)
  - extract_regex 命中第一组即写入 secret (追加模式, 已存在同值去重)
  - link_click=click 时额外提取 http 链接打印(供确认链接点掉)
"""
from __future__ import annotations
import json, re, subprocess, sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
CLI = str(Path.home() / "AppData/Local/Microsoft/WindowsApps/qqmail-cli.exe")
import os
ENV = {**os.environ, "QQMAIL_CLI_READONLY": "1"}

def run(args):
    p = subprocess.run([CLI] + args, capture_output=True, text=True, encoding="utf-8", errors="replace", env=ENV, timeout=120)
    return p.returncode, p.stdout, p.stderr

def mask(s):
    if not s: return ""
    return s[:6] + "..." + s[-4:] + f" (len={len(s)})"

def main():
    kw, secret_path, rx = sys.argv[1], sys.argv[2], sys.argv[3]
    click = len(sys.argv) > 4 and sys.argv[4] == "click"
    rc, out, err = run(["envelope", "list", "--since", "24h", "--limit", "50", "--json"])
    if rc != 0:
        print(json.dumps({"ok": False, "step": "envelope", "rc": rc, "err": err[:200]})); return
    envs = json.loads(out)
    d = envs.get("data", {})
    msgs = d.get("envelopes") if isinstance(d, dict) else d
    if msgs is None:
        msgs = d.get("messages", []) if isinstance(d, dict) else []
    hits = []
    for m in (msgs if isinstance(msgs, list) else []):
        blob = json.dumps({k: m.get(k) for k in ("from", "subject", "date", "id")}, ensure_ascii=False)
        if kw.lower() in blob.lower():
            hits.append(m)
    if not hits:
        print(json.dumps({"ok": True, "matched": 0, "kw": kw})); return
    ids = [h["id"] for h in hits[:4]]
    meta = [{"id": h.get("id"), "from": h.get("from"), "subject": h.get("subject")} for h in hits[:4]]
    rc2, out2, err2 = run(["message", "show"] + ids + ["--json"])
    if rc2 != 0:
        print(json.dumps({"ok": False, "step": "show", "rc": rc2, "err": err2[:200], "matched": meta})); return
    raw = out2
    found, links = [], []
    for m in re.finditer(rx, raw, re.I):
        v = m.group(1).strip()
        if v and v not in found:
            found.append(v)
    if click:
        links = [l for l in re.findall(r'https?://[^\s"\'<>]+', raw) if any(t in l.lower() for t in ("verify", "confirm", "activate", "token", "click", "magic", "signin", "login"))]
    result = {"ok": True, "matched": meta, "keys_found": len(found)}
    if found:
        p = Path(secret_path)
        existing = p.read_text(encoding="utf-8") if p.exists() else ""
        new = [v for v in found if v not in existing]
        if new:
            with p.open("a", encoding="utf-8") as f:
                for v in new:
                    f.write(v + "\n")
        result["saved"] = [mask(v) for v in new]
        result["masked_all"] = [mask(v) for v in found]
    if click:
        result["links"] = links[:6]
    print(json.dumps(result, ensure_ascii=False))

if __name__ == "__main__":
    main()
