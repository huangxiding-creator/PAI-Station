# -*- coding: utf-8 -*-
"""gen_h3_top50 — TOP50-2026 H3 视频生成 ×3 (复刻 gen_h3_sched.py 生产法:
We-AIPO MiniMax-H3 API). 脚本与 meta 全出 promo/top50_h3_scripts.md (1029 预装备),
成书指标已按 s3_run_manifest.json 实测回填 (12章/23.0万字/229,599 CJK/331页).
卡序: v3=卡A 主卡(50强格局·上架卡位) v1=卡B(央企座次) v2=卡C(设计院反差).
用法: py -X utf8 gen_h3_top50.py [v3|v1|v2|all]
"""
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


def log(msg):
    print(msg, flush=True)


def generate(prompt, resolution="768P", duration=10):
    headers = {"Authorization": f"Bearer {_TOKEN}",
               "Content-Type": "application/json"}
    payload = {"model": _MODEL, "content": [{"type": "text", "text": prompt}],
               "resolution": resolution, "duration": duration, "ratio": "9:16"}
    resp = requests.post(f"{_BASE_URL}/v2/video_generation",
                         headers=headers, json=payload, timeout=30)
    data = resp.json()
    if data.get("code") and data["code"] != 0:
        log(f"创建失败: {data.get('message', str(data)[:100])}")
        return None
    task_id = data.get("task_id") or data.get("data", {}).get("task_id")
    if not task_id:
        log(f"无task_id: {str(data)[:100]}")
        return None
    log(f"task_id: {task_id}")
    deadline = time.time() + _MAX_WAIT
    while time.time() < deadline:
        time.sleep(_POLL_INTERVAL)
        try:
            resp = requests.get(
                f"{_BASE_URL}/v2/query/video_generation/{task_id}",
                headers=headers, timeout=15)
            result = resp.json()
            task = result.get("task", {})
            status = task.get("status", "")
            if status in ("succeed", "succeeded", "SUCCEEDED",
                          "completed", "done"):
                content = task.get("content", {})
                url = (content.get("url", "")
                       if isinstance(content, dict) else "")
                if url:
                    return url
                log(f"成功但无URL: {str(result)[:150]}")
                return None
            if status in ("failed", "FAILED", "error"):
                log(f"生成失败: {str(result)[:100]}")
                return None
            log(f"等待... status={status}")
        except Exception as e:  # noqa: BLE001
            log(f"轮询异常: {e}")
    log(f"超时({_MAX_WAIT}s)")
    return None


def download(url, out_path):
    try:
        resp = requests.get(url, stream=True, timeout=120)
        with open(out_path, "wb") as f:
            for chunk in resp.iter_content(chunk_size=8192):
                f.write(chunk)
        return out_path.exists() and out_path.stat().st_size > 50_000
    except Exception as e:  # noqa: BLE001
        log(f"下载异常: {e}")
        return False


# ---- 画面脚本 (promo/top50_h3_scripts.md 逐字) ----

PROMPT_V3 = """竖屏9:16，10秒，工程建设行业风格视频。

画面开场（0-2秒）：深蓝色背景上一张巨型榜单自上而下展开，金色横条逐行点亮，白色大字「2025 总承包营业额排名」浮现，副字幕「178 家上榜」金色标注。

中段（2-6秒）：榜单顶部一条金色横条冲出放光，弹出字幕「榜首 454.9 亿元」，随后镜头下拉，金色刻度线上标出「200亿俱乐部 仅 2 家」「100亿梯队 8 家」，每条配金色边框与数字强调。

高潮（6-9秒）：50 行企业名化作 50 枚金色方块阵列，深蓝底色分出三个梯队色带，字幕「50 强全景 · 一册拆透」。

结尾（9-10秒）：深蓝收束，一本厚书从底部升起，白色文字「12 章 · 深度研究报告」+底部留白。

整体色调：深蓝×金色×白色，工程感强，无人物，纯图形动画。"""

PROMPT_V1 = """竖屏9:16，10秒，工程建设行业风格视频。

画面开场（0-2秒）：深蓝色背景上八根金色立柱依次升起，白色大字「八大央企营收座次」，副字幕「FY2025 · 营业总收入」。

中段（2-6秒）：立柱按高度重排位次，逐条弹出字幕：「中国建筑 20,821亿」「中国中铁 10,935亿」「中国铁建 10,298亿」「中国交建 7,311亿」「中国电建 6,462亿」，数字用金色大字强调，尾注「上市公司口径 · 数仓实测」。

高潮（6-9秒）：画面切到一张设计院榜单卡，金色高亮「设计院系榜首 454.9亿」，字幕「集团军之外 · 设计院系正在改写榜面」。

结尾（9-10秒）：深蓝收束，白色文字「央企体系 · 逐企拆解」+底部留白。

整体色调：深蓝×金色×白色，工程感强，无人物，纯图形动画。"""

