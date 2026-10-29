# -*- coding: utf-8 -*-
"""编目字段四件套 + TSV 元数据块（v2.6 #6）。

巨人肩膀（Ontology 101 第一律：复用先于自创）：
  - 编目四件套 = MIT librarian 式条目编目（类号 / 净题名 / 提要 / 受控标签）；
  - TSV 元数据块列结构 = Harvard Dataverse（Apache-2.0）metadata block 的
    name/type/required/multiple/vocabulary/parent 六列，文件条目为行。
纯 stdlib 规则实现：零 LLM、零网络、零第三方包，无随机源无时钟，同输入必同输出。

四件套（每文件条目一份，落 slot["catalog"] 增量键——小程序 v1/v2 双模式渲染
只读具名键，新增键不破渲染）：
  clc_no       中图法类号，从分组映射：L1 code 是中图法大类字母→直接用；
               否则用 taxonomy.CLC_22 别名对 L2/L1 组名打分，零分=无映射→如实 None
  clean_title  净题名：去站点前后缀（百度文库/豆丁网/道客巴巴…）与广告词
               （【精品】/免费下载/完整版…）；剥空则回退原题——绝不产空净题名
  digest       60-100 字提要：只取渠道 extra 真实摘要（abstract/snippet/intro/
               description…）清洗截断；无来源=「待补充」显式标注，禁编造（零造假：
               短于 60 的真实摘要如实保留，不注水凑数）
  digest_from  提要溯源（渠道名 / "none"），对账用（四件套随附键）
  tags         3-5 受控标签：命中需求关键词→L2 组名→中图法类名→需求域→
               tier 中文标签，全部取自真实受控词表，去重截 5（材料不足如实短）

入口：
  catalog_entry(slot, l1, l2, need, meta=FileMeta, channel=…)
      ——enrich 回填时逐槽调用（渠道摘要即刻入库；无 l1/l2 上下文时传 None 跳分组键）
  ensure_catalog(bp) ——全蓝图补缺四件套（既有真实值优先，增量不回退）
  dump_group_tsv(bp, out_dir) ——每 L2 分组一张 TSV（先 ensure 再落盘）

TSV 行值映射（六列照任务规约，tab 分隔，utf-8，值内制表/换行压平保可读回）：
  name=槽位文件名（组内唯一机器名） type=扩展名 required=core 档 true（主干必备）
  multiple=多值标签 true vocabulary=受控标签（| 连接） parent=中图法类号（无映射留空）
"""
import os
import re

from . import taxonomy
from .metadata import TIER_LABEL

CATALOG_KEYS = ("clc_no", "clean_title", "digest", "digest_from", "tags")
DIGEST_PLACEHOLDER = "待补充"   # 零造假：无来源显式标注，禁编造
DIGEST_MAX = 100                # 提要上限（60-100 字区间的高位截断）
# 渠道真实摘要键（优先级序）：wenku=abstract / djyanbao=snippet / doc88=intro /
# ima=description，后两个为通用兜底键
DIGEST_KEYS = ("abstract", "snippet", "intro", "description", "summary", "desc")

# 站点前后缀词表（剥净题名用；长词在前防「豆丁网」被「豆丁」抢先）
SITE_NAMES = ("百度文库", "道客巴巴", "原创力文档", "人人文库", "得力文库", "熊猫办公",
              "爱问共享资料", "MBA智库", "冰点文库", "豆丁网", "豆丁", "book118",
              "max.book118", "doc88", "doch88", "wenku")
# 广告词表（剥净题名用：括号段内含广告词整段剥；词本身锚定首尾剥）
AD_WORDS = ("免费下载", "限时下载", "限时免费", "打包下载", "无水印", "可编辑",
            "高清版", "超清版", "精品", "热门", "推荐", "最新版", "完整版", "原创")

_SEP_CLASS = r"[\s\-_－—–|｜·]"                     # 净题名分隔符族
_SITE_ALT = "|".join(re.escape(s) for s in sorted(SITE_NAMES, key=len, reverse=True))
_AD_ALT = "|".join(re.escape(w) for w in AD_WORDS)
_SITE_SUFFIX_RE = re.compile(rf"{_SEP_CLASS}*(?:{_SITE_ALT})\s*$", re.IGNORECASE)
_SITE_PREFIX_RE = re.compile(rf"^\s*(?:{_SITE_ALT}){_SEP_CLASS}+", re.IGNORECASE)
_SITE_PAREN_RE = re.compile(                        # 尾部「（book118.com）」类站点括注
    rf"{_SEP_CLASS}*[（(][^（）()]*?(?:{_SITE_ALT}|book118\.com|doc88\.com|baidu\.com)"
    rf"[^（）()]*?[）)]\s*$", re.IGNORECASE)
_AD_BRACKET_RE = re.compile(rf"\s*[【\[][^】\]]{{0,12}}?(?:{_AD_ALT})[^】\]]{{0,12}}?[】\]]")
_EDGE_SEP_RE = re.compile(rf"^{_SEP_CLASS}+|{_SEP_CLASS}+$")

