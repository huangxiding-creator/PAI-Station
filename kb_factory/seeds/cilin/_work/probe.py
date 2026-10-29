# -*- coding: utf-8 -*-
"""探测两版词林文件的词数/编码数（选源对账用，零造假实测）"""
from pathlib import Path

RAW = Path(__file__).resolve().parent.parent / "_raw"

for name in ["cilin_V1.txt", "new_cilin_V3.txt"]:
    p = RAW / name
    n_lines = n_words = n_groups = 0
    vocab = set()
    word_code = {}
    bad_lines = 0
    for line in p.read_text(encoding="gbk").splitlines():
        parts = line.split()
        if not parts:
            continue
        n_lines += 1
        code, words = parts[0], parts[1:]
        if len(code) == 8 and (code[7] in "=#@") and code[:7].isalnum():
            n_groups += 1
            n_words += len(words)
            vocab.update(words)
            for w in words:
                word_code.setdefault(w, []).append(code)
        else:
            bad_lines += 1
    print(f"{name}: lines={n_lines} 8码组={n_groups} 词条总次={n_words} 去重词={len(vocab)} 词→码映射={len(word_code)} 非8码行={bad_lines}")
