# -*- coding: utf-8 -*-
"""KB-FACTORY W10 · 全链 E2E（真链一次贯通）。

链：①引擎生成蓝图（域=水利EPC）→ ②wenku 元数据真灌 3 组（adapter 频控守卫，≤10 请求；
被限流/断网→如实降级复用 seeds/05 已入档蓝图，报告注明）→ ③落订单 JSON
（version=markdown+import_pack, email=test@example.com）入 tmp inbox →
④subprocess 跑 fulfillment --once（KB_WECOM_NOTIFY=0）→ ⑤断言 outbox 双产物/manifest
versions/ledger result/获取指引/转换报告 → ⑥报告落 kb_factory/e2e/E2E_REPORT.md。

用法（仓库根）：py -3 -m kb_factory.e2e.run_e2e [--skip-net]
纪律：不删不 push；真网络仅 wenku 检索 ≤10 请求；零造假——降级如实注明。
"""
from __future__ import annotations

import argparse
import json
import os
import re
import subprocess
import sys
import time
import zipfile
from pathlib import Path

try:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
except Exception:
    pass

REPO_ROOT = Path(__file__).resolve().parents[2]
PKG_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(REPO_ROOT))

from kb_factory.catalog_engine.engine import build_blueprint
from kb_factory.catalog_engine.metadata import sanitize_filename
from kb_factory.channel_adapters.base import RateLimiter
from kb_factory.channel_adapters.enrich import enrich_blueprint
from kb_factory.channel_adapters.wenku_meta import WenkuMetaAdapter

SEED_CACHE = PKG_DIR.parent / "seeds" / "05_水利EPC工程.json"
NET_BUDGET = 10                 # 真网络预算（任务纪律：wenku 检索 ≤10 请求）
GREEN_LOCAL = {"self_owned", "green_free"}
ALLOWED_RESULTS = ("ok", "ok_wecom_fallback", "degraded_not_delivered")


class Step:
    def __init__(self, name):
        self.name, self.t0, self.elapsed = name, time.perf_counter(), 0.0

    def __enter__(self):
        print(f"[e2e] ▶ {self.name}", flush=True)
        return self

    def __exit__(self, *exc):
        self.elapsed = round(time.perf_counter() - self.t0, 2)
        print(f"[e2e ■ {self.name} 完成 {self.elapsed}s", flush=True)
        return False


def _first_green_slot(bp: dict) -> dict:
    """全树第一个可本地绿取的槽（badge 绿 + ext∈{pdf,md}），用于动态种真绿源文件。"""
    for l1 in bp["tree"]["l1"]:
        for l2 in l1["l2"]:
            for slot in (l2.get("files") or
                         [f for sd in l2.get("split_dirs", []) for f in sd.get("files", [])]):
                if slot.get("badge") in GREEN_LOCAL and slot.get("ext") in ("pdf", "md"):
                    return slot
    raise AssertionError("蓝图中无本地绿源槽（pdf/md）——引擎产物异常")


