# -*- coding: utf-8 -*-
"""W7 履约：付费交付包 BagIt 化导出器（v2.6 #2，公有领域规范纯手写零依赖）。

把镜像树交付产物（outbox/<订单号>/<知识库名>/ 三级树）打成 BagIt 包
（RFC 8493 / bagit-python 兼容，不装第三方库）：
- data/                    载荷 = 镜像树原样复制（copy 非 move，源不动）
- manifest-sha256.txt      每行「sha256  相对路径」（两空格，路径相对包根含 data/ 前缀）
- bag-info.txt             库域名/文件数/总字数/生成日期 ISO/Payload-Oxum（全实测）
- quote.txt                报价单 tag 文件（quote_info dict 逐行「键: 值」；str 原样）
- tagmanifest-sha256.txt   tag 文件哈希对账（覆盖除自身外全部 tag 文件）
- bagit.txt                规范声明（BagIt-Version / 字符编码）

命名律：载荷相对路径禁空格（中文可用）；日期一律 ISO（YYYY-MM-DD）；
序号一律补零（suggest_bag_name 产 <域名>_<ISO日期>_<NNN> 包名，报价单序号同律）。
数字零造假：文件数/字节数/字数/哈希全部实测自复制后的交付副本——
字数口径 = 文本类后缀文件 UTF-8/GB18030 解码后 CJK 逐字 + 西文连串各计 1，
二进制（pdf 等）如实计 0，绝不手填。
纪律：任何分支不删除文件；out_dir 已存在且非空即拒（绝不覆盖既有交付）；
出厂自检 verify_bagit 不过即抛（绝不带病出厂）。
"""
import hashlib
import re
import shutil
import time
from pathlib import Path

BAGIT_VERSION = "0.97"        # 与 bagit-python 工具链互验最稳的版本线
MANIFEST_NAME = "manifest-sha256.txt"
TAGMANIFEST_NAME = "tagmanifest-sha256.txt"
BAGIT_DECL_NAME = "bagit.txt"
BAG_INFO_NAME = "bag-info.txt"
QUOTE_NAME = "quote.txt"
_SEP = "  "                    # manifest 校验和与路径分隔：两空格（bagit-python 同款）

# 实测字数口径：只对文本类后缀解码计数，其余（pdf/zip 等）如实 0
TEXT_SUFFIXES = {".txt", ".md", ".markdown", ".html", ".htm", ".json", ".jsonl",
                 ".csv", ".xml", ".yml", ".yaml", ".log", ".py"}
_CJK_RANGES = ((0x3400, 0x4DBF), (0x4E00, 0x9FFF), (0xF900, 0xFAFF),
               (0x20000, 0x2A6DF), (0x2A700, 0x2EBEF), (0x30000, 0x3134F))
_WORD_RE = re.compile(r"[A-Za-z0-9]+(?:['\-][A-Za-z0-9]+)*")
_MANIFEST_LINE_RE = re.compile(r"^([0-9a-fA-F]{64})\s+(\S.*)$")
_ISO_DATE_RE = re.compile(r"^\d{4}-\d{2}-\d{2}$")
_SEQ_KEYS = ("序号", "seq", "order_seq")  # 报价单整数字段补零渲染


def _iso_date() -> str:
    return time.strftime("%Y-%m-%d")


def suggest_bag_name(domain, seq: int, date: str | None = None, width: int = 3) -> str:
    """包名助手：<库域名>_<ISO日期>_<序号补零>（域名空格转 _，命名律三件套）。"""
    d = date or _iso_date()
    if not _ISO_DATE_RE.match(d):
        raise ValueError(f"日期非 ISO（YYYY-MM-DD）: {d}")
    dom = re.sub(r"\s+", "_", str(domain).strip())
    return f"{dom}_{d}_{int(seq):0{width}d}"


def _is_cjk(ch: str) -> bool:
    return any(lo <= ord(ch) <= hi for lo, hi in _CJK_RANGES)


