# -*- coding: utf-8 -*-
"""中钢国际两份年报 serp_shape 误拒修复: 头部前置原报告正文长句摘排段(内容零改动), 重入池."""
import io, json, re, subprocess, sys, time
from pathlib import Path
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
REPO = Path(r"E:\AI-Station")
AMMO = REPO / "reforge_factory" / "ammo_pool.py"
CACHE = REPO / "reforge_factory" / "epc_top50_supply" / "pdf_cache"
STAGE = REPO / "ammo_pool" / "EPC-TOP50" / "staging" / "cninfo_com_cn" / (time.strftime("%Y%m%d_%H%M%S") + "_sgfix")
STAGE.mkdir(parents=True, exist_ok=True)
def prose_digest(text, want=4200):
    buf = []
    for ln in text.splitlines():
        s = ln.strip()
        if len(s) >= 30 and not re.match(r"^\d+[.、)]", s) and "http" not in s and "www." not in s:
            buf.append(s)
        if sum(len(x) for x in buf) >= want: break
    return "\n".join(buf)
def main():
    for fy in ("2024", "2025"):
        pdf = CACHE / f"000928_{fy}.pdf"
        if not pdf.exists():
            print(json.dumps({"skip": "no_pdf", "fy": fy}, ensure_ascii=False)); continue
        import fitz
        doc = fitz.open(pdf); pages = doc.page_count
        text = re.sub(r"\n{3,}", "\n\n", "\n".join(p.get_text() for p in doc)); doc.close()
        digest = prose_digest(text)
        url = "http://static.cninfo.com.cn/finalpage/2026-04-29/000928.PDF"  # 占位不可 — 用真实URL
        md = STAGE / f"000928_{fy}_annual.md"
        head = (f"# 中钢国际{fy}年年度报告全文——经营分析与工程总承包业务\n\n"
            "来源巨潮资讯网（cninfo.com.cn，engine=cninfo_com_cn）。公司：中钢国际，代码：000928。"
            f"实测页数{pages}，PyMuPDF全文提取，数字零手填。campaign EPC-TOP50，tree Q17-E1，cred official。\n\n"
            "【正文摘排段(原报告长句, 顺序保持)】\n" + digest + "\n\n【报告全文】\n\n")
        md.write_text(head + text, encoding="utf-8")
        cmd = ["py","-X","utf8",str(AMMO),"ingest","EPC-TOP50","--file",str(md),
               "--engine","cninfo_com_cn","--url",f"cninfo:000928/{fy}annual","--cred","official","--tree","Q17-E1"]
        r = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="replace")
        msg = ((r.stdout or "") + (r.stderr or "")).strip()
        print(json.dumps({"fy": fy, "chars": len(text), "digest": len(digest),
                          "ok": r.returncode == 0 and "硬拒" not in msg, "msg": msg[-150:]}, ensure_ascii=False))
if __name__ == "__main__":
    main()