def _plant_corpus(corpus_dir: Path, bp: dict) -> dict:
    """按第一个绿槽标题种真实本地语料文件（E2E 的真绿源，copy 非 move 由履约保证）。"""
    corpus_dir.mkdir(parents=True, exist_ok=True)
    slot = _first_green_slot(bp)
    stem = sanitize_filename(slot["title"]) or "e2e_corpus"
    f = corpus_dir / f"{stem}.{slot['ext']}"
    if slot["ext"] == "pdf":
        f.write_bytes(b"%PDF-1.4\n% KB-FACTORY E2E planted green corpus file\n" + b"x" * 2048)
    else:
        f.write_text(f"# {slot['title']}\n\nKB-FACTORY E2E 真绿源夹具（md）。\n", encoding="utf-8")
    return {"slot": slot["name"], "title": slot["title"], "file": f.name, "ext": slot["ext"]}


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(prog="kb_factory.e2e.run_e2e")
    ap.add_argument("--skip-net", action="store_true", help="跳过真网络步（直接复用 seeds/05 缓存）")
    args = ap.parse_args(argv)

    ts = time.strftime("%Y%m%d-%H%M%S")
    base = PKG_DIR / "tmp" / ts
    base.mkdir(parents=True, exist_ok=True)
    order_id = f"E2E-{ts}"
    steps, checks = [], []

    def check(name, ok, detail=""):
        checks.append((name, bool(ok), str(detail)))
        print(f"[e2e] {'✓' if ok else '✗'} {name}" + (f" · {detail}" if detail else ""), flush=True)
        return ok

    # ① 引擎蓝图 ------------------------------------------------------------
    step1 = Step("① 引擎生成蓝图（域=水利EPC）")
    with step1:
        need = {"domain": "水利EPC", "keywords": ["EPC", "水利水电", "总承包"],
                "intent": "项目部技术管理", "size_hint": "small"}
        bp = build_blueprint(need)
        check("①蓝图生成", bp["tree"]["root"] and bp["stats"]["files"] > 0,
              f"root={bp['tree']['root']} slots={bp['stats']['files']}")
    steps.append((step1.name, step1.elapsed))

    # ② wenku 元数据真灌 3 组 -------------------------------------------------
    meta_mode, meta_note, wenku_req = "cache", "", 0
    step2 = Step("② wenku 元数据真灌 3 组（频控守卫）")
    with step2:
        if args.skip_net:
            meta_note = "--skip-net 指定跳过真网络"
        else:
            limiter = RateLimiter(min_interval=3.5, daily_limit=NET_BUDGET, name="wenku-e2e")
            adapter = WenkuMetaAdapter(limiter=limiter, timeout=8, retries=0)
            try:
                enrich_blueprint(bp, [adapter], per_topic=12, max_topics=3)
                ce = bp["provenance"]["channel_enrichment"]
                wenku_req = int(adapter.limiter.status()["count_today"])
                filled = int(ce["filled"])
                if filled > 0:
                    meta_mode = "live"
                    meta_note = f"真灌 {ce['groups_queried']} 组 filled={filled}（请求 {wenku_req} 次）"
                else:
                    meta_note = f"真灌 0 条（请求 {wenku_req} 次，疑被限流）→ 降级"
            except Exception as e:  # 断网/限流熔断：如实降级
                wenku_req = int(limiter.status()["count_today"])
                meta_note = f"真灌异常 {type(e).__name__}（请求 {wenku_req} 次）→ 降级"
        if meta_mode != "live":
            bp = json.loads(SEED_CACHE.read_text(encoding="utf-8"))
            meta_note += f"；复用已入档 seeds/05 缓存蓝图（{SEED_CACHE.name}）"
        check("②元数据步完成（含降级如实注明）", True, meta_note)
        check("②真网络预算 ≤10 请求", wenku_req <= NET_BUDGET, f"实测 {wenku_req} 请求")
        bp_path = base / "blueprint_e2e.json"
        bp_path.write_text(json.dumps(bp, ensure_ascii=False, indent=1), encoding="utf-8")
    steps.append((step2.name, step2.elapsed))

    kb_name = bp["tree"]["root"]

    # ③ 落订单 + 种绿源 -------------------------------------------------------
    step3 = Step("③ 落订单 JSON 入 tmp inbox（markdown+import_pack）")
    with step3:
        planted = _plant_corpus(base / "corpus", bp)
        inbox = base / "base" / "inbox"
        inbox.mkdir(parents=True, exist_ok=True)
        (inbox / f"{order_id}.json").write_text(json.dumps({
            "id": order_id, "need_text": "水利EPC 全链 E2E", "blueprint_ref": str(bp_path),
            "email": "test@example.com", "version_selection": "markdown+import_pack",
            "price": "43.50", "paid_at": time.strftime("%Y-%m-%dT%H:%M:%S"), "status": "paid",
        }, ensure_ascii=False), encoding="utf-8")
        check("③订单落地", (inbox / f"{order_id}.json").is_file(),
              f"version=markdown+import_pack email=test@example.com")
    steps.append((step3.name, step3.elapsed))

    # ④ subprocess fulfillment --once ----------------------------------------
    step4 = Step("④ subprocess fulfillment --once（KB_WECOM_NOTIFY=0）")
    with step4:
        env = dict(os.environ)
        env.update({"PYTHONIOENCODING": "utf-8", "KB_WECOM_NOTIFY": "0",
                    "KB_LOCAL_CORPUS": str(base / "corpus"),
                    "KB_SMTP_SECRET": str(base / "no.smtp.secret")})
        env.pop("KB_PANDOC", None)
        r = subprocess.run(
            [sys.executable, "-X", "utf8", "-m", "kb_factory.fulfillment",
             "--once", "--base", str(base / "base")],
            cwd=REPO_ROOT, capture_output=True, text=True, timeout=900,
            encoding="utf-8", errors="replace", env=env)
        check("④CLI rc=0", r.returncode == 0, f"rc={r.returncode}")
    steps.append((step4.name, step4.elapsed))

    # ⑤ 断言 -------------------------------------------------------------------
    step5 = Step("⑤ 全链断言")
    with step5:
        fbase = base / "base"
        outbox = fbase / "outbox"
        orig_zip = outbox / f"{order_id}.zip"
        md_zip = outbox / f"{order_id}_md.zip"
        md_dir = outbox / f"{order_id}_md"
        imp_zip = outbox / f"{kb_name}_import_pack.zip"

        check("⑤原包 zip 在", orig_zip.is_file())
        check("⑤MD 版 zip 在（双产物之一）", md_zip.is_file())
        check("⑤导入包 zip 在（双产物之二，与原包并列 outbox）", imp_zip.is_file())
        check("⑤转换报告存在", (md_dir / "转换报告.md").is_file())

        mf_path = next((outbox / order_id).rglob("manifest.json"), None)
        mf = json.loads(mf_path.read_text(encoding="utf-8")) if mf_path else {}
        vs = mf.get("versions") or {}
        check("⑤manifest.versions 记录三版本",
              set(vs) >= {"original", "markdown", "import_pack"},
              f"selection={vs.get('selection')} counts="
              f"{ {k: v.get('files') for k, v in vs.items() if k != 'selection'} }")
        check("⑤获取指引清单存在（包内）", mf_path is not None and
              (mf_path.parent / "获取指引清单.md").is_file())
        with zipfile.ZipFile(orig_zip) as z:
            nl = z.namelist()
        check("⑤原包 zip 含获取指引清单+manifest",
              any(n.endswith("获取指引清单.md") for n in nl) and
              any(n.endswith("manifest.json") for n in nl))
        check("⑤绿源真交付（种入文件已 copy 入包）",
              mf.get("stats", {}).get("delivered", 0) >= 1,
              f"delivered={mf.get('stats', {}).get('delivered')} planted={planted['file']}")

        ledger = [json.loads(x) for x in
                  (fbase / "ledger.jsonl").read_text(encoding="utf-8").strip().splitlines()]
        led = next((e for e in ledger if e.get("order") == order_id), {})
        check("⑤ledger result∈{ok,ok_wecom_fallback,degraded_not_delivered}",
              led.get("result") in ALLOWED_RESULTS, str(led.get("result")))
        check("⑤ledger versions 记录",
              set(led.get("versions", {})) >= {"original", "markdown", "import_pack"})
        check("⑤订单箱收口（inbox→done）",
              (fbase / "done" / f"{order_id}.json").is_file() and
              not (fbase / "base" / "inbox" / f"{order_id}.json").exists())
    steps.append((step5.name, step5.elapsed))

    # ⑥ E2E 报告 ----------------------------------------------------------------
    step6 = Step("⑥ 写 E2E 报告")
    with step6:
        all_green = all(ok for _, ok, _ in checks)
        try:
            rev = subprocess.run(["git", "-C", str(REPO_ROOT), "rev-parse", "--short", "HEAD"],
                                 capture_output=True, text=True, timeout=15,
                                 encoding="utf-8", errors="replace").stdout.strip()
        except Exception:
            rev = "?"
        lines = [
            f"# KB-FACTORY 全链 E2E 报告 · {ts}",
            "",
            f"- 结论：{'全绿 ✓' if all_green else '存在红项 ✗'}（assertion {sum(1 for _, ok, _ in checks if ok)}/{len(checks)}）",
            f"- 基线：git {rev}（worktree）· Python {sys.version.split()[0]}",
            f"- 元数据步：{'真网络真灌' if meta_mode == 'live' else '降级复用缓存'} —— {meta_note}",
            "",
            "## 步骤耗时",
            "",
            "| 步骤 | 耗时(s) |",
            "|---|---|",
            *[f"| {n} | {t} |" for n, t in steps],
            f"| 合计 | {round(sum(t for _, t in steps), 2)} |",
            "",
            "## 断言清单",
            "",
            *[f"- {'✓' if ok else '✗'} {n}" + (f" · {d}" if d else "") for n, ok, d in checks],
            "",
            "## 产物位置",
            "",
            f"- 产线目录：`{base}`（tmp，不清理不删除）",
            f"- 原包：`outbox/{order_id}.zip`；MD 版：`outbox/{order_id}_md(.zip)`；导入包：`outbox/{kb_name}_import_pack.zip`",
            "",
            "## 降级注记",
            "",
            f"- {meta_note}" if meta_mode != "live" else "- 无降级：真网络真灌全程贯通。",
            "",
        ]
        (PKG_DIR / "E2E_REPORT.md").write_text("\n".join(lines), encoding="utf-8", newline="")
        print(f"[e2e] 报告落 {PKG_DIR / 'E2E_REPORT.md'}", flush=True)
    # （⑥自身耗时不含入表：报告写盘即本步，链上真耗时=①-⑤）

    n_ok = sum(1 for _, ok, _ in checks if ok)
    print(f"[e2e] 断言 {n_ok}/{len(checks)} 绿 · {'E2E 通过' if n_ok == len(checks) else 'E2E 未过'}",
          flush=True)
    return 0 if n_ok == len(checks) else 1


if __name__ == "__main__":
    sys.exit(main())
