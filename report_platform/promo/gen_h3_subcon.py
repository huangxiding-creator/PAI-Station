# -*- coding: utf-8 -*-
"""gen_h3_subcon — SUBCON-2026 H3 ×3."""
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
            if k and v and k not in os.environ: os.environ[k] = v

_BASE_URL = "https://metaso.cn/api/minimax"
_TOKEN = os.environ.get("MINIMAX_TOKEN", "")
_MODEL = "MiniMax-H3"
_POLL_INTERVAL = 15
_MAX_WAIT = 600
OUT_DIR = Path(r"E:\AI-Station\report_platform\promo\videos")

def log(m): print(m, flush=True)

def generate(prompt, resolution="768P", duration=10):
    headers = {"Authorization": f"Bearer {_TOKEN}", "Content-Type": "application/json"}
    payload = {"model": _MODEL, "content": [{"type": "text", "text": prompt}], "resolution": resolution, "duration": duration, "ratio": "9:16"}
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
            log(f"等待... {status}")
        except: pass
    return None

def download(url, out_path):
    try:
        resp = requests.get(url, stream=True, timeout=120)
        with open(out_path, "wb") as f:
            for chunk in resp.iter_content(chunk_size=8192): f.write(chunk)
        return out_path.exists() and out_path.stat().st_size > 50_000
    except: return False

PROMPT_V3 = """竖屏9:16，10秒，工程建设行业风格视频。

画面开场（0-2秒）：深蓝背景上一份分包合同文档展开，红色印章「连带责任」盖下，白色大字「EPC分包与总分包界面管理」浮现。

中段（2-6秒）：合同右侧弹出三条金色字幕「转包红线」「挂靠风险」「背靠背攻防」，下方大数字卡「12 章 · 90 万字」金色点亮。

高潮（6-9秒）：三条字幕汇入一本升起的厚书，金色大字「EPC分包与总分包界面管理实战研究报告」。

结尾（9-10秒）：深蓝收束，白色文字「分包的事故就是总包的事故」+底部留白。

整体色调：深蓝×金色×白色，工程感强，无人物，纯图形动画。"""

PROMPT_V1 = """竖屏9:16，10秒，工程建设行业风格视频。

画面开场（0-2秒）：画面左右分屏。左半深蓝底金色大字「合法分包」，右半灰蓝底白色大字「违法转包」，中间红色裂缝。

中段（2-6秒）：左侧弹出金色字幕「主体结构不分包」「专业工程有资质」「劳务≠派遣」，右侧灰色字幕「层层转包」「借照挂靠」「指定无据」逐条加红叉。

高潮（6-9秒）：裂缝中升起法槌与分包合同同框，金色大字「分包的法律边界」。

结尾（9-10秒）：深蓝收束，白色文字「踩线=合同无效+连带追责」+底部留白。

整体色调：深蓝×金色×红色点缀，工程感强，无人物，纯图形动画。"""

PROMPT_V2 = """竖屏9:16，10秒，工程建设行业风格视频。

画面开场（0-2秒）：深蓝背景上「背靠背条款」五个金色大字出现，随后一个锁链图标连接「总包」和「分包」两个方块。

中段（2-6秒）：锁链断裂动画，弹出三个裁判结果：「支持·意思自治」「否定·显失公平」「折中·善意履行」，各配天平图标。

高潮（6-9秒）：画面切至法院外景剪影，金色大字「背靠背条款的裁判规则全解」。

结尾（9-10秒）：深蓝收束，白色文字「证据链决定条款命运」+底部留白。

整体色调：深蓝×金色×灰白，工程感强，无人物，纯图形动画。"""

META = {
    "subcon_v3_h3": {"title": "EPC分包界面管理一本讲透", "desc": "《EPC分包与总分包界面管理实战研究报告》上架：12章90万字350+页，转包红线+挂靠体系+背靠背攻防+连带责任+FIDIC国际分包，2.3亿字弹药池判例实锚。第1章免费试读。", "tags": ["分包", "总分包", "EPC", "研究报告"]},
    "subcon_v1_h3": {"title": "合法分包与违法转包的分野", "desc": "主体结构不能分包、专业工程须有资质、劳务≠派遣——三条红线踩线后果：合同无效+实际施工人直诉+行政处罚。《EPC分包与总分包界面管理实战研究报告》第2章拆解。", "tags": ["转包", "违法分包", "法律边界", "研究报告"]},
    "subcon_v2_h3": {"title": "背靠背条款还能用吗", "desc": "支持派vs否定派vs折中派——背靠背条款的裁判口径分化与善意履行的证据组织。《EPC分包与总分包界面管理实战研究报告》第10章拆解。", "tags": ["背靠背", "分包结算", "工程款", "研究报告"]},
}

PROMPTS = {"subcon_v3_h3": PROMPT_V3, "subcon_v1_h3": PROMPT_V1, "subcon_v2_h3": PROMPT_V2}

def run_card(slug):
    log(f"== SUBCON H3: {slug} ==")
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
        (OUT_DIR / f"{slug}.json").write_text(json.dumps({"title": m["title"], "desc": m["desc"], "tags": m["tags"], "video": f"{slug}.mp4", "sku": "SUBCON-2026", "src": "h3"}, ensure_ascii=False, indent=1), encoding="utf-8")
    return ok

if __name__ == "__main__":
    which = sys.argv[1] if len(sys.argv) > 1 else "all"
    order = (["subcon_v3_h3", "subcon_v1_h3", "subcon_v2_h3"] if which == "all" else [f"subcon_{which}_h3"])
    n_ok = sum(1 for s in order if run_card(s))
    log(f"== 完成 {n_ok}/{len(order)} ==")
    raise SystemExit(0 if n_ok == len(order) else 1)