# v2 document_driven 蓝图槽无 tier 键：按超越层名回填档位（同 document_engine 兼容映射）
_V2_TIER = {"合规底线": "core", "技术标准": "core", "操作实务": "field", "参考工具": "guide"}
_CLC_TOP = {c["code"] for c in taxonomy.CLC_22}
_CLC_NAME = {c["code"]: c["name"] for c in taxonomy.CLC_22}


# ── 净题名 ────────────────────────────────────────────────────────────────

def clean_title(title: str) -> str:
    """净题名：去站点前后缀/广告词；剥空回退原题（负例兜底，绝不产空净题名）。"""
    raw = str(title or "").strip()
    if not raw:
        return ""
    t = raw
    for _ in range(4):  # 叠层站点尾「… - 豆丁网 - book118」「… - 原创力文档（book118.com）」逐层剥
        new = _SITE_SUFFIX_RE.sub("", _SITE_PAREN_RE.sub("", t)).strip()
        if new == t:
            break
        t = new
    for _ in range(2):  # 站点头「百度文库 - …」
        new = _SITE_PREFIX_RE.sub("", t).strip()
        if new == t:
            break
        t = new
    t = _AD_BRACKET_RE.sub(" ", t)                   # 【精品】【最新完整】类括号段
    for _ in range(3):  # 广告词锚定首尾剥（「…实务免费下载」→「…实务」）
        new = re.sub(rf"(?:{_AD_ALT})\s*$", "", t).strip()
        new = re.sub(rf"^\s*(?:{_AD_ALT}){_SEP_CLASS}*", "", new).strip()
        if new == t:
            break
        t = new
    t = _EDGE_SEP_RE.sub("", re.sub(r"\s{2,}", " ", t)).strip()
    return t or raw


# ── 提要（零造假） ────────────────────────────────────────────────────────

def digest_from_extra(extra) -> tuple:
    """渠道 extra → (提要, 来源键)。只认真实摘要键；空白/纯 URL/缺席=("", None)。
    返回原文清洗值（≤100 字截断），短于 60 的真实摘要如实保留（不注水凑数）。"""
    if not isinstance(extra, dict):
        return "", None
    for key in DIGEST_KEYS:
        v = extra.get(key)
        if not isinstance(v, str):
            continue
        v = re.sub(r"<[^>]{1,20}>", "", v)           # 残留 HTML 强调标签
        v = re.sub(r"\s+", " ", v).strip()
        if len(v) >= 2 and not v.startswith(("http://", "https://", "www.")):
            return v[:DIGEST_MAX], key
    return "", None


# ── 中图法类号（从分组映射） ─────────────────────────────────────────────

def _clc_score(text: str) -> str | None:
    """组名文本对中图法 22 大类打别名分（口径同 taxonomy._clc_scores），零分=None。"""
    best, best_s = None, 0
    for c in taxonomy.CLC_22:
        s = sum(1 for a in c["aliases"] if a in text)
        if s > best_s:
            best, best_s = c["code"], s
    return best


def clc_for_group(l1: dict, l2: dict) -> str | None:
    """从分组映射得中图法类号：L1 code 是大类字母→直接用（引擎 clc 模式权威值）；
    否则（六域 MK/EN/…、超越层 D-01/…）L2 组名优先、L1 短名兜底打别名分，
    零分=无映射→如实 None（禁编造类号）。兜底只信 L1 短名不信 theme——
    theme 是长描述串（「政策 · 法规 · …」），会把无命中子组全染成同一类。"""
    code = str((l1 or {}).get("code") or "").strip()
    if code in _CLC_TOP:
        return code
    hit = _clc_score(str((l2 or {}).get("name") or ""))
    if hit:
        return hit
    return _clc_score(str((l1 or {}).get("name") or ""))


# ── 受控标签 ──────────────────────────────────────────────────────────────

def _slot_tier(slot: dict, l1: dict) -> str:
    """槽位档位：v1 槽自带 tier；v2 槽按超越层名映射（同 document_engine 兼容口径）。"""
    t = (slot or {}).get("tier")
    if t in TIER_LABEL:
        return t
    return _V2_TIER.get((l1 or {}).get("name"), "guide")


def build_tags(slot: dict, l1: dict, l2: dict, need: dict, clean: str,
               clc_no: str | None) -> list:
    """3-5 受控标签：命中需求关键词→L2 组名→中图法类名→需求域→tier 中文标签。
    全部取自真实受控词表（需求 keywords / 树节点 / CLC_22 / TIER_LABEL），
    去重保序截 5；材料不足时如实短（禁编造标签凑数）。"""
    l1, l2, need = l1 or {}, l2 or {}, need or {}
    text = f"{clean} {l1.get('name', '')} {l2.get('name', '')}"
    matched = [k for k in (need.get("keywords") or []) if isinstance(k, str) and k in text]
    tier = _slot_tier(slot, l1)
    cands = [*matched, l2.get("name"), _CLC_NAME.get(clc_no), need.get("domain"),
             TIER_LABEL.get(tier)]
    out, seen = [], set()
    for t in cands:
        t = str(t or "").strip()
        if t and t not in seen:
            seen.add(t)
            out.append(t)
    return out[:5]


