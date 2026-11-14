# -*- coding: utf-8 -*-
"""gen_h3_visa — VISA-2026 H3 视频生成 ×3 (照 gen_h3_audit 生产法).
卡序: v3=主卡(签证索赔上架) v1=效力卡(签了算不算) v2=停窝工卡(损失怎么算).
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
            if status in ("succeed", "succeeded", "SUCCEEDED", "completed", "done"):
                content = task.get("content", {})
                url = (content.get("url", "") if isinstance(content, dict) else "")
                if url:
                    return url
                log(f"成功但无URL: {str(result)[:150]}")
                return None
            if status in ("failed", "FAILED", "error"):
                log(f"生成失败: {str(result)[:100]}")
                return None
            log(f"等待... status={status}")
        except Exception as e:
            log(f"轮询异常: {e}")
    return None


def download(url, out_path):
    try:
        resp = requests.get(url, stream=True, timeout=120)
        with open(out_path, "wb") as f:
            for chunk in resp.iter_content(chunk_size=8192):
                f.write(chunk)
        return out_path.exists() and out_path.stat().st_size > 50_000
    except Exception as e:
        log(f"下载异常: {e}")
        return False


PROMPT_V3 = """竖屏9:16，10秒，工程建设行业风格视频。

画面开场（0-2秒）：深蓝色背景上一张签证单文档放大，金色印章「已签认」盖下，白色大字「工程签证与变更索赔」浮现。

中段（2-6秒）：签证单右侧弹出三条金色字幕「签证效力」「费用工期索赔」「反索赔」，下方大数字卡「12 章 · 26.6 万字」金色点亮。

高潮（6-9秒）：三条字幕汇入一本升起的厚书，金色大字「工程签证与变更索赔实战研究报告」。

结尾（9-10秒）：深蓝收束，白色文字「签下去的是钱 签不下去是官司」+底部留白。

整体色调：深蓝×金色×白色，工程感强，无人物，纯图形动画。"""

PROMPT_V1 = """竖屏9:16，10秒，工程建设行业风格视频。

画面开场（0-2秒）：画面左右分屏。左半深蓝底金色大字「签了」，右半灰蓝底白色大字「算数？」，中间金色裂缝。

中段（2-6秒）：左侧弹出金色字幕「表见代理成立」「权限链条完整」，右侧灰白字幕「权限瑕疵」「越权签认」逐条加暗红下划线。

高潮（6-9秒）：裂缝中升起法槌与签证单同框，金色大字「签证效力的裁判规则」。

结尾（9-10秒）：深蓝收束，白色文字「谁签的 签了什么 算到什么程度」+底部留白。

整体色调：深蓝×金色×灰白，工程感强，无人物，纯图形动画。"""

PROMPT_V2 = """竖屏9:16，10秒，工程建设行业风格视频。

画面开场（0-2秒）：深蓝背景上一个工地停工场景（塔吊静止剪影），红色数字「停工 90天」闪烁，白色大字「损失怎么算？」

中段（2-6秒）：画面切为三行金色清单「人员窝工费」「设备闲置费」「赶工补偿费」，每行右侧金色数字滚动。

高潮（6-9秒）：清单汇入法院天平，左盘「完整证据链」右盘「笼统主张」，天平倾向左侧，金色字幕「法院认什么样的账」。

结尾（9-10秒）：深蓝收束，白色文字「每一笔钱 都能翻到凭证页」+底部留白。

整体色调：深蓝×金色×红色点缀，工程感强，无人物，纯图形动画。"""

META = {
    "visa_v3_h3": {
        "title": "工程签证与变更索赔一本讲透",
        "desc": ("《工程签证与变更索赔实战研究报告》上架：12章26.6万字330+页，"
                 "签证效力+变更估价+费用工期索赔+反索赔+时效红线+FIDIC国际，"
                 "1.45亿字弹药池判例实锚。第1章免费试读。"),
        "tags": ["工程签证", "变更索赔", "EPC", "研究报告"],
    },
    "visa_v1_h3": {
        "title": "签了算不算数？签证效力的裁判规则",
        "desc": ("现场代表签了字，公司说不认——表见代理的成立条件、签证效力四边界、"
                 "结算文件性质光谱。《工程签证与变更索赔实战研究报告》第2章专章拆解，"
                 "第1章免费试读。"),
        "tags": ["签证效力", "表见代理", "工程签认", "研究报告"],
    },
    "visa_v2_h3": {
        "title": "停窝工损失法院认什么样的账",
        "desc": ("停工三个月设备人员天天烧钱——人员/设备/维护三层分层口径、定额法与"
                 "实际法双算、完整证据链怎么建。《工程签证与变更索赔实战研究报告》"
                 "第9章拆解，第1章免费试读。"),
        "tags": ["停窝工", "索赔计算", "工程索赔", "研究报告"],
    },
}

PROMPTS = {"visa_v3_h3": PROMPT_V3, "visa_v1_h3": PROMPT_V1,
           "visa_v2_h3": PROMPT_V2}


def run_card(slug):
    log(f"== VISA H3 生成: {slug} ==")
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
             "video": f"{slug}.mp4", "sku": "VISA-2026", "src": "h3"},
            ensure_ascii=False, indent=1), encoding="utf-8")
        log(f"✓ meta {slug}.json")
    return ok


if __name__ == "__main__":
    which = sys.argv[1] if len(sys.argv) > 1 else "all"
    order = (["visa_v3_h3", "visa_v1_h3", "visa_v2_h3"]
             if which == "all" else [f"visa_{which}_h3"])
    if order[0] not in PROMPTS:
        log(f"未知卡: {which}")
        raise SystemExit(2)
    n_ok = sum(1 for s in order if run_card(s))
    log(f"== 完成 {n_ok}/{len(order)} ==")
    raise SystemExit(0 if n_ok == len(order) else 1)