def count_words(path) -> int:
    """实测单文件字数：文本类=CJK 逐字计 1 + 西文/数字连串计 1；其余二进制如实 0。"""
    p = Path(path)
    if p.suffix.lower() not in TEXT_SUFFIXES:
        return 0
    raw = p.read_bytes()
    text = None
    for enc in ("utf-8", "gb18030"):
        try:
            text = raw.decode(enc)
            break
        except UnicodeDecodeError:
            continue
    if text is None:
        return 0  # 双编码都解不开：如实 0，不猜
    cjk = sum(1 for ch in text if _is_cjk(ch))
    return cjk + len(_WORD_RE.findall(text))


def _sha256_file(path) -> str:
    h = hashlib.sha256()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def _check_name_law(rel: str):
    """命名律门：载荷相对路径禁空格/制表符/反斜杠/.. 逃逸；正斜杠分隔。违者 ValueError。"""
    if "\\" in rel or rel != rel.strip():
        raise ValueError(f"载荷相对路径非法: {rel!r}")
    parts = rel.split("/")
    if any((not part) or part in (".", "..") or " " in part or "\t" in part
           for part in parts):
        raise ValueError(f"载荷相对路径违反命名律（相对路径+无空格）: {rel!r}")


def _write_lf(path: Path, text: str):
    """tag 文件统一 UTF-8 无 BOM + LF（跨平台确定性）。"""
    with open(path, "w", encoding="utf-8", newline="\n") as f:
        f.write(text)


def _one_line(s) -> str:
    return str(s).replace("\r", " ").replace("\n", " ").strip()


def _render_quote(quote_info):
    """报价单渲染：dict→「键: 值」逐行（保持插入序，序号类整数字段补零）；
    str→原样；None→None（不产 quote.txt）。键值内换行折叠为空格（保 tag 行格式）。"""
    if quote_info is None:
        return None
    if isinstance(quote_info, str):
        return quote_info if quote_info.endswith("\n") else quote_info + "\n"
    if not isinstance(quote_info, dict) or not quote_info:
        raise ValueError("quote_info 仅接受 dict/str/None")
    lines = []
    for k, v in quote_info.items():
        if str(k) in _SEQ_KEYS and isinstance(v, int) and not isinstance(v, bool):
            v = f"{v:03d}"  # 序号补零（对齐镜像树 01/02 与订单 001 习惯）
        lines.append(f"{_one_line(k)}: {_one_line(v)}")
    return "\n".join(lines) + "\n"


