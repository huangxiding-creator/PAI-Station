# -*- coding: utf-8 -*-
"""gen_h3_jes2 — JES2-2026 H3 ×3 (照 gen_h3_insure 生产法)."""
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


PROMPT_V3 = """竖屏9:16，10秒，法律实务风格视频。

画面开场（0-2秒）：深红色背景上一份司法解释文件展开，金色印章「法释〔2026〕12号」盖下，白色大字「建工司法解释二」浮现。

中段（2-6秒）：文件右侧弹出四条金色字幕「合同效力」「黑白合同」「实际施工人」「优先受偿权」，下方大数字卡「23 条逐条 × 12 章」金色点亮。

高潮（6-9秒）：四条字幕汇入一座天平，天平两侧升起「六立场攻防矩阵」金色大字「建工司法解释二逐条实务与多立场应对实战研究报告」。

结尾（9-10秒）：深红收束，白色文字「一部解释 六种立场」+底部留白。

整体色调：深红×金色×白色，法律文书感，无人物，纯图形动画。"""

PROMPT_V1 = """竖屏9:16，10秒，法律实务风格视频。

画面开场（0-2秒）：深红背景上「三类主体」四个金色大字砸下，随后白色副标题「实际施工人的彻底重构」。

中段（2-6秒）：画面三列金色阶梯——「转包」「违法分包」「挂靠」依次点亮，中间浮现金色箭头汇聚到「代位权通道」四个大字。

高潮（6-9秒）：法槌落下敲响，金色字幕「直索收窄 代位登场」，天平重新配平。

结尾（9-10秒）：深红收束，白色文字「身份先分类 求偿走对门」+底部留白。

整体色调：深红×金色×灰白，法律感强，无人物，纯图形动画。"""

PROMPT_V2 = """竖屏9:16，10秒，法律实务风格视频。

画面开场（0-2秒）：深蓝背景上一份旧判决书展开，红色印章「2009-2021旧案」盖下，白色大字「旧案新规翻转推演」。

中段（2-6秒）：判决书上的旧结论文字被金色光线逐条划过改写——「无效≠白干」「参照约定折价」「鉴定启动权换位」三条金色新字幕依次浮现。

高潮（6-9秒）：改写完成的新判决书升起，金色大字「新规则的逻辑在真实案卷上过一遍」。

结尾（9-10秒）：深蓝收束，白色文字「推演不是预言 是沙盘」+底部留白。

整体色调：深蓝×金色×红色点缀，法律感强，无人物，纯图形动画。"""

META = {
    "jes2_v3_h3": {"title": "建工司法解释二一本讲透", "desc": "《建工司法解释二逐条实务与多立场应对实战研究报告》上架：12章20万字253页，23条逐条×六立场攻防矩阵×旧案新规翻转推演，54卷判例切片+官方全文与答记者问定调底本。第1章全章免费试读。", "tags": ["建工解释二", "司法解释", "建设工程", "研究报告"]},
    "jes2_v1_h3": {"title": "实际施工人新规彻底重构", "desc": "三类主体划分+代位权通道——笼统的「实际施工人」表述告别历史，直索发包人的老路收窄。《建工司法解释二逐条实务与多立场应对实战研究报告》第4章拆解，第1章免费试读。", "tags": ["实际施工人", "代位权", "转包", "研究报告"]},
    "jes2_v2_h3": {"title": "旧判例放到新规下会怎么判", "desc": "2009-2021真实判例按23条逐条推演结论变化——量价分离、参照折价、鉴定启动权换位，每处显式标注推演性质。《建工司法解释二逐条实务与多立场应对实战研究报告》第11章拆解，第1章免费试读。", "tags": ["旧案新规", "判例推演", "建工纠纷", "研究报告"]},
}

PROMPTS = {"jes2_v3_h3": PROMPT_V3, "jes2_v1_h3": PROMPT_V1, "jes2_v2_h3": PROMPT_V2}

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
        (OUT_DIR / f"{slug}.json").write_text(json.dumps({"title": m["title"], "desc": m["desc"], "tags": m["tags"], "video": f"{slug}.mp4", "sku": "JES2-2026", "src": "h3"}, ensure_ascii=False, indent=1), encoding="utf-8")
        log(f"✓ meta {slug}.json")
    return ok

if __name__ == "__main__":
    which = sys.argv[1] if len(sys.argv) > 1 else "all"
    order = (["jes2_v3_h3", "jes2_v1_h3", "jes2_v2_h3"] if which == "all" else [f"handov_{which}_h3"])
    n_ok = sum(1 for s in order if run_card(s))
    log(f"== 完成 {n_ok}/{len(order)} ==")
    raise SystemExit(0 if n_ok == len(order) else 1)
