# -*- coding: utf-8 -*-
"""harvest_video — 视频文稿收割腿 (BID26 四面补采 · video 渠道, B站).

链路: Python311+yt-dlp `bilisearchN:<查询词>` --flat-playlist 拿 URL →
逐条 `-J` 全量元数据 (title/uploader/description/subtitles) → 中文字幕
可下则取字幕, 否则简介兜底 → 落 data/harvest/video/<cid>/*.md。

侦察实锤 (承 epc49_bili_leg v3 + 本次冒烟 2026-10-15):
  - bilisearch 免登录可用; 必须 --flat-playlist 才吐清单, flat 模式
    title=NA → 两段式 (flat 拿 URL → 逐条全量取元数据);
  - B站 CC 字幕免登录基本不可下 → 全仓搜 bili cookie (data/secrets/*.ini
    等) 未找到 = 如实报 blocker, 简介为文稿主力;
  - 旧版 yt-dlp 必 412, 本次冒烟 2026.08.19 通过, 不再强制升级。

纪律: 双重相关门 (标题命中面词 ∧ 标题命中域词); 正文 (简介+字幕)
≥300 字才落件, 不足如实 skip; 串行 + 逐条 3s/逐词 8s 礼节间隔;
单条抽取失败不拖全词; 绝不 import/写 ammo_pool — 只产文件 + 台账。

用法: py -3.11 reforge_factory/harvest_video.py --campaign EPC-BID26 [--dry]
"""
from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
import tempfile
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REPO = Path(__file__).resolve().parents[1]
PY311 = r"C:\Users\91216\AppData\Local\Programs\Python\Python311\python.exe"
ENGINE = "video:bili"                      # 渠道 id 子串 = video
CREW = "media"

# (查询词, 目标 EEI) — 四面为主 (国际Q23/Q24, 技术Q19, 组织Q21, 渠道Q25), 域词兜底 Q1/Q5
PLAN: list[tuple[str, str]] = [
    ("FIDIC 合同 条款", "Q23-E1"),
    ("国际工程 海外项目 投标", "Q24-E1"),
    ("电子招投标 平台", "Q19-E1"),
    ("BIM 招投标", "Q19-E1"),
    ("评标专家 库", "Q21-E1"),
    ("招标代理 机构", "Q25-E1"),
    ("工程总承包 EPC 招标", "Q1-E1"),
    ("招投标 合规 串标", "Q5-E1"),
]
# 面词 (标题第一门): 取全部查询词的面词性 token
FACE_WORDS = ["FIDIC", "国际工程", "海外", "电子招投标", "BIM", "评标", "招标",
              "投标", "工程总承包", "EPC", "供应链", "串标", "合规"]
FACE_RE = re.compile("|".join(FACE_WORDS), re.IGNORECASE)
# 域词 (标题第二门, 契约口径)
DOMAIN_RE = re.compile(r"招标|投标|评标|工程|EPC|采购|承包|造价|FIDIC|BIM|供应链")
PER_QUERY = 5
MIN_CONTENT = 300                         # 正文 (简介+字幕) 下限, 不足如实 skip


def _ytdlp(*args: str, timeout: int = 120) -> str:
    r = subprocess.run([PY311, "-m", "yt_dlp", *args], capture_output=True,
                       timeout=timeout, creationflags=0x08000000)
    return r.stdout.decode("utf-8", errors="replace")


def _find_bili_cookie() -> Path | None:
    """全仓约定位置找 bili cookie (data/secrets/*.ini|*.txt), 找不到返 None."""
    for pat in ("bili*.ini", "bili*.txt", "*bili*cookie*"):
        for f in (REPO / "data" / "secrets").glob(pat):
            return f
    return None


def flat_search(q: str, size: int = PER_QUERY) -> list[str]:
    """第一段: flat 清单拿视频 URL (空=疑限流, 30s 后单次重试, 再空如实返空)."""
    def once() -> list[str]:
        o = _ytdlp(f"bilisearch{size}:{q}", "--no-update", "--flat-playlist",
                   "--skip-download", "--print", "%(webpage_url)s", timeout=90)
        return [u.strip() for u in o.splitlines()
                if "/video/" in u][:size]
    urls = once()
    if not urls:
        print(f"[video] '{q}': 空清单疑限流, 30s 后重试一次", flush=True)
        time.sleep(30)
        urls = once()
    return urls


def video_meta(url: str) -> dict | None:
    """第二段: 逐条全量元数据 (-J). 单条死=None, 如实跳过不拖全词."""
    o = _ytdlp(url, "--no-update", "--skip-download", "-J", "--no-warnings")
    try:
        return json.loads(o)
    except json.JSONDecodeError:
        return None


