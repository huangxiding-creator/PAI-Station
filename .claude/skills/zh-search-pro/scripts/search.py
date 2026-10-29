# -*- coding: utf-8 -*-
"""zh-search-pro 本机化检索 — 免key多引擎中文搜索清单.

上游: OpenClaw skills careytian-ai/zh-search-pro (MIT-0)
本机化实锤病理 (1004 冒烟四轮锁定):
  - 必应中国: 无 Accept-Language/Referer 头 → 诱饵结果(标题对词面但结果区
    换成无关内容); 实体名查询可靠, 概念长词偶被降级到宽泛词面 → 头必带,
    实体词优先
  - 百度桌面端: 无 JS 的请求一律 tuxing 验证码墙 → 走 m.baidu.com WAP 面
    (无墙, 但页面变体轮盘 → 多模式解析)
  - 搜狗微信: href 在 uigs 前(属性序), 结果链为 /link?url= 相对链须绝对化
  - 360: <h3   class="res-title"> 有多空格; 真实URL在 data-mdurl 属性
  - 头条/知乎: 结果 JS 注水, SSR 面解析弱 → 如实报0, 深查走 webReader
零账号: 全引擎匿名, 账号安全四件套天然满足; curl_cffi impersonate=chrome
免疫 TLS 指纹 WAF (同 metaso-tls-fingerprint-waf 病理)。

用法:
  python search.py "查询词" [-e bing_cn,sogou_weixin,so360] [--top 8] [--json] [--all]
                [--bing-filter last7] [--proxy 127.0.0.1:7890]
"""
import argparse
import html as html_mod
import json
import re
import sys
import time
from pathlib import Path
from urllib.parse import quote_plus, urljoin

from curl_cffi import requests

BASE_HEADERS = {
    "Accept-Language": "zh-CN,zh;q=0.9",
    "Referer": "https://cn.bing.com/",
}
ENGINES = {
    # key: (url模板, 解析器名, 基址[相对链绝对化用])
    "baidu":       ("https://m.baidu.com/s?word={q}{extra}", "baidu_wap", "https://m.baidu.com/"),
    "bing_cn":     ("https://cn.bing.com/search?q={q}{extra}", "bing", "https://cn.bing.com/"),
    "sogou_weixin": ("https://weixin.sogou.com/weixin?type=2&query={q}", "sogou_wx", "https://weixin.sogou.com/"),
    "so360":       ("https://www.so.com/s?q={q}", "so360", "https://www.so.com/"),
    "zhihu":       ("https://www.zhihu.com/search?q={q}&type=content", "generic", "https://www.zhihu.com/"),
    "toutiao":     ("https://so.toutiao.com/search?keyword={q}", "generic", "https://so.toutiao.com/"),
    "duckduckgo":  ("https://duckduckgo.com/html/?q={q}", "ddg", "https://duckduckgo.com/"),
}
DEFAULT_ENGINES = ["bing_cn", "sogou_weixin", "so360", "baidu"]
BLOCKLIST = Path(r"E:\AI-Station\EPC100\data\domain_blocklist.json")
THROTTLE_S = 1.2  # 引擎间节流(账号安全四件套·节流层)

TAG_RE = re.compile(r"<[^>]+>|<!--.*?-->", re.S)
GENERIC_ANCHOR = re.compile(r'<a[^>]+href="(https?://[^"]+)"[^>]*>(.{10,}?)</a>', re.S)


def _clean(title: str) -> str:
    return re.sub(r"\s+", " ", html_mod.unescape(TAG_RE.sub("", title))).strip()


def _host(url: str) -> str:
    m = re.match(r"https?://([^/]+)", url)
    return m.group(1).lower() if m else ""


def _load_blocklist() -> list:
    """高风险域名闸 (high-risk-site-avoidance 铁律); 文件缺=无闸不阻断."""
    try:
        data = json.loads(BLOCKLIST.read_text(encoding="utf-8"))
        if isinstance(data, dict):
            data = data.get("domains", data.get("blocklist", []))
        return [str(d).lower() for d in data] if isinstance(data, list) else []
    except Exception:
        return []


