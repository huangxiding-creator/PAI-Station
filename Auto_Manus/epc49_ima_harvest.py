# -*- coding: utf-8 -*-
"""EPC49 ima 知识库收获器 — 总包知识库-998 电建系词表批量收割.

1003 全渠道令: #49 四川电力设计咨询(电建系设计院). 探测实证
「电力设计院」39 命中(电力设计院EPC方法论PDF直靶). 配方承 epc50 版:
search_knowledge(词) → 相关性门 → get_media_info → url 下载落
02.../51_ima知识库/. 断点续跑(已存在即跳过), 3s 节流, 429/限额即停.
"""
import io
import json
import re
import subprocess
import sys
import time
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")

IMA = Path(r"C:\Users\91216\.claude\skills\ima-skill\ima_api.cjs")
OUT = Path(r"E:/AI-Station/ResearchFactory-Eng/ResearchTopics/"
           "《四川电力设计咨询有限责任公司怎么干EPC总承包？》/02 初次网络调研"
           "/51_ima知识库")
STATE = OUT / "_ima_state.json"
KB_ID = "08r_VxgPH8ajgOsoAAqZo8nSXMgQskYH_VPfokrF6g0="

TERMS = [
    # ---- 电建系主面 (1003 全渠道审计定词) ----
    "电力设计院", "电力设计企业", "输变电EPC", "输变电工程",
    "电力工程总承包", "变电站工程", "电力勘测设计", "新能源EPC",
    "光伏EPC", "风电场EPC", "抽水蓄能", "源网荷储",
    "火力发电设计", "水电站设计", "电网工程设计",
    # ---- EPC 方法论通用面 ----
    "EPC总承包项目管理", "EPC设计管理", "EPC采购管理", "EPC施工管理",
    "EPC风险管理", "EPC合同管理", "EPC成本控制", "工程总承包项目管理",
    "国际工程总承包", "FIDIC", "设计采购施工", "总承包商管理",
    "招投标管理", "工程造价管理", "HSE管理", "工程分包管理",
    "数字化交付", "智能工地",
]
RELEVANT = re.compile(
    r"EPC|总承包|电力|输变电|变电站|风电|光伏|抽水蓄能|源网荷储|"
    r"勘测|设计院|FIDIC|设计采购|工程合同|建设工程|项目管理|"
    r"采购管理|施工管理", re.I)
IRRELEVANT = re.compile(r"股票|基金|育儿|菜谱|旅游|小说|游戏", re.I)


def opts() -> str:
    import pathlib
    cid = (pathlib.Path.home() / ".config/ima/client_id").read_text().strip()
    key = (pathlib.Path.home() / ".config/ima/api_key").read_text().strip()
    return json.dumps({"clientId": cid, "apiKey": key})


OPTS = opts()


def call(api: str, body: dict, timeout: int = 60) -> dict:
    r = subprocess.run(
        ["node", str(IMA), api, json.dumps(body, ensure_ascii=False), OPTS],
        capture_output=True, text=True, encoding="utf-8", timeout=timeout)
    try:
        return json.loads(r.stdout)
    except (json.JSONDecodeError, ValueError):
        return {"code": -1, "msg": (r.stdout or r.stderr)[:200]}


def search(term: str) -> list:
    d = call("openapi/wiki/v1/search_knowledge",
             {"query": term, "knowledge_base_id": KB_ID, "limit": 20})
    return (d.get("data") or {}).get("info_list") or []


def download(title: str, media_id: str) -> bool:
    info = call("openapi/wiki/v1/get_media_info", {"media_id": media_id})
    url = ((info.get("data") or {}).get("download_url")
           or (info.get("data") or {}).get("url"))
    if not url:
        return False
    import urllib.request
    safe = re.sub(r'[\\/:*?"<>|\r\n]', "_", title)[:80]
    dst = OUT / f"{safe}.pdf"
    if dst.exists():
        return True
    req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
    with urllib.request.urlopen(req, timeout=120) as resp, \
            open(dst, "wb") as f:
        f.write(resp.read())
    return dst.stat().st_size > 1024


def main() -> int:
    OUT.mkdir(parents=True, exist_ok=True)
    done = {}
    if STATE.exists():
        done = json.loads(STATE.read_text(encoding="utf-8"))
    total = 0
    for term in TERMS:
        if done.get(term) == "ok":
            continue
        try:
            items = search(term)
        except Exception as e:  # noqa: BLE001
            print(f"[ima] {term} 搜索失败: {e}", flush=True)
            time.sleep(3)
            continue
        n = 0
        for it in items:
            title = it.get("title", "")
            if not RELEVANT.search(title) or IRRELEVANT.search(title):
                continue
            try:
                if download(title, it.get("media_id", "")):
                    n += 1
                    total += 1
            except Exception as e:  # noqa: BLE001
                print(f"[ima] 下载失败 {title[:40]}: {type(e).__name__}",
                      flush=True)
            time.sleep(3)  # 账号安全: 下载节流
        done[term] = "ok"
        STATE.write_text(json.dumps(done, ensure_ascii=False, indent=1),
                         encoding="utf-8")
        print(f"[ima] {term}: 收 {n}", flush=True)
        time.sleep(3)  # 搜索节流
    print(f"[ima] 完成 共收 {total}", flush=True)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
