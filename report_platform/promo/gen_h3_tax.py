# -*- coding: utf-8 -*-
"""gen_h3_tax — TAX-2026 H3 ×3 (照 gen_h3_insure 生产法)."""
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


PROMPT_V3 = """竖屏9:16，10秒，财税实务风格视频。

画面开场（0-2秒）：墨绿色背景上一份税法文件展开，金色印章「EPC工程税务」盖下，白色大字「工程税务实务」浮现。

中段（2-6秒）：文件右侧弹出四条金色字幕「增值税」「发票攻防」「跨境常设机构」「出口退税」，下方大数字卡「12 章 · 20 万字」金色点亮。

高潮（6-9秒）：四条字幕汇入一座天平，天平上「合同」与「税单」两端平衡，金色大字「EPC工程税务实务与跨境税务实战研究报告」。

结尾（9-10秒）：墨绿收束，白色文字「每一分利润都要过一道税的关口」+底部留白。

整体色调：墨绿×金色×白色，财税文书感，无人物，纯图形动画。"""

PROMPT_V1 = """竖屏9:16，10秒，财税实务风格视频。

画面开场（0-2秒）：墨绿背景上「3633550」金色大数字砸下，随后白色副标题「结算总额」浮现，旁边小字「已开票3510000」。

中段（2-6秒）：画面出现「发票差额123550」红色字幕被一道金色横线划掉，旁边浮现「判付2733550元」金色字幕。

高潮（6-9秒）：法槌落下，金色字幕「发票是附随义务 工程款是主给付」。

结尾（9-10秒）：墨绿收束，白色文字「先开票后付款 挡不住主给付义务」+底部留白。

整体色调：墨绿×金色×红色点缀，财税感强，无人物，纯图形动画。"""

PROMPT_V2 = """竖屏9:16，10秒，财税实务风格视频。

画面开场（0-2秒）：墨绿背景上一份合同展开，「含税」与「不含税」两个金色大字分列左右，中间一个「11%」红色数字。

中段（2-6秒）：「11%」翻转变形成「9%」，两侧合同条款文字被金色光线逐条划过改写，浮现三条金色字幕「从约」「包干归承包方」「未约定不扣减」。

高潮（6-9秒）：改写完成的合同升起，金色大字「税率差利益归谁 看合同怎么写」。

结尾（9-10秒）：墨绿收束，白色文字「一个含字差出一笔税」+底部留白。

整体色调：墨绿×金色×红色点缀，财税感强，无人物，纯图形动画。"""

META = {
    "tax_v3_h3": {"title": "EPC工程税务一本讲透", "desc": "《EPC工程税务实务与跨境税务实战研究报告》上架：12章20万字250页，增值税计税方法+跨区预缴+发票攻防+税率调整+跨境常设机构+出口退税，27件税法底本+10件跨境专著+58卷判例切片。第1章免费试读。", "tags": ["EPC税务", "工程税务", "增值税", "研究报告"]},
    "tax_v1_h3": {"title": "先开票后付款挡得住工程款吗", "desc": "结算3633550元已开票3510000元差额123550元——发票差额抗辩不成立，判付2733550元及利息。发票是附随义务工程款是主给付。《EPC工程税务实务与跨境税务实战研究报告》第5章拆解，第1章免费试读。", "tags": ["发票", "工程款", "先票后款", "研究报告"]},
    "tax_v2_h3": {"title": "税率从11%降到9%利益归谁", "desc": "安徽高院从约、宁波中院包干归承包方、阳原法院未约定不扣减——三案同向：税率差利益归谁看合同怎么写。《EPC工程税务实务与跨境税务实战研究报告》第6章拆解，第1章免费试读。", "tags": ["税率调整", "增值税", "合同条款", "研究报告"]},
}

PROMPTS = {"tax_v3_h3": PROMPT_V3, "tax_v1_h3": PROMPT_V1, "tax_v2_h3": PROMPT_V2}

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
        (OUT_DIR / f"{slug}.json").write_text(json.dumps({"title": m["title"], "desc": m["desc"], "tags": m["tags"], "video": f"{slug}.mp4", "sku": "TAX-2026", "src": "h3"}, ensure_ascii=False, indent=1), encoding="utf-8")
        log(f"✓ meta {slug}.json")
    return ok

if __name__ == "__main__":
    which = sys.argv[1] if len(sys.argv) > 1 else "all"
    order = (["tax_v3_h3", "tax_v1_h3", "tax_v2_h3"] if which == "all" else [f"handov_{which}_h3"])
    n_ok = sum(1 for s in order if run_card(s))
    log(f"== 完成 {n_ok}/{len(order)} ==")
    raise SystemExit(0 if n_ok == len(order) else 1)
