# -*- coding: utf-8 -*-
"""EPC49 B站轻量腿 v1 — 1004 渠道总动员 (视频线).

侦察实锤 (wf_ee5e6e4e): B站搜索免登录可用, 但旧版 yt-dlp 必 412
(反爬口径漂移) — 用前必须升到最新 (呼应「杜绝跑旧代码」铁律).
CC 字幕免登录不可下 → 本腿定位 = 搜索发现 + 简介采集 (辅助信号渠道,
非文稿主力). 无 SEPDRI 官方账号, 命中多为招聘/行业背景视频.

产物: 02/31_秘塔视频/bili_search_<date>.md (清单+top命中简介).
"""
import io
import subprocess
import sys
import time
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")

CODE_VERSION = "v3"
# v2 (1004 白班扩容): 修复 0 命中假空 — bilisearch 必须 --flat-playlist 才吐清单
#   (逐条全量抽取免登录静默死, 错误全在 stderr); flat 模式 title=NA,
#   故两段式: flat 拿 URL → 逐条全量取 id|title|uploader|description
# v3: 空清单多为 transient 限流(探针实证隔时即通) — 空则 30s 后单次重试
PY = r"C:\Users\91216\AppData\Local\Programs\Python\Python311\python.exe"

sys.path.insert(0, r"E:\AI-Station\Auto_Manus")
import epc49_topics as T  # noqa: E402

OUT = ([d for d in T.BATTLE.iterdir() if d.name.startswith("02")][0]
       / "31_秘塔视频")
KEYWORDS = ["四川电力设计咨询", "中电建四川院", "电力设计院 EPC"]


def sh(args: list, timeout: int = 240) -> str:
    r = subprocess.run([PY] + args, capture_output=True, timeout=timeout,
                       creationflags=0x08000000)
    return r.stdout.decode("utf-8", errors="replace")


def main() -> int:
    print(f"[{CODE_VERSION}] bili 腿启动 {time.strftime('%F %T')}",
          flush=True)
    OUT.mkdir(parents=True, exist_ok=True)
    # 铁律: 旧版必 412, 先升级 (幂等)
    up = sh(["-m", "pip", "install", "-q", "-U", "yt-dlp"], 300)
    ver = sh(["-m", "yt_dlp", "--version"]).strip()
    print(f"[bili] yt-dlp 版本 {ver}", flush=True)

    lines = [f"# B站搜索采集 {time.strftime('%F')} (yt-dlp {ver})\n"]
    hits_all = {}
    for kw in KEYWORDS:
        # 第一段: flat 清单拿 URL (免登录搜索面唯一可用形态); 空=限流重试一次
        def flat_list(k: str) -> list:
            o = sh(["-m", "yt_dlp", f"bilisearch10:{k}", "--no-update",
                    "--flat-playlist", "--skip-download",
                    "--print", "%(webpage_url)s"])
            return [u.strip() for u in o.splitlines()
                    if u.strip().startswith("http")][:5]
        urls = flat_list(kw)
        if not urls:
            print(f"[bili] {kw}: 空清单疑限流, 30s 后重试", flush=True)
            time.sleep(30)
            urls = flat_list(kw)
        # 第二段: 逐条全量元数据 (title/uploader/description)
        rows, kws_desc, n_ok = [], [], 0
        for u in urls:
            meta = sh(["-m", "yt_dlp", u, "--no-update", "--skip-download",
                       "--print", "META:%(id)s|%(title)s|%(uploader)s",
                       "--print", "DESC:%(description)s"], 120)
            m = next((l for l in meta.splitlines()
                      if l.startswith("META:")), None)
            d = next((l for l in meta.splitlines()
                      if l.startswith("DESC:")), None)
            if not m:                        # 单条死=如实跳过, 不拖全词
                rows.append(f"- [抽取失败] {u}")
                continue
            r = m[len("META:"):]
            rows.append(f"- {r} | {u}")
            hits_all[r.split('|')[0]] = r
            n_ok += 1
            if d and d != "DESC:NA":
                kws_desc.append((r, " ".join(d[len("DESC:"):].split())[:600]))
            time.sleep(3)                    # 逐条礼节间隔
        lines.append(f"\n## {kw} ({len(urls)} 清单 / {n_ok} 成功抽取)\n")
        lines += rows + [""]
        for r, d in kws_desc:
            lines.append(f"### 简介 {r}\n{d}\n")
        print(f"[bili] {kw}: 清单 {len(urls)}, 抽取成功 {n_ok}",
              flush=True)
        time.sleep(8)                        # 搜索礼节间隔
    f = OUT / f"bili_search_{time.strftime('%m%d')}.md"
    f.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"[bili] 完: {len(hits_all)} 命中 → {f.name}", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