def export_bagit(src_dir, out_dir, quote_info) -> dict:
    """镜像树 → BagIt 交付包；返回实测统计 dict（与 bag-info 同源，禁手填）。

    - src_dir：镜像树根（库域名目录，或含它的订单目录），全部文件递归作 data/ 载荷
    - out_dir：包目录（已存在且非空即拒；绝不覆盖/删除既有产物）
    - quote_info：报价单（dict/str/None → quote.txt tag 文件）
    库域名取 quote_info 的 库域名/domain/库名 键，缺省用 src_dir 名。
    """
    src = Path(src_dir)
    bag = Path(out_dir)
    if not src.is_dir():
        raise ValueError(f"src_dir 不存在或不是目录: {src}")
    # 1) 载荷清点 + 命名律门（先验后写：违律即拒，不留半成品包）
    rels = sorted(p.relative_to(src).as_posix() for p in src.rglob("*") if p.is_file())
    if not rels:
        raise ValueError(f"src_dir 无任何文件，拒绝打空包: {src}")
    for rel in rels:
        _check_name_law(rel)
    if bag.exists() and (bag.is_file() or any(bag.iterdir())):
        raise ValueError(f"out_dir 已存在且非空，拒绝覆盖: {bag}")
    data_dir = bag / "data"
    data_dir.mkdir(parents=True, exist_ok=True)

    # 2) 载荷复制（copy 非 move）+ 实测统计（对复制后的副本算：交付什么测什么）
    total_bytes = total_words = 0
    entries = []
    for rel in rels:
        dst = data_dir.joinpath(*rel.split("/"))
        dst.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(src.joinpath(*rel.split("/")), dst)
        entries.append((_sha256_file(dst), "data/" + rel))
        total_bytes += dst.stat().st_size
        total_words += count_words(dst)

    # 3) manifest-sha256.txt（两空格分隔；行序=相对路径排序，确定性）
    _write_lf(bag / MANIFEST_NAME,
              "".join(f"{sha}{_SEP}{rel}\n" for sha, rel in entries))

    # 4) bagit.txt（规范声明）
    _write_lf(bag / BAGIT_DECL_NAME,
              f"BagIt-Version: {BAGIT_VERSION}\n"
              f"Tag-File-Character-Encoding: UTF-8\n")

    # 5) quote.txt（tag 文件，可缺省）
    quote_text = _render_quote(quote_info)
    if quote_text is not None:
        _write_lf(bag / QUOTE_NAME, quote_text)

    # 6) bag-info.txt（四要件全实测：库域名/文件数/总字数/生成日期 ISO）
    if isinstance(quote_info, dict):
        domain = (quote_info.get("库域名") or quote_info.get("domain")
                  or quote_info.get("库名") or src.name)
    else:
        domain = src.name
    info_lines = [
        f"Library-Domain: {domain}",
        f"Payload-Files: {len(rels)}",
        f"Payload-Oxum: {total_bytes}.{len(rels)}",
        f"Total-Word-Count: {total_words}",
        "Word-Count-Method: cjk_char+ascii_word; text-suffix files only (binary counted 0)",
        f"Bagging-Date: {_iso_date()}",
        "Bagging-Software: kb_factory.fulfillment.bagit_export",
    ]
    _write_lf(bag / BAG_INFO_NAME, "\n".join(info_lines) + "\n")

    # 7) tagmanifest-sha256.txt：对账全部在位 tag 文件（不含自身）
    tag_names = sorted(n for n in (BAGIT_DECL_NAME, BAG_INFO_NAME, MANIFEST_NAME, QUOTE_NAME)
                       if (bag / n).is_file())
    _write_lf(bag / TAGMANIFEST_NAME,
              "".join(f"{_sha256_file(bag / n)}{_SEP}{n}\n" for n in tag_names))

    receipt = {
        "bag_dir": str(bag),
        "domain": domain,
        "files": len(rels),
        "bytes": total_bytes,
        "words": total_words,
        "bagging_date": _iso_date(),
        "tags": tag_names,
    }
    ok, bad = verify_bagit(bag)  # 出厂自检：对账不过即抛，绝不带病出厂
    if bad:
        raise RuntimeError(f"BagIt 出厂自检失败: ok={ok} bad={bad}: {bag}")
    receipt["self_check"] = [ok, bad]
    return receipt


def verify_bagit(bag_dir):
    """全量哈希重算对账：payload manifest + tagmanifest 逐行重算；
    加完整性清点（data/ 夹带未登记件、根层 tag 漏登记、manifest 缺失/坏行各计坏）。
    返回 (ok_count, bad_count)。"""
    bag = Path(bag_dir)
    ok = bad = 0

    def _check_manifest(mpath: Path) -> set:
        nonlocal ok, bad
        listed = set()
        if not mpath.is_file():
            bad += 1  # 对账文件缺失：按坏计
            return listed
        for line in mpath.read_text(encoding="utf-8").splitlines():
            if not line.strip():
                continue
            m = _MANIFEST_LINE_RE.match(line)
            if not m:
                bad += 1  # 行格式坏：按坏计
                continue
            sha, rel = m.group(1).lower(), m.group(2).strip()
            listed.add(rel)
            target = bag.joinpath(*rel.split("/"))
            if target.is_file() and _sha256_file(target) == sha:
                ok += 1
            else:
                bad += 1
        return listed

    payload_listed = _check_manifest(bag / MANIFEST_NAME)
    tag_listed = _check_manifest(bag / TAGMANIFEST_NAME)

    # 完整性清点 1：data/ 下实测文件必须全在 payload manifest（夹带即坏）
    data_dir = bag / "data"
    if data_dir.is_dir():
        for p in sorted(data_dir.rglob("*")):
            if p.is_file():
                rel = "data/" + p.relative_to(data_dir).as_posix()
                if rel not in payload_listed:
                    bad += 1
    # 完整性清点 2：根层 tag 文件必须全在 tagmanifest（漏登记即坏；tagmanifest 自身除外）
    for p in sorted(bag.glob("*")):
        if p.is_file() and p.name not in tag_listed and p.name != TAGMANIFEST_NAME:
            bad += 1
    return ok, bad
