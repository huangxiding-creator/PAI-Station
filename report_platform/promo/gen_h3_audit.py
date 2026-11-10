# -*- coding: utf-8 -*-
"""gen_h3_audit — AUDIT-2026 H3 视频生成 ×3 (照 gen_h3_ess 生产法).
卡序: v3=主卡(审计决算上架) v1=审减攻防 v2=审计效力条款.
用法: py -X utf8 gen_h3_audit.py [v3|v1|v2|all]
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

画面开场（0-2秒）：深蓝色背景上一枚金色天平升起，左盘白色大字「送审价」，右盘金色大字「审定价」，中间一道红色审减裂缝，副字幕「EPC工程审计与决算」。

中段（2-6秒）：天平右盘下沉，金色数字滚动「审减率 30%？」随后弹出三条金色字幕「审减攻防」「造价鉴定」「审计效力」，每条配金色边框。

高潮（6-9秒）：裂缝中升起一本厚书，金色大字「EPC工程审计与决算实战研究报告」+大数字卡「12 章 · 25 万字」。

结尾（9-10秒）：深蓝收束，白色文字「算得清的账 才守得住的钱」+底部留白。

整体色调：深蓝×金色×红色点缀，工程感强，无人物，纯图形动画。"""

PROMPT_V1 = """竖屏9:16，10秒，工程建设行业风格视频。

画面开场（0-2秒）：深蓝色背景上一份结算书文档展开，红色印章「审减-18%」砸下，白色大字「一审砍掉两千万？」

中段（2-6秒）：文档旁弹出金色对勘清单，逐条点亮「工程量重复计算」「单价高套」「取费错档」，尾注「审减因素清单实证」。

高潮（6-9秒）：画面切分两侧——左侧灰色字幕「高估冒算」，右侧金色字幕「有据可依的送审」，中间金色桥梁「审减攻防方法论」。

结尾（9-10秒）：深蓝收束，白色文字「每一笔审减 都有打法」+底部留白。

整体色调：深蓝×金色×红色点缀，工程感强，无人物，纯图形动画。"""

PROMPT_V2 = """竖屏9:16，10秒，工程建设行业风格视频。

画面开场（0-2秒）：画面左右分屏。左半灰蓝底白色大字「以审计为准」，右半深蓝底金色大字「视为认可条款」，中间金色裂缝。

中段（2-6秒）：右侧依次弹出金色字幕「逾期未审 视为认可」「审计条款 效力边界」「优先受偿权 时效防线」，左侧灰色字幕「结算无限期拖延」加暗红下划线。

高潮（6-9秒）：裂缝中升起法槌与结算书同框剪影，金色大字「审计对决算的效力规则」。

结尾（9-10秒）：深蓝收束，白色文字「合同怎么写 钱就怎么结」+底部留白。

整体色调：深蓝×金色×灰白，工程感强，无人物，纯图形动画。"""

META = {
    "audit_v3_h3": {
        "title": "EPC审计决算一本讲透",
        "desc": ("《EPC工程审计与决算实战研究报告》上架：12章25万字400+页，"
                 "审计监管框架+竣工决算编制+送审策略+审减攻防+造价鉴定+FIDIC国际决算，"
                 "2.4亿字弹药池判例实锚。第1章免费试读。"),
        "tags": ["工程审计", "竣工决算", "审减", "研究报告"],
    },
    "audit_v1_h3": {
        "title": "一审砍掉两千万怎么救",
        "desc": ("工程量重复、单价高套、取费错档——审减因素的攻防清单。《EPC工程审计与决算"
                 "实战研究报告》第7章拆解审减攻防方法论，第1章免费试读。"),
        "tags": ["审减", "工程结算", "造价", "研究报告"],
    },
    "audit_v2_h3": {
        "title": "合同写了以审计为准就完了？",
        "desc": ("逾期未审视为认可、审计条款效力边界、工程款优先受偿权——审计对决算效力的"
                 "裁判规则全解。《EPC工程审计与决算实战研究报告》第10章专章拆解，第1章免费试读。"),
        "tags": ["审计条款", "视为认可", "优先受偿权", "研究报告"],
    },
}

PROMPTS = {"audit_v3_h3": PROMPT_V3, "audit_v1_h3": PROMPT_V1,
           "audit_v2_h3": PROMPT_V2}


def run_card(slug):
    log(f"== AUDIT H3 生成: {slug} ==")
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
             "video": f"{slug}.mp4", "sku": "AUDIT-2026", "src": "h3"},
            ensure_ascii=False, indent=1), encoding="utf-8")
        log(f"✓ meta {slug}.json")
    return ok


if __name__ == "__main__":
    which = sys.argv[1] if len(sys.argv) > 1 else "all"
    order = (["audit_v3_h3", "audit_v1_h3", "audit_v2_h3"]
             if which == "all" else [f"audit_{which}_h3"])
    if order[0] not in PROMPTS:
        log(f"未知卡: {which}")
        raise SystemExit(2)
    n_ok = sum(1 for s in order if run_card(s))
    log(f"== 完成 {n_ok}/{len(order)} ==")
    raise SystemExit(0 if n_ok == len(order) else 1)
