# -*- coding: utf-8 -*-
"""_audit_ch02_final — EPC-CASELAW 收编编辑段 ch05 终稿全量审计（双口径两账都报）:
  口径A (P锚回bank): 全部(P锚)锚点须在本章 bank_ch05.md 中真实存在;
                     正文全部数字token(剔own_calc句/标题/代码块/表格结构行)回本章bank验证。
  口径B ([事实]回源包): 口径A未命中的数字token转查 nblm_upload/ch05_笔记本 全文源包验证。
  附: CJK字数门(>=18000) | dup段 | NBLM残留/术语扫描 | 尾注锚覆盖 | 残留[N]源编号。
用法: py -X utf8 _audit_ch01_final.py
"""
import re, sys, json
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8")

HERE = Path(__file__).resolve().parent
FW = "０１２３４５６７８９．，－／％＋（）［］"
HW = "0123456789.,-/%+()[]"
TRANS = str.maketrans(FW, HW)

def norm(s: str) -> str:
    s = s.translate(TRANS)
    s = re.sub(r"(?<=\d)\s+(?=\d)", "", s)
    return s

ARTIFACTS = ["树子问卷", "请回复", "继续输出", "下一阶段请求", "Studio", "工作室面板", "笔记本全量",
             "NBLM", "NotebookLM", "来源编号索引说明", "读者可随时指示", "已为你撰写", "own_calc 标注",
             "AI生成", "人工智能生成", "大语言模型", "语料库", "抓取", "纯HTTP", "是否需要我",
             "由于字数安排", "分段输出指令", "源引用对照", "研究总监"]
CJK_RE = re.compile(r"[一-鿿]")

report = {}
print("=" * 88)
ch = HERE / "_ch05_final.md"
bank = HERE / "bank_ch05.md"
src_dir = HERE / "nblm_upload" / "ch05_笔记本"
t = ch.read_text(encoding="utf-8")
bt = bank.read_text(encoding="utf-8", errors="ignore")
bank_blocks = set(re.findall(r"^## (P\d{6})\b", bt, re.M))
banks_n = norm(bt).replace(",", "")
src_join = ""
src_files = 0
for f in sorted(src_dir.glob("*")):
    if f.is_file() and f.suffix in (".md", ".txt"):
        src_join += f.read_text(encoding="utf-8", errors="ignore")
        src_files += 1
srcs_n = norm(src_join).replace(",", "")

# ---- 锚点存在性 ----
anchors = sorted(set(re.findall(r"P\d{6}", t)))
ghost = [a for a in anchors if a not in bank_blocks]

# ---- 尾注覆盖 ----
endnote = re.search(r"## 本章尾注[^\n]*\n(.+)$", t, re.S)
endnote_ps = set(re.findall(r"^\| (P\d{6}) \|", endnote.group(1), re.M)) if endnote else set()
endnote_missing = [a for a in anchors if a not in endnote_ps]

# ---- 残留 [N] ----
resid = re.findall(r"\[\d{1,2}(?:[,，\s]\d{1,2})*\]", t)

# ---- 数字token 双口径 ----
num_re = re.compile(r"\d[\d.,%/－—~\-]*\d|\d")
fail_bank, derived_ok, pass_src, fail_both = [], [], [], []
total = 0
for ln, raw in enumerate(t.splitlines(), 1):
    st = raw.strip()
    if st.startswith("#") or st.startswith(">") or st.startswith("```"):
        continue
    if "own_calc" in st or "示意性" in st and "%" in st:
        pass  # own_calc 句跳过; 示意性标尺句照查(不跳, 走数字核对)
    if "own_calc" in st:
        continue
    if re.match(r"^\|[:\-\s|]+\|$", st):
        continue
    cells = st.split("|") if st.startswith("|") else [st]
    for cell in cells:
        if re.fullmatch(r"\s*[:\-\s]*\s*", cell):
            continue
        for m in num_re.finditer(norm(cell)):
            tok = m.group(0)
            if len(tok.replace(".", "").replace(",", "")) < 2:
                continue  # 单位序号/极短token
            if re.match(r"^(19|20)\d{2}$", tok) and not re.search(r"[%年月日万亿倍家件条]", cell[max(0, m.start()-1):m.end()+2]):
                continue  # 裸年份
            total += 1
            tn = tok.replace(",", "")
            if tn in banks_n:
                continue
            elif tn in srcs_n:
                pass_src.append(tok)
            else:
                fail_both.append((ln, tok, cell.strip()[:48]))
# ---- dup 段 ----
paras = [p.strip() for p in re.split(r"\n\s*\n", t) if 30 < len(p.strip()) < 400 and not p.strip().startswith("|")]
seen, dups = {}, []
for p in paras:
    key = re.sub(r"\s", "", p)[:60]
    if key in seen:
        dups.append(p[:40])
    seen[key] = 1
# ---- 残留与术语 ----
art_hits = {a: t.count(a) for a in ARTIFACTS if a in t}
# ---- CJK ----
cjk = len(CJK_RE.findall(t))
gate = cjk >= 18000

rec = dict(cjk=cjk, gate=gate, anchors=len(anchors), ghost=ghost,
           endnote_missing=endnote_missing, residual_N=resid[:5],
           num_total=total, pass_bank=total - len(pass_src) - len(fail_both),
           pass_srcB=len(pass_src), fail_both=len(fail_both),
           fail_samples=fail_both[:10], dup_paras=dups[:5], artifacts=art_hits,
           src_files=src_files)
report["ch05"] = rec
print("### 第5章 _ch05_final.md")
print(f"  CJK {cjk} (门>=18000: {'PASS' if gate else 'FAIL'}) | P锚 {len(anchors)} 个 | 幽灵锚 {ghost or '无'}")
print(f"  尾注缺锚 {endnote_missing or '无'} | 残留[N] {resid[:5] or '无'}")
print(f"  数字token {total}: bank命中 {rec['pass_bank']} | 口径B源包命中 {len(pass_src)} | 双账未中 {len(fail_both)}")
for ln, tok, cell in fail_both[:10]:
    print(f"    - L{ln} [{tok}] {cell}")
print(f"  dup段 {len(dups)} {dups[:3] or ''} | 残留/术语 {art_hits or '无'}")
print("-" * 88)

(HERE / "_audit_ch05_final_report.json").write_text(json.dumps(report, ensure_ascii=False, indent=1), encoding="utf-8")
print("审计账落盘: _audit_ch05_final_report.json")
