# -*- coding: utf-8 -*-
"""归档清洗器（W6 judge #2）：诊断/活测归档 JSON 的提取码与凭据残值掩码。

背景（2026-10-29 W5 归档复盘）：share/pset 响应的 qrcodeurl 内嵌 `pwd=<明文提取码>`
（顶层字段已掩码，URL 查询串漏网）——judge 抓漏。本件双用：
1. `scrub_payload(obj)`：内存清洗（后续 smoke/诊断落档前调用）；
2. `scrub_file(path)` / CLI：对已落盘 JSON 追溯清洗（原件存 `<name>.orig` 后改写）。

掩码规则（窄刃，只动提取码类内容，不动其他）：
- 任意字符串值内 URL 查询串：`?pwd=XXX` / `&pwd=XXX` → `?pwd=***` / `&pwd=***`
  （XXX 为非 & 任意串；空值 `pwd=` 也统一为 `pwd=***`）；
- dict 的 pwd/passwd 字段为明文短串（非 *** / <masked…> 形态）→ "***"
  （冒烟归档里这些字段本已掩码——保持既有掩码不动，仅补漏）；
- bduss/stoken/bdstoken 字段名出现明文 → 掩码并打印警告（归档件不该有）。

用法：
  python tests\\_diag_archive\\scrub.py <json 文件或目录>...   # 追溯清洗（留 .orig）
  python tests\\_diag_archive\\scrub.py --check <目录>          # 只扫描报告零改写
"""
from __future__ import annotations

import json
import os
import re
import sys

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

# URL 查询串里的提取码参数（负向前瞻排除已掩码 *** → 幂等：二跑零替换）
_PWD_IN_URL = re.compile(r"([?&]pwd=)(?!\*\*\*)[^&]*")
_PWD_KEYS = ("pwd", "passwd")
_CRED_KEYS = ("bduss", "stoken", "bdstoken")
_MASKED_SHAPE = re.compile(r"^(\*{3}|<masked\b)")


def scrub_string(s: str) -> tuple[str, int]:
    """清洗字符串内的 URL pwd 查询参数 → (新串, 替换次数)。"""
    return _PWD_IN_URL.subn(r"\1***", s)


def _scrub_value(v, hits: list, path: str = "$"):
    """纯函数式递归清洗 → (新值, 替换次数)。不原地改写（str 不可变陷阱免疫）。"""
    if isinstance(v, dict):
        out, n = {}, 0
        for k, val in v.items():
            kl = str(k).lower()
            if (kl in _CRED_KEYS and isinstance(val, str) and val
                    and not _MASKED_SHAPE.match(val)):
                out[k], n = "***", n + 1
                hits.append(f"{path}.{k}=cred(归档件不应含凭据)")
            elif (kl in _PWD_KEYS and isinstance(val, str) and val
                    and not _MASKED_SHAPE.match(val)):
                out[k], n = "***", n + 1
                hits.append(f"{path}.{k}=pwd")
            else:
                out[k], nn = _scrub_value(val, hits, f"{path}.{k}")
                n += nn
        return out, n
    if isinstance(v, list):
        out, n = [], 0
        for i, item in enumerate(v):
            new_item, nn = _scrub_value(item, hits, f"{path}[{i}]")
            out.append(new_item)
            n += nn
        return out, n
    if isinstance(v, str):
        new, cnt = scrub_string(v)
        if cnt:
            hits.append(f"{path}=url_pwd×{cnt}")
        return new, cnt
    return v, 0


def scrub_payload(obj):
    """入口：→ (清洗后对象, 替换次数, 命中清单)。原对象不动，返回新对象。"""
    hits: list = []
    new_obj, n = _scrub_value(obj, hits)
    return new_obj, n, hits


def scrub_file(path: str, keep_orig: bool = True, dry_check: bool = False) -> dict:
    """清洗一个 JSON 归档件。keep_orig=True 时原件存 <path>.orig（仅追溯清洗用；
    例行归档走 scrub_payload 内存清洗，不产生 .orig）。"""
    with open(path, "r", encoding="utf-8") as f:
        obj = json.load(f)
    new_obj, n, hits = scrub_payload(obj)
    row = {"file": path, "replacements": n, "hits": hits, "rewritten": False}
    if n == 0 or dry_check:
        return row
    if keep_orig:
        orig = path + ".orig"
        if not os.path.exists(orig):        # 幂等：不覆盖已有原件
            with open(path, "r", encoding="utf-8") as fsrc, \
                    open(orig, "w", encoding="utf-8") as fdst:
                fdst.write(fsrc.read())
            row["orig_kept"] = orig
    tmp = path + ".tmp"
    with open(tmp, "w", encoding="utf-8") as f:
        json.dump(new_obj, f, ensure_ascii=False, indent=2)
    os.replace(tmp, path)
    row["rewritten"] = True
    return row


def main(argv: list) -> int:
    if not argv:
        print(__doc__)
        return 2
    dry = False
    if argv[0] == "--check":
        dry, argv = True, argv[1:]
        print("# 只扫描零改写模式")
    total = 0
    for p in argv:
        if os.path.isdir(p):                # 目录 → 递归 .json（跳过 .orig）
            files = [os.path.join(dp, fn) for dp, _dn, fns in os.walk(p)
                     for fn in fns if fn.endswith(".json")]
        else:
            files = [p]
        for fp in files:
            try:
                row = scrub_file(fp, keep_orig=not dry, dry_check=dry)
            except (OSError, ValueError) as e:
                print(f"[scrub] 跳过 {fp}: {type(e).__name__}: {e}")
                continue
            total += row["replacements"]
            tag = "命中" if row["replacements"] else "干净"
            print(f"[scrub] {tag} {fp} 替换={row['replacements']} "
                  f"{'→ 原件留 ' + row['orig_kept'] if row.get('orig_kept') else ''}")
            for h in row["hits"]:
                print(f"        {h}")
    print(f"# 合计替换 {total} 处")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
