# -*- coding: utf-8 -*-
"""h3_pipeline — H3 三卡+视频号通用管线 (1125 用户令: H3/视频号接入编排器).

两个动作:
  gen    读 sched/h3_prompts.json (宣传稿claude工人顺写: 3条视频prompt+meta)
         → MiniMax-H3 生成 → 下载 mp4 + meta json → promo/videos/
  queue  处理待发队列 data/factory/h3_pending.json (9222死时的自动重试,
         视频日帽4条/日), 成功→移除, 失败→保留给下一班。

用法:
  py -X utf8 tools/h3_pipeline.py gen --campaign-dir work/m2/<slug> --sku X-2026
  py -X utf8 tools/h3_pipeline.py queue [--cap 4]
"""
from __future__ import annotations

import argparse
import json
import os
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]
PROMO = REPO / "report_platform" / "promo"
VIDEOS = PROMO / "videos"
FACT = REPO / "data" / "factory"
PENDING = FACT / "h3_pending.json"
ENV = Path(r"F:\We-AIPO\.env")
BASE_URL = "https://metaso.cn/api/minimax"
MODEL = "MiniMax-H3"


def _token() -> str:
    if ENV.exists():
        for line in ENV.read_text(encoding="utf-8").splitlines():
            line = line.strip()
            if "=" in line and not line.startswith("#"):
                k, _, v = line.partition("=")
                if k.strip() == "MINIMAX_TOKEN":
                    return v.strip().strip("'\"")
    return os.environ.get("MINIMAX_TOKEN", "")


def _generate(prompt: str, token: str) -> str | None:
    import requests
    headers = {"Authorization": f"Bearer {token}", "Content-Type": "application/json"}
    payload = {"model": MODEL, "content": [{"type": "text", "text": prompt}],
               "resolution": "768P", "duration": 10, "ratio": "9:16"}
    resp = requests.post(f"{BASE_URL}/v2/video_generation", headers=headers,
                         json=payload, timeout=30)
    data = resp.json()
    task_id = data.get("task_id") or data.get("data", {}).get("task_id")
    if not task_id:
        return None
    deadline = time.time() + 600
    while time.time() < deadline:
        time.sleep(15)
        try:
            rr = requests.get(f"{BASE_URL}/v2/query/video_generation/{task_id}",
                              headers=headers, timeout=15).json()
            st = rr.get("task", {}).get("status", "")
            if st in ("succeed", "succeeded", "SUCCEEDED", "completed", "done"):
                c = rr.get("task", {}).get("content", {})
                return c.get("url", "") if isinstance(c, dict) else ""
            if st in ("failed", "FAILED", "error"):
                return None
        except Exception:
            pass
    return None


def _download(url: str, out: Path) -> bool:
    import requests
    try:
        resp = requests.get(url, stream=True, timeout=120)
        with open(out, "wb") as f:
            for chunk in resp.iter_content(chunk_size=8192):
                f.write(chunk)
        return out.exists() and out.stat().st_size > 50_000
    except Exception:
        return False


def cmd_gen(ns) -> int:
    sched = REPO / ns.campaign_dir / "sched"
    pj = sched / "h3_prompts.json"
    if not pj.is_file():
        print("[miss] h3_prompts.json 缺席 (宣传稿工人未产出)")
        return 1
    doc = json.loads(pj.read_text(encoding="utf-8"))
    token = _token()
    if not token:
        print("[miss] MINIMAX_TOKEN 缺席")
        return 1
    okn = 0
    pending = _load_pending()
    for card in doc.get("cards", [])[:3]:
        slug = card.get("slug") or f"{ns.sku.lower()}_h3_{card.get('no', '')}"
        url = _generate(card["prompt"], token)
        if not url:
            print(f"[gen] {slug} 生成失败 — 入待发队列重试")
            pending.append({"sku": ns.sku, "slug": slug, "card": card,
                            "why": "gen_failed", "ts": time.strftime("%F %T")})
            continue
        mp4 = VIDEOS / f"{slug}.mp4"
        if _download(url, mp4):
            meta = {"title": card.get("title", "")[:30], "desc": card.get("desc", ""),
                    "tags": card.get("tags", ["研究报告"]), "video": f"{slug}.mp4",
                    "sku": ns.sku, "src": "h3"}
            (VIDEOS / f"{slug}.json").write_text(
                json.dumps(meta, ensure_ascii=False, indent=1), encoding="utf-8")
            okn += 1
            pending.append({"sku": ns.sku, "slug": slug, "card": {},
                            "why": "gen_ok_待上传", "ts": time.strftime("%F %T")})
            print(f"[gen] ✓ {slug}.mp4 ({mp4.stat().st_size:,}B) — 入待发队列")
        else:
            pending.append({"sku": ns.sku, "slug": slug, "card": card,
                            "why": "download_failed", "ts": time.strftime("%F %T")})
    _save_pending(pending)
    print(f"[gen] {okn}/{len(doc.get('cards', []))}")
    return 0 if okn else 1


