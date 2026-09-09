"""混沌学园全量课程普查（M2.5 扩容：所有课程资料的采集整理）。

tab_list(/pc/tab_list) → 每个 sub_tab 的 /online/schedule/list →
包(boutique) 内 course_list → 全站课程清单（按 tab/sub_tab 分类，
course_id 去重）。输出 data/hundun/_recon/census.json：
{"courses": {cid: {title, tab, sub_tab, package, ...}}, "stats": {...}}
幂等：可重复运行刷新清单。
"""
import configparser
import json
import os
import sys
import time

sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))), "src"))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from paistation.forge.hundun import HundunClient  # noqa: E402

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(ROOT, "data", "hundun", "_recon", "census.json")
PAGE_SIZE = 50
THROTTLE = 0.3  # 每次请求间隔（秒）——稳定采集，不做压力测试


def census(cli: HundunClient) -> dict:
    tabs = (cli.get("user", "/pc/tab_list").get("data") or {}).get("tab_list") or []
    courses: dict[str, dict] = {}
    for tab in tabs:
        tab_name = tab.get("name", "")
        tab_key = tab.get("key")
        subs = tab.get("sub_tab_list") or []
        if not subs:  # 无子分类的 tab（课程上新/购买记录）跳过——包结构不同
            continue
        for sub in subs:
            sub_name, sku_mode, module_id = (sub.get("name", ""),
                                             sub.get("key", ""),
                                             sub.get("module_id", 0))
            page = 0
            while True:
                data = cli.get("course", "/online/schedule/list",
                               sku_mode=sku_mode, column_type=tab.get("column_type", 0),
                               module_id=module_id, page_no=page,
                               page_size=PAGE_SIZE).get("data") or {}
                packs = data.get("boutique_list") or []
                for pack in packs:
                    for c in pack.get("course_list") or []:
                        cid = str(c.get("course_id", ""))
                        if not cid:
                            continue
                        rec = courses.setdefault(cid, {
                            "course_id": cid,
                            "title": c.get("title", ""),
                            "tab": tab_name, "sub_tab": sub_name,
                            "package": pack.get("title", ""),
                            "package_id": pack.get("package_id"),
                            "teacher": c.get("teacher_name", ""),
                            "score": c.get("course_score", 0),
                        })
                        # 多分类命中时保留首个，但记录全部归属
                        rec.setdefault("cats", []).append(f"{tab_name}/{sub_name}")
                time.sleep(THROTTLE)
                totals = data.get("totals") or len(packs)
                if (page + 1) * PAGE_SIZE >= totals or not packs:
                    break
                page += 1
            print(f"[census] {tab_name}/{sub_name}: 累计 {len(courses)} 门（去重后）")
    return {"courses": courses,
            "stats": {"total": len(courses),
                      "tabs": [t.get("name") for t in tabs]}}


def main() -> int:
    cred = configparser.ConfigParser()
    cred.read(os.path.join(ROOT, "config", "hundun.secret.ini"), encoding="utf-8")
    cli = HundunClient(phone=cred.get("hundun", "phone"),
                       password=cred.get("hundun", "password"))
    cli.login()
    result = census(cli)
    os.makedirs(os.path.dirname(OUT), exist_ok=True)
    with open(OUT, "w", encoding="utf-8") as fh:
        json.dump(result, fh, ensure_ascii=False, indent=1)
    n = result["stats"]["total"]
    ai = sum(1 for c in result["courses"].values() if c["tab"] == "AI")
    print(f"[census] 全站去重 {n} 门 | AI 分类 {ai} 门 -> {OUT}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
