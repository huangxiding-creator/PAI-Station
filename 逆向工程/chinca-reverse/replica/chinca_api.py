# -*- coding: utf-8 -*-
"""
chinca_api.py — 中国对外承包工程商会 (www.chinca.org) 纯 HTTP 客户端（复刻件）

破解 Aliyun WAF「acw_sc__v2」JS 挑战（页面自称加速乐体系同源 cookie 名）：
  1) GET 任意页 → 200 挑战页（textarea#renderData 内 var arg1='50HEX' + 自校验混淆 VM）
  2) 本地以 Node vm 沙箱原样执行该挑战 JS（关键: 沙箱不注入宿主 Function/Error/RegExp 等，
     让 vm 用自身 intrinsics —— realm 一致后分支与真实 Chrome 完全一致），
     捕获 reload(M) 写入的 acw_sc__v2 cookie
  3) 带 acw_tc + acw_sc__v2 重放 → 真实页面
全程只读 GET；无浏览器；挑战求解完全本地。

用法:
  python chinca_api.py --selftest          # 5 次独立会话全链贯通实测
  python chinca_api.py --list notice       # 栏目列表
  python chinca_api.py --list notice -p 2  # 翻页
  python chinca_api.py --article /CICA/info/26102016045611
"""
import argparse
import io
import json
import os
import re
import subprocess
import sys
import tempfile
import time

import requests

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
_HERE = os.path.dirname(os.path.abspath(__file__))
SOLVER_JS = os.path.join(_HERE, "solver.js")

BASE = "https://www.chinca.org"
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36")

COLUMNS = {
    "notice":   "/CICA/Notice/List",                  # 通知公告
    "industry": "/CICA/Industrynews/List",            # 行业新闻
    "member":   "/CICA/Memberdynamics/List",          # 会员动态
    "coc":      "/CICA/COCNews/List",                 # 商会新闻
    "intl":     "/CICA/InternationalContractors/List",  # 国际承包商(ENR榜讯息在此)
    "stats":    "/CICA/StatisticalAnalysis/List/Sa",  # 统计分析(行业数据)
    "research": "/CICA/reserrch/List",                # 研究(国际工程观察等)
    "project":  "/CICA/Projectinfo/List",             # 项目信息
}


class GateError(RuntimeError):
    pass


class SolverError(RuntimeError):
    pass


def solve_challenge_html(html_text, timeout=90):
    """把挑战页交给本地 Node 沙箱执行（原样运行站点自己的挑战 JS），返回 (arg1, acw_sc__v2)。"""
    tmp = tempfile.NamedTemporaryFile("w", suffix=".html", delete=False, encoding="utf-8")
    try:
        tmp.write(html_text)
        tmp.close()
        p = subprocess.run(["node", SOLVER_JS, tmp.name],
                           capture_output=True, text=True, timeout=timeout, cwd=_HERE)
        if p.returncode != 0:
            raise SolverError("solver exit %d: %s" % (p.returncode, (p.stderr or "")[:300]))
        out = json.loads(p.stdout.strip().splitlines()[-1])
        if not out.get("acw_sc__v2"):
            raise SolverError("solver produced no cookie: %s" % json.dumps(out)[:300])
        return out.get("arg1"), out["acw_sc__v2"]
    finally:
        try:
            os.unlink(tmp.name)
        except OSError:
            pass


