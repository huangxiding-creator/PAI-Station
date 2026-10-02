# -*- coding: utf-8 -*-
"""EPC50 ima 知识库收获器 — 总包知识库-998 (25321 条) EPC 方法论批量收割.

0924 用户令: 全渠道用上 + 1000 万字必须突破. ima 换词复探实证
石化/EPC 主题命中密集 (石油化工项目管理 17 / EPC采购 16 / 炼化EPC 4).
配方: search_knowledge(词) → 相关性门(标题白名单) → get_media_info
→ url 下载落 04.../51_ima知识库/. 断点续跑 (已存在即跳过), 3s 节流,
429/限额即停 (账号安全).
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
           "《中石化南京工程有限公司怎么干EPC总承包？》/04 网络调研搜集的资料"
           "/51_ima知识库")
STATE = OUT / "_ima_state.json"
KB_ID = "08r_VxgPH8ajgOsoAAqZo8nSXMgQskYH_VPfokrF6g0="

TERMS = [
    "石油化工项目管理", "石化工程总承包", "炼化EPC", "EPC采购",
    "EPC总承包项目管理", "EPC合同管理", "EPC风险管理", "EPC设计管理",
    "EPC施工管理", "EPC成本控制", "FIDIC", "工程总承包项目管理",
    "国际工程总承包", "海外EPC", "设计采购施工", "总承包商管理",
    "石化设计", "炼油装置", "化工工程建设", "项目融资EPC",
    # ---- 0924 夜第二批 (全渠道令: 总包库 25321 条深挖) ----
    "EPC项目案例", "总承包合同", "石化装置安装", "加氢装置",
    "催化裂化", "乙烯装置", "常减压装置", "储运工程",
    "工艺管道安装", "大型设备吊装", "化工监理", "招投标管理",
    "工程造价管理", "HSE管理", "石油化工安全", "环保工程",
    "化工总承包", "煤化工工程", "天然气净化", "LNG工程",
    "管道工程", "压力容器", "换热器", "化工自控",
    "数字化交付", "智能工厂建设", "石化设备管理", "装置检修",
    "石化检修", "工程分包管理",
]
# 标题相关性门: 必须命中领域词 (垃圾不落地)
RELEVANT = re.compile(
    r"EPC|总承包|石化|炼化|炼油|化工|FIDIC|设计采购|工程合同|建设工程|"
    r"项目管理|采购管理|施工管理", re.I)
IRRELEVANT = re.compile(r"股票|基金|育儿|菜谱|旅游|小说|游戏", re.I)


def opts() -> str:
    import pathlib
    cid = (pathlib.Path.home() / ".config/ima/client_id").read_text().strip()
    key = (pathlib.Path.home() / ".config/ima/api_key").read_text().strip()
    return json.dumps({"clientId": cid, "apiKey": key})


OPTS = opts()


def call(api: str, body: dict) -> dict:
    r = subprocess.run(["node", str(IMA), api, json.dumps(body, ensure_ascii=False),
                        OPTS], capture_output=True, text=True, encoding="utf-8",
                       timeout=60)
    try:
        return json.loads(r.stdout)
    except Exception:
        return {"code": -1, "msg": (r.stdout or r.stderr)[-150:]}


def search(term: str) -> list[dict]:
    out, cursor = [], ""
    for _ in range(3):                      # 每词最多 3 页
        body = {"query": term, "knowledge_base_id": KB_ID, "limit": 20}
        if cursor:
            body["cursor"] = cursor
        d = call("openapi/wiki/v1/search_knowledge", body)
        if d.get("code") != 0:
            print(f"[ima] 搜索异常 {term}: {str(d.get('msg'))[:60]}", flush=True)
            break
        data = d.get("data", {})
        items = data.get("info_list", [])
        out += items
        cursor = data.get("next_cursor") or data.get("cursor") or ""
        if not cursor or not items:
            break
        time.sleep(2.5)
    return out


def fname_safe(t: str) -> str:
    return re.sub(r'[\\/:*?"<>|\r\n]', "_", t).strip()[:70] or "untitled"


def download(media_id: str, title: str) -> str:
    d = call("openapi/wiki/v1/get_media_info", {"media_id": media_id})
    if d.get("code") != 0:
        if d.get("code") == 220030:          # 瞬时抖动, 5s 重试一次
            time.sleep(5)
            d = call("openapi/wiki/v1/get_media_info", {"media_id": media_id})
        if d.get("code") != 0:
            return f"info失败:{d.get('code')}:{str(d.get('msg'))[:36]}"
    data = d.get("data") or {}
    url = (data.get("url_info") or {}).get("url") or data.get("url") or ""
    if not url:
        return "无url"
    ext = ".pdf" if ".pdf" in url or "pdf" in str(data.get("file_type", "")) else ".bin"
    dst = OUT / (fname_safe(title) + ext)
    import urllib.request
    try:
        req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
        raw = urllib.request.urlopen(req, timeout=120).read()
        dst.write_bytes(raw)
        return f"ok {len(raw)//1024}KB"
    except Exception as e:
        return f"下载失败:{type(e).__name__}"


def main() -> int:
    smoke = "--smoke" in sys.argv
    OUT.mkdir(parents=True, exist_ok=True)
    done_ids: set = set()
    if STATE.exists():
        done_ids = set(json.loads(STATE.read_text(encoding="utf-8")))
    seen, queue = set(), []
    for t in TERMS:
        for it in search(t):
            mid = it.get("media_id") or it.get("doc_id") or ""
            title = (it.get("title") or it.get("name") or "").strip()
            if not mid or mid in seen or mid in done_ids:
                continue
            seen.add(mid)
            if IRRELEVANT.search(title) or not RELEVANT.search(title):
                continue
            queue.append((mid, title))
        if smoke and len(queue) >= 3:
            break
        print(f"[ima] 词「{t}」累计候选 {len(queue)}", flush=True)
    print(f"[ima] 待下载 {len(queue)} (已跳过 {len(done_ids)})" +
          (" [冒烟3件]" if smoke else ""), flush=True)
    ok = fail = 0
    for i, (mid, title) in enumerate(queue, 1):
        note = download(mid, title)
        if note.startswith("ok"):
            ok += 1
            done_ids.add(mid)
            STATE.write_text(json.dumps(sorted(done_ids)), encoding="utf-8")
            print(f"[{i}/{len(queue)}] ✓ {title[:40]} {note}", flush=True)
        else:
            fail += 1
            print(f"[{i}/{len(queue)}] ✗ {title[:40]} {note}", flush=True)
            if "429" in note or "limit" in note.lower():
                print("[ima] 限额信号, 停 (断点续跑)", flush=True)
                break
        time.sleep(3)
    print(f"[ima] 完: 落 {ok} / 败 {fail}", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