# ── 四件套主入口 ─────────────────────────────────────────────────────────

def catalog_entry(slot: dict, l1: dict | None = None, l2: dict | None = None,
                  need: dict | None = None, meta=None, channel: str | None = None) -> dict:
    """计算四件套并写入 slot["catalog"]（确定性覆盖式重算，返回写入值）。

    meta=渠道 FileMeta（鸭子类型：title/extra）时：净题名取真实题名、提要取
    extra 真实摘要（无摘要键→「待补充」+ digest_from="none"）；meta 缺席时从
    槽位自描述字段推（占位槽摘要必为「待补充」——占位 description 不是渠道摘要，
    不得冒充提要，零造假）。"""
    l1, l2, need = l1 or {}, l2 or {}, need or {}
    title = ""
    if meta is not None and getattr(meta, "title", None):
        title = str(meta.title)
    title = title or str(slot.get("title") or slot.get("name") or "")
    clean = clean_title(title)
    if meta is not None:
        text, src_key = digest_from_extra(getattr(meta, "extra", None))
        digest_from = channel if text else "none"
    else:
        text, src_key, digest_from = "", None, "none"
    clc_no = clc_for_group(l1, l2)
    slot["catalog"] = {
        "clc_no": clc_no,
        "clean_title": clean,
        "digest": text or DIGEST_PLACEHOLDER,
        "digest_from": digest_from,
        "tags": build_tags(slot, l1, l2, need, clean, clc_no),
    }
    return slot["catalog"]


def _group_slots(l2: dict) -> list:
    """L2 组文件槽列表（files 优先，分拆组拍平；与 enrich._group_slots 同款）。"""
    if l2.get("files"):
        return l2["files"]
    return [f for sd in l2.get("split_dirs", []) for f in sd.get("files", [])]


def ensure_catalog(bp: dict) -> dict:
    """全蓝图补缺四件套（增量：既有真实值优先，缺键才补，绝不回退）。
    返回 {"groups": 组数, "files": 槽位数, "filled": 本次补全槽位数}。"""
    need = bp.get("need") if isinstance(bp.get("need"), dict) else {}
    groups = files = filled = 0
    for l1 in (bp.get("tree") or {}).get("l1") or []:
        for l2 in l1.get("l2") or []:
            groups += 1
            for slot in _group_slots(l2):
                files += 1
                cat = slot.get("catalog")
                if isinstance(cat, dict) and all(k in cat for k in CATALOG_KEYS):
                    continue
                entry = catalog_entry(slot, l1, l2, need)
                if isinstance(cat, dict):
                    slot["catalog"] = {**entry, **cat}  # 既有值（真实摘要等）优先
                filled += 1
    return {"groups": groups, "files": files, "filled": filled}


# ── TSV 元数据块（dataverse 列结构） ─────────────────────────────────────

TSV_COLUMNS = ("name", "type", "required", "multiple", "vocabulary", "parent")


def _ext_of(slot: dict) -> str:
    ext = slot.get("ext") or slot.get("fmt")
    if not ext and "." in str(slot.get("name") or ""):
        stem, _, tail = str(slot["name"]).rpartition(".")
        if stem and tail:
            ext = tail
    return str(ext or "bin")


def _tsv_filename(l2: dict, seq: int) -> str:
    """TSV 文件名：L2 code（KN-01/02）→ KN-01-02.tsv；无 code 回退组名净化/序号。"""
    base = str(l2.get("code") or l2.get("path") or l2.get("name") or "")
    base = re.sub(r"[\\/:*?\"<>|\s]+", "-", base).strip("-")
    return (base or f"group-{seq:03d}") + ".tsv"


def _tsv_row(slot: dict, l1: dict) -> list:
    cat = slot.get("catalog") or {}
    tags = cat.get("tags") or []
    row = [slot.get("name") or "", _ext_of(slot),
           "true" if _slot_tier(slot, l1) == "core" else "false",
           "true" if len(tags) > 1 else "false",
           "|".join(tags), cat.get("clc_no") or ""]
    return [re.sub(r"[\t\r\n]", " ", str(x)).strip() for x in row]  # 值内制表压平


def dump_group_tsv(bp: dict, out_dir) -> list:
    """每 L2 分组一张 TSV 元数据块（dataverse 六列结构），文件条目为行。
    落盘前先 ensure_catalog 补缺四件套（对蓝图纯增量）。返回写入路径列表。"""
    os.makedirs(out_dir, exist_ok=True)
    ensure_catalog(bp)
    written = []
    seq = 0
    for l1 in (bp.get("tree") or {}).get("l1") or []:
        for l2 in l1.get("l2") or []:
            slots = _group_slots(l2)
            if not slots:
                continue
            seq += 1
            path = os.path.join(out_dir, _tsv_filename(l2, seq))
            with open(path, "w", encoding="utf-8", newline="\n") as f:
                f.write("\t".join(TSV_COLUMNS) + "\n")
                for s in slots:
                    f.write("\t".join(_tsv_row(s, l1)) + "\n")
            written.append(path)
    return written
