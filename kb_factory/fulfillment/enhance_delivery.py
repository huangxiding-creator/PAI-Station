# -*- coding: utf-8 -*-
"""C2 交付增强管线（KB-FACTORY 2.0 轴④）——BagIt 交付包出厂后处理。

四段增强（顺序即依赖：清洗先行，提要吃 QA 后文本）：
  ① 编目四件套补全：包内 manifest.json 每已交付文本件回填 cataloging 四件套
     （clc_no 类号 / clean_title 净题名 / digest 提要 / tags 受控标签，随附
     digest_from 溯源键）；提要自「QA 清洗后的正文」实测抽取（digest_from=
     text_qa/text_raw 如实标源），蓝图可加载时四件套带 L1/L2 分组上下文
     （类号/标签更真），蓝图缺席走独立档（类号如实 None，禁编造）。
  ② qa_clean 清洗：调同包 harvest_engine.qa_clean.qa_clean 生成 <stem>.cleaned.md
     随原件并排交付（原件字节不动）；qa_clean 模块缺席/单件失败→如实计账跳过，
     绝不伪造清洗件。
  ③ 预览站随库交付：manifest 引用蓝图且蓝图可加载时，export_mkdocs 于
     kb 根生成 preview_site/（mkdocs.yml + docs/ 骨架，纯 stdlib）；本机装有
     mkdocs 时追加 mkdocs build --strict 静态站（preview_site/site/），
     缺席或禁用→skip 如实记原因。
  ④ BagIt 重打包：增强件落包后 export_bagit 增量重打包到 <包名>_enh 新包
     （原包四件 tag 文件一个不动；禁删纪律：原包保留，回执指认新包为权威交付）。

ops 账（增量覆盖台账）：kb 根 ops-enhance.jsonl 逐行 JSON 全实测回执，随增强件
一并进新包载荷（审计随库交付）。分层如实：enhance 行先写（新包载至该行），
repack 自身回执随后补尾行（重打包不可能先于自身产物入包，不伪造时序）。

接线说明（本模块不碰 engine.py/既有开关；新能力独立成文件）：
  - 手动单包：from kb_factory.fulfillment import enhance_delivery
              receipt = enhance_delivery.enhance(Path(bag_dir))
  - 产线收口（pipeline.run → bagit_export 之后）：
      bag_receipt = bx.export_bagit(kb_root, out_dir, quote)
      enh_receipt = enhance_delivery.enhance(Path(bag_receipt["bag_dir"]))
  - qa_clean 未随本轴落地时缺席可跑（清洗腿如实降级计账）；harvest_engine.qa_clean
    上线后 import 期自动探测接管，零改动。
  - 测试桩：enhance(bag, qa_clean=fake_fn, build_site=False)（清洗注入/禁建站）。

纪律：数字零造假——全部计数实测自盘；任何分支不删除文件；清洗只增不改。
"""
import importlib.util
import json
import subprocess
import sys
import time
from pathlib import Path
from types import SimpleNamespace

from ..catalog_engine.cataloging import (CATALOG_KEYS, DIGEST_MAX,
                                         catalog_entry, ensure_catalog)
from ..export_mkdocs import export_mkdocs as run_export_mkdocs
from .bagit_export import export_bagit

# 清洗/编目对象=文档型文本件（md/markdown/txt）；.json/.csv 等账簿与数据件不入编目
CLEAN_SUFFIXES = {".md", ".markdown", ".txt"}
# 记账类文件（产线自产簿记页，非知识文档，不入四件套/清洗）
BOOKKEEPING_NAMES = {"_INDEX.md", "manifest.json", "获取指引清单.md", "使用与来源说明.md"}
CLEANED_SUFFIX = ".cleaned.md"      # 清洗件命名：<原stem>.cleaned.md
PREVIEW_DIR = "preview_site"        # 预览站目录（kb 根下，随库交付）
LEDGER_NAME = "ops-enhance.jsonl"   # 增量覆盖 ops 账（随载荷进新包）
_SITE_BUILD_TIMEOUT = 180           # mkdocs build 超时（秒）
_DIGEST_LINES = 3                   # 提要取正文前 N 个有效行（标题/引用/表格行跳过）
_DIGEST_SKIP_PREFIX = ("#", ">", "|", "---")   # md 结构行不进提要


def _now() -> str:
    return time.strftime("%Y-%m-%dT%H:%M:%S")


