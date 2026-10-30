# -*- coding: utf-8 -*-
"""_audit_ch05_final — 第5章终稿全量数字审计（双口径两账都报）:
  口径A (P锚回bank): 全部[来源: Pxxxxxx]锚点须在 bank_ch01-12 中真实存在;
                     正文全部数字token(剔锚点/章节号/代码块/表格结构)回 bank 联合文本验证。
  口径B ([N]回源文): 残留[NN]源编号须在 nblm_upload/ch06_笔记本 20件源包内可溯(文件存在+编号合法);
                     口径A未命中的数字token转查源包(20件)验证。
  附: CJK字数门(≥18000)/dup段/尾行chars一致性/AI与计算机术语扫描。
用法: py -X utf8 _audit_ch05_final.py
"""
import re, sys
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")

HERE = Path(__file__).resolve().parent
CH = "_ch05_final.md"
FW = "０１２３４５６７８９．，－／％＋（）［］"
HW = "0123456789.,-/%+()[]"
TRANS = str.maketrans(FW, HW)

def norm(s: str) -> str:
    s = s.translate(TRANS)
    s = re.sub(r"(?<=\d)\s+(?=\d)", "", s)
    s = re.sub(r"(?<=\d)[一一—–−]+(?=\d)", "-", s)
    return s

# ---- 底料加载 ----
bank_blocks = {}          # P锚 -> bank文本(锚点存在性)
banks_join = ""
for f in sorted(HERE.glob("bank_ch*.md")):
    t = f.read_text(encoding="utf-8", errors="ignore")
    banks_join += t
    for m in re.finditer(r"^## (P\d{6})\b", t, re.M):
        bank_blocks.setdefault(m.group(1), f.stem)
banks_n = norm(banks_join); banks_nc = banks_n.replace(",", "")

SRC = HERE / "nblm_upload" / "ch06_笔记本"
src_join = ""; src_files = {}
for f in sorted(SRC.glob("*.md")):
    t = f.read_text(encoding="utf-8", errors="ignore")
    src_join += t; src_files[int(re.match(r"(\d+)", f.name).group(1))] = f.name
srcs_n = norm(src_join); srcs_nc = srcs_n.replace(",", "")

t = (HERE / CH).read_text(encoding="utf-8")

# ---- 口径A: 锚点存在性 ----
anchors = re.findall(r"\[来源:\s*(P\d{6})[^\]]*\]", t)
anchor_multi = re.findall(r"\[来源:\s*((?:P\d{6}[,，;\s]*)+)\]", t)
flat = []
for grp in anchor_multi:
    flat += re.findall(r"P\d{6}", grp)
ghost = sorted({a for a in flat if a not in bank_blocks})

# ---- 数字token 双账 ----
num_re = re.compile(r"\d[\d.,%/－—~－-]*\d|\d")
in_code = False
fail_bank, pass_src, fail_both = [], [], []
total = pb = ps2 = shiyan = 0
for ln, raw in enumerate(t.splitlines(), 1):
    st = raw.strip()
    if st.startswith("```"):
        in_code = not in_code; continue
    if in_code or st.startswith("#") or st.startswith("<!--"):
        continue
    line = raw
    if "示意数据" in line:
        shiyan += len(num_re.findall(re.sub(r"\[(?:来源:)?\s*[^\]]*\]", " ", line)))
        continue                                                # 示例性复盘示意数(已明示),另账
    line = re.sub(r"\[(?:来源:)?\s*[^\]]*\]", " ", line)      # 锚点与[N]引用剔除
    line = re.sub(r"第\d+(至\d+)?[章节]", " ", line)
    line = re.sub(r"^\s*\d+(\.\d+)*\s*$", " ", line)
    line = re.sub(r"^\s*[-*]?\s*`?\[\d+\]`?[,，]?\s*$", " ", line)
    for tok in num_re.findall(line):
        tt = norm(tok).strip("%+")
        if not tt or not re.search(r"\d", tt):
            continue
        total += 1
        variants = {tt, tt.replace(",", ""), tt.rstrip("."), re.sub(r"[.,]+$", "", tt)}
        if any(v in banks_n or v in banks_nc for v in variants if v):
            pb += 1
        elif any(v in srcs_n or v in srcs_nc for v in variants if v):
            ps2 += 1; pass_src.append((ln, tok))
        else:
            fail_both.append((ln, tok))

# ---- 口径B: [N] 源编号可溯性 ----
cites = re.findall(r"\[(\d{1,2})\]", t)
ghost_cites = sorted({c for c in cites if int(c) not in src_files}, key=int)

# ---- dup段 / 尾行 / 体裁 ----
_keep, _inf = [], False
for _l in t.splitlines():
    if _l.strip().startswith("```"):
        _inf = not _inf; continue
    if not _inf and len(_l.strip()) >= 30:
        _keep.append(_l.strip())
paras = _keep
dpc = sum(v - 1 for v in __import__("collections").Counter(paras).values() if v > 1)
cjk = len(re.findall(r"[一-鿿]", t))
tail = [l for l in t.splitlines() if l.strip().startswith("<!-- chars:")]
tail_ok = bool(tail) and tail[-1].strip() == f"<!-- chars: {cjk} -->"
ai = re.findall(r"AI|人工智能|大模型|GPT|Claude|NotebookLM|机器生成|算法生成", t)
comp = re.findall(r"数据库|软件|程序|代码|接口|平台|系统架构|数据结构", t)

print(f"=== {CH} 终稿审计 ===")
print(f"CJK字数: {cjk:,} (门≥18,000 {'✓' if cjk>=18000 else '✗'}) | dup段: {dpc} | 尾行chars一致: {tail_ok}")
print(f"提及AI/生成式: {len(ai)}处 {ai[:5]} | 计算机词扫描(人工复核用): {len(comp)}处 {list(dict.fromkeys(comp))[:6]}")
print(f"--- 口径A (P锚回bank) ---")
print(f"证据锚点引用: {len(flat)}次 / 去重{len(set(flat))}个 | 幽灵锚点( bank中不存在): {len(ghost)} {ghost[:10]}")
print(f"数字token: {total} | bank命中: {pb} ({pb/total*100:.1f}%) | 示例性复盘示意数(已明示另账): {shiyan}")
print(f"--- 口径B ([N]回源文) ---")
print(f"残留[N]源引用: {len(cites)}次 | 幽灵编号(源包无对应文件): {len(ghost_cites)} {ghost_cites}")
print(f"数字token转源包命中: {ps2}")
print(f"--- 双账均未命中 (须修/删): {len(fail_both)} ---")
for ln, tok in fail_both:
    seg = t.splitlines()[ln-1][:80]
    print(f"  MISS L{ln} [{tok}] :: {seg}")
