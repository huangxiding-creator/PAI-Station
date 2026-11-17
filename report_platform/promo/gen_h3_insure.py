# -*- coding: utf-8 -*-
"""gen_h3_insure — INSURE-2026 H3 ×3 (照生产法)."""
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


PROMPT_V3 = """竖屏9:16，10秒，工程建设行业风格视频。

画面开场（0-2秒）：深蓝色背景上一份保函文件展开，金色印章「独立保函」盖下，白色大字「EPC工程保险与保函」浮现。

中段（2-6秒）：保函右侧弹出三条金色字幕「履约保函」「工程一切险」「保函欺诈例外」，下方大数字卡「12 章 · 25 万字」金色点亮。

高潮（6-9秒）：三条字幕汇入一本升起的厚书，金色大字「EPC工程保险与保函实务研究报告」。

结尾（9-10秒）：深蓝收束，白色文字「保函管信用 保险管意外」+底部留白。

整体色调：深蓝×金色×白色，工程感强，无人物，纯图形动画。"""

PROMPT_V1 = """竖屏9:16，10秒，工程建设行业风格视频。

画面开场（0-2秒）：深蓝背景上「见索即付」四个金色大字砸下，随后出现白色副标题「独立保函最锋利的刀」。

中段（2-6秒）：画面切分两列——左侧金色字幕「虚假陈述」「明显滥用权利」「恶意索赔」，右侧金色字幕「欺诈例外」「止付令」「善意付款抗辩」。

高潮（6-9秒）：中间升起法槌与保函同框，金色大字「独立保函唯一的刹车」。

结尾（9-10秒）：深蓝收束，白色文字「欺诈例外是唯一的防线」+底部留白。

整体色调：深蓝×金色×灰白，工程感强，无人物，纯图形动画。"""

PROMPT_V2 = """竖屏9:16，10秒，工程建设行业风格视频。

画面开场（0-2秒）：深蓝背景上一张保险单放大，红色印章「除外责任」盖下，白色大字「工程一切险的真战场」。

中段（2-6秒）：保险单展开显示金色清单「设计错误除外」「战争除外」「故意行为除外」，右侧金色字幕「72小时报案」「定损→实赔差距」。

高潮（6-9秒）：清单汇入法院天平，左盘「完整证据链」右盘「笼统投保」，天平倾向左侧，金色字幕「理赔能否成功看条款」。

结尾（9-10秒）：深蓝收束，白色文字「投保前看清除外责任」+底部留白。

整体色调：深蓝×金色×红色点缀，工程感强，无人物，纯图形动画。"""

META = {
    "insure_v3_h3": {"title": "EPC工程保险与保函一本讲透", "desc": "《EPC工程保险与保函实务研究报告》上架：12章25万字370+页，投标/履约/预付款/质保金保函+工程一切险/保证保险/IDI/职业责任险，1.9亿字弹药池判例实锚。第1章免费试读。", "tags": ["工程保函", "工程保险", "EPC", "研究报告"]},
    "insure_v1_h3": {"title": "见索即付的独立保函怎么防", "desc": "虚假陈述、明显滥用权利、恶意索赔——独立保函的欺诈例外规则与止付令程序。《EPC工程保险与保函实务研究报告》第9章专章拆解，第1章免费试读。", "tags": ["独立保函", "见索即付", "保函欺诈", "研究报告"]},
    "insure_v2_h3": {"title": "工程一切险的除外责任才是真战场", "desc": "设计错误除外、战争除外、72小时报案条款——投保前不看条款，理赔时才发现损失全被排除。《EPC工程保险与保函实务研究报告》第6章拆解，第1章免费试读。", "tags": ["工程一切险", "除外责任", "工程保险", "研究报告"]},
}

PROMPTS = {"insure_v3_h3": PROMPT_V3, "insure_v1_h3": PROMPT_V1, "insure_v2_h3": PROMPT_V2}

def run_card(slug):
    log(f"== INSURE H3: {slug} ==")
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
        (OUT_DIR / f"{slug}.json").write_text(json.dumps({"title": m["title"], "desc": m["desc"], "tags": m["tags"], "video": f"{slug}.mp4", "sku": "INSURE-2026", "src": "h3"}, ensure_ascii=False, indent=1), encoding="utf-8")
        log(f"✓ meta {slug}.json")
    return ok

if __name__ == "__main__":
    which = sys.argv[1] if len(sys.argv) > 1 else "all"
    order = (["insure_v3_h3", "insure_v1_h3", "insure_v2_h3"] if which == "all" else [f"insure_{which}_h3"])
    n_ok = sum(1 for s in order if run_card(s))
    log(f"== 完成 {n_ok}/{len(order)} ==")
    raise SystemExit(0 if n_ok == len(order) else 1)