def _call_cleaner(fn, text: str, source: str) -> str:
    """清洗器归一调用：兼容 qa_clean(text) 与 clean_text(text, source)→(文, ops)。

    收割轴 qa_clean 两种口径皆认；返回值取元组首元（ops 明细归收割轴审计位，
    本模块只计件数账）。双形态都调不动→TypeError 上抛由调用方如实计失败。
    """
    try:
        out = fn(text, source)
    except TypeError:                       # 单参形态 qa_clean(text) 兜底
        out = fn(text)
    if isinstance(out, tuple):
        out = out[0] if out else ""
    return out


def _resolve_qa_clean():
    """懒探测同包 harvest_engine.qa_clean；缺席→None（调用方如实计账）。

    巨人肩膀纪律：qa_clean 归收割轴所有，本模块只探测不实现；import 失败/半成品
    一律视为缺席，绝不在此抛出（增强腿降级而非崩链）。归一为 fn(text, source)。
    """
    try:
        from ..harvest_engine import qa_clean as mod
    except Exception:                       # ImportError 及包内任何导入期异常
        return None, "absent"
    fn = getattr(mod, "qa_clean", None)     # 口径A：任务书 qa_clean(text)→str
    if callable(fn):
        return (lambda text, source: fn(text)), "qa_clean"
    ct = getattr(mod, "clean_text", None)   # 口径B：落地实口径 (text, source)→(文, ops)
    if callable(ct):
        return (lambda text, source: ct(text, source)[0]
                if isinstance(ct(text, source), tuple) else ct(text, source)), "clean_text"
    return None, "absent"


# ── 文本读取 / 提要抽取（零造假：短于 60 字的真实摘要如实保留）────────────

def _read_text(path: Path):
    """utf-8 → gb18030 双解码（口径同 bagit_export.count_words）；都解不开 None。"""
    raw = path.read_bytes()
    for enc in ("utf-8", "gb18030"):
        try:
            return raw.decode(enc)
        except UnicodeDecodeError:
            continue
    return None


def _text_digest(text: str) -> str:
    """正文前 N 有效行 → 提要（≤100 字截断；空/纯结构行→空串，由调用方降级）。"""
    lines = []
    for ln in str(text or "").splitlines():
        s = ln.strip()
        if not s or any(s.startswith(p) for p in _DIGEST_SKIP_PREFIX):
            continue
        lines.append(s)
        if len(lines) >= _DIGEST_LINES:
            break
    digest = " ".join(lines)
    digest = " ".join(digest.split())        # 折叠空白
    return digest[:DIGEST_MAX] if len(digest) >= 2 else ""


def _iter_content_texts(root: Path) -> list:
    """root 下文档型内容件清单（Path 列表，rglob 排序确定性）。

    排除：记账簿（BOOKKEEPING_NAMES）、清洗件自身（*.cleaned.md）、预览站目录。
    """
    out = []
    for p in sorted(root.rglob("*")):
        if not p.is_file() or p.suffix.lower() not in CLEAN_SUFFIXES:
            continue
        if p.name in BOOKKEEPING_NAMES or p.name.endswith(CLEANED_SUFFIX):
            continue
        if PREVIEW_DIR in p.relative_to(root).parts:   # 预览站件非知识文档
            continue
        out.append(p)
    return out


# ── 蓝图 / manifest 对接 ──────────────────────────────────────────────────

def _load_blueprint(ref):
    """蓝图引用 → (bp|None, 原因)。缺席/路径无效/JSON 坏→(None, 如实原因)。"""
    if not ref:
        return None, "manifest 未携带蓝图引用"
    p = Path(str(ref))
    if not p.is_file():
        return None, f"蓝图文件不存在: {p}"
    try:
        bp = json.loads(p.read_text(encoding="utf-8"))
    except (OSError, ValueError) as e:
        return None, f"蓝图加载失败: {e}"
    if not isinstance(bp.get("tree"), dict) or not (bp["tree"].get("l1") or []):
        return None, "蓝图缺 tree.l1（空树不可用）"
    return bp, ""


def _slot_index(bp: dict) -> dict:
    """蓝图槽位索引：槽名 → (slot, l1, l2)（files 优先，分拆组拍平，首见为准）。"""
    idx = {}
    for l1 in (bp.get("tree") or {}).get("l1") or []:
        if not isinstance(l1, dict):
            continue
        for l2 in l1.get("l2") or []:
            if not isinstance(l2, dict):
                continue
            slots = l2.get("files") or [f for sd in l2.get("split_dirs") or []
                                        for f in sd.get("files", [])]
            for slot in slots:
                if isinstance(slot, dict) and slot.get("name") not in idx:
                    idx[slot["name"]] = (slot, l1, l2)
    return idx


