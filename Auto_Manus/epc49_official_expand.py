# -*- coding: utf-8 -*-
"""EPC49 官网扩量腿 v1 — 1004 渠道总动员令 (用户: 官网=优质渠道).

侦察实锤 (wf_ee5e6e4e): 官网 sedc.powerchina.cn (jcms+jpaas, webId=43)
全站权威总量 230 条, 已采仅 112 件. 本腿打穿缺口 ~115 件:
  集团要闻 88 条外链 (www.powerchina.cn, ~1500字/篇) + 信息公开 13 +
  科技实力 12 + 资质荣誉 17 + 业绩展示尾巴 3 + 视频集锦 5.

API (侦察验证, GET 非 POST):
  /api-gateway/jpaas-publish-server/front/page/build/unit
  ?parseType=bulidstatic&webId=43&tplSetId=7ltgfkeApzjMs0AOIDb7V
  &pageType=column&tagId=当前信息&editType=null&pageId={ID}
  &paramJson={"pageNo":1,"pageSize":500}
  返回 data.html 内 href+title+时间; 分页 div count=权威总数.

礼节: 详情页间 1.5-3s 随机; 黑名单闸全渠道生效; 幂等 (已存文件跳过).
产物: 战役 02/52_官网深挖/ 下, 由入账班 v2 自动发现入池.
"""
import hashlib
import io
import json
import random
import re
import subprocess
import sys
import time
import urllib.request
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")

CODE_VERSION = "v1"

sys.path.insert(0, r"E:\AI-Station\Auto_Manus")
import epc49_topics as T  # noqa: E402

BASE = "http://sedc.powerchina.cn"
API = (BASE + "/api-gateway/jpaas-publish-server/front/page/build/unit"
       "?parseType=bulidstatic&webId=43&tplSetId=7ltgfkeApzjMs0AOIDb7V"
       "&pageType=column&tagId=%E5%BD%93%E5%89%8D%E4%BF%A1%E6%81%AF"
       "&editType=null&pageId={pid}"
       '&paramJson=%7B%22pageNo%22%3A1%2C%22pageSize%22%3A500%7D')

# 栏目: pageId → 落盘子目录名 (侦察定位的缺口栏目)
PAGES = {
    3540: "集团要闻",      # 88 条外链 www.powerchina.cn
    3533: "信息公开",      # 13
    3609: "科技实力",      # 12
    3605: "资质荣誉",      # 17
    3545: "业绩展示",      # 尾巴 3 (其他领域)
    3539: "视频集锦",      # 5 (标题+链接线索)
}
OUT = [d for d in T.BATTLE.iterdir() if d.name.startswith("02")][0] \
    / "52_官网深挖"

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36")

# 黑名单闸 (conductor 同源数据)
BLOCK = json.loads((Path(r"E:\AI-Station\ResearchFactory-Eng\EPC100"
                         r"\data\domain_blocklist.json"))
                   .read_text(encoding="utf-8"))
BLOCKED = {b if isinstance(b, str) else b.get("domain", "")
           for b in (BLOCK if isinstance(BLOCK, list)
                     else BLOCK.get("domains", []))}


def fetch(url: str, timeout: int = 30) -> str:
    req = urllib.request.Request(url, headers={"User-Agent": UA})
    with urllib.request.urlopen(req, timeout=timeout) as r:
        return r.read().decode("utf-8", errors="replace")


def blocked(url: str) -> bool:
    m = re.match(r"https?://([^/]+)", url)
    return bool(m and any(m.group(1).endswith(b) or b in m.group(1)
                          for b in BLOCKED if b))


def slug(s: str, n: int = 40) -> str:
    return re.sub(r"[\\/:*?\"<>|\s]+", "_", s)[:n].strip("_") or "untitled"


def html_text(h: str) -> str:
    """PowerChina jcms 详情页静态抽取: 去 script/style → 剥标签 → 压空白."""
    h = re.sub(r"<(script|style)[^>]*>.*?</\1>", " ", h,
               flags=re.S | re.I)
    h = re.sub(r"<br\s*/?>|</p>|</div>", "\n", h, flags=re.I)
    t = re.sub(r"<[^>]+>", " ", h)
    t = re.sub(r"&nbsp;|&amp;|&lt;|&gt;|&quot;", " ", t)
    return re.sub(r"[ \t]+", " ", t)


def main() -> int:
    print(f"[{CODE_VERSION}] 官网扩量腿启动 {time.strftime('%F %T')}",
          flush=True)
    OUT.mkdir(parents=True, exist_ok=True)
    n_new = n_skip = n_err = 0
    for pid, name in PAGES.items():
        try:
            js = json.loads(fetch(API.format(pid=pid), timeout=40))
        except Exception as e:                              # noqa: BLE001
            print(f"[{name}] 清单API失败: {type(e).__name__} {e}",
                  flush=True)
            continue
        items = re.findall(r'href="([^"]+)"[^>]*>([^<]{4,})<',
                           (js.get("data") or {}).get("html", ""))
        if not items:
            items = re.findall(r"<a[^>]+href=['\"]([^'\"]+)['\"][^>]*>"
                               r"([^<]{4,})<",
                               (js.get("data") or {}).get("html", ""))
        # 同一 href 多锚点去重 (缩略图/标题双锚)
        seen = {}
        for href, title in items:
            u = href.strip()
            if not u or u.startswith(("javascript", "#")):
                continue
            if u.startswith("/"):
                u = BASE + u
            if u not in seen:
                seen[u] = re.sub(r"\s+", " ", title).strip()
        print(f"[{name}] pageId={pid} 清单 {len(seen)} 条", flush=True)
        sub = OUT / f"扩量_{name}"
        sub.mkdir(parents=True, exist_ok=True)
        for u, title in seen.items():
            if blocked(u):
                print(f"  [gate] 黑名单域跳过: {u[:60]}", flush=True)
                continue
            # 稳定指纹 (md5): hash() 跨进程随机会破幂等
            fp = hashlib.md5(u.encode()).hexdigest()[:6]
            f = sub / f"{slug(title)}_{fp}.md"
            if f.exists():
                n_skip += 1
                continue
            try:
                art = fetch(u)
            except Exception as e:                          # noqa: BLE001
                print(f"  [err] {u[:70]}: {type(e).__name__}", flush=True)
                n_err += 1
                time.sleep(2)
                continue
            m = re.search(r"<title>([^<]+)</title>", art, re.I)
            body = html_text(art)
            # 正文定位: title 之后的主块 (jcms 详情正文占比最大段)
            core = max((p for p in re.split(r"\n{2,}", body)
                        if len(p) > 200), default=body)
            f.write_text(f"# {m.group(1).strip() if m else title}\n\n"
                         f"- 来源: {u}\n- 栏目: {name}\n"
                         f"- 采集: {time.strftime('%F')}\n\n{core}\n",
                         encoding="utf-8")
            n_new += 1
            print(f"  + {f.name[:52]} ({len(core)}字)", flush=True)
            time.sleep(random.uniform(1.5, 3.0))            # 礼貌节流
    print(f"[官网扩量] 完: 新增 {n_new} | 已存跳过 {n_skip} | 失败 {n_err}",
          flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
