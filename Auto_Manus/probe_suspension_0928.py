# -*- coding: utf-8 -*-
"""封号波及面 API 无损摸底 — 5号样本只读 GetAvailableCredits (诊断非对抗).

选样: 0928晨成功派发号×2 (最新鲜) + 累计派发Top3重度号 (最可能被停).
红线: token 内容绝不打印/落日志; 输出仅 邮箱+HTTP状态+积分/错误白名单字段.
节奏: 号间 60s; 走 manus_api.api_call(page=None) 纯 urllib 直连 (不动网).
"""
import collections
import io
import json
import sys
import time
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")
ROOT = Path(__file__).parent
sys.path.insert(0, str(ROOT))
import manus_api  # noqa: E402

rows = []
for ln in (ROOT / "data" / "epc50_corps_log.jsonl").read_text(
        encoding="utf-8").splitlines():
    if ln.strip():
        rows.append(json.loads(ln))

fresh, seen = [], set()
for r in rows:
    if r["ts"] >= "2026-09-28" and r["email"] not in seen:
        fresh.append(r["email"])
        seen.add(r["email"])
tot = collections.Counter(r["email"] for r in rows if r["ts"] < "2026-09-27")
heavy = [e for e, _ in tot.most_common(3)]
sample = fresh[:2] + heavy[:3]
print(f"样本 fresh×{len(fresh[:2])}: {fresh[:2]}", flush=True)
print(f"样本 heavy×{len(heavy[:3])}: {heavy[:3]}", flush=True)

for i, email in enumerate(sample):
    if i:
        time.sleep(60)
    f = ROOT / "data" / "tokens" / (email.replace("@", "_at_") + ".json")
    if not f.exists():
        print(f"{email}: 无token文件(跳过)", flush=True)
        continue
    tok = json.loads(f.read_text(encoding="utf-8"))
    try:
        st, text = manus_api.api_call(
            None, "POST", "/user.v1.UserService/GetAvailableCredits",
            tok, body={})
        try:
            d = json.loads(text)
            keep = {k: d.get(k) for k in ("totalCredits", "refreshCredits",
                                          "code", "message") if k in d}
            print(f"{email}: HTTP {st} {json.dumps(keep, ensure_ascii=False)}",
                  flush=True)
        except Exception:
            print(f"{email}: HTTP {st} {str(text)[:150]}", flush=True)
    except Exception as e:
        print(f"{email}: {type(e).__name__} {str(e)[:80]}", flush=True)

print("摸底完成", flush=True)
