# -*- coding: utf-8 -*-
"""metaso_api.py — 秘塔AI搜索(metaso.cn) 纯HTTP复刻件 (metaso-reverse 1024)
================================================================
替代 DrissionPage 9551 浏览器采集腿: 关键词 → AI综述(SSE流) + 来源清单, 零浏览器。

逆向结论 (证据: ../captures/):
  1. POST https://metaso.cn/api/search/chat  (SSE流, accept: text/event-stream)
     - 引擎: engineType="" → 全网; "scholar" → 学术(万方/DOI/期刊论文源)
     - token 字段 = SSR首页 <meta id="meta-token"> 服务端签发, 纯HTTP可取
     - cookie面: tid=客户端uuid4(已sha256实证) + _nb_ioWEgULi=""(空) + aliyungf_tc(home Set-Cookie)
       + JSESSIONID(GET /api/search-template 等预热链 Set-Cookie)
     - 缺 tid/token 的瘦请求 → SSE内 {"code":429} (bot评分), 补齐后全绿
  2. SSE事件: conversation_init/user_message_init/response_message_init/heartbeat
     + chat.completion.qa_with_agent delta{action,reasoning_content,content,citations[],
       total_cite_num} + data:[DONE]
  3. 开放API POST /api/v1/search 要key(errCode:2005) → 本件走匿名面, 不碰key墙
流控纪律 (scope.md): 搜索间隔≥5s, 单会话≤6次; 429如实上报不硬刚。
用法:
  py -3 metaso_api.py "中资EPC出海" [--scope scholar] [--json out.json] [--md out.md]
"""
import argparse, json, re, sys, time, uuid

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
try:
    from curl_cffi import requests as cr
except ImportError:
    sys.exit("need curl_cffi: pip install curl_cffi")

HOME = "https://metaso.cn/"
CHAT = "https://metaso.cn/api/search/chat"
H = {"accept": "text/event-stream", "content-type": "application/json",
     "metaso-pc": "pc", "origin": "https://metaso.cn", "referer": "https://metaso.cn/",
     "accept-language": "zh-CN,zh;q=0.9"}
SCOPES = {"web": "", "scholar": "scholar", "全网": "", "学术": "scholar"}


class MetasoClient:
    def __init__(self, timeout=120, verbose=True):
        self.s = cr.Session(impersonate="chrome")
        self.s.cookies.set("tid", str(uuid.uuid4()), domain=".metaso.cn", path="/")
        self.s.cookies.set("_nb_ioWEgULi", "", domain=".metaso.cn", path="/")
        self.timeout, self.v = timeout, verbose
        self.token = None
        self.searches = 0

    def _log(self, *a):
        if self.v:
            print("[metaso]", *a, file=sys.stderr)

    def warmup(self):
        """home → meta-token + aliyungf_tc; search-template → JSESSIONID (浏览器同构预热链)."""
        r = self.s.get(HOME, timeout=25, headers={"accept-language": "zh-CN,zh;q=0.9"})
        r.raise_for_status()
        m = re.search(r'<meta id="meta-token" content="([^"]+)"', r.text)
        if not m:
            raise RuntimeError("meta-token not found in SSR home (page shape changed?)")
        self.token = m.group(1)
        self.s.get("https://metaso.cn/api/search-template", timeout=20,
                   headers={"referer": HOME, "accept": "application/json"})
        self._log(f"warmup ok: token len={len(self.token)} cookies={sorted(self.s.cookies.keys())}")

    def _body(self, q, engine):
        msg = {"id": f"temp-{uuid.uuid4()}", "key": f"temp-{uuid.uuid4()}",
               "conversationId": f"temp-{uuid.uuid4()}", "role": "user",
               "content": q, "markdownContent": q, "engineType": engine,
               "filter": "all", "contentType": 0, "outputHtml": False,
               "mode": "detail", "model": "fast_thinking", "outputStyle": "正常"}
        return {"model": "fast_thinking", "stream": True, "messages": [msg],
                "engineType": engine, "mode": "detail", "filter": "all",
                "outputHtml": False, "outputStyle": "正常", "darkMode": False,
                "outputLanguage": "中文", "htmlNoDisplayEnable": True,
                "metaso-pc": "pc", "token": self.token}

    def search(self, q, scope="web", stream_cap=800000):
        """关键词 → {conversation_id, chat_url, reasoning, answer, citations, total_cite_num}.
        scope: 'web'|'scholar' (中文别名亦可). 429 → 如实抛 RuntimeError。"""
        if self.token is None:
            self.warmup()
        engine = SCOPES.get(scope, scope)
        r = self.s.post(CHAT, json=self._body(q, engine), headers=H,
                        timeout=self.timeout, stream=True)
        r.raise_for_status()
        buf, t0, out = [], time.time(), {"reasoning": "", "answer": "", "citations": [],
                                         "conversation_id": None, "total_cite_num": 0,
                                         "engine": engine, "query": q, "events": 0,
                                         "actions": [], "err": None}
        for line in r.iter_lines():
            ln = line if isinstance(line, str) else line.decode("utf-8", "replace")
            buf.append(ln)
            if time.time() - t0 > 110 or sum(map(len, buf)) > stream_cap:
                out["err"] = "stream_cutoff(110s/cap)"
                break
        raw = "\n".join(buf)
        out["stream_len"] = len(raw)
        for p in (e[5:] for e in raw.split("\n") if e.startswith("data:")):
            if p == "[DONE]":
                out["done"] = True
                continue
            try:
                j = json.loads(p)
            except Exception:
                continue
            if j.get("type") == "conversation_init":
                out["conversation_id"] = j["data"]["id"]
                continue
            if j.get("type") == "error" or j.get("code") == 429:
                out["err"] = f"SSE error: {p[:200]}"
                continue
            for ch in j.get("choices", []):
                d = ch.get("delta", {})
                if d.get("action"):
                    out["actions"].append(d["action"])
                out["reasoning"] += d.get("reasoning_content") or ""
                out["answer"] += d.get("content") or ""
                if d.get("citations"):
                    out["citations"] += d["citations"]
                if isinstance(d.get("total_cite_num"), int):
                    out["total_cite_num"] = d["total_cite_num"]
            out["events"] += 1
        out["chat_url"] = f"https://metaso.cn/chat/{out['conversation_id']}" if out["conversation_id"] else None
        out["sources"] = dedupe_sources(out["citations"])
        self.searches += 1
        if out["err"] and "429" in str(out["err"]):
            raise RuntimeError(f"metaso 429 rate-limited (anonymous face): {out['err']}")
        return out


