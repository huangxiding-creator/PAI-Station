# -*- coding: utf-8 -*-
"""P6b: MAIGOO/CNPP 表格结构解析"""
import sys, io, re, json
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')

def cells(row):
    return [re.sub(r"<[^>]+>|&nbsp;|\s+", "", c).strip() for c in re.findall(r"<t[dh][^>]*>(.*?)</t[dh]>", row, re.S)]

for name in ["maigoo", "cnpp"]:
    body = open(f"E:/AI-Station/逆向工程/enr-reverse/captures/p6_{name}.html", encoding="utf-8").read()
    print(f"\n########## {name} ##########")
    tables = re.findall(r"<table[^>]*>(.*?)</table>", body, re.S | re.I)
    print("tables:", len(tables))
    for ti, tb in enumerate(tables):
        rows = re.findall(r"<tr[^>]*>(.*?)</tr>", tb, re.S | re.I)
        if not rows: continue
        print(f"-- table{ti}: {len(rows)} rows")
        for r in rows[:4]:
            print("   ", cells(r)[:6])
        if len(rows) > 4:
            print("   ...tail:", cells(rows[-1])[:6])
    # 分页线索
    for m in re.finditer(r'href="([^"]*)"[^>]*>(下页|下一页|第\s*\d+\s*页|\d+/\d+)', body):
        print("  pager:", m.group(1)[:80], "|", m.group(2))
