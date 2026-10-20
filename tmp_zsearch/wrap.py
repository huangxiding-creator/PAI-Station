# -*- coding: utf-8 -*-
import sys, io, runpy
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
queries = open(r'E:\AI-Station\tmp_zsearch\queries.txt', encoding='utf-8').read().splitlines()
q = queries[int(sys.argv[1])].strip()
extra = sys.argv[2:]
sys.argv = ['search.py', q] + extra
runpy.run_path(r'E:\AI-Station\.claude\skills\zh-search-pro\scripts\search.py', run_name='__main__')
