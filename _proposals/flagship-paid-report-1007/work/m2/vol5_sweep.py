# -*- coding: utf-8 -*-
"""vol5_sweep — 卷五《独家判断卷》全卷一键验收 (主验波次用).

每章四查:
  1. m2_gate --target N          字数带 ±5% + 禁词 + 冻结门
  2. 引用门: gate3_vol5(融合/原创, own_num) / m2_gate2(精编, bank)
  3. 精编 UNREF 补查: 带数字句必须挂 P 六位锚 (gate2 不查此项, sweep 兜底)
  4. 判断卷结构门: 「证据强度：」标注 >=8 处 ∧ 「反证检验：」>=4 处

usage: PYTHONIOENCODING=utf-8 python vol5_sweep.py [num ...]   # 缺省全 7 章
exit: 0 全 PASS / 1 有 FAIL / 2 冻结门
"""
import re
import subprocess
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
PY = r"C:\Users\91216\AppData\Local\Programs\Python\Python311\python.exe"
WORK = r"E:\AI-Station\_proposals\flagship-paid-report-1007\work"
VOL5 = WORK + r"\..\bluebook\vol5"

# (章号, 文件, 目标字数, 门类型, 参数)
CHAPTERS = [
    (1, "5-1-fangfalun.md", 4000, "gate2", "vol5_bank_method.txt"),
    (2, "5-2-wubufa.md", 9000, "gate2", "vol5_bank_wubufa.txt"),
    (3, "5-3-chuangxiao.md", 7000, "gate2", "vol1_bank_yingli.txt"),
    (4, "5-4-zuzhi.md", 10000, "gate3", 4),
    (5, "5-5-xuanze.md", 10000, "gate3", 5),
    (6, "5-6-yangben.md", 10000, "gate2", "vol5_bank_sample.txt"),
    (7, "5-7-yujian.md", 10000, "gate3", 7),
]

NUM = re.compile(r"\d[\d,]*(?:\.\d+)?(?=\s*(?:亿|万|％|%|个百分点))")
YEAR = re.compile(r"(?<![\d.])(?:19|20)\d{2}(?![\d.])")
ANCHOR = re.compile(r"P\d{6}")


def run(cmd):
    p = subprocess.run([PY] + cmd, capture_output=True, text=True,
                       encoding="utf-8", errors="replace", cwd=WORK,
                       creationflags=0x08000000)
    return p.returncode, (p.stdout or "") + (p.stderr or "")


def main():
    only = {int(a) for a in sys.argv[1:]} if len(sys.argv) > 1 else None
    rows, total, fails = [], 0, 0
    for num, fname, target, kind, arg in CHAPTERS:
        if only and num not in only:
            continue
        md = VOL5 + "\\" + fname
        try:
            text = open(md, encoding="utf-8").read()
        except OSError:
            rows.append((fname, "缺文件", "-", "-", "-", "-"))
            fails += 1
            continue
        rc1, out1 = run(["m2_gate.py", md, "--target", str(target)])
        m = re.search(r"body_cjk[=:\s]+(\d+)", out1)
        cjk = int(m.group(1)) if m else -1
        word_ok = "PASS" in out1 and rc1 == 0
        if kind == "gate3":
            rc2, out2 = run(["m2_gate3_vol5.py", md, str(arg)])
            ref_ok = "-> PASS" in out2
            unref = []
        else:
            rc2, out2 = run(["m2_gate2.py", md, "m2\\" + arg])
            ref_ok = "-> PASS" in out2
            # UNREF 补查: 带数字句(非own_calc)须含 P6位锚
            body = text.split("## 一、", 1)[1].rsplit("---", 1)[0] \
                if "## 一、" in text else ""
            unref = [s.strip()[:60] for s in re.split(r"[。；\n]", body)
                     if s.strip() and "own_calc" not in s
                     and (NUM.search(s) or YEAR.search(s))
                     and not ANCHOR.search(s)]
        # 判断卷结构门
        n_evi = len(re.findall(r"证据强度[：:]", text))
        n_ach = len(re.findall(r"反证检验[：:]", text))
        struct_ok = n_evi >= 8 and n_ach >= 4
        ok = word_ok and ref_ok and not unref and struct_ok
        if not ok:
            fails += 1
        total += max(cjk, 0)
        note = []
        if not word_ok:
            lines1 = [l for l in out1.splitlines() if l.strip()]
            note.append("字数门:" + lines1[-1][:60] if lines1 else "字数门:无输出")
        if not ref_ok:
            bad2 = [l.strip()[:60] for l in out2.splitlines()
                    if l.strip().startswith(("MISS", "UNREF", "NO_CHAPTER",
                                             "BAD", "⛔"))]
            note.append("引用门:" + "; ".join(bad2[:3]) if bad2 else "引用门FAIL")
        if unref:
            note.append(f"UNREF×{len(unref)}: " + unref[0])
        if not struct_ok:
            note.append(f"结构门:证据强度{n_evi}/8 反证检验{n_ach}/4")
        rows.append((fname, str(cjk),
                     "✓" if word_ok else "✗", "✓" if ref_ok else "✗",
                     f"{n_evi}/{n_ach}", "; ".join(note) if note else "PASS"))
    print(f"{'文件':<22}{'CJK':>7}  字数  引用  强度/反证  备注")
    for r in rows:
        print(f"{r[0]:<22}{r[1]:>7}  {r[2]}    {r[3]}    {r[4]:<9}  {r[5]}")
    print(f"\n全卷正文 CJK 合计 = {total} (框架 60,000)")
    print("SWEEP " + ("PASS 全绿" if fails == 0 else f"FAIL ×{fails}"))
    sys.exit(1 if fails else 0)


if __name__ == "__main__":
    main()
