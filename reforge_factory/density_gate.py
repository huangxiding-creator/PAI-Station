# -*- coding: utf-8 -*-
"""density_gate — 章级密度门 (T-012R / REQ-014, 百倍V3).

REQ-014: m2 章节验收时执行章级密度门（gzip 冗余增量 / 新 n-gram 率 / slop
规则密度，CONTEXT 术语口径「密度四指标」= 三判据 + 章字数参考），超标章打回。
REQ-013: 章字数带降为参考值（floor 来自 gates.json chapter_band.floor_per_type），
密度门主判。

指标口径 (docstring 公式, 全标准库实现, 全本地):

1) redundancy_ratio — gzip(zlib/deflate) 冗余增量 (标准 NCD 前后半口径), 高=冗余, [0,1]:
       C(s)    = len(raw_deflate(s))            # zlib.compressobj(wbits=-15, level=9)
       A, B    = 测量汉字流(前 MEASURE_MAX_CJK_CHARS 字)的 UTF-8 字节等长前半 / 后半
       NCD(A,B) = (C(A+B) - min(C(A),C(B))) / max(C(A),C(B))
       redundancy_ratio = 1 - NCD(A,B)
   解释: 后半内容在前半已出现(重复堆砌/复制粘贴) → 压缩 B 时可回引 A →
         C(A+B)≈C(A) → NCD≈0 → redundancy≈1 (高冗余);
         后半与前半信息互异(信息密集) → C(A+B)≈C(A)+C(B) → NCD≈1 →
         redundancy≈0 (低冗余). deflate 32KB 滑窗约束: A+B ≤ 24KB UTF-8
         (8000 汉字) 保证 B 可全程回引 A, NCD 口径有效.
   (注: 自拼接 C(x+x) 口径不可用 — deflate 对逐字节相同的后半直接回引,
    任何文本增量都趋 0, 无判别力; 故取前后半 NCD.)

2) new_ngram_rate — 相对通用中文停用骨架 (SKELETON_GRAMS 冻结虚词集) 的
   2/3-gram 新词率 = 非骨架去重 n-gram 类型数 / n-gram token 总数 (type/token 比):
       grams  = 每个连续汉字段内滑动 bigram + trigram (不跨段)
       rate   = |{g ∈ set(grams) : g ∉ SKELETON_GRAMS}| / max(1, |grams|)
   低=词汇多样性差/复制粘贴; 高=信息密集. 判据: 不低于下限.

3) slop_hits / slop_density_per_kchar — 内置中文 slop(套话/空话)正则命中:
       slop_hits               = 各 SLOP_PATTERNS 在全文命中次数总和
       slop_density_per_kchar  = slop_hits / max(1, cjk_chars) * 1000
   判据用每千汉字密度 (章长不一归一), slop_hits 保留原值供报告.

4) cjk_chars — 章汉字数 (REQ-013: 降为参考值, 附 gates.json floor 参考, 不判).

阈值表: reforge_factory/config/density_thresholds.json — 每次判定现读 (无缓存,
可热改); 初值为保守启发临时基线, 黄金样板分位数标定位待标 (见 json note).

打回记录: chapter_verdict 判 reject 时追加 {file,chapter,metrics,verdict,ts}
到 V3 work/density_rejects.jsonl (DEFAULT_REJECTS_PATH, 可用 reject_log 覆盖;
传 False 关闭落账).
"""
from __future__ import annotations

import json
import re
import time
import zlib
from pathlib import Path

__all__ = [
    "metrics", "chapter_verdict", "record_reject",
    "DEFAULT_THRESHOLDS_PATH", "DEFAULT_REJECTS_PATH",
    "CHAPTER_TYPES", "SLOP_PATTERNS", "SKELETON_GRAMS",
]

# ---------------------------------------------------------------- 路径常量
_FACTORY_ROOT = Path(__file__).resolve().parent
DEFAULT_THRESHOLDS_PATH = _FACTORY_ROOT / "config" / "density_thresholds.json"
DEFAULT_REJECTS_PATH = (Path("E:/AI-Station") / "ResearchFactory-Eng" / "06 迭代优化"
                        / "百倍V3_极致调研变现计划" / "work" / "density_rejects.jsonl")
_GATES_JSON = _FACTORY_ROOT / "config" / "gates.json"

CHAPTER_TYPES = ("精编", "融合", "原创")   # 与 gates.json chapter_band.floor_per_type 同键

