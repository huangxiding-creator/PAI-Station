# -*- coding: utf-8 -*-
"""gen_h3_ess — ESS-2026 H3 视频生成 ×3 (复刻 gen_h3_top50.py 生产法).
成书指标: 12章/26.2万字/262,341 CJK/382页 (s3_run_manifest 实测).
卡序: v3=卡A 主卡(市场洗牌·上架卡位) v1=卡B(技术路线与成本) v2=卡C(政策重写收益模型).
用法: py -X utf8 gen_h3_ess.py [v3|v1|v2|all]
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


PROMPT_V3 = """竖屏9:16，10秒，工程建设行业风格视频。

画面开场（0-2秒）：深蓝色背景上光伏矩阵与储能电池舱的剪影依次亮起金色轮廓，白色大字「储能与光伏EPC」浮现，副字幕「进入洗牌期」金色标注。

中段（2-6秒）：画面分出三条金色光带，逐条弹出字幕「市场与投标决策」「技术方案与成本管控」「履约与风控」，每条配金色边框；随后大数字卡亮起「12 章 · 26.2 万字 · 382 页」。

高潮（6-9秒）：三条光带汇入中央一本升起的厚书，金色大字「国际储能与光伏EPC总承包投标实战研究报告」。

结尾（9-10秒）：深蓝收束，白色文字「洗牌期 · 算得准才活得下」+底部留白。

整体色调：深蓝×金色×白色，工程感强，无人物，纯图形动画。"""

PROMPT_V1 = """竖屏9:16，10秒，工程建设行业风格视频。

画面开场（0-2秒）：深蓝色背景上一台天平升起，左盘金色大字「技术路线」，右盘金色大字「全生命周期成本」，白色大字「选型不看谁最新」。

中段（2-6秒）：天平右盘下沉发光，弹出字幕「磷酸铁锂 vs 液流」「液冷 vs 风冷」「构网型 · 黑启动支撑」，尾注「度电成本 LCOE 实测对勘」金色标注。

高潮（6-9秒）：画面切到一张概算表格卡，金色高亮「概算四法 · 动态调价算式」，字幕「报价底线 · 元/Wh 坐标」。

结尾（9-10秒）：深蓝收束，白色文字「技术标 · 成本标 · 一册讲透」+底部留白。

整体色调：深蓝×金色×白色，工程感强，无人物，纯图形动画。"""

PROMPT_V2 = """竖屏9:16，10秒，工程建设行业风格视频。

画面开场（0-2秒）：画面左右分屏。左半灰蓝色底白色大字「旧模型 · 单一价差」，右半深蓝底金色大字「容量电价 + 现货套利」，中间一道金色裂缝。

中段（2-6秒）：右侧依次弹出金色字幕「发改价格〔2026〕114号」「清单制管理 · 顶峰能力折算」，左侧灰白字幕「测算失真 · 可研作废」逐条加暗红色下划线。

高潮（6-9秒）：裂缝中升起一张电网拓扑图，金色高亮节点，字幕「电网节点容量 · 独立储能第一约束」。

结尾（9-10秒）：深蓝收束，白色文字「政策线 · 电网线 · 收益线」+底部留白。

整体色调：深蓝×金色×灰白，工程感强，无人物，纯图形动画。"""

META = {
    "ess_v3_h3": {
        "title": "储能与光伏EPC进入洗牌期",
        "desc": ("《国际储能与光伏EPC总承包投标实战研究报告·2026》上架："
                 "12章26.2万字382页，市场全景+技术路线+成本管控+政策并网+海外FIDIC，"
                 "37渠道306件语料底账。第1章免费试读。"),
        "tags": ["储能EPC", "光伏EPC", "总承包投标", "研究报告"],
    },
    "ess_v1_h3": {
        "title": "储能技术选型算的是全生命周期的账",
        "desc": ("磷酸铁锂还是液流、液冷还是风冷、构网型要不要上——选型失误的代价是度电成本失控。"
                 "《国际储能与光伏EPC总承包投标实战研究报告·2026》第2-4章拆解技术路线、"
                 "组件采购与造价指标，第1章免费试读。"),
        "tags": ["储能", "技术路线", "LCOE", "研究报告"],
    },
    "ess_v2_h3": {
        "title": "114号文重写了储能收益模型",
        "desc": ("容量电价叠加现货套利，独立储能从资源开发转向资产运营博弈；电网节点容量成为第一约束。"
                 "《国际储能与光伏EPC总承包投标实战研究报告·2026》第5-7章政策线电网线收益线三线拆解，"
                 "第1章免费试读。"),
        "tags": ["储能政策", "容量电价", "独立储能", "研究报告"],
    },
}

PROMPTS = {"ess_v3_h3": PROMPT_V3, "ess_v1_h3": PROMPT_V1,
           "ess_v2_h3": PROMPT_V2}


def run_card(slug):
    log(f"== ESS H3 生成: {slug} ==")
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
             "video": f"{slug}.mp4", "sku": "ESS-2026", "src": "h3"},
            ensure_ascii=False, indent=1), encoding="utf-8")
        log(f"✓ meta {slug}.json")
    return ok


if __name__ == "__main__":
    which = sys.argv[1] if len(sys.argv) > 1 else "all"
    order = (["ess_v3_h3", "ess_v1_h3", "ess_v2_h3"]
             if which == "all" else [f"ess_{which}_h3"])
    if order[0] not in PROMPTS:
        log(f"未知卡: {which}")
        raise SystemExit(2)
    n_ok = sum(1 for s in order if run_card(s))
    log(f"== 完成 {n_ok}/{len(order)} ==")
    raise SystemExit(0 if n_ok == len(order) else 1)
