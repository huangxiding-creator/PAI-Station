# -*- coding: utf-8 -*-
"""W3 · 115/光鸭 owner 开链狩猎 + wss 文叔叔活链狩猎（2026-10-30 夜）

任务：TG 腿+活源定向搜「115 网盘 分享」「光鸭 分享」类词；发现链后免登直链验证；
命中即真件门转绿（≥10MB 落盘 w1_downloads/<盘>/）；未命中维持绿? 如实。
预算：115/光鸭 各 ≤15 发搜+5 发验；wss ≤10 发（搜+验合计）；命中下载各 1 件 ≥10MB（≤300MB）。
铁律：零凭据；单源间隔≥2s；TG 走代理重试；数字零造假（逐发入 w3_owner_ledger.jsonl）。
产出：analysis/w3_owner_hunt.jsonl（逐链验证行+门件行）
"""
from __future__ import annotations

import json
import random
import re
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "engine" / "sourcehub"))
sys.stdout.reconfigure(encoding="utf-8")

from searchagg import SearchSession, SearchLedger                    # noqa: E402
from adapters import ADAPTERS                                        # noqa: E402
from adapters.base import PanError, extract_pwd                      # noqa: E402
from curl_cffi import requests as creq                               # noqa: E402

LEDGER = ROOT / "analysis" / "w3_owner_ledger.jsonl"
RESULTS = ROOT / "analysis" / "w3_owner_hunt.jsonl"
RUN = time.strftime("%Y%m%d_%H%M%S")
GATE_MB = 10
CAP_BYTES = 120 * 1024 * 1024          # 门件截断顶（≤300MB 铁律内取 120MB）

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36")
PROXIES = {"http": "http://127.0.0.1:7892", "https": "http://127.0.0.1:7892"}
_BLK_RE = re.compile(r'tgme_widget_message_text[^>]*>(.*?)</div>', re.S)
_PWD_RE = re.compile(r'(?:提取码|密码|访问码)[：:\s]*([A-Za-z0-9]{3,8})')

TARGETS = [
    {"disk": "115", "adapter": "115", "domains": ("115.com/s/", "anxia.com/s/"),
     "kws": ["115网盘", "115 分享"], "agg": ["melost", "panhunt", "naspt"],
     "search_budget": 15, "verify_budget": 5},
    {"disk": "guangya", "adapter": "guangya", "domains": ("guangyapan.com",),
     "kws": ["光鸭", "光鸭网盘"], "agg": ["melost", "panhunt", "naspt"],
     "search_budget": 15, "verify_budget": 5},
    {"disk": "wss", "adapter": "wenshushu", "domains": ("wenshushu.cn", "wss.zone"),
     "kws": ["文叔叔", "wenshushu"], "agg": ["melost", "panhunt"],
     "search_budget": 7, "verify_budget": 5},
]


def _shot(tag, url, note=""):
    with open(LEDGER, "a", encoding="utf-8") as f:
        f.write(json.dumps({"ts": time.strftime("%H:%M:%S"), "run": RUN,
                            "tag": tag, "url": url[:130], "note": note[:100]},
                           ensure_ascii=False) + "\n")


def _row(**kw):
    kw["run"] = RUN
    with open(RESULTS, "a", encoding="utf-8") as f:
        f.write(json.dumps(kw, ensure_ascii=False) + "\n")
        f.flush()


def tg_search(kw: str, domains: tuple[str, ...], found: list, counter: dict) -> None:
    url = f"https://t.me/s/tgsearchers7?q={kw}"
    for path in ("direct", "proxy"):
        if counter["search"] >= counter["search_budget"]:
            return
        _shot(f"tg:{path}", url)
        counter["search"] += 1
        try:
            r = creq.get(url, headers={"User-Agent": UA}, timeout=15,
                         impersonate="chrome124",
                         proxies=PROXIES if path == "proxy" else None)
            for blk in _BLK_RE.findall(r.text or ""):
                m = _PWD_RE.search(blk)
                bpwd = m.group(1) if m else ""
                for u in re.findall(r'https?://[^\s"\'<>）】\]]+', blk):
                    if not any(d in u for d in domains):
                        continue
                    u = u.rstrip(".,;:!?、。；")
                    _, pwd = extract_pwd(u)
                    if any(x["url"] == u for x in found):
                        continue
                    found.append({"url": u, "pwd": pwd or bpwd, "src": "tg"})
            return
        except Exception:
            time.sleep(2)
    return


def agg_search(kw: str, src: str, domains: tuple[str, ...], found: list, counter: dict):
    if counter["search"] >= counter["search_budget"]:
        return
    led = SearchLedger(str(LEDGER))
    s = SearchSession(src, led)
    hits = s.search(kw)
    counter["search"] += 1
    for h in hits:
        if not any(d in h.url for d in domains):
            continue
        _, pwd = extract_pwd(h.url)
        if not any(x["url"] == h.url for x in found):
            found.append({"url": h.url, "pwd": pwd, "src": src})


