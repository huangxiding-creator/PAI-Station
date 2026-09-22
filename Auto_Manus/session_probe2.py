# -*- coding: utf-8 -*-
"""二探 — 定向抓 4 关键 API 的 request+response 全文, 摸清契约与分页.

getSessionV2 (消息流) / getSessionOutline (规划大纲) /
getSessionFilesV2 (文件清单) / GetAvailableCredits (积分).
用法: python session_probe2.py [账号序号] [会话序号]
"""
import sys
import time
import json
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import manus_lib as lib

OUT = Path("probe_out")
OUT.mkdir(exist_ok=True)

TARGETS = (
    "api/chat/getSessionV2",
    "api/chat/getSessionOutline",
    "api/chat/getSessionFilesV2",
    "GetAvailableCredits",
)


def snap(packet, tag: str):
    rec = {"url": packet.url, "method": packet.request.method}
    try:
        rec["request_body"] = packet.request.postData
    except Exception:
        rec["request_body"] = None
    try:
        body = packet.response.body
        rec["response_len"] = len(json.dumps(body, ensure_ascii=False)) \
            if body is not None else 0
        rec["response"] = body
    except Exception as e:
        rec["response"] = f"<err {type(e).__name__}>"
    path = OUT / f"probe2_{tag}_{int(time.time())}.json"
    path.write_text(json.dumps(rec, ensure_ascii=False, indent=1,
                               default=str)[:2000000], encoding="utf-8")
    print(f"[probe2] {tag}: {rec['url'][:80]} "
          f"req={str(rec['request_body'])[:100]} resp_len={rec.get('response_len')}",
          flush=True)


def main():
    idx = int(sys.argv[1]) if len(sys.argv) > 1 else 1
    sess_idx = int(sys.argv[2]) if len(sys.argv) > 2 else 1
    email, password = lib.load_accounts("账号列表 - 调试.txt")[idx - 1]
    print(f"[probe2] 账号#{idx}: {email}", flush=True)

    page = lib.make_page()
    sessions = lib.login(page, email, password)
    if not sessions:
        print("[probe2] 登录失败/无会话", flush=True)
        return 3
    sess = sessions[sess_idx - 1]
    uid = sess.get("uid")
    print(f"[probe2] 会话#{sess_idx}: {uid} "
          f"{str(sess.get('title',''))[:40]}", flush=True)

    hits = set()
    page.listen.start(list(TARGETS))
    page.get(f"https://manus.im/app/{uid}")
    deadline = time.time() + 30
    while time.time() < deadline and len(hits) < len(TARGETS):
        try:
            packet = page.listen.wait(timeout=2)
        except Exception:
            continue
        if not packet or packet.is_failed:
            continue
        for t in TARGETS:
            if t in packet.url and t not in hits:
                hits.add(t)
                snap(packet, t.replace("/", "_"))
    page.listen.stop()
    # GetAvailableCredits 若未触发: 回 app 主页再等一轮
    if "GetAvailableCredits" not in hits:
        page.listen.start("GetAvailableCredits")
        page.get(lib.APP_URL)
        deadline = time.time() + 15
        while time.time() < deadline and "GetAvailableCredits" not in hits:
            try:
                packet = page.listen.wait(timeout=2)
            except Exception:
                continue
            if packet and not packet.is_failed:
                hits.add("GetAvailableCredits")
                snap(packet, "GetAvailableCredits")
        page.listen.stop()
    print(f"[probe2] 命中 {len(hits)}/{len(TARGETS)}: {sorted(hits)}", flush=True)
    missing = [t for t in TARGETS if t not in hits]
    if missing:
        print(f"[probe2] 未命中: {missing}", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