def _parse(page_html: str, parser: str, base: str):
    """按引擎解析器抽 标题+URL; 相对链绝对化; 解析失败=[](如实报0)."""
    if parser == "bing":
        pat = re.compile(r'<li class="b_algo".*?<h2[^>]*>\s*<a[^>]*href="([^"]+)"[^>]*>(.*?)</a>', re.S)
        items = [(u, t) for u, t in pat.findall(page_html)]
    elif parser == "sogou_wx":
        # 实锤: href 在 uigs 属性之前(属性序与直觉相反)
        pat = re.compile(r'<a[^>]*href="([^"]+)"[^>]*uigs="article_title_\d+"[^>]*>(.*?)</a>', re.S)
        items = [(u, t) for u, t in pat.findall(page_html)]
    elif parser == "so360":
        # 实锤: h3 与 class 间多空格; 真实URL优先 data-mdurl
        pat = re.compile(r'<h3[^>]*class="res-title[^"]*"[^>]*>\s*<a[^>]*href="([^"]+)"'
                         r'([^>]*)>(.*?)</a>', re.S)
        items = []
        for href, rest, title in pat.findall(page_html):
            md = re.search(r'data-mdurl="([^"]+)"', rest)
            items.append((md.group(1) if md else href, title))
    elif parser == "baidu_wap":
        # 页面变体轮盘: h3 锚 → c-container 内锚 → 通用锚 三梯
        p1 = re.compile(r'<h3[^>]*>\s*<a[^>]+href="([^"]+)"[^>]*>(.*?)</a>', re.S)
        items = p1.findall(page_html)
        if not items:
            p2 = re.compile(r'class="c-container[^"]*".*?<a[^>]+href="([^"]+)"[^>]*>(.{12,}?)</a>', re.S)
            items = p2.findall(page_html)
        if not items:
            items = GENERIC_ANCHOR.findall(page_html)
    elif parser == "ddg":
        pat = re.compile(r'<a[^>]+class="result__a"[^>]+href="([^"]+)"[^>]*>(.*?)</a>', re.S)
        items = pat.findall(page_html)
    else:
        items = GENERIC_ANCHOR.findall(page_html)

    # 自域排除仅滤导航/登录链; 跳转包装链(/link? /baidu.php /from=)是真结果须保留
    # (实锤: 搜狗 weixin.sogou.com/link?url= 与百度 m.baidu.com/from= 全在自域)
    engine_host = _host(base)
    redirect_marks = ("/link?", "/baidu.php", "/from=")
    out = []
    for url, title in items:
        url = urljoin(base, url.strip())
        h = _host(url)
        if engine_host in h and not any(m in url for m in redirect_marks):
            continue
        title = _clean(title)
        if len(title) < 8:
            continue
        out.append({"title": title[:120], "url": url})
    return out


import importlib.util as _ilu

_LEDGER_ENV = "RF_API_INVOCATION_LEDGER"

def _invocation(query, n):
    """台账记账 (env 门控, 缺省零副作用): API 路径成功记一行 api_replica。"""
    import os as _os
    if not _os.environ.get(_LEDGER_ENV):
        return
    try:
        for anc in Path(__file__).resolve().parents:
            bridge = (anc / "reforge_factory" / "legs"
                      / "api_replica_bridge.py")
            if bridge.is_file():
                break
        else:
            return
        spec = _ilu.spec_from_file_location("api_replica_bridge", bridge)
        mod = _ilu.module_from_spec(spec)
        sys.modules[spec.name] = mod
        spec.loader.exec_module(mod)
        mod.append_invocation(
            "sougo",
            "api_replica:sogou_weixin_api(四段GET链: 预热+检索+/link解析+真链)",
            query, f"{n}条 mp.weixin 真链",
            note="1024 API优先令: zh-search-pro sogou_weixin 引擎切复刻件;")
    except Exception as e:
        print(f"[sogou_weixin] 台账记失败: {type(e).__name__}", file=sys.stderr)


def _sogou_weixin_api_first(query: str, top: int, proxy: str | None,
                            blocklist: list | None):
    """1024 API优先令: 搜狗微信引擎先走复刻件 sogou_weixin_api (四段GET链,
    纯HTTP零浏览器, curl_cffi 抗TLS指纹) — 检索 + /link 解析出 mp.weixin 真链。
    返回 list[{title,url}] (真链, 免跳转壳); 复刻件抛错/零命中 → None,
    调用方降级下方原 HTTP 解析路径 (原样保留)。"""
    replica = None
    for anc in Path(__file__).resolve().parents:
        cand = anc / "逆向工程" / "sogou-weixin-reverse" / "replica" / "sogou_weixin_api.py"
        if cand.is_file():
            replica = cand
            break
    if replica is None:
        print("[sogou_weixin] api_replica 缺件 → 原HTTP路径", file=sys.stderr)
        return None
    try:
        spec = _ilu.spec_from_file_location("sogou_weixin_api_replica", replica)
        mod = _ilu.module_from_spec(spec)
        sys.modules[spec.name] = mod
        spec.loader.exec_module(mod)
        api = mod.SogouWeixinAPI(proxy=proxy, verbose=False)
        hits = api.search(query)
        out, seen = [], set()

        for h in hits[:top]:
            u = api.resolve(h.link_url)          # 短时效签名链, 立即用
            host = _host(u)
            if u in seen or any(b in host for b in (blocklist or [])):
                continue
            seen.add(u)
            out.append({"title": h.title[:120], "url": u,
                        "account": h.account, "publish_time": h.publish_time})
        if out:
            _invocation(query, len(out))
        return out if out else None
    except Exception as e:                      # antispider/墙/网错 — 如实降级
        print(f"[sogou_weixin] api_replica 未成({type(e).__name__}: {str(e)[:90]})"
              " → 原HTTP路径", file=sys.stderr)
        return None


