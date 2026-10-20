# -*- coding: utf-8 -*-
"""EPC49 giiisp 中文检索一发验证 v2 — 挖透 A 端点 data 结构 + token 反哺 B 端点.

v1 发现: keyless arxivByTitle 中文 HTTP 200, 响应含 code/msg/data/token/total;
B (OA 正确体) 仍 400。v2: ① 解析 A 的 data 真实结构与命中; ② 若响应带 token,
用该 token 作 Bearer 打 B, 判 token 是否解锁中文 OA。token 值绝不打印 (只报长度)。
"""
import io
import json
import sys
import urllib.request

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")

BASE = "https://giiisp.com"
UA = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)",
      "Content-Type": "application/json;charset=UTF-8"}
KW = "四川电力设计咨询 EPC 总承包"
KW2 = "电力工程 EPC 总承包 项目管理"


def post(url, body, headers=None, timeout=25):
    data = json.dumps(body, ensure_ascii=False).encode("utf-8")
    req = urllib.request.Request(url, data=data,
                                 headers={**UA, **(headers or {})},
                                 method="POST")
    try:
        with urllib.request.urlopen(req, timeout=timeout) as r:
            return r.status, r.read().decode("utf-8", errors="replace")
    except urllib.error.HTTPError as e:
        return e.code, e.read().decode("utf-8", errors="replace")[:300]
    except Exception as e:
        return -1, repr(e)[:200]


def walk_titles(node, out, depth=0):
    """递归找 title 字段 (结构未知)."""
    if depth > 6 or len(out) >= 5:
        return
    if isinstance(node, dict):
        t = node.get("title") or node.get("paperTitle") or node.get("name")
        if isinstance(t, str) and len(t) > 4:
            out.append(t[:60])
        for v in node.values():
            walk_titles(v, out, depth + 1)
    elif isinstance(node, list):
        for v in node[:8]:
            walk_titles(v, out, depth + 1)


def main() -> int:
    print("[giiisp-zh-v2] 启动", flush=True)
    # A: 中文 key (v1 已 200)
    ca, ta = post(f"{BASE}/first/paper/searchArxivByTitle",
                  {"key": KW, "pageNum": 1, "pageSize": 5})
    print(f"[A] HTTP {ca}", flush=True)
    tok = ""
    if ca == 200:
        try:
            j = json.loads(ta)
            print(f"[A] code={j.get('code')} msg={str(j.get('msg'))[:60]} "
                  f"total={j.get('total')} token_len={len(str(j.get('token') or ''))}",
                  flush=True)
            titles = []
            walk_titles(j.get("data"), titles)
            print(f"[A] 命中标题: {titles[:5]}", flush=True)
            tok = str(j.get("token") or "")
        except Exception as e:
            print(f"[A] 解析失败: {e} | 原文头: {ta[:200]}", flush=True)
    # B: keyless 正确体 (v1 400, 复核)
    cb, tb = post(f"{BASE}/first/oaPaper/searchArticlesByQuery1",
                  {"titleAndAbs": [KW2], "pageNum": 1, "pageSize": 5})
    print(f"[B-keyless] HTTP {cb} {tb[:120]}", flush=True)
    # C: A 的 token 作 Bearer 打 B
    if tok:
        cc, tc = post(f"{BASE}/first/oaPaper/searchArticlesByQuery1",
                      {"titleAndAbs": [KW2], "pageNum": 1, "pageSize": 5},
                      headers={"Authorization": "Bearer " + tok})
        print(f"[C-Bearer(A-token)] HTTP {cc} {tc[:160]}", flush=True)
        if cc == 200:
            titles = []
            try:
                walk_titles(json.loads(tc).get("data"), titles)
            except Exception:
                pass
            print(f"[C] 命中标题: {titles[:5]}", flush=True)
    else:
        print("[C] A 未带 token, 跳过", flush=True)
    print("[giiisp-zh-v2] 完", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
