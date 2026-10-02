# -*- coding: utf-8 -*-
"""纯HTTP工程大脑KB直连验证——curl_cffi指纹+cookie+meta-token，零浏览器依赖。
验证通过后此模式即总包千问后端主引擎的调用姿势。"""
import json
import re
import sys
import time

from curl_cffi import requests as cr

COOKIE = "tid=c7baa307-f664-4e14-966d-0bafec9536e6; coverIds=[%228673582927558737920%22]; _c_WBKFRo=lZjsYTbaTUsnE9fQOpgVLDfL4g4AaZHKAtflnoa8; _nb_ioWEgULi=; uid=67c5bd8df6f09a0550659053; sid=2dece763dd4f40c6b92101cfeb7a06db; traceid=2945616a4d134244"
TOKEN = "wr8+pHu3KYryzz0O2MaBSNUZbVLjLUYC1FR4sKqSW0oY+a9+FzLxNoG/EHc90mkqSjGprczOhCjvKPq0tB3yo7sFMCUzldy9rni2zxmeMALR98Q5qn9qyrIfm4ZDyZtOEmQ15azWbC9qTE+okOCR0Q=="
TOPIC_ID = "8673582927558737920"


def kb_ask(question: str, model: str = "fast", timeout: int = 180):
    s = cr.Session(impersonate="chrome")
    body = {
        "model": model,
        "stream": True,
        "messages": [{
            "id": "temp-probe-001",
            "conversationId": "temp-probe-001",
            "role": "user",
            "content": question,
            "parentId": None,
        }],
        "topicId": TOPIC_ID,
        "scope": "knowledge",
        "include": None,
        "exclude": None,
        "searchFile": False,
        "metaso-pc": "pc",
        "token": TOKEN,
    }
    r = s.post(
        "https://metaso.cn/api/knowledge/chat",
        headers={"Content-Type": "application/json", "token": TOKEN, "Cookie": COOKIE},
        json=body,
        stream=True,
        timeout=timeout,
    )
    print(f"[ask] HTTP {r.status_code}")
    cid = None
    total = 0
    for chunk in r.iter_lines():
        if not chunk:
            continue
        line = chunk.decode("utf-8", errors="replace")
        total += len(line)
        if cid is None:
            m = re.search(r'"id"\s*:\s*"(\d{15,})"', line)
            if m:
                cid = m.group(1)
    print(f"[ask] stream bytes={total} cid={cid}")
    return cid


def kb_fulltext(cid: str):
    s = cr.Session(impersonate="chrome")
    r = s.get(
        f"https://metaso.cn/api/conversation/{cid}/branched-messages",
        headers={"token": TOKEN, "Cookie": COOKIE},
        timeout=60,
    )
    d = r.json()
    best = ""

    def ext(msg):
        nonlocal best
        if not msg or not msg.get("content") or not msg["content"].get("stages"):
            return
        stages = msg["content"]["stages"]
        if len(stages) > 1:
            last = stages[-1]
            t = "".join(tx.get("text", "") for tx in (last.get("texts") or []))
        else:
            t = "".join(
                tx.get("text", "")
                for st_ in stages
                for tx in (st_.get("texts") or [])
            )
        if len(t) > len(best):
            best = t

    for m in (d.get("data", {}).get("activePathMessages") or []):
        ext(m)
    return best


if __name__ == "__main__":
    q = sys.argv[1] if len(sys.argv) > 1 else "钢结构焊接质量控制要点，100字内简答"
    t0 = time.time()
    cid = kb_ask(q)
    if not cid:
        print("[FAIL] no cid — cookie/token 可能失效")
        sys.exit(1)
    # 轮询取全文（回答完成后 branched-messages 才有完整内容）
    answer = ""
    for i in range(24):
        time.sleep(5)
        answer = kb_fulltext(cid)
        if len(answer) > 100:
            break
    print(f"[done] {time.time()-t0:.0f}s len={len(answer)}")
    print("HEAD:", answer[:200])
    print("TAIL:", answer[-100:])