def verify_and_gate(t: dict, found: list, counter: dict) -> dict:
    """新链优先（found 尾部=最新消息块）：snap/parse → direct → 门件下载。"""
    disk, adapter = t["disk"], ADAPTERS[t["adapter"]]
    out_dir = ROOT / "w1_downloads" / disk
    for item in reversed(found):
        if counter["verify"] >= t["verify_budget"] and not counter.get("gate_ok"):
            break
        if counter["verify"] >= t["verify_budget"] + 2:      # 门件追加容限
            break
        url, pwd = item["url"], item["pwd"]
        try:
            _shot(f"{disk}:parse", url)
            entries = adapter.parse(url, pwd)
            counter["verify"] += 1
            _row(disk=disk, url=url[:110], pwd=pwd, stage="parse",
                 ok=True, n=len(entries),
                 sample=[f"{'D' if e.is_dir else 'F'}:{e.name[:40]}:{e.size}"
                         for e in entries[:3]])
            target = next((e for e in entries if not e.is_dir
                           and e.size >= GATE_MB * 1048576), None) \
                if not counter.get("gate_ok") else None
            if not target:
                print(f"    parse OK({len(entries)}) 无≥10MB 文件或门已过，下一条")
                continue
            _shot(f"{disk}:direct", url, note=target.name[:60])
            u = adapter.direct_url(target)
            counter["verify"] += 1
            _row(disk=disk, url=url[:110], stage="direct", ok=True,
                 file=target.name[:80], size=target.size, durl=u[:150])
            out_dir.mkdir(parents=True, exist_ok=True)
            safe = "".join(c for c in target.name if c not in '\\/:*?"<>|')[:80]
            out = out_dir / safe
            _shot(f"{disk}:download", url, note=f"gate file {target.size}B")
            n, sha = adapter.stream_download(u, out, CAP_BYTES)
            ok_gate = n >= GATE_MB * 1048576
            _row(disk=disk, url=url[:110], stage="gate_file", ok=ok_gate,
                 file=target.name[:80], landed=n, sha1=sha, path=str(out)[-80:])
            counter["gate_ok"] = ok_gate
            print(f"    门件落盘 {n}B sha1={sha[:12]}…（≥10MB={'是' if ok_gate else '否'}）")
            if ok_gate:
                return {"gate": True, "url": url, "file": out.name, "bytes": n, "sha1": sha}
        except PanError as e:
            counter["verify"] += 1
            _row(disk=disk, url=url[:110], pwd=pwd, stage="error",
                 ok=False, err=str(e)[:160])
            print(f"    ✗ {str(e)[:100]}")
        except Exception as e:
            counter["verify"] += 1
            _row(disk=disk, url=url[:110], stage="exception",
                 ok=False, err=f"{type(e).__name__}:{str(e)[:120]}")
            print(f"    ✗EXC {type(e).__name__} {str(e)[:80]}")
        time.sleep(random.uniform(2.0, 3.2))
    return {"gate": False, "tried": counter["verify"]}


def main():
    summary = {}
    for t in TARGETS:
        print(f"\n===== {t['disk']} 狩猎（搜≤{t['search_budget']} 验≤{t['verify_budget']}）=====")
        found: list = []
        counter = {"search": 0, "verify": 0, "search_budget": t["search_budget"],
                   "verify_budget": t["verify_budget"]}
        for kw in t["kws"]:
            tg_search(kw, t["domains"], found, counter)
            time.sleep(random.uniform(2.0, 3.0))
            if len(found) >= 8 or counter["search"] >= counter["search_budget"]:
                break
        for src in t["agg"]:
            if len(found) >= 8 or counter["search"] >= counter["search_budget"]:
                break
            agg_search(t["kws"][0], src, t["domains"], found, counter)
            time.sleep(random.uniform(2.0, 3.0))
        print(f"  收割 {len(found)} 链（{counter['search']} 搜发）→ 验证")
        for f in found[:8]:
            print(f"    {f['url'][:84]} pwd={f['pwd'] or '-'}")
        res = verify_and_gate(t, found, counter)
        summary[t["disk"]] = {"found": len(found), "search_shots": counter["search"],
                              "verify_shots": counter["verify"], **res}
        print(f"  → {t['disk']} 结果：{json.dumps(res, ensure_ascii=False)[:160]}")
    _row(type="summary", **{k: v for k, v in summary.items()})
    print(f"\n== owner 狩猎收官：{json.dumps(summary, ensure_ascii=False)[:400]}")


if __name__ == "__main__":
    main()
