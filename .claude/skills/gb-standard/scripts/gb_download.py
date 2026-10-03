# -*- coding: utf-8 -*-
"""eBiaozhun 国标 PDF 下载器 — china-gb-standard-downloader (dageer2026) 配方封装.

来源: https://github.com/dageer2026/china-gb-standard-downloader (MIT)
原理: ebiaozhun.com 的 paystatus API 对 0 币件免登录直发下载链接 —
      前端显示「请充值金币」, 后端 API 直接给 {"code":1,"data":{"files":[...]}}

链路: search.html?q={数字段} → /std/{hash}.html 提取 var pid →
      /matrix/order/paystatus?type=doc&pid={pid} (X-Requested-With 头 +
      PHPSESSID 会话) → files[0].url 直链 → curl/requests 下载 → ≥100KB 验真

用法:
  python gb_download.py "GB/T 8110-2020" "GB 50017-2017" [-o 输出目录] [--info]

纪律: 标准间 sleep 3s 轻节流; 只做按需单件, 不做批量并发。
免责: 仅供个人学习研究 (上游仓库声明), 商用请购正版 (中国标准出版社)。
"""
import argparse
import io
import re
import sys
import time
from pathlib import Path

import requests


def _utf8_stdout() -> None:
    """GBK 控制台防炸 (仅 CLI 直跑时包; 被 import 时不动别人的流)."""
    try:
        if sys.stdout.encoding and sys.stdout.encoding.lower() != "utf-8":
            sys.stdout = io.TextIOWrapper(sys.stdout.buffer,
                                          encoding="utf-8",
                                          errors="replace")
    except Exception:                                  # noqa: BLE001
        pass

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
      " (KHTML, like Gecko) Chrome/126.0 Safari/537.36")
BASE = "https://www.ebiaozhun.com"
MIN_PDF_BYTES = 100_000        # 上游配方验真线: <100KB ≈ 错误壳


def _session() -> requests.Session:
    s = requests.Session()
    s.headers.update({"User-Agent": UA})
    return s


def std_numeric(std: str) -> str:
    """'GB/T 8110-2020' → '8110' (搜索只用数字段, 不带年代号)."""
    m = re.search(r"(\d{3,6})", std.split("-")[0].split("—")[0])
    return m.group(1) if m else ""


def find_hash(s: requests.Session, numeric: str, std: str) -> str:
    """搜索页 → 本标准的 /std/{hash}.html 哈希 (标题含数字段者)."""
    r = s.get(f"{BASE}/search.html", params={"q": numeric}, timeout=25)
    r.raise_for_status()
    pairs = re.findall(
        r'<a[^>]+href="/std/([0-9a-f]+)\.html"[^>]*>(.*?)</a>', r.text,
        re.DOTALL)
    year = (re.search(r"[-—.](\d{4})", std) or [None, ""])[1] \
        if re.search(r"[-—.](\d{4})", std) else ""
    for h, txt in pairs:
        t = re.sub(r"<[^>]+>", "", txt)
        if numeric in t:
            if not year or year in t:      # 年代号也对得上 = 精确命中
                return h
    for h, txt in pairs:                   # 年代不匹配时退回首命中
        t = re.sub(r"<[^>]+>", "", txt)
        if numeric in t:
            return h
    return ""


def extract_pid(s: requests.Session, std_hash: str) -> str:
    r = s.get(f"{BASE}/std/{std_hash}.html", timeout=25)
    r.raise_for_status()
    m = re.search(r"var\s+pid\s*=\s*(\d+)\s*;", r.text)
    return m.group(1) if m else ""


def paystatus(s: requests.Session, std_hash: str, pid: str) -> dict:
    """免登录直链 API. 返回 {code, url, name} 或 {code, msg}."""
    r = s.get(
        f"{BASE}/matrix/order/paystatus",
        params={"type": "doc", "pid": pid},
        headers={"Referer": f"{BASE}/std/{std_hash}.html",
                 "X-Requested-With": "XMLHttpRequest",
                 "Accept": "application/json, text/javascript, */*; q=0.01"},
        timeout=25)
    try:
        d = r.json()
    except ValueError:
        return {"code": -1, "msg": f"非JSON回包(HTTP {r.status_code})"}
    if d.get("code") == 1:
        f0 = (d.get("data", {}).get("files") or [{}])[0]
        if f0.get("url"):
            return {"code": 1, "url": f0["url"], "name": f0.get("name", "")}
        return {"code": -1, "msg": "code=1 但无 files"}
    return {"code": d.get("code"), "msg": str(d.get("msg", d))[:120]}


