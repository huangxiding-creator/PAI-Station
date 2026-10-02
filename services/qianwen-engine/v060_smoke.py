# -*- coding: utf-8 -*-
"""v0.6.0 生产 smoke：追问 / digest / 海报 三腿实弹（真实智谱 + 真实 wxacode + 真实 Pillow）。"""
import base64
import io
import json
import sys
import time
import urllib.request

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8")
sys.path.insert(0, r"E:\AI-Station\services\qianwen-engine")
from qianwen_engine import wechat  # noqa: E402

BASE = "http://47.120.43.20:8869"
TOKEN = wechat.issue_token("smoke-v060-0930")


def call(method, path, body=None):
    req = urllib.request.Request(
        BASE + path, method=method,
        data=json.dumps(body).encode() if body is not None else None,
        headers={"Content-Type": "application/json", "Authorization": "Bearer " + TOKEN})
    try:
        with urllib.request.urlopen(req, timeout=60) as r:
            return r.status, json.loads(r.read().decode())
    except urllib.error.HTTPError as exc:
        return exc.code, json.loads(exc.read().decode() or "{}")


def main():
    # 选一篇锅圈答案做靶（全员可见）
    code, pot = call("GET", "/api/pot/list")
    assert code == 200 and pot["items"], f"pot/list {code}"
    aid = pot["items"][0]["id"]
    print(f"TARGET aid={aid} q={pot['items'][0]['question'][:30]}")

    # 腿1：digest（真实智谱）
    t0 = time.time()
    code, d = call("GET", f"/api/answer/{aid}/digest")
    dt = time.time() - t0
    assert code == 200, f"digest {code} {d}"
    print(f"DIGEST {dt:.1f}s cached={d['cached']} tldr={len(d['tldr'])} related={len(d['related'])}")
    for x in d["tldr"]:
        print("  -", x)

    # 腿2：追问（真实智谱接地）
    t0 = time.time()
    code, f = call("POST", f"/api/answer/{aid}/followup",
                   {"question": "这条结论在结算实操里第一步该做什么"})
    assert code == 200, f"followup {code} {f}"
    fid = f["id"]
    for _ in range(30):
        time.sleep(1.5)
        code, fl = call("GET", f"/api/answer/{aid}/followups")
        item = next((x for x in fl["items"] if x["id"] == fid), None)
        if item and item["status"] != "pending":
            break
    dt = time.time() - t0
    assert item and item["status"] == "ready", f"followup 终态异常: {item}"
    print(f"FOLLOWUP {dt:.1f}s len={len(item['answer'])}")
    print("  head:", item["answer"][:80].replace("\n", " "))

    # 腿3：海报（真实 wxacode + 真实 Pillow）
    t0 = time.time()
    code, p = call("GET", f"/api/answer/{aid}/poster")
    dt = time.time() - t0
    assert code == 200, f"poster {code} {p}"
    png = base64.b64decode(p["b64"])
    assert png[:4] == b"\x89PNG", "海报非 PNG"
    with open(r"E:\AI-Station\WeAppForge\work\poster_smoke_v060.png", "wb") as fh:
        fh.write(png)
    print(f"POSTER {dt:.1f}s png={len(png)}B → poster_smoke_v060.png")

    # 二次海报=缓存（应秒回）
    t0 = time.time()
    code, p2 = call("GET", f"/api/answer/{aid}/poster")
    assert code == 200 and p2["b64"] == p["b64"], "海报缓存失效"
    print(f"POSTER-CACHED {time.time() - t0:.2f}s")
    print("SMOKE ALL GREEN")


if __name__ == "__main__":
    main()