PROMPT_V2 = """竖屏9:16，10秒，工程建设行业风格视频。

画面开场（0-2秒）：画面左右分屏。左半深蓝底金色大字「榜首 454.9 亿」，右半灰蓝色底白色大字「月薪 4800 元」，中间一道金色裂缝。

中段（2-6秒）：左侧弹出字幕「设计院系总承包榜首 · 连年霸榜」，右侧依次弹出灰白字幕「一线城市 设计师月到手3、4千」「6个月 没等到工资」「从业5年 收入近乎减半」，右侧字幕逐条加暗红色下划线。

高潮（6-9秒）：裂缝中升起一条金色路径，字幕「转型 EPC · 路径与模式逐条拆解」，左右两半向金色路径收拢。

结尾（9-10秒）：深蓝收束，白色文字「同一行业 · 两种命运」+底部留白。

整体色调：深蓝×金色×灰白，工程感强，无人物，纯图形动画。"""

# ---- 视频卡 meta (top50_h3_scripts.md · 成书指标已实测回填) ----

META = {
    "top50_v3_h3": {
        "title": "总承包50强一张榜摊开",
        "desc": ("《工程企业工程总承包业务全景研究报告：2025 TOP50》上架："
                 "12章23.0万字331页，榜单格局+央企体系+赛道分化+设计院转型+分档画像，"
                 "2867.6万字调研底账。第1章免费试读。"),
        "tags": ["工程总承包", "EPC", "TOP50", "行业格局"],
    },
    "top50_v1_h3": {
        "title": "八大央企营收座次实测",
        "desc": ("中国建筑20,821亿领跑，中铁、铁建破万亿；设计院系华东院454.9亿登上总承包榜首"
                 "——集团军与设计院系同榜竞技。《工程企业工程总承包业务全景研究报告：2025 TOP50》"
                 "12章逐企拆解，第1章免费试读。"),
        "tags": ["央企", "工程总承包", "营收排名", "研究报告"],
    },
    "top50_v2_h3": {
        "title": "同是设计院，命运两重天",
        "desc": ("一边是454.9亿的总承包榜首设计院，一边是月薪4800、数月欠薪的行业寒潮"
                 "——分野就在转型EPC的路径选择上。《工程企业工程总承包业务全景研究报告：2025 TOP50》"
                 "第6章专章拆解设计院转型路径与模式，第1章免费试读。"),
        "tags": ["设计院", "EPC转型", "行业变局", "研究报告"],
    },
}

PROMPTS = {"top50_v3_h3": PROMPT_V3, "top50_v1_h3": PROMPT_V1,
           "top50_v2_h3": PROMPT_V2}


def run_card(slug):
    log(f"== TOP50 H3 生成: {slug} ==")
    url = generate(PROMPTS[slug])
    ok = False
    if url:
        out = OUT_DIR / f"{slug}.mp4"
        if download(url, out):
            log(f"✓ {out.name} | {out.stat().st_size:,} bytes")
            ok = True
        else:
            log("下载失败")
    else:
        log("生成失败")
    if ok:
        m = META[slug]
        (OUT_DIR / f"{slug}.json").write_text(json.dumps(
            {"title": m["title"], "desc": m["desc"], "tags": m["tags"],
             "video": f"{slug}.mp4", "sku": "TOP50-2026", "src": "h3"},
            ensure_ascii=False, indent=1), encoding="utf-8")
        log(f"✓ meta {slug}.json")
    return ok


if __name__ == "__main__":
    which = sys.argv[1] if len(sys.argv) > 1 else "all"
    order = (["top50_v3_h3", "top50_v1_h3", "top50_v2_h3"]
             if which == "all" else [f"top50_{which}_h3"])
    if order[0] not in PROMPTS:
        log(f"未知卡: {which}")
        raise SystemExit(2)
    n_ok = sum(1 for s in order if run_card(s))
    log(f"== 完成 {n_ok}/{len(order)} ==")
    raise SystemExit(0 if n_ok == len(order) else 1)
