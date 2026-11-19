# -*- coding: utf-8 -*-
"""gen_h3_handov — HANDOV-2026 H3 ×3 (照 gen_h3_insure 生产法)."""
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

画面开场（0-2秒）：深蓝色背景上一份竣工验收报告展开，金色印章「验收合格」盖下，白色大字「EPC竣工验收与移交」浮现。

中段（2-6秒）：报告右侧弹出四条金色字幕「五方验收」「甩项验收」「竣工日期」「资料移交」，下方大数字卡「12 章 · 21 万字」金色点亮。

高潮（6-9秒）：四条字幕汇入一座正在交接的工程钥匙与合同同框，金色大字「EPC竣工验收与移交实务实战研究报告」。

结尾（9-10秒）：深蓝收束，白色文字「验收合格不等于完事」+底部留白。

整体色调：深蓝×金色×白色，工程感强，无人物，纯图形动画。"""

PROMPT_V1 = """竖屏9:16，10秒，工程建设行业风格视频。

画面开场（0-2秒）：深蓝背景上「42494元」金色大字砸下，随后出现白色副标题「质保金攻防的真实战场」。

中段（2-6秒）：画面切分三道金色闸门——第一道「原件凭证」、第二道「实际履行」、第三道「期间与因果」，每道闸门亮起红色「未过」。

高潮（6-9秒）：三道闸门汇入法院天平，左盘「完整证据链」右盘「复印件主张」，天平倾向左侧，金色字幕「三重举证缺一不可」。

结尾（9-10秒）：深蓝收束，白色文字「质保金动钱要过三重门」+底部留白。

整体色调：深蓝×金色×灰白，工程感强，无人物，纯图形动画。"""

PROMPT_V2 = """竖屏9:16，10秒，工程建设行业风格视频。

画面开场（0-2秒）：深蓝背景上一条时间轴展开，三个金色节点依次点亮「缺陷责任期」「保修期」「质保金存续期」，白色大字「三条期间轨」。

中段（2-6秒）：三条轨道并行延伸，各自尽头弹出金色字幕——钱轨「质保金返还」、责轨「修复义务存续」、合同轨「扣留期间」，中间红色警示「互不吸收」。

高潮（6-9秒）：一本厚书升起，金色大字「工程交出去了 责任什么时候交割完」。

结尾（9-10秒）：深蓝收束，白色文字「钱与责是两条轨」+底部留白。

整体色调：深蓝×金色×红色点缀，工程感强，无人物，纯图形动画。"""

META = {
    "handov_v3_h3": {"title": "EPC竣工验收与移交一本讲透", "desc": "《EPC竣工验收与移交实务实战研究报告》上架：12章21万字256页，五方验收/甩项验收/竣工日期/资料移交/风险转移/缺陷责任期/质保金/保修/结算联动+国际FIDIC三证书，跨池9892件弹药判例实锚。第1章免费试读。", "tags": ["竣工验收", "工程移交", "EPC", "研究报告"]},
    "handov_v1_h3": {"title": "质保金被扣的业主输在哪", "desc": "42494元配件主张三重举证全败——原件凭证、实际履行、期间因果，缺一件就是标准败诉配方。《EPC竣工验收与移交实务实战研究报告》第10章拆解，第1章免费试读。", "tags": ["质保金", "质量抗辩", "工程款", "研究报告"]},
    "handov_v2_h3": {"title": "验收合格后责任什么时候清零", "desc": "缺陷责任期、保修期、质保金存续期三条期间轨并行——钱轨责轨互不吸收，最高法典型案例的退场起算规则。《EPC竣工验收与移交实务实战研究报告》第8章拆解，第1章免费试读。", "tags": ["缺陷责任期", "保修义务", "移交", "研究报告"]},
}

PROMPTS = {"handov_v3_h3": PROMPT_V3, "handov_v1_h3": PROMPT_V1, "handov_v2_h3": PROMPT_V2}

def run_card(slug):
    log(f"== HANDOV H3: {slug} ==")
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
        (OUT_DIR / f"{slug}.json").write_text(json.dumps({"title": m["title"], "desc": m["desc"], "tags": m["tags"], "video": f"{slug}.mp4", "sku": "HANDOV-2026", "src": "h3"}, ensure_ascii=False, indent=1), encoding="utf-8")
        log(f"✓ meta {slug}.json")
    return ok

if __name__ == "__main__":
    which = sys.argv[1] if len(sys.argv) > 1 else "all"
    order = (["handov_v3_h3", "handov_v1_h3", "handov_v2_h3"] if which == "all" else [f"handov_{which}_h3"])
    n_ok = sum(1 for s in order if run_card(s))
    log(f"== 完成 {n_ok}/{len(order)} ==")
    raise SystemExit(0 if n_ok == len(order) else 1)