def page_price(html: str) -> str:
    """详情页金币价 ('下载文档需要支付 N 金币')."""
    m = re.search(r"下载文档需要支付\s*<span[^>]*>(\d+)</span>\s*金币", html)
    return m.group(1) if m else ""


def download_pdf(s: requests.Session, url: str, dest: Path) -> int:
    dest.parent.mkdir(parents=True, exist_ok=True)
    with s.get(url, headers={"Referer": BASE + "/"}, stream=True,
               timeout=120) as r:
        r.raise_for_status()
        with open(dest, "wb") as f:
            for chunk in r.iter_content(65536):
                f.write(chunk)
    return dest.stat().st_size


def fetch_one(s: requests.Session, std: str, outdir: Path,
              info_only: bool) -> dict:
    numeric = std_numeric(std)
    if not numeric:
        return {"std": std, "ok": False, "err": "标准号无数字段"}
    try:
        h = find_hash(s, numeric, std)
        if not h:
            return {"std": std, "ok": False, "err": "搜索页无命中"}
        detail = s.get(f"{BASE}/std/{h}.html", timeout=25)
        detail.raise_for_status()
        pid_m = re.search(r"var\s+pid\s*=\s*(\d+)\s*;", detail.text)
        if not pid_m:
            return {"std": std, "ok": False, "err": "详情页无 pid"}
        pid = pid_m.group(1)
        title_m = re.search(r"<title>(.*?)</title>", detail.text,
                            re.DOTALL)
        title = re.sub(r"[-|]\s*易标超.*$", "",
                       (title_m.group(1).strip() if title_m else std))
        price = page_price(detail.text)
        ps = paystatus(s, h, pid)
        if ps["code"] != 1:
            # 1003 实测: 全站抽样 3-15 金币, 0 币免登录件已罕见 —
            # 付费件不绕 (不碰支付墙), 如实报价
            return {"std": std, "ok": False, "title": title,
                    "price": price, "detail": f"{BASE}/std/{h}.html",
                    "err": f"付费件 {price}金币 (paystatus: "
                           f"{ps.get('msg', '')})"}
        url, name = ps["url"], ps.get("name") or f"{std}.pdf"
        if info_only:
            return {"std": std, "ok": True, "url": url, "name": name,
                    "title": title, "info": True}
        safe = re.sub(r"[\\/:*?\"<>|\s]", "_", f"{std}_{name}")[:80]
        dest = outdir / (safe if safe.lower().endswith(".pdf")
                         else safe + ".pdf")
        size = download_pdf(s, url, dest)
        if size < MIN_PDF_BYTES:
            dest.unlink(missing_ok=True)
            return {"std": std, "ok": False,
                    "err": f"验真失败 {size}B < 100KB (疑似错误壳)"}
        return {"std": std, "ok": True, "file": str(dest), "size": size,
                "name": name, "title": title, "url": url}
    except Exception as e:  # noqa: BLE001
        return {"std": std, "ok": False, "err": f"{type(e).__name__}: "
                                                f"{str(e)[:80]}"}


def main() -> int:
    _utf8_stdout()
    ap = argparse.ArgumentParser(description="国标 GB/GB/T PDF 下载 (eBiaozhun)")
    ap.add_argument("standards", nargs="+", help='标准号, 如 "GB/T 8110-2020"')
    ap.add_argument("-o", "--outdir", default=".", help="输出目录 (默认当前)")
    ap.add_argument("--info", action="store_true", help="只解析直链不下载")
    args = ap.parse_args()

    outdir = Path(args.outdir)
    s = _session()
    rc = 0
    for i, std in enumerate(args.standards):
        r = fetch_one(s, std.strip(), outdir, args.info)
        if r["ok"]:
            if r.get("info"):
                print(f"[INFO] {std}: {r.get('title', '')}\n"
                      f"       {r['name']}\n       {r['url']}")
            else:
                print(f"[OK] {std} → {r['file']} ({r['size'] // 1024}KB)"
                      f"  名称: {r.get('title', r['name'])}")
        else:
            rc = 1
            extra = ""
            if r.get("title"):
                extra = (f"\n       名称: {r['title']}"
                         f"\n       详情: {r.get('detail', '')}")
            print(f"[FAIL] {std}: {r['err']}{extra}")
        if i < len(args.standards) - 1:
            time.sleep(3)                # 轻节流
    return rc


if __name__ == "__main__":
    sys.exit(main())