def dedupe_sources(cites):
    seen, srcs = set(), []
    for c in cites:
        k = c.get("link") or c.get("title")
        if not k or k in seen:
            continue
        seen.add(k)
        srcs.append({"title": c.get("orig_title") or c.get("title") or "",
                     "link": c.get("link") or "",
                     "site": (c.get("site") or [""])[0] if isinstance(c.get("site"), list) else c.get("site"),
                     "authors": c.get("authors") or [],
                     "institution": c.get("institution"),
                     "date": c.get("publish_date_str") or c.get("date") or "",
                     "type": c.get("article_type") or c.get("type") or "",
                     "snippet": (c.get("snippet") or "")[:200]})
    return srcs


def to_md(res):
    q, scope = res["query"], res["engine"] or "web"
    scope_cn = "学术" if scope == "scholar" else "全网"
    lines = [f"# 秘塔AI搜索({scope_cn})·{q}", "",
             f"> 来源: 秘塔AI搜索 metaso.cn ({res['chat_url']})",
             f"> engine: metaso({scope}) | 纯HTTP复刻件 metaso_api.py | 匿名免登录", "",
             "## AI综述答案 (metaso生成, 含[[N]]来源引用)", "", res["answer"], "",
             f"## 来源清单 (去重后{len(res['sources'])}条/流内引用{res['total_cite_num']}条)", ""]
    for i, s in enumerate(res["sources"], 1):
        au = f"; {', '.join(s['authors'][:3])}" if s["authors"] else ""
        inst = f" | {s['institution']}" if s["institution"] else ""
        lines.append(f"{i}. [{s['title']}]({s['link']}) — {s['site']} | {s['date']}{au}{inst}")
    return "\n".join(lines)


def main():
    ap = argparse.ArgumentParser(description="metaso.cn 纯HTTP AI搜索复刻件")
    ap.add_argument("query")
    ap.add_argument("--scope", default="web", help="web|scholar (全网|学术)")
    ap.add_argument("--json", dest="jout", help="result json path")
    ap.add_argument("--md", dest="mdout", help="markdown path")
    ap.add_argument("--quiet", action="store_true")
    a = ap.parse_args()
    c = MetasoClient(verbose=not a.quiet)
    res = c.search(a.query, scope=a.scope)
    ok = len(res["answer"]) > 200 and res["sources"]
    if a.jout:
        slim = {k: v for k, v in res.items() if k != "citations"}
        open(a.jout, "w", encoding="utf-8").write(json.dumps(slim, ensure_ascii=False, indent=1))
    if a.mdout:
        open(a.mdout, "w", encoding="utf-8").write(to_md(res))
    print(f"answer={len(res['answer'])}字 sources={len(res['sources'])} "
          f"cite_num={res['total_cite_num']} chat={res['chat_url']} err={res['err']}")
    if not a.quiet:
        print("\n--- 答案头300字 ---\n" + res["answer"][:300])
        print("--- 来源前5 ---")
        for s in res["sources"][:5]:
            print(f"  - {s['title'][:50]} | {s['link'][:70]}")
    sys.exit(0 if ok else 2)


if __name__ == "__main__":
    main()
