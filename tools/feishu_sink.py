# -*- coding: utf-8 -*-
"""feishu_sink.py — 调研成品沉淀管线 (1004用户三连令: 调研收集↔飞书知识库联动).

调研过程中发现的高质量稀缺成品 (论文/机构研报/著作/电子书/年报/法规)
边发现边上传到总包智库飞书知识库专用节点, 与本地弹药池并行沉淀.

结构: 总包智库(space 7689289338592431383)
  └─ EPC调研沉淀（研报战役精选成果）  MlqHw7GDsioDCdk9bGJc2JJ0nSG
      └─ 按来源分类子节点 (自动建: 电子书与报告/学术论文/券商研报/公司公告/政策法规)

精选规则 (绝不凑数令同款精神 — 只沉淀真成品, 不沉淀碎片):
  形态: .pdf/.docx/.epub (成品文档; .md/.html 网页碎片不传)
  体积: >=500KB (真品有肉; 小于的多为单页纸)
  快消品过滤 (仅券商研报类): 标题含 周报|日报|晨会|纪要|快评|周观点 跳过

幂等: ledger jsonl 记已传路径; 断点续传; 2-4s 礼貌间隔.
"""
import json
import re
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

LARK = (r"C:\Users\91216\AppData\Roaming\npm\node_modules"
        r"\@larksuite\cli\bin\lark-cli.exe")
SPACE = "7689289338592431383"                 # 总包智库
PARENT = "MlqHw7GDsioDCdk9bGJc2JJ0nSG"        # EPC调研沉淀 父节点
LEDGER = Path(r"E:\AI-Station\tools\feishu_sink_ledger.jsonl")
MIN_BYTES = 500_000
FAST_FOOD = re.compile(r"周报|日报|晨会|纪要|快评|周观点|月报")

# 扫描根: 战役 02 目录 (来源目录名 → 飞书子节点标题)
SINKS = {
    "52_ima公开库": "电子书与研究报告（ima库）",
    "_channel_wenchuanyun": "学术论文（知网镜像）",
    "40_洞见研报": "券商研报精选",
    "_registry_cninfo": "公司公告与年报",
    "61_政策法规": "政策法规文件",
}
ROOTS = [Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics")
         / "《四川电力设计咨询有限责任公司怎么干EPC总承包？》"
         / "02 初次网络调研"]
EXTS = {".pdf", ".docx", ".epub"}


def lark(*args: str, timeout: int = 300, cwd: str | None = None) -> dict:
    cp = subprocess.run(
        [LARK, *args, "--as", "user", "--json"],
        capture_output=True, text=True, encoding="utf-8", timeout=timeout,
        cwd=cwd)
    return json.loads(cp.stdout or "{}")


def load_ledger() -> set:
    """已成功沉淀的路径集 (失败件不进 done, 下轮重试)."""
    if not LEDGER.exists():
        return set()
    return {json.loads(x).get("path")
            for x in LEDGER.read_text(encoding="utf-8").splitlines()
            if x.strip() and json.loads(x).get("ok")}


def sub_node(title: str, cache: dict) -> str:
    """分类子节点 token (无则建, 缓存避免重复查)."""
    if title in cache:
        return cache[title]
    d = lark("wiki", "+node-list", "--space-id", SPACE,
             "--parent-node-token", PARENT, "--page-size", "50")
    data = d.get("data", {})
    for n in (data.get("items") or data.get("nodes") or []):
        cache[n.get("title") or ""] = n.get("node_token")
    if title in cache:
        return cache[title]
    d = lark("wiki", "+node-create", "--space-id", SPACE,
             "--parent-node-token", PARENT, "--title", title)
    tok = (((d.get("data") or {}).get("node")) or {}).get("node_token") \
        or (d.get("data") or {}).get("node_token", "")
    time.sleep(1.5)
    cache[title] = tok
    print(f"[节点] 建 {title} → {tok[:12]}…", flush=True)
    return tok


def upload(fp: Path, node_tok: str, cat: str) -> bool:
    # 坑: lark-cli 文件路径白名单只认 cwd/临时/家目录 — 须 cwd=文件目录+相对名
    d = lark("drive", "+upload", "--file", fp.name,
             "--wiki-token", node_tok, timeout=600, cwd=str(fp.parent))
    ok = bool(d.get("ok"))
    if not ok:  # 报错留痕 (ledger 记因, 不吞错)
        err = ((d.get("error") or {}).get("message") or "")[:120]
        print(f"      ↳ {err}", flush=True)
    rec = {"ts": time.strftime("%F %T"), "path": str(fp), "cat": cat,
           "ok": ok, "file_token": (d.get("data") or {}).get("file_token", "")}
    with LEDGER.open("a", encoding="utf-8") as fh:
        fh.write(json.dumps(rec, ensure_ascii=False) + "\n")
    return ok


def main() -> int:
    done = load_ledger()
    cache: dict = {}
    n_ok = n_skip = n_fail = 0
    print(f"[sink] 启动 {time.strftime('%F %T')} | 已沉淀 {len(done)} 件",
          flush=True)
    for root in ROOTS:
        for sub_name, cat in SINKS.items():
            d = root / sub_name
            if not d.is_dir():
                continue
            files = [f for f in sorted(d.rglob("*"))
                     if f.is_file() and f.suffix.lower() in EXTS
                     and f.stat().st_size >= MIN_BYTES]
            if cat == "券商研报精选":  # 快消品过滤 (仅研报类)
                files = [f for f in files
                         if not FAST_FOOD.search(f.stem)]
            todo = [f for f in files if str(f) not in done]
            print(f"[{cat}] {d.name}: 成品 {len(files)} 件 | 待传 "
                  f"{len(todo)}", flush=True)
            if not todo:
                continue
            node_tok = sub_node(cat, cache)
            if not node_tok:
                print(f"[fail] 子节点获取失败: {cat}", flush=True)
                n_fail += len(todo)
                continue
            for f in todo:
                try:
                    ok = upload(f, node_tok, cat)
                except Exception as e:                    # noqa: BLE001
                    ok = False
                    print(f"  [err] {f.name[:40]}: {type(e).__name__}",
                          flush=True)
                n_ok, n_fail = (n_ok + 1, n_fail) if ok else (n_ok, n_fail + 1)
                print(f"  {'✓' if ok else '✗'} {f.name[:52]}", flush=True)
                time.sleep(2.5)
    print(f"[sink] 完: 新沉淀 {n_ok} | 失败 {n_fail} | 账本 "
          f"{len(load_ledger())} 件", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
