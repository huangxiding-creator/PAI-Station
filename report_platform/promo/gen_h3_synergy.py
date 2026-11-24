# -*- coding: utf-8 -*-
"""gen_h3_synergy — SYNERGY-2026 H3 ×3 (照 gen_h3_tax 生产法)."""
import os, sys, time, json, requests
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).parent))

ENV = Path(r"F:\We-AIPO\.env")
if ENV.exists():
    for line in ENV.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if "=" in line and not line.startswith("#"):
            k, _, v = line.partition("=")
            k, v = k.strip(), v.strip().strip("'\"")
            if k and v and k not in os.environ:
                os.environ[k] = v

_BASE_URL = "https://metaso.cn/api/minimax"
_TOKEN = os.environ.get("MINIMAX_TOKEN", "")
_MODEL = "MiniMax-H3"
_POLL_INTERVAL = 15
_MAX_WAIT = 600
OUT_DIR = Path(r"E:\AI-Station\report_platform\promo\videos")
SKU = "SYNERGY-2026"


def log(msg): print(msg, flush=True)


def generate(prompt, resolution="768P", duration=10):
    headers = {"Authorization": f"Bearer {_TOKEN}", "Content-Type": "application/json"}
    payload = {"model": _MODEL, "content": [{"type": "text", "text": prompt}],
               "resolution": resolution, "duration": duration, "ratio": "9:16"}
    resp = requests.post(f"{_BASE_URL}/v2/video_generation", headers=headers, json=payload, timeout=30)
    data = resp.json()
    if data.get("code") and data["code"] != 0: return None
    task_id = data.get("task_id") or data.get("data", {}).get("task_id")
    if not task_id: return None
    log(f"task_id: {task_id}")
    deadline = time.time() + _MAX_WAIT
    while time.time() < deadline:
        time.sleep(_POLL_INTERVAL)
        try:
            resp = requests.get(f"{_BASE_URL}/v2/query/video_generation/{task_id}", headers=headers, timeout=15)
            result = resp.json()
            task = result.get("task", {})
            status = task.get("status", "")
            if status in ("succeed", "succeeded", "SUCCEEDED", "completed", "done"):
                content = task.get("content", {})
                url = (content.get("url", "") if isinstance(content, dict) else "")
                return url if url else None
            if status in ("failed", "FAILED", "error"): return None
            log(f"等待... status={status}")
        except Exception as e: log(f"轮询异常: {e}")
    return None


def download(url, out_path):
    try:
        resp = requests.get(url, stream=True, timeout=120)
        with open(out_path, "wb") as f:
            for chunk in resp.iter_content(chunk_size=8192): f.write(chunk)
        return out_path.exists() and out_path.stat().st_size > 50_000
    except: return False


PROMPT_V3 = """竖屏9:16，10秒，工程实务风格视频。

画面开场（0-2秒）：墨绿色背景上一张施工图纸展开，图纸中线两侧分别是蓝色线稿的建筑立面与橙色线稿的脚手架场景，两条线在中缝汇成一座金色桥梁。

中段（2-6秒）：桥面上依次弹出四条金色字幕「设计管理」「优化收益」「变更界分」「界面管控」，下方大数字卡「12 章 · 36 万字」金色点亮。

高潮（6-9秒）：图纸卷起合成一册报告，金色大字「EPC设计施工协同与利润分配实战研究报告」。

结尾（9-10秒）：墨绿收束，白色文字「协同做好 利润落袋」+底部留白。

整体色调：墨绿×金色×蓝橙点缀，工程图纸感，无人物，纯图形动画。"""

PROMPT_V1 = """竖屏9:16，10秒，工程实务风格视频。

画面开场（0-2秒）：墨绿背景上「3米」金色大数字砸下，旁边「1米」白色数字随即浮现，两数字之间出现一道裂缝。

中段（2-6秒）：裂缝上方弹出白色字幕「路基设计」与「工程量清单」对不上，一条金色路径从裂缝上方架过去，字幕「走变更程序」金色点亮。

高潮（6-9秒）：金色大字「图纸与清单不符 唯一安全出口」。

结尾（9-10秒）：墨绿收束，白色文字「先干了再说=自己扛差价」+底部留白。

整体色调：墨绿×金色×红色裂缝点缀，工程感强，无人物，纯图形动画。"""

PROMPT_V2 = """竖屏9:16，10秒，工程实务风格视频。

画面开场（0-2秒）：墨绿背景上十张文件卡片横排展开，随后只有四张卡片盖上金色对勾印章，其余六张变灰。

中段（2-6秒）：灰色卡片碎裂消失，白色字幕「口头默契」被金色横线划掉，浮现金色字幕「十份变更单 仅四份获确认」。

高潮（6-9秒）：一份卷宗合上，金色大字「界面上的口头默契 卷宗里一文不值」。

结尾（9-10秒）：墨绿收束，白色文字「先签变更单 再动工」+底部留白。

整体色调：墨绿×金色×灰色点缀，工程感强，无人物，纯图形动画。"""

META = {
    "synergy_v3_h3": {"title": "设计施工协同一本讲透", "desc": "《EPC设计施工协同与利润分配实战研究报告》上架：12章36万字421页，设计管理衔接+优化收益归属+变更界分+利润分配条款+界面失效模式+联合体追偿+税务合规，判例四段式+失效模式目录+协同自查台账。第1章免费试读。", "tags": ["EPC", "工程总承包", "设计施工协同", "研究报告"]},
    "synergy_v1_h3": {"title": "图纸与清单对不上怎么办", "desc": "路基设计3米清单只有1米——法院给出的唯一安全出口是走变更程序，而不是先干了再说。《EPC设计施工协同与利润分配实战研究报告》第3章拆解优化收益归属与计价口径，第1章免费试读。", "tags": ["工程变更", "工程量清单", "结算", "研究报告"]},
    "synergy_v2_h3": {"title": "十份变更单只有四份算数", "desc": "合同约定先签工程项目变更单，十份变更单仅四份获确认——界面上的口头默契在卷宗里一文不值。《EPC设计施工协同与利润分配实战研究报告》第6章14行失效模式目录对照断裂环节与法院分责依据，第1章免费试读。", "tags": ["变更签证", "界面管理", "工程判例", "研究报告"]},
}

PROMPTS = {"synergy_v3_h3": PROMPT_V3, "synergy_v1_h3": PROMPT_V1, "synergy_v2_h3": PROMPT_V2}

def run_card(slug):
    log(f"== SYNERGY H3: {slug} ==")
    url = generate(PROMPTS[slug])
    ok = False
    if url:
        out = OUT_DIR / f"{slug}.mp4"
        if download(url, out):
            log(f"✓ {out.name} | {out.stat().st_size:,}B"); ok = True
        else: log("下载失败")
    else: log("生成失败")
    if ok:
        m = META[slug]
        (OUT_DIR / f"{slug}.json").write_text(json.dumps({"title": m["title"], "desc": m["desc"], "tags": m["tags"], "video": f"{slug}.mp4", "sku": SKU, "src": "h3"}, ensure_ascii=False, indent=1), encoding="utf-8")
        log(f"✓ meta {slug}.json")
    return ok

if __name__ == "__main__":
    which = sys.argv[1] if len(sys.argv) > 1 else "all"
    order = (["synergy_v3_h3", "synergy_v1_h3", "synergy_v2_h3"] if which == "all" else [f"synergy_{which}_h3"])
    n_ok = sum(1 for s in order if run_card(s))
    log(f"[done] {n_ok}/{len(order)}")
