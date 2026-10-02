# -*- coding: utf-8 -*-
"""单发实弹探针（反驳复现用，仅 1 问 ≈3 点，免费网页池，引擎同款调用姿势）。

目的：判定声称缺陷的核心前提——
  「_fulltext_get 在生成中就返回到目前为止的部分文本（≥100 字）」
做法：POST /api/knowledge/chat (SSE) 后，在流仍在吐增量的同时，每 ~2s GET 一次
  branched-messages，记录每条消息的 stage 数、各 stage 文本长度、最长 stage 开头、
  与 SSE 已收部分正文的匹配关系；流结束后再取一次终态。
零敏感信息打印（不打印 cookie/token）；总时长硬上限 90s。"""
import io
import json
import re
import sys
import time
import uuid

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\services\qianwen-engine")

from curl_cffi import requests as cr  # noqa: E402

from qianwen_engine import config, session as kb_session  # noqa: E402
from qianwen_engine import metaso_kb  # noqa: E402

QUESTION = "EPC固定总价合同下设计变更怎么计价调价"
HARD_DEADLINE = 90.0
PROBE_EVERY = 2.0

_DELTA_RE = metaso_kb._DELTA_CONTENT_RE
_decode = metaso_kb._decode_json_str


def chat_post(sess):
    tmp = "temp-" + uuid.uuid4().hex[:12]
    body = {
        "model": "fast", "stream": True,
        "messages": [{"id": tmp, "conversationId": tmp, "role": "user",
                      "content": QUESTION, "parentId": None}],
        "topicId": config.KB_TOPIC_ID, "scope": "knowledge",
        "include": None, "exclude": None, "searchFile": False,
        "metaso-pc": "pc", "token": sess["token"],
    }
    return cr.post(config.KB_CHAT_URL,
                   headers={"Content-Type": "application/json", "token": sess["token"],
                            "Cookie": sess["cookie"]},
                   json=body, impersonate="chrome", stream=True,
                   timeout=config.KB_ASK_TIMEOUT_SEC)


def fulltext_snapshot(sess, cid):
    """返回结构化摘要（不打印全文，防敏感/防刷屏）：每消息 role/n_stages/各stage长度/最长stage头40字。"""
    try:
        r = cr.get(config.KB_CONV_URL.format(cid=cid),
                   headers={"token": sess["token"], "Cookie": sess["cookie"]},
                   impersonate="chrome", timeout=20)
    except Exception as exc:  # noqa: BLE001
        return {"http": f"EXC:{type(exc).__name__}"}
    if r.status_code != 200:
        return {"http": r.status_code}
    try:
        d = r.json()
    except Exception:  # noqa: BLE001
        return {"http": 200, "json": "parse_fail"}
    msgs = d.get("data", {}).get("activePathMessages") or []
    out = {"http": 200, "n_msgs": len(msgs), "msgs": []}
    for m in msgs:
        stages = ((m or {}).get("content") or {}).get("stages") or []
        lens, texts = [], []
        for st_ in stages:
            t = "".join(tx.get("text", "") for tx in (st_.get("texts") or []))
            lens.append(len(t))
            texts.append(t)
        best = max(texts, key=len) if texts else ""
        out["msgs"].append({
            "role": (m or {}).get("role", "?"),
            "n_stages": len(stages),
            "stage_lens": lens,
            "best_len": len(best),
            "best_head": best[:40].replace("\n", " "),
        })
    return out