def _load_pending() -> list:
    if PENDING.is_file():
        try:
            return json.loads(PENDING.read_text(encoding="utf-8"))
        except Exception:
            return []
    return []


def _save_pending(items: list) -> None:
    PENDING.write_text(json.dumps(items, ensure_ascii=False, indent=1),
                       encoding="utf-8")


def _today_uploads() -> int:
    """今日已发视频数 (promo_ledger src=h3 记录)."""
    led = PROMO / "promo_ledger.jsonl"
    today = time.strftime("%Y-%m-%d")
    n = 0
    if led.is_file():
        for ln in led.read_text(encoding="utf-8", errors="replace").splitlines():
            try:
                d = json.loads(ln)
                if d.get("ts", "").startswith(today) and d.get("src") == "h3" and d.get("ok"):
                    n += 1
            except Exception:
                pass
    return n


def cmd_queue(ns) -> int:
    items = _load_pending()
    if not items:
        print("[queue] 空")
        return 0
    used = _today_uploads()
    cap = ns.cap
    remaining = []
    done = 0
    for it in items:
        if used >= cap:
            remaining.append(it)
            continue
        slug = it["slug"]
        mp4 = VIDEOS / f"{slug}.mp4"
        mj = VIDEOS / f"{slug}.json"
        if not (mp4.is_file() and mj.is_file()):
            # 生成件不在盘 (gen_failed) — 重新生成一次
            card = it.get("card", {})
            token = _token()
            url = _generate(card.get("prompt", ""), token) if token else None
            if not url or not _download(url, mp4):
                it["why"] = "regen_failed"
                it["ts"] = time.strftime("%F %T")
                remaining.append(it)
                continue
            meta = {"title": card.get("title", "")[:30], "desc": card.get("desc", ""),
                    "tags": card.get("tags", ["研究报告"]), "video": f"{slug}.mp4",
                    "sku": it.get("sku", ""), "src": "h3"}
            mj.write_text(json.dumps(meta, ensure_ascii=False, indent=1), encoding="utf-8")
        env = dict(os.environ, WECHAT_ACCOUNTS_FILE=r"F:\We-AIPO\data\wechat_accounts.json")
        r = subprocess.run([sys.executable, "-X", "utf8", str(PROMO / "video_upload.py"),
                            "--slug", slug, "--go"], capture_output=True, text=True,
                           encoding="utf-8", errors="replace", timeout=1200,
                           cwd=str(PROMO), env=env)
        out = r.stdout or ""
        if "publish ok= True" in out or "[vup] ✓" in out:
            done += 1
            used += 1
            print(f"[queue] ✓ {slug} 发表 ({used}/{cap})")
        elif "9222" in out or "登录态死" in out:
            remaining.append(it)  # 9222未复活 — 留队列等下一班
            print(f"[queue] {slug} 9222未复活 — 留队")
            break  # 当班 9222 不会再活, 别再撞
        else:
            it["why"] = f"upload_rc={r.returncode}"
            it["ts"] = time.strftime("%F %T")
            remaining.append(it)
            print(f"[queue] {slug} 上传失败 — 留队重试")
    _save_pending(remaining)
    print(f"[queue] 发表{done} 留队{len(remaining)}")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser()
    sub = ap.add_subparsers(dest="cmd", required=True)
    g = sub.add_parser("gen")
    g.add_argument("--campaign-dir", required=True)
    g.add_argument("--sku", required=True)
    q = sub.add_parser("queue")
    q.add_argument("--cap", type=int, default=4)
    ns = ap.parse_args()
    if ns.cmd == "gen":
        return cmd_gen(ns)
    return cmd_queue(ns)


if __name__ == "__main__":
    raise SystemExit(main())