# ---------------------------------------------------------------- slop 正则 (≥12 条)
SLOP_PATTERNS: tuple[tuple[str, str], ...] = (
    ("值得注意的是", r"值得注意的是"),
    ("综上所述", r"综上所述"),
    ("众所周知", r"众所周知"),
    ("不难发现", r"不难发现"),
    ("不难看出", r"不难看出"),
    ("由此可见", r"由此可见"),
    ("总而言之", r"总而言之"),
    ("显而易见", r"显而易见"),
    ("毋庸置疑", r"毋庸置疑"),
    ("毋庸讳言", r"毋庸讳言"),
    ("与此同时", r"与此同时"),
    ("首先其次", r"首先[\s\S]{0,40}?其次"),
    ("赋能", r"赋能"),
    ("抓手", r"抓手"),
    ("起到了重要作用", r"起到了?[极重]?[其大]??的作用"),
    ("奠定基础", r"奠定了?[^。，；]{0,10}基础"),
    ("保驾护航", r"保驾护航"),
    ("迈上新台阶", r"[迈再]上[了新]?台阶"),
    ("深入贯彻", r"深入贯彻"),
    ("随着发展", r"随着[^。，；]{0,16}的?不断发展"),
    ("当今背景", r"在当今[^。，；]{0,10}背景[下中]"),
    ("发挥着作用", r"发挥[着了][^。，；]{0,8}作用"),
    ("闭环", r"闭环"),
    ("颗粒度", r"颗粒度"),
)

# ------------------------------------------------- 通用中文停用骨架 (冻结集)
# 虚词/功能词 n-gram: 命中视为「骨架旧词」, 不计入新 n-gram. 宁小勿大, 避免误杀实词.
_SKELETON_WORDS = """
我们 你们 他们 这个 那个 哪个 每个 一个 一些 一样 一直 一方面 不仅 而且 但是 因为 所以 如果 虽然 还有 就是 还是 已经 通过 对于 关于 其中 其他 之间 之一 以上 以下 进行 可以 应该 需要 能够 成为 使得 达到 以及 或者 同时 此外 另外 例如 包括 除了 随着 目前 现在 过去 时候 的话 之后 之前 以及 因此 然而 并且 或者 但是 不仅 而且 那么 这样 那样 怎样 为什么 怎么 什么 哪些 这些 那些 自己 更加 最大 最低 平均 水平 情况 方面 一定程度上 基本上 进一步 一般来说 换言之 也就是说 总体来看 由此可见 的时候 有没有 是不是 能不能 也就是 与此同 此外 另外 首先 其次 最后 再次 许多 很多 大量 少量 部分 全部 整个 个别 单一 对于 针对 根据 按照 遵循 除了 关于 由于 鉴于 无论 不管 只要 只有 既然 假如 倘若 即使 尽管 仍然 依然 仍然 正在 将会 曾经 刚刚 马上 立刻 随后 紧接 最终 结果 首先 再者
"""
SKELETON_GRAMS: frozenset[str] = frozenset(
    w for w in _SKELETON_WORDS.split() if 2 <= len(w) <= 3
)

# ---------------------------------------------------------------- 内部参数
MEASURE_MAX_CJK_CHARS = 8000          # 冗余测量上限汉字数 (UTF-8 24KB < 32KB deflate 窗口)
_CJK_SEG_RE = re.compile(r"[\u4e00-\u9fff]+")
_CJK_CHAR_RE = re.compile(r"[\u4e00-\u9fff]")


# ---------------------------------------------------------------- 公式实现
def _raw_deflate_len(data: bytes) -> int:
    """len(raw deflate 流) — zlib 标准库, wbits=-15 去头尾, level=9."""
    co = zlib.compressobj(9, zlib.DEFLATED, -15)
    return len(co.compress(data) + co.flush())


def _redundancy_ratio(cjk_stream: str) -> float:
    """redundancy_ratio = 1 - NCD(A,B) (前半 A vs 后半 B), 见模块 docstring 公式."""
    x = cjk_stream[:MEASURE_MAX_CJK_CHARS].encode("utf-8")
    if len(x) < 64:
        return 0.0
    half = len(x) // 2
    a, b = x[:half], x[half:2 * half]
    ca, cb = _raw_deflate_len(a), _raw_deflate_len(b)
    cab = _raw_deflate_len(a + b)
    m = max(ca, cb)
    if m <= 0:
        return 0.0
    ncd = (cab - min(ca, cb)) / m
    return max(0.0, min(1.0, 1.0 - ncd))


def _ngram_stats(text: str) -> tuple[int, int]:
    """(非骨架去重 n-gram 类型数, n-gram token 总数) — 段内滑窗 2/3-gram."""
    total = 0
    new_types: set[str] = set()
    for seg in _CJK_SEG_RE.findall(text):
        n = len(seg)
        for i in range(n - 1):
            g = seg[i:i + 2]
            total += 1
            if g not in SKELETON_GRAMS:
                new_types.add(g)
        for i in range(n - 2):
            g = seg[i:i + 3]
            total += 1
            if g not in SKELETON_GRAMS:
                new_types.add(g)
    return len(new_types), total


