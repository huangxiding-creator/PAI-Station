# -*- coding: utf-8 -*-
"""gen_h3_sched — SCHED-2026 工期实战指南 H3 视频生成
(复刻 gen_h3_slsd.py 生产法: We-AIPO MiniMax-H3 API)."""
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


PROMPT = """竖屏9:16，10秒，工程建设行业风格视频。

画面开场（0-2秒）：深蓝色背景上一条工程进度横道图动画推进，突然卡住变红，白色大字「延误一天」浮现，金色下划线标注「亏多少」。

中段（2-6秒）：横道图化作现金流曲线下坠，依次弹出字幕：「624天看护损失46.8万」「停窝工索赔3.37亿」「签证七步法」，每条配金色边框与数字强调。

高潮（6-9秒）：一本厚书从底部升起翻开，金色光散出，字幕「12章·20.5万字·371页」。

结尾（9-10秒）：深蓝收束，白色文字「免费试读」+底部留白。

整体色调：深蓝×金色×白色，工程感强，无人物，纯图形动画。"""

if __name__ == "__main__":
    log("== SCHED H3 视频生成 ==")
    url = generate(PROMPT)
    ok = False
    if url:
        out = OUT_DIR / "sched_v3_h3.mp4"
        if download(url, out):
            log(f"✓ {out.name} | {out.stat().st_size:,} bytes")
            ok = True
        else:
            log("下载失败")
    else:
        log("生成失败")
    if ok:
        import video_factory as vf
        c = vf.CARDS["sched_v3_h3"]
        (OUT_DIR / "sched_v3_h3.json").write_text(json.dumps(
            {"title": c["title"], "desc": c["desc"],
             "tags": c["desc_tags"], "video": "sched_v3_h3.mp4"},
            ensure_ascii=False, indent=1), encoding="utf-8")
        log("✓ meta sched_v3_h3.json")
    raise SystemExit(0 if ok else 1)