class ChincaClient:
    def __init__(self, base=BASE, timeout=30):
        self.base = base
        self.timeout = timeout
        self.s = requests.Session()
        self.s.headers.update({
            "User-Agent": UA,
            "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
            "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8",
            "Accept-Encoding": "gzip, deflate, br",
            "Connection": "keep-alive",
            "Upgrade-Insecure-Requests": "1",
        })
        self.solve_count = 0

    @staticmethod
    def _is_challenge(text):
        return ("renderData" in text) and ("acw_sc__v2" in text)

    def get(self, url, params=None, max_solve=2):
        """GET with auto gate-passing. 相对路径自动拼 BASE。"""
        if url.startswith("/"):
            url = self.base + url
        r = self.s.get(url, params=params, timeout=self.timeout)
        for _ in range(max_solve):
            if not self._is_challenge(r.text):
                return r
            arg1, acw = solve_challenge_html(r.text)
            self.s.cookies.set("acw_sc__v2", acw, domain=".chinca.org", path="/")
            self.solve_count += 1
            r = self.s.get(url, params=params, timeout=self.timeout)
        if self._is_challenge(r.text):
            raise GateError("gate not passed after %d solves (arg1=%s)" % (max_solve, arg1))
        return r

    # ---------- 栏目列表 ----------
    def list_column(self, column=None, path=None, page=1, limit=None):
        """栏目列表 → [{'title','url','date'}]. column 为 COLUMNS 键或直接给 path。"""
        if path is None:
            if column not in COLUMNS:
                raise ValueError("unknown column %r; known: %s" % (column, ",".join(COLUMNS)))
            path = COLUMNS[column]
        params = {"p": page} if page and page > 1 else None
        r = self.get(path, params=params)
        html = r.text
        # 契约: <a href="/CICA/info/<id>" title="标题">  + 相邻日期 20xx-xx-xx
        items = []
        seen = set()
        for m in re.finditer(
                r'<a[^>]+href="(/CICA/info/\d+)"[^>]*?(?:title="([^"]*)")?[^>]*>(.*?)</a>',
                html, re.S):
            url, title_attr, inner = m.group(1), m.group(2), m.group(3)
            title = (title_attr or re.sub(r"<[^>]+>", "", inner)).strip()
            # 截断列表项内联摘要噪音
            title = re.split(r"发布时间|阅读次数|\.{4,}|…", title)[0].strip()
            title = re.sub(r"\s+", " ", title).strip()
            if not title or (url, title) in seen:
                continue
            seen.add((url, title))
            # 就近日期: 先看锚点后 240 字符, 再看内联文本自身
            tail = html[m.end():m.end() + 240]
            dm = re.search(r"(20\d{2}-\d{2}-\d{2})", tail) or re.search(r"(20\d{2}-\d{2}-\d{2})", inner)
            items.append({"title": title, "url": url, "date": dm.group(1) if dm else None})
        if limit:
            items = items[:limit]
        # 分页信息
        pages = set(int(x) for x in re.findall(r'[?&]p=(\d+)', html))
        return items, (max(pages) if pages else 1)

    # ---------- 文章详情 ----------
    def get_article(self, url):
        r = self.get(url)
        html = r.text
        title = None
        m = re.search(r'<h2[^>]*class="[^"]*newstit[^"]*"[^>]*>(.*?)</h2>', html, re.S)
        if not m:
            m = re.search(r"<title>(.*?)</title>", html, re.S)
        if m:
            title = re.sub(r"\s+", " ", re.sub(r"<[^>]+>", "", m.group(1))).strip()
        date = None
        dm = re.search(r'发布时间[：:]\s*(20\d{2}-\d{2}-\d{2})', html)
        if dm:
            date = dm.group(1)
        # 正文: releasetime 容器之后的 <p> 连续块
        content = ""
        i = html.find('class="releasetime"')
        if i > -1:
            window = html[i:i + 30000]
            paras = re.findall(r"<p[^>]*>(.*?)</p>", window, re.S)
            keep = []
            for p in paras:
                txt = re.sub(r"<[^>]+>", "", p)
                txt = re.sub(r"&nbsp;", " ", txt).strip()
                txt = re.sub(r"\s+", " ", txt)
                if not txt:
                    continue
                if re.match(r"^(var |with\(|http)", txt):  # 页脚脚本噪音
                    break
                keep.append(txt)
            content = "\n".join(keep)
        return {"title": title, "date": date, "url": url if url.startswith("http") else BASE + url,
                "content": content, "content_len": len(content)}


# ---------- 自测 ----------
def selftest(rounds=5):
    # 注意: stdout 的 UTF-8 包装只由 main() 做一次
    results = []
    for i in range(rounds):
        t0 = time.time()
        rec = {"round": i + 1}
        try:
            c = ChincaClient()
            # 1) 闸门: 首页
            r = c.get("/")
            rec["gate"] = ("renderData" not in r.text) and r.status_code == 200
            rec["home_len"] = len(r.text)
            # 2) 栏目×2
            items_a, _ = c.list_column("notice")
            items_b, _ = c.list_column("stats")
            rec["notice_items"] = len(items_a)
            rec["stats_items"] = len(items_b)
            # 3) 文章详情
            art_url = None
            for it in items_a:
                if it["url"].startswith("/CICA/info/"):
                    art_url = it["url"]
                    break
            rec["article_url"] = art_url
            if art_url:
                art = c.get_article(art_url)
                rec["article_title"] = (art["title"] or "")[:40]
                rec["article_content_len"] = art["content_len"]
            rec["solves"] = c.solve_count
            rec["ok"] = bool(rec.get("gate") and rec.get("notice_items", 0) > 0
                             and rec.get("stats_items", 0) > 0
                             and rec.get("article_content_len", 0) > 50)
        except Exception as e:
            rec["ok"] = False
            rec["error"] = repr(e)[:200]
        rec["secs"] = round(time.time() - t0, 1)
        results.append(rec)
        print(json.dumps(rec, ensure_ascii=False))
        time.sleep(1.5)
    passed = sum(1 for r in results if r.get("ok"))
    print(json.dumps({"selftest": "PASS %d/%d" % (passed, rounds)}, ensure_ascii=False))
    return results


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--selftest", action="store_true")
    ap.add_argument("--list", dest="column")
    ap.add_argument("-p", "--page", type=int, default=1)
    ap.add_argument("--article")
    ap.add_argument("--limit", type=int, default=None)
    args = ap.parse_args()
    try:
        sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
    except Exception:
        pass
    if args.selftest:
        selftest()
        return
    c = ChincaClient()
    if args.column:
        items, maxpage = c.list_column(args.column, page=args.page, limit=args.limit)
        print(json.dumps({"column": args.column, "page": args.page, "maxpage": maxpage,
                          "count": len(items), "items": items}, ensure_ascii=False, indent=1))
    elif args.article:
        print(json.dumps(c.get_article(args.article), ensure_ascii=False, indent=1))


if __name__ == "__main__":
    main()