def metrics(text: str) -> dict:
    """四指标报告: 三判据 + 章汉字数(参考). 公式见模块 docstring."""
    cjk_chars = len(_CJK_CHAR_RE.findall(text))
    segs = _CJK_SEG_RE.findall(text)
    stream = "".join(segs)
    new_types, total_grams = _ngram_stats(text)
    slop_hits = sum(len(re.findall(pat, text)) for _, pat in SLOP_PATTERNS)
    return {
        "cjk_chars": cjk_chars,
        "redundancy_ratio": round(_redundancy_ratio(stream), 4),
        "new_ngram_rate": round(new_types / total_grams, 4) if total_grams else 1.0,
        "slop_hits": slop_hits,
        "slop_density_per_kchar": round(slop_hits / cjk_chars * 1000, 4) if cjk_chars else 0.0,
    }


# ---------------------------------------------------------------- 阈值
def load_thresholds(path=None) -> dict:
    """现读阈值表 (无缓存 → json 可热改). 结构 {chapter_type: {…}} + defaults."""
    p = Path(path) if path else DEFAULT_THRESHOLDS_PATH
    data = json.loads(p.read_text(encoding="utf-8"))
    return data.get("thresholds", {})


def _thresholds_for(chapter_type: str, table: dict) -> dict:
    if chapter_type in table:
        return table[chapter_type]
    return table.get("defaults", {})


def _char_floor_reference(chapter_type: str) -> int | None:
    """REQ-013: 章字数带降为参考 — 从 gates.json 取 floor_per_type (只读, 失败容忍)."""
    try:
        g = json.loads(_GATES_JSON.read_text(encoding="utf-8"))
        return g["chapter_band"]["floor_per_type"].get(chapter_type)
    except Exception:
        return None


# ---------------------------------------------------------------- 判定
_RULE_KEYS = (   # (指标键, 阈值键, 方向) — direction: max=超标于超过, min=低于下限超标
    ("redundancy_ratio", "redundancy_ratio_max", "max"),
    ("new_ngram_rate", "new_ngram_rate_min", "min"),
    ("slop_density_per_kchar", "slop_density_per_kchar_max", "max"),
)


def chapter_verdict(md_text: str, chapter_type: str = "精编", *,
                    source_file: str | None = None,
                    thresholds_path=None, reject_log=None) -> dict:
    """章级密度门判定: 三指标对照阈值表 → pass / 超标哪项.

    chapter_verdict(md_text, chapter_type) → {
      verdict: "pass"|"reject", failed: [{rule,value,threshold,op}],
      metrics, chapter_type, thresholds_used, char_count_reference }
    reject 时自动追加打回记录到 reject_log (默认 V3 work/density_rejects.jsonl;
    reject_log=False 关闭; 传路径覆盖 — 测试用 tmp).
    """
    m = metrics(md_text)
    table = load_thresholds(thresholds_path)
    th = _thresholds_for(chapter_type, table)
    failed = []
    for metric_key, rule_key, direction in _RULE_KEYS:
        limit = th.get(rule_key)
        if limit is None:
            continue
        value = m[metric_key]
        if direction == "max" and value > limit:
            failed.append({"rule": rule_key, "value": value,
                           "threshold": limit, "op": "<="})
        elif direction == "min" and value < limit:
            failed.append({"rule": rule_key, "value": value,
                           "threshold": limit, "op": ">="})
    verdict = {
        "verdict": "reject" if failed else "pass",
        "chapter_type": chapter_type,
        "failed": failed,
        "metrics": m,
        "thresholds_used": th,
        "char_count_reference": {
            "cjk_chars": m["cjk_chars"],
            "floor_per_type": _char_floor_reference(chapter_type),
            "note": "V3: 章字数带降为参考值, 密度门主判 (REQ-013)",
        },
    }
    if failed and reject_log is not False:
        record_reject(verdict, source_file=source_file,
                      path=None if reject_log in (None, True) else reject_log)
    return verdict


def record_reject(verdict: dict, *, source_file: str | None = None,
                  path=None) -> Path:
    """打回记录追加 jsonl: {file, chapter, metrics, verdict, ts}."""
    p = Path(path) if path else DEFAULT_REJECTS_PATH
    p.parent.mkdir(parents=True, exist_ok=True)
    rec = {
        "file": source_file or "<inline>",
        "chapter": verdict.get("chapter_type"),
        "metrics": verdict["metrics"],
        "verdict": {k: verdict[k] for k in ("verdict", "failed")},
        "ts": time.strftime("%Y-%m-%dT%H:%M:%S%z") or time.strftime("%Y-%m-%dT%H:%M:%S"),
    }
    with p.open("a", encoding="utf-8") as f:
        f.write(json.dumps(rec, ensure_ascii=False) + "\n")
    return p


# ---------------------------------------------------------------- CLI 自测
if __name__ == "__main__":  # pragma: no cover
    import sys
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    src = sys.argv[1] if len(sys.argv) > 1 else None
    ctype = sys.argv[2] if len(sys.argv) > 2 else "精编"
    text = Path(src).read_text(encoding="utf-8") if src else (
        "湖南省2024年基建投资同比增长8.5%，其中EPC模式渗透率持续提升。" * 50)
    v = chapter_verdict(text, ctype, source_file=src, reject_log=False)
    print(json.dumps(v, ensure_ascii=False, indent=1))