def _entry_index(manifest: dict, kb_root: Path) -> tuple:
    """manifest 文件条目双索引：(kb 相对 path 键→条目, 槽名→条目)；首见为准。"""
    by_path, by_slot = {}, {}
    for e in manifest.get("files") or []:
        if not isinstance(e, dict):
            continue
        key = str(e.get("path") or "")
        if key.startswith(kb_root.name + "/"):
            key = key[len(kb_root.name) + 1:]
        rel = key.replace("\\", "/")
        if rel and rel not in by_path:
            by_path[rel] = e
        sn = str(e.get("slot") or "")
        if sn and sn not in by_slot:
            by_slot[sn] = e
    return by_path, by_slot


# ── BagIt 侧工具（读原包 tag 真值，不篡改）────────────────────────────────

def _bag_domain(bag: Path) -> str:
    """bag-info.txt 的 Library-Domain 真值；缺失回退包名。"""
    info = bag / "bag-info.txt"
    if info.is_file():
        for ln in info.read_text(encoding="utf-8").splitlines():
            if ln.startswith("Library-Domain:"):
                return ln.split(":", 1)[1].strip() or bag.name
    return bag.name


def _parse_quote(bag: Path):
    """原包 quote.txt → dict（键: 值 行格式回读）；缺失/空→None。"""
    q = bag / "quote.txt"
    if not q.is_file():
        return None
    out = {}
    for ln in q.read_text(encoding="utf-8").splitlines():
        if ":" in ln:
            k, v = ln.split(":", 1)
            k, v = k.strip(), v.strip()
            if k:
                out[k] = v
    return out or None


def _free_enh_dir(bag: Path) -> Path:
    """重打包目标名：<包名>_enh（占用则 _enh2/_enh3…首个空位；绝不覆盖）。"""
    cand = bag.parent / (bag.name + "_enh")
    i = 1
    while cand.exists() and (cand.is_file() or any(cand.iterdir())):
        i += 1
        cand = bag.parent / f"{bag.name}_enh{i}"
    return cand


# ── 预览站构建（mkdocs 缺席 skip 如实记）──────────────────────────────────

def _mkdocs_available() -> bool:
    try:
        return importlib.util.find_spec("mkdocs") is not None
    except Exception:
        return False


def _build_site(site_dir: Path, yml_path: Path) -> dict:
    """mkdocs build --strict 静态站（子进程，判据=strict 零错误）；失败如实记。"""
    t0 = time.perf_counter()
    cmd = [sys.executable, "-X", "utf8", "-m", "mkdocs", "build",
           "--strict", "-f", str(yml_path)]
    try:
        r = subprocess.run(cmd, cwd=str(site_dir), capture_output=True,
                           timeout=_SITE_BUILD_TIMEOUT)
    except (OSError, subprocess.SubprocessError) as e:
        return {"ok": False, "error": f"{type(e).__name__}: {e}"}
    site = site_dir / "site"
    # 成功判据=strict 零错误（exporter 判据②）+ 站点真产物实测（html 页数>0；
    # mkdocs 默认 use_directory_urls 无根 index.html，以实测 html 计数为准）
    htmls = [q for q in site.rglob("*.html")] if site.is_dir() else []
    ok = r.returncode == 0 and bool(htmls)
    return {"ok": ok, "returncode": r.returncode,
            "site_dir": str(site) if site.is_dir() else None,
            "html_pages": len(htmls),
            "elapsed_s": round(time.perf_counter() - t0, 3)}


# ── 主入口 ────────────────────────────────────────────────────────────────