def search_engine(key: str, query: str, top: int, extra: str = "",
                  proxy: str | None = None, blocklist: list | None = None) -> list:
    """单引擎检索; 任何失败→[]并打印原因(错误处理纪律, 不静默)."""
    if key == "sogou_weixin":                       # 1024 API优先: 复刻件四段GET链
        hits = _sogou_weixin_api_first(query, top, proxy, blocklist)
        if hits is not None:
            return hits[:top]
    url_tpl, parser, base = ENGINES[key]
    url = url_tpl.format(q=quote_plus(query), extra=extra)
    # Referer 用各引擎自家基址(跨域referer如带bing头打百度疑似触发验证墙)
    headers = {**BASE_HEADERS, "Referer": base}
    proxies = {"http": f"http://{proxy}", "https": f"http://{proxy}"} if proxy else None
    try:
        if key == "baidu":
            # 实锤: m.baidu 裸请求轮盘式触发验证墙, 会话预热(取首页cookie)后稳定
            sess = requests.Session(impersonate="chrome")
            sess.get(base, timeout=15, headers=headers, proxies=proxies)
            r = sess.get(url, timeout=25, proxies=proxies,
                         allow_redirects=True, headers=headers)
        else:
            r = requests.get(url, impersonate="chrome", timeout=25,
                             proxies=proxies, allow_redirects=True,
                             headers=headers)
        if r.status_code != 200:
            print(f"[{key}] HTTP {r.status_code} → 0 结果", file=sys.stderr)
            return []
        page = r.text
        if len(page) < 5000 and any(k in page[:3000] for k in ("安全验证", "captcha", "wappass")):
            print(f"[{key}] 验证码页 → 如实报0(不硬刚)", file=sys.stderr)
            return []
        results = _parse(page, parser, base)
        bl = blocklist or []
        engine_host = _host(base)
        seen, dedup = set(), []
        for it in results:
            h = _host(it["url"])
            # 跳转包装链(自域)按全URL去重; 直链按域名去重
            dk = it["url"] if engine_host in h else h
            if dk in seen or any(b in h for b in bl):
                continue
            seen.add(dk)
            dedup.append(it)
        return dedup[:top]
    except Exception as e:
        print(f"[{key}] err: {str(e)[:80]} → 0 结果", file=sys.stderr)
        return []


def main() -> int:
    ap = argparse.ArgumentParser(description="zh-search-pro 免key中文多引擎检索")
    ap.add_argument("query", nargs="+", help="查询词(多词空格相连)")
    ap.add_argument("-e", "--engines", default=",".join(DEFAULT_ENGINES),
                    help=f"逗号分隔引擎键, 可选: {','.join(ENGINES)}")
    ap.add_argument("--all", action="store_true", help="全引擎(含弱引擎与需代理的ddg)")
    ap.add_argument("--top", type=int, default=8, help="每引擎条数(默认8)")
    ap.add_argument("--json", action="store_true", help="JSON 输出")
    ap.add_argument("--bing-filter", default="",
                    help="必应时间过滤: last24|last7|last30|lasty")
    ap.add_argument("--proxy", default=None, help="代理 host:port (ddg等国际引擎必带)")
    args = ap.parse_args()

    query = " ".join(args.query).strip()
    keys = list(ENGINES) if args.all else [k.strip() for k in args.engines.split(",")]
    bad = [k for k in keys if k not in ENGINES]
    if bad:
        print(f"未知引擎: {bad} (可选: {','.join(ENGINES)})", file=sys.stderr)
        return 2
    if "duckduckgo" in keys and not args.proxy:
        print("[warn] duckduckgo 直连被墙, 需 --proxy 127.0.0.1:7890", file=sys.stderr)

    bl = _load_blocklist()
    extras = {"bing_cn": f'&filters=ex1%3a%22{args.bing_filter}%22'} if args.bing_filter else {}

    all_hits, first = {}, True
    for k in keys:
        if not first:
            time.sleep(THROTTLE_S)  # 引擎间节流
        first = False
        all_hits[k] = search_engine(k, query, args.top,
                                    extra=extras.get(k, ""), proxy=args.proxy,
                                    blocklist=bl)

    if args.json:
        print(json.dumps({"query": query, "hits": all_hits}, ensure_ascii=False, indent=1))
    else:
        print(f"# zh-search-pro | {query}")
        total = 0
        for k, hits in all_hits.items():
            total += len(hits)
            print(f"\n## [{k}] {len(hits)} 条")
            for it in hits:
                print(f"- [{it['title']}]({it['url']})")
        print(f"\n合计 {total} 条 (引擎: {','.join(keys)})")
    return 0


if __name__ == "__main__":
    sys.exit(main())