def main():
    t0 = time.time()
    sess = kb_session.get_session()
    r = chat_post(sess)
    print(f"[chat] HTTP {r.status_code}")
    if r.status_code in (401, 403):
        print("[chat] 会话失效 → 在线刷新一次（镜像 ask() 行为）")
        kb_session.invalidate()
        sess = kb_session.get_session(force_refresh=True)
        r = chat_post(sess)
        print(f"[chat retry] HTTP {r.status_code}")
        if r.status_code != 200:
            print("PROBE ABORT: 会话不可用")
            return 2
    elif r.status_code != 200:
        print("PROBE ABORT: chat 非 200")
        return 2

    cid = ""
    buf = []
    chars = 0
    last_probe_t = 0.0
    probes = []
    stream_done = False
    try:
        for chunk in r.iter_lines():
            if not chunk:
                continue
            if time.time() - t0 > HARD_DEADLINE:
                print("[stream] 硬上限到点，停止读流")
                break
            line = chunk.decode("utf-8", errors="replace")
            if not cid:
                m = re.search(r'"type"\s*:\s*"conversation_init"', line)
                if m:
                    m2 = re.search(r'"id"\s*:\s*"(\d{10,})"', line)
                    if m2:
                        cid = m2.group(1)
                        print(f"[stream] t+{time.time()-t0:.1f}s cid={cid}")
                else:
                    m3 = re.search(r'"id"\s*:\s*"(\d{15,})"', line)
                    if m3:
                        cid = m3.group(1)
                        print(f"[stream] t+{time.time()-t0:.1f}s cid={cid}")
                continue
            for m in _DELTA_RE.finditer(line):
                piece = _decode(m.group(1))
                if piece:
                    buf.append(piece)
                    chars += len(piece)
            if '"type":"chunk"' in line or '"type": "chunk"' in line:
                stream_done = True
            # 生成中并行探针：流活着 + 距上次探针 ≥2s
            if cid and not stream_done and time.time() - last_probe_t >= PROBE_EVERY:
                last_probe_t = time.time()
                snap = fulltext_snapshot(sess, cid)
                probes.append((round(time.time() - t0, 1), chars, snap))
    except Exception as exc:  # noqa: BLE001
        print(f"[stream] 中断: {type(exc).__name__}")
    finally:
        try:
            r.close()
        except Exception:  # noqa: BLE001
            pass

    print(f"[stream] done={stream_done} chars={chars}")
    if not cid:
        print("PROBE ABORT: 无 cid")
        return 2

    partial = "".join(buf)
    print("\n===== 生成中探针时间线（t=自POST起秒, sse_chars=流已收字数）=====")
    for t, c, snap in probes:
        print(f"t+{t:5.1f}s sse_chars={c:5d}  http={snap.get('http')} n_msgs={snap.get('n_msgs')}")
        for i, msum in enumerate(snap.get("msgs") or []):
            match = ""
            if partial and msum["best_len"] > 0:
                head20 = partial[:20]
                if msum["best_head"].startswith(head20[:10]) or head20.startswith(msum["best_head"][:10]):
                    match = " <== 与SSE部分正文同源(答案正文)"
            print(f"    msg[{i}] role={msum['role']} n_stages={msum['n_stages']}"
                  f" stage_lens={msum['stage_lens']} best_len={msum['best_len']}{match}")
            print(f"           best_head={msum['best_head']!r}")

    # 终态（流结束后）
    time.sleep(1.0)
    snap = fulltext_snapshot(sess, cid)
    print("\n===== 终态（流已结束）=====")
    print(f"http={snap.get('http')} n_msgs={snap.get('n_msgs')}")
    for i, msum in enumerate(snap.get("msgs") or []):
        print(f"    msg[{i}] role={msum['role']} n_stages={msum['n_stages']}"
              f" stage_lens={msum['stage_lens']} best_len={msum['best_len']}")
        print(f"           best_head={msum['best_head']!r}")

    # 判据汇总
    print("\n===== 判据 =====")
    mid_ge100 = [p for p in probes
                 if any(ms["best_len"] >= 100 for ms in (p[2].get("msgs") or []))]
    mid_answer_like = []
    for t, c, p in probes:
        for ms in (p.get("msgs") or []):
            if partial and ms["best_len"] >= 20:
                if ms["best_head"].startswith(partial[:10]) or partial.startswith(ms["best_head"][:10]):
                    mid_answer_like.append((t, c, ms["best_len"]))
    print(f"SSE 终稿字数           : {len(partial)}")
    print(f"生成中(流活着时)探针次数: {len(probes)}")
    print(f"生成中出现≥100字stage的探针: {len(mid_ge100)} 次")
    if mid_ge100:
        for t, c, p in mid_ge100:
            print(f"    t+{t}s sse_chars={c} stage_lens={[ms['stage_lens'] for ms in p['msgs']]}")
    print(f"生成中最长stage与SSE正文同源(=部分答案)的探针: {len(mid_answer_like)} 次 {mid_answer_like[:5]}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
