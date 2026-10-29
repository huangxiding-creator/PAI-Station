# -*- coding: utf-8 -*-
"""livefire_epc.py — 实弹: EPC-OVERSEAS 战役 kws 搜一轮 → 前 20 本相关书
简介 md + 目录框架 md → E:/AI-Station/ammo_pool/EPC-OVERSEAS/staging/dangdang/

v3: 全 kws 扫描 (不提前断); 家族键=书名核心前12字 (出版社噪声剔出键);
家族内副本排序 = 评论降序 → pid 长度升序 (自营主品 pid 短);
收录判据: 简介 或 目录 至少其一; 已收录核心题名不重复收 (跨家族去重);
副本薄页 (集市页无描述blob) 如实跳过记账。m 页标记变体 (内容/作者) 已由
复刻件别名层归一 → 简介覆盖率最大化。
"""
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
from dangdang_api import DangdangClient  # noqa: E402

OUT = Path("E:/AI-Station/ammo_pool/EPC-OVERSEAS/staging/dangdang")
SUMMARY = Path(__file__).resolve().parents[1] / "captures" / "livefire_epc_summary.json"
NEED = 20

# 战役 kws 优先轴 (前=最相关)
KWS = ["国际工程EPC", "FIDIC合同", "海外EPC", "国际工程索赔", "海外工程风险",
       "电力出海", "海外电力投资", "一带一路工程", "EPC", "FIDIC"]


def core(title: str) -> str:
    s = re.sub(r"^(\u6b63\u7248\u4e66\u7c4d|\u6b63\u7248\u4e66|\u6b63\u7248|\u5168\u65b0|\u65b0\u4e66|2023\u65b0)\s*[:\uff1a]?\s*", "", title.strip())
    s = re.sub(r"^[\u201c\u201d\"'\u300a\u3010\[]+", "", s)
    s = re.sub(r"[^\w\u4e00-\u9fffA-Za-z0-9]", "", s)
    return s[:12]


def main() -> int:
    OUT.mkdir(parents=True, exist_ok=True)
    c = DangdangClient()
    fams: dict[str, dict] = {}               # core → {"kw","copies":[...]}
    for kw in KWS:
        items = c.search(kw)
        for it in items[:15]:
            k = core(it["title"])
            f = fams.setdefault(k, {"kw": kw, "copies": []})
            if any(x["pid"] == it["pid"] for x in f["copies"]):
                continue
            f["copies"].append(it)
            if kw != f["kw"] and KWS.index(kw) < KWS.index(f["kw"]):
                f["kw"] = kw                  # 保留最优先轴的词
        print(f"[livefire] '{kw}' → 家族 {len(fams)}", flush=True)

    ranked = sorted(fams.items(),
                    key=lambda kv: (KWS.index(kv[1]["kw"]),
                                    -max(x["comments"] for x in kv[1]["copies"])))
    results, thin, got_cores = [], [], set()
    for k, f in ranked:
        if len(results) >= NEED:
            break
        if k in got_cores:
            continue
        copies = sorted(f["copies"], key=lambda x: (-x["comments"], len(x["pid"])))
        got = None
        for rec in copies[:4]:                # 每家族最多试 4 份副本
            try:
                d = c.detail(rec["pid"])
            except Exception as e:
                thin.append({"pid": rec["pid"], "title": rec["title"], "why": str(e)[:100]})
                continue
            has_intro = bool(d["content_intro"] or d["sections"].get("编辑推荐")
                             or d["sections"].get("推荐语"))
            has_toc = not d["toc_missing"]
            if has_intro or has_toc:
                if got is None or (has_intro and not got[2]):
                    got = (rec, d, has_intro, has_toc)
                if got[2] and got[3]:
                    break                     # 双全即收, 省请求
        if not got:
            thin.append({"pid": copies[0]["pid"], "title": copies[0]["title"],
                         "why": "全家族副本缺简介+目录 (集市页无描述blob)"})
            continue
        rec, d, has_intro, has_toc = got
        got_cores.add(k)
        head = (f"# {d['title']}\n\n"
                f"> 来源: 当当网图书情报 (复刻件 dangdang_api, 纯HTTP)\n"
                f"> URL: {d['url']}\n> ISBN: {d['isbn'] or ''}\n"
                f"> 作者: {d['parms'].get('作者', rec['author_line'])}\n"
                f"> 出版社: {d['publisher'] or ''}\n> 出版时间: {d['pubdate'] or ''}\n"
                f"> 页数: {d['pages'] or ''} / 开本: {d['format'] or ''}\n"
                f"> 现价: ¥{rec['price'] or ''} (评论 {rec['comments']})\n"
                f"> 检索词: {f['kw']}\n> 采集: {time.strftime('%F %T')}\n\n")
        if has_intro:
            parts = []
            if d["content_intro"]:
                parts.append(("内容简介", d["content_intro"]))
            if d["author_intro"]:
                parts.append(("作者简介", d["author_intro"]))
            for alt in ("编辑推荐", "推荐语"):
                if not parts and d["sections"].get(alt):
                    parts.append((alt, d["sections"][alt]))
            body = "\n\n".join(f"## {t}\n\n{v}" for t, v in parts)
            (OUT / f"dd_{d['pid']}_intro.md").write_text(head + body + "\n", encoding="utf-8")
        if has_toc:
            (OUT / f"dd_{d['pid']}_toc.md").write_text(
                head + "## 目录框架\n\n```\n" + d["toc"] + "\n```\n", encoding="utf-8")
        results.append({"pid": d["pid"], "title": d["title"][:44], "kw": f["kw"],
                        "comments": rec["comments"], "intro": has_intro, "toc": has_toc,
                        "toc_lines": len(d["toc_lines"])})
        print(f"[livefire] {len(results):02d} {'V' if has_intro else '-'}{'V' if has_toc else '-'} "
              f"{d['title'][:32]} (目录{len(d['toc_lines'])}行)", flush=True)

    summary = {
        "ts": time.strftime("%F %T"), "campaign": "EPC-OVERSEAS", "need": NEED,
        "books": len(results),
        "intro_files": sum(1 for r in results if r["intro"]),
        "toc_files": sum(1 for r in results if r["toc"]),
        "toc_missing_books": [r["title"] for r in results if not r["toc"]],
        "skipped_thin": thin, "kws": KWS, "results": results, "out_dir": str(OUT),
    }
    SUMMARY.write_text(json.dumps(summary, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"[livefire] 收官: {len(results)} 本 | 简介md {summary['intro_files']} | 目录md {summary['toc_files']}"
          f" | 目录缺失 {len(summary['toc_missing_books'])} 本 | 跳过薄页 {len(thin)} → {OUT}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
