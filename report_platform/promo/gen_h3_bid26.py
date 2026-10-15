# -*- coding: utf-8 -*-
"""gen_h3_bid26 — BID26 报告 H3 视频生成（复用 We-AIPO MiniMax H3 API）."""
import os, sys, time, json, requests
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).parent))

# 加载 .env（优先从 We-AIPO 读取 MINIMAX_TOKEN）
ENV = Path(r"F:\We-AIPO\.env")
if ENV.exists():
    for line in ENV.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if "=" in line and not line.startswith("#"):
            k, _, v = line.partition("=")
            k, v = k.strip(), v.strip().strip("'\"")
            if k and k not in os.environ:
                os.environ[k] = v

_BASE_URL = "https://metaso.cn/api/minimax"
_TOKEN = os.environ.get("MINIMAX_TOKEN", "")
_MODEL = "MiniMax-H3"
_POLL_INTERVAL = 15
_MAX_WAIT = 600

OUT_DIR = Path(r"E:\AI-Station\report_platform\promo\videos")
OUT_DIR.mkdir(parents=True, exist_ok=True)


def log(msg): print(msg, flush=True)


def generate(prompt, resolution="768P", duration=10):
    headers = {"Authorization": f"Bearer {_TOKEN}", "Content-Type": "application/json"}
    payload = {"model": _MODEL, "content": [{"type": "text", "text": prompt}],
               "resolution": resolution, "duration": duration, "ratio": "9:16"}
    resp = requests.post(f"{_BASE_URL}/v2/video_generation", headers=headers, json=payload, timeout=30)
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
            resp = requests.get(f"{_BASE_URL}/v2/query/video_generation/{task_id}", headers=headers, timeout=15)
            result = resp.json()
            task = result.get("task", {})
            status = task.get("status", "")
            if status in ("succeed", "succeeded", "SUCCEEDED", "completed", "done"):
                content = task.get("content", {})
                url = content.get("url", "") if isinstance(content, dict) else ""
                if url: return url
                log(f"成功但无URL: {str(result)[:150]}")
                return None
            elif status in ("failed", "FAILED", "error"):
                log(f"生成失败: {str(result)[:100]}")
                return None
            log(f"等待... status={status}")
        except Exception as e:
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
    except Exception as e:
        log(f"下载异常: {e}")
        return False


PROMPT = """竖屏9:16，10秒，工程行业风格视频。

画面开场（0-2秒）：深蓝色背景，白色大字「2026」从中心炸开，配金色粒子效果，字幕浮现「三份新规·同日施行」。

中段（2-6秒）：法律条文快速滚动效果，核心条款依次弹出：「罚款提至10%」「追责98种」「终身问责」，每条出现时配红色警示框闪烁。

高潮（6-9秒）：一本书从底部升起翻开，金色光芒从书页中散出，字幕「12章·8万字·100+案例」。

结尾（9-10秒）：深蓝背景收束为一个小点，白色文字「免费试读」+底部二维码位置留白。

整体色调：深蓝×金色×白色，专业感强，无人物，纯图形动画。"""

if __name__ == "__main__":
    log("== BID26 H3 视频生成 ==")
    url = generate(PROMPT)
    if url:
        out = OUT_DIR / "bid26_v3_h3.mp4"
        if download(url, out):
            log(f"✓ {out.name} | {out.stat().st_size:,} bytes")
        else:
            log("下载失败")
    else:
        log("生成失败")