def enhance(bag_dir, *, qa_clean=None, build_site=None) -> dict:
    """BagIt 交付包后处理（四段：四件套补全/qa_clean 清洗/预览站/重打包）。

    - bag_dir：bagit_export.export_bagit 产出的包目录（data/ 载荷 + tag 四件）
    - qa_clean：清洗函数注入位（默认 None→import 期探测 harvest_engine.qa_clean）
    - build_site：预览站构建开关（None=自动按 mkdocs 可用性；False=禁用）
    返回全实测回执 dict；任何腿失败/缺席如实计账，不抛出（对齐 deliver 纪律）。
    """
    bag = Path(bag_dir)
    data = bag / "data"
    if not bag.is_dir() or not data.is_dir():
        raise ValueError(f"非 BagIt 包目录（缺 data/）: {bag}")

    receipt = {"bag_dir": str(bag), "ts": _now()}
    t0 = time.perf_counter()

    # ── 载荷定位：kb 根=最浅 manifest.json 所在目录（缺 manifest 回退 data 根）──
    manifests = sorted(data.rglob("manifest.json"),
                       key=lambda p: len(p.relative_to(data).parts))
    manifest_path = manifests[0] if manifests else None
    kb_root = manifest_path.parent if manifest_path else data
    receipt["kb_root"] = str(kb_root)
    manifest = {}
    if manifest_path is not None:
        try:
            loaded = json.loads(manifest_path.read_text(encoding="utf-8"))
            if isinstance(loaded, dict):
                manifest = loaded
            else:
                manifest_path, kb_root = None, data
                receipt["manifest_error"] = "manifest.json 非对象（回退 data 根）"
        except (OSError, ValueError) as e:
            receipt["manifest_error"] = f"{type(e).__name__}: {e}"
            manifest, manifest_path, kb_root = {}, None, data

    # ── 蓝图对接（四件套分组上下文 + 预览站原料）───────────────────────────
    bp_ref = (manifest.get("kb") or {}).get("blueprint_ref") if manifest else None
    bp, bp_reason = _load_blueprint(bp_ref)
    receipt["blueprint"] = {"ref": str(bp_ref or ""), "loaded": bp is not None,
                            "reason": bp_reason}
    slot_idx = {}
    if bp is not None:
        m = ensure_catalog(bp)                 # 蓝图全槽四件套补缺（增量不回退）
        receipt["blueprint"].update(m)
        slot_idx = _slot_index(bp)

    # ── ② qa_clean 清洗（先行：①提要吃 QA 后文本）─────────────────────────
    if qa_clean is None:
        qa_clean, mode = _resolve_qa_clean()
    else:
        mode = "injected"
    receipt["qa_clean"] = mode
    content_files = _iter_content_texts(kb_root)
    digests = {}                               # rel → (提要, 溯源 text_qa/text_raw)
    badges = {}                                # rel → 渠道徽章（clean_text source 位）
    if manifest:
        bp_map, bs_map = _entry_index(manifest, kb_root)
        for rel, e in bp_map.items():
            b = str(e.get("badge") or e.get("channel") or "").strip()
            if b:
                badges[rel] = b
    cleaned = clean_skipped = clean_failed = 0
    fail_notes = []
    for p in content_files:
        rel = p.relative_to(kb_root).as_posix()
        raw = _read_text(p)
        if raw is None:
            clean_failed += 1
            fail_notes.append(f"{rel}:双编码解码失败")
            continue
        dst = p.with_name(p.stem + CLEANED_SUFFIX)
        if qa_clean is None:
            digests[rel] = (_text_digest(raw), "text_raw")
            continue                           # 清洗腿缺席：提要回退原文实测
        if dst.exists():
            clean_skipped += 1                 # 幂等：清洗件已在，不覆盖
            ct = _read_text(dst)
            digests[rel] = (_text_digest(ct) if ct else "", "text_qa")
            continue
        try:
            out = _call_cleaner(qa_clean, raw, badges.get(rel) or "fulfillment")
            if not isinstance(out, str) or not out.strip():
                raise ValueError("qa_clean 返回非字符串/空")
            with open(dst, "w", encoding="utf-8", newline="\n") as f:
                f.write(out)
            cleaned += 1
            digests[rel] = (_text_digest(out), "text_qa")
        except Exception as e:                 # 单件失败不破链：如实计账降级原文
            clean_failed += 1
            fail_notes.append(f"{rel}:{type(e).__name__}:{e}")
            digests[rel] = (_text_digest(raw), "text_raw")
    receipt["clean"] = {"text_files": len(content_files), "cleaned": cleaned,
                        "skipped_existing": clean_skipped, "failed": clean_failed,
                        "notes": fail_notes[:20]}

    # ── ① 编目四件套入 manifest（提要=QA 后文本实测；蓝图缺席走独立档）─────
    by_path, by_slot = _entry_index(manifest, kb_root) if manifest else ({}, {})
    catalog_filled = catalog_kept = no_entry = 0
    from_bp = from_standalone = 0                     # 四件套上下文来源实测分计
    need = bp.get("need") if isinstance(bp, dict) and isinstance(bp.get("need"), dict) else {}
    for p in content_files:
        rel = p.relative_to(kb_root).as_posix()
        entry = by_path.get(rel) or by_slot.get(p.name)
        if entry is None:
            no_entry += 1
            continue
        if isinstance(entry.get("catalog"), dict) and \
                all(k in entry["catalog"] for k in CATALOG_KEYS):
            catalog_kept += 1                  # 幂等：四件套已入位不重算
            continue
        digest, src = digests.get(rel, ("", "none"))
        triple = slot_idx.get(entry.get("slot")) or slot_idx.get(p.name)
        if triple is not None:
            slot, l1, l2 = triple
            if not (isinstance(slot.get("catalog"), dict)
                    and all(k in slot["catalog"] for k in CATALOG_KEYS)):
                catalog_entry(slot, l1, l2, need)      # 蓝图槽缺四件套现场补
            cat = dict(slot["catalog"])                # 带分组上下文的四件套
            from_bp += 1
        else:
            stub = {"name": p.name, "title": entry.get("slot_title") or p.stem,
                    "ext": p.suffix.lstrip(".")}
            meta = SimpleNamespace(title=stub["title"],
                                   extra={"abstract": digest} if digest else None)
            cat = catalog_entry(stub, None, None, need, meta=meta,
                                channel=src if digest else "none")
            from_standalone += 1
        if digest:                                     # 任务口径：QA 后文本提摘要
            cat["digest"], cat["digest_from"] = digest[:DIGEST_MAX], src
        entry["catalog"] = cat
        catalog_filled += 1
    receipt["catalog"] = {"filled": catalog_filled, "kept_existing": catalog_kept,
                          "no_manifest_entry": no_entry, "from_blueprint": from_bp,
                          "from_standalone": from_standalone,
                          "source": ("blueprint" if from_bp and not from_standalone
                                     else "standalone" if from_standalone and not from_bp
                                     else "mixed" if from_bp else "none")}

    # ── manifest 回写（增量：既有键全保，只增 catalog/enhance 账）──────────
    if manifest_path is not None and (catalog_filled or catalog_kept):
        manifest["enhance"] = {
            "qa_clean": receipt["qa_clean"], "clean": receipt["clean"],
            "catalog": receipt["catalog"], "blueprint": receipt["blueprint"],
            "ops_ledger": LEDGER_NAME}
        manifest_path.write_text(
            json.dumps(manifest, ensure_ascii=False, indent=1), encoding="utf-8")

    # ── ③ 预览站（蓝图可用才生成；mkdocs 缺席只出骨架）────────────────────
    site_dir = kb_root / PREVIEW_DIR
    if bp is None:
        receipt["preview_site"] = {"skipped": f"蓝图不可用: {bp_reason}"}
    elif site_dir.exists() and any(site_dir.iterdir()):
        receipt["preview_site"] = {"skipped": f"已存在不覆盖: {site_dir}"}
    else:
        skel = run_export_mkdocs(bp, site_dir)
        want_build = _mkdocs_available() if build_site is None else bool(build_site)
        if want_build:
            skel["build"] = _build_site(site_dir, Path(skel["mkdocs_yml"]))
        else:
            skel["build"] = {"skipped": "mkdocs 缺席或已禁用（骨架已随库交付）"}
        receipt["preview_site"] = skel

    # ── ops 账（增量覆盖台账，先于重打包写入→随载荷进新包）─────────────────
    ledger = kb_root / LEDGER_NAME
    line = {"ts": _now(), "event": "enhance", "bag_dir": str(bag),
            "clean": receipt["clean"], "catalog": receipt["catalog"],
            "preview_site": {"skipped": receipt["preview_site"].get("skipped"),
                             "md_pages": receipt["preview_site"].get("md_pages"),
                             "build_ok": (receipt["preview_site"].get("build") or {})
                             .get("ok")},
            "blueprint": receipt["blueprint"], "qa_clean": receipt["qa_clean"]}
    with open(ledger, "a", encoding="utf-8", newline="\n") as f:
        f.write(json.dumps(line, ensure_ascii=False) + "\n")
    receipt["ops_ledger"] = str(ledger)

    # ── ④ BagIt 重打包（data/ 全载荷→新包；原包保留，tag 四件不动）─────────
    quote = _parse_quote(bag) or {"库域名": _bag_domain(bag)}
    new_bag = _free_enh_dir(bag)
    try:
        rp = export_bagit(data, new_bag, quote)
        rp["old_bag_note"] = "原包保留（禁删）；本回执为权威交付"
        receipt["repack"] = rp
        tail = {"ts": _now(), "event": "repack", "new_bag_dir": rp["bag_dir"],
                "files": rp["files"], "bytes": rp["bytes"], "words": rp["words"],
                "self_check": rp["self_check"]}
        with open(ledger, "a", encoding="utf-8", newline="\n") as f:
            f.write(json.dumps(tail, ensure_ascii=False) + "\n")
    except Exception as e:                     # 重打包失败如实计账（载荷已在原包）
        receipt["repack"] = {"error": f"{type(e).__name__}: {e}",
                             "old_bag_note": "重打包失败：原包载荷已含增强件"}

    receipt["elapsed_s"] = round(time.perf_counter() - t0, 3)
    return receipt


__all__ = ["enhance"]
