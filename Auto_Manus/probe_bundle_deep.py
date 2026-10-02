# -*- coding: utf-8 -*-
"""bundle 深挖 — agentEmail/邮件通知/connect-RPC 方法全集 (本地 grep)."""
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
JB = Path("data/jsbundle")

PATTERNS = {
    "UserService 方法": r'["\'](?:/)?user\.v1\.UserService/([A-Za-z]+)["\']',
    "NotificationService 方法": r'["\'](?:/)?([\w.]+NotificationService/[A-Za-z]+)["\']',
    "全部 connect 服务": r'["\']/?((?:user|session|chat|notify|feed|team|setting|account)[\w.]*Service/[A-Za-z]+)["\']',
    "agentEmail 上下文": r'.{80}agentEmail.{120}',
    "邮件通知文案": r'.{60}(?:[Ee]mail [Nn]otif|[Nn]otif.{0,30}email|邮件通知).{100}',
    "manus.bot": r'.{60}manus\.bot.{120}',
    "enable notifications 文案": r'.{100}to enable notifications.{60}',
}


def main():
    chunks = sorted(JB.glob("*.js"))
    print(f"[local] {len(chunks)} chunks, {sum(c.stat().st_size for c in chunks)//1024}KB")
    for label, pat in PATTERNS.items():
        hits = {}
        for c in chunks:
            text = c.read_text(encoding="utf-8", errors="replace")
            for m in re.findall(pat, text):
                key = m if isinstance(m, str) else m[0]
                hits.setdefault(key, set()).add(c.name)
        print(f"\n### {label}: {len(hits)} 命中")
        for k in sorted(hits)[:25]:
            print(f"  {k}   <- {','.join(sorted(hits[k])[:2])}")


if __name__ == "__main__":
    main()