def fetch_subtitle(meta: dict) -> str:
    """中文字幕可下则下 (vtt→净文本); 免登录多半不可下, 返回空串走简介兜底."""
    subs = meta.get("subtitles") or {}
    zh_lang = next((k for k in subs if k.lower().startswith("zh")), None)
    if not zh_lang:
        return ""
    with tempfile.TemporaryDirectory() as td:
        _ytdlp(meta.get("webpage_url", ""), "--no-update", "--skip-download",
               "--write-subs", "--sub-langs", zh_lang, "--sub-format",
               "vtt/srt/best", "-o", str(Path(td) / "%(id)s"), timeout=90)
        files = list(Path(td).glob("*.vtt")) + list(Path(td).glob("*.srt"))
        if not files:
            return ""
        raw = files[0].read_text(encoding="utf-8", errors="replace")
    lines, seen = [], set()
    for ln in raw.splitlines():
        ln = ln.strip()
        if (not ln or ln in seen or "-->" in ln or ln.startswith(("WEBVTT", "Kind:", "Language:"))
                or ln.isdigit() or ln.startswith("<") or ln.endswith("}") or "}" in ln[:1]):
            continue
        seen.add(ln)
        lines.append(ln)
    return "\n".join(lines)


def gate(title: str) -> bool:
    """双重相关门: 标题命中面词 ∧ 标题命中域词, 不相关不入."""
    return bool(FACE_RE.search(title) and DOMAIN_RE.search(title))


def run(cid: str, dry: bool = False) -> int:
    out_dir = REPO / "data" / "harvest" / "video" / cid
    out_dir.mkdir(parents=True, exist_ok=True)
    rec_path = out_dir / "_records.jsonl"
    cookie = _find_bili_cookie()
    print(f"[video] bili cookie: {'命中 ' + cookie.name if cookie else '未找到 (CC字幕大概率不可下, 简介兜底)'}",
          flush=True)
    ver = _ytdlp("--version").strip()
    records: list[dict] = []
    n_fetched = n_skip_gate = n_skip_thin = n_fail = 0
    seen: set[str] = set()
    for q, eei in PLAN:
        for url in flat_search(q):
            vid = url.rsplit("/", 1)[-1].split("?")[0]
            if vid in seen:
                continue
            seen.add(vid)
            meta = video_meta(url)
            if not meta or not meta.get("title"):
                n_fail += 1
                print(f"  [video] 抽取失败如实跳: {url}", flush=True)
                continue
            title = str(meta["title"]).strip()
            if not gate(title):
                n_skip_gate += 1
                continue
            desc = re.sub(r"\s+", " ", str(meta.get("description") or "")).strip()
            subt = fetch_subtitle(meta)     # 有 cookie 更易成; 无 cookie 多半空串
            content = desc if not subt else (subt + "\n\n## 视频简介\n" + desc)
            if len(content) < MIN_CONTENT:
                n_skip_thin += 1
                print(f"  [video] 正文 {len(content)} 字不足 {MIN_CONTENT} 如实跳: {title[:40]}",
                      flush=True)
                continue
            fp = out_dir / (re.sub(r"[^\w一-鿿-]+", "_", title)[:50] + f"_{vid[:12]}" + ".md")
            if not fp.exists():
                head = (f"# {title}\n\n"
                        f"> 来源: 哔哩哔哩视频 ({meta.get('webpage_url', url)})\n"
                        f"> UP主: {meta.get('uploader', '')} | 时长: {meta.get('duration', '')}s"
                        f" | 发布: {meta.get('upload_date', '')} | 播放: {meta.get('view_count', '')}\n"
                        f"> engine: {ENGINE} | cred: {CREW} | EEI: {eei}"
                        f" | 采集: {time.strftime('%F')} yt-dlp {ver}"
                        f" | 形态: {'字幕+简介' if subt else '简介'}\n\n")
                fp.write_text(head + ("## 字幕\n" + content if subt else "## 视频简介\n" + desc)
                              + "\n", encoding="utf-8")
            n_fetched += 1
            records.append({"file": str(fp), "url": str(meta.get("webpage_url", url)),
                            "engine": ENGINE, "tree": eei, "cred": CREW})
            print(f"  [video] {'[dry] ' if dry else ''}{eei} {title[:44]} ({len(content)}字)", flush=True)
            time.sleep(3)                       # 逐条礼节间隔
        print(f"[video] '{q}' → 累计 fetched {n_fetched} / 域门跳 {n_skip_gate} / 过瘦跳 {n_skip_thin} / 失败 {n_fail}",
              flush=True)
        time.sleep(8)                           # 逐词礼节间隔
    if not dry:
        rec_path.write_text("\n".join(json.dumps(r, ensure_ascii=False) for r in records) + "\n",
                            encoding="utf-8")
        print(f"[video] 台账: {rec_path}", flush=True)
    print(f"[video] {'DRY' if dry else 'APPLY'}: 抓取 {n_fetched} | 域门跳 {n_skip_gate} | "
          f"过瘦跳 {n_skip_thin} | 失败 {n_fail} | cookie {'有' if cookie else '无(简介兜底)'}")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description="B站视频文稿收割腿 (video 渠道)")
    ap.add_argument("--campaign", default="EPC-BID26")
    ap.add_argument("--dry", action="store_true")
    ns = ap.parse_args()
    return run(ns.campaign, ns.dry)


if __name__ == "__main__":
    sys.exit(main())
