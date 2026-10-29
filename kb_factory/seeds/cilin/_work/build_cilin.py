# -*- coding: utf-8 -*-
"""词林原始件 → 词→编码倒排种子 JSON（KB-FACTORY v2.7 #10，波B）

输入：seeds/cilin/_raw/cilin_V1.txt（yaleimeng/Final_word_Similarity cilin/V1，
      「编码 词1 词2 …」逐行，gbk 编码；GitHub raw 官方直链（经 7890 代理）下载，
      字节数 696374 已与 GitHub contents API listing 对账，sha256 记入 _summary）
输出：seeds/cilin/cilin.json（{"meta":…, "words": {词: [编码,…]}} 倒排，全量如实）
      + seeds/cilin/_summary.json（台账：字节对账/实测计数/版权与 85777 口径注记）

零造假注记（实测口径）：
  - 本文件实测 17817 行 / 17809 个唯一 8 位编码（Ga05/Hg02/Hg03 区 8 码上游重复
    出现，词表并集合并如实记档）/ 90115+ 词条次 / 77456 去重词，与 yaleimeng
    README 表中「同义词词林 77456」口径完全一致；
  - 任务简报所引「85777」= 该 README 中「词林+HowNet 混合词汇量 85777」，
    即两库并集词汇数，非词林单库词数——此处如实记档，禁手填 85777。

编码五层结构（8 位 = 5 层 + 1 相似标记）：
  大类(1) 中类(1) 小类(2) 词群(1) 原子词群(1) 标记(1: '='同义 '#'相关 '@'独立)
"""
from __future__ import annotations
import hashlib
import json
import re
from datetime import datetime, timezone
from pathlib import Path

CILIN_DIR = Path(__file__).resolve().parents[1]        # seeds/cilin/
RAW = CILIN_DIR / "_raw" / "cilin_V1.txt"
OUT = CILIN_DIR / "cilin.json"
SUMMARY = CILIN_DIR / "_summary.json"

CODE_RE = re.compile(r"^[A-Za-z]{2}[0-9]{2}[A-Za-z][0-9]{2}[=#@]$")


def main() -> None:
    raw = RAW.read_bytes()
    sha256 = hashlib.sha256(raw).hexdigest()
    assert len(raw) == 696374, f"字节数对账失败: {len(raw)} != 696374"

    words: dict[str, list[str]] = {}                    # 词 → [编码…]（保持文件序）
    codes: dict[str, list[str]] = {}                    # 编码 → [词…]（重复码词表并集）
    dup_codes: dict[str, int] = {}                      # 上游重复出现的编码 → 出现次数
    tokens = 0
    n_lines = 0
    bad_lines = 0
    for line in raw.decode("gb18030").splitlines():     # gb18030 为 gbk 超集
        parts = line.split()
        if not parts:
            continue
        n_lines += 1
        code, ws = parts[0], parts[1:]
        if not CODE_RE.match(code) or not ws:
            bad_lines += 1
            continue
        tokens += len(ws)
        bucket = codes.setdefault(code, [])
        if bucket:                                      # 上游重复码：词表并集合并
            dup_codes[code] = dup_codes.get(code, 1) + 1
        for w in ws:
            if w not in bucket:
                bucket.append(w)
            cb = words.setdefault(w, [])
            if code not in cb:
                cb.append(code)

    assert bad_lines == 0, f"坏行 {bad_lines} 条（上游应为 17817 行全有效）"
    assert n_lines == 17817, f"行数实测 {n_lines} != 17817"
    assert len(codes) == 17809, f"唯一编码实测 {len(codes)} != 17809"
    assert len(dup_codes) == 8, f"重复码实测 {len(dup_codes)} != 8"
    assert len(words) == 77456, f"去重词实测 {len(words)} != 77456"

    marker = {"=": 0, "#": 0, "@": 0}
    for c in codes:
        marker[c[-1]] += 1
    multi = sum(1 for v in words.values() if len(v) > 1)

    meta = {
        "source": "yaleimeng/Final_word_Similarity cilin/V1/cilin.txt",
        "upstream": "https://github.com/yaleimeng/Final_word_Similarity",
        "repo_license": "MIT（仓库代码层）",
        "data_copyright": "《同义词词林(扩展版)》数据版权归哈工大 HIT-SCIR/知网，"
                          "商用前须上游授权评估或换自建同义组（cilin_norm 默认关）",
        "encoding": "gb18030 解码（上游 loader 用 gbk，实测同结果）",
        "raw_bytes": len(raw),
        "raw_sha256": sha256,
        "raw_lines": n_lines,
        "code_groups": len(codes),
        "dup_codes": dup_codes,
        "word_tokens": tokens,
        "unique_words": len(words),
        "multi_code_words": multi,
        "groups_by_marker": marker,
        "note_85777": "简报口径 85777=README 中词林+HowNet 并集词汇量，非词林文件词数",
        "built_at": datetime.now(timezone.utc).isoformat(timespec="seconds"),
    }
    OUT.write_text(json.dumps({"meta": meta, "words": words},
                              ensure_ascii=False, separators=(",", ":")),
                   encoding="utf-8")

    summary = dict(meta)
    summary["out_file"] = OUT.name
    summary["out_bytes"] = OUT.stat().st_size
    summary["raw_files_kept"] = sorted(
        p.name for p in (CILIN_DIR / "_raw").iterdir() if p.is_file())
    SUMMARY.write_text(json.dumps(summary, ensure_ascii=False, indent=1),
                       encoding="utf-8")
    print(f"cilin.json: {len(words)} words / {len(codes)} codes / dup {len(dup_codes)} / "
          f"tokens {tokens} / multi-code {multi} / marker {marker} / "
          f"{OUT.stat().st_size} bytes")


if __name__ == "__main__":
    main()
