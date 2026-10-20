# -*- coding: utf-8 -*-
"""同进程检索驱动v3: 多引擎轮询+重试, 抓到为止"""
import sys, io, time

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
sys.path.insert(0, r"E:\AI-Station\.claude\skills\zh-search-pro\scripts")
from search import search_engine, _load_blocklist

QUERIES = {
    "c1": "中国电建 抽水蓄能 占",
    "c2": "中国安能 抽水蓄能 项目",
    "c3": "中国能建 抽水蓄能 中标",
    "c4": "抽水蓄能 EPC 总承包 中标",
    "c5": "抽水蓄能 在建 2亿千瓦",
    "c6": "华东院 抽水蓄能 设计 市场",
    "c7": "抽水蓄能 分会 2024 报告",
    "c8": "水电四局 灵寿 抽水蓄能 中标",
}

def main():
    keys = sys.argv[1:] or list(QUERIES.keys())
    bl = _load_blocklist()
    for k in keys:
        q = QUERIES[k]
        print(f"\n===== {k}: {q} =====")
        for attempt in range(2):
            for eng in ["so360", "baidu"]:
                try:
                    hits = search_engine(eng, q, 8, blocklist=bl)
                    if hits:
                        for h in hits:
                            print(f"  [{eng}] {h['title'][:85]}")
                            print(f"      {h['url'][:170]}")
                        break
                except Exception as e:
                    print(f"  [{eng}] ERR: {str(e)[:60]}")
                time.sleep(1.5)
            else:
                continue
            break

if __name__ == "__main__":
    main()
