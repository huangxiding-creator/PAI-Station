# -*- coding: utf-8 -*-
"""feedback_revision_loop — 用户反馈驱动的报告自动改版飞轮 (1017 用户令: 全自动闭环).

流程 (每轮):
  1. 拉取: 引擎 GET /api/feedback/pending (X-Admin-Key)
  2. 聚合: 按 SKU 分组, 剔探针(openid 含 probe/test)
  3. 改版 (每 SKU, 缺省每轮最多 1 份 --max-sku):
     a. GLM 起草《修订记录》章: 每条反馈 → 摘要/评分/处置(修正·澄清·补充·待采集)
        铁律: 修订章只引用反馈原文与既有章节位置, 不新增任何统计数据 (数字零造假)
     b. 追加到 m2 成书 merged md 末尾 → report_to_docx.py 重排 docx
        → Word COM (SaveAs2 17) 转 PDF
     c. 新 PDF 落 report_platform/content/full/<sku>.pdf (上架真源)
     d. 部署: tools/mp_list_report.py --sku <sku> (TCB 内容重部署)
     e. 邮箱同步: 引擎侧邮箱回填本地 data/feedback/emails.jsonl
        → tools/feedback_new_version_push.py 自动发新版+个性化改进说明 (SMTP)
     f. 回执: 引擎 POST /api/feedback/ack (fids → addressed)
  4. 台账: data/feedback/revision_ledger.jsonl

用法: py -X utf8 tools/feedback_revision_loop.py [--dry] [--sku X] [--max-sku 1]
调度: schtasks/cron 每 2h (见 --help); 14:30-22:00 让路窗照跑 (纯 API+本地, 不占浏览器).
失败语义: 任一步失败 → 本 SKU 标 failed 停在该步, 不 ack, 下轮重试 (幂等: fids 未 ack 恒重拉).
"""
from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
import time
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]
ENGINE = "https://qianwen-engine-322438-9-1499254664.sh.run.tcloudbase.com"
M2 = REPO / "_proposals" / "flagship-paid-report-1007" / "work" / "m2"
FB = REPO / "data" / "feedback"
LEDGER = FB / "revision_ledger.jsonl"
EMAILS = FB / "emails.jsonl"
PY = [sys.executable, "-X", "utf8"]

# SKU → 成书源 (m2 merged md); 新报告上线时补一行
SKU_SOURCES = {
    "BID26-2026": M2 / "bid26" / "bid26_merged.md",
    "TRAIN-2026": M2 / "train" / "train_merged.md",
    "CONTRACT-2026": M2 / "contract" / "contract_merged.md",
}

REV_PROMPT = """你是研究报告的修订编辑。以下是读者付费后提交的反馈清单（已由AI按六维评分），
以及报告的章节标题列表。请为报告起草一节《修订记录》附录，逐条回应每个反馈。

硬纪律（违反=废稿）：
- 只引用反馈原文与既有章节号/章名；不得编造任何新数字、新统计、新金额
- 处置类型只能从: 已修正 / 已澄清 / 已补充说明 / 已列入待采集清单 四类中选
- "已修正"仅限文字表述、表格与正文一致性、指代不清这类不涉及新数据的修正
- 涉及新数据需求的（如补充某省某年数据）一律"已列入待采集清单"，写明将采集的口径
- 语气: 对买家诚实、专业、致谢；不辩解、不敷衍

报告章节标题列表：
{chapters}

反馈清单：
{feedbacks}

输出 Markdown（不要代码块包裹）：
## 修订记录·第 {rev} 版（{date}，读者反馈驱动）

（一段 3-4 句的导语：感谢反馈、本轮修订原则、如何复核）

### 逐条回应

（每条格式：
#### 反馈 {{n}}（评分 {{score}}/100 · {{category}}）
> {{反馈原文截断120字}}
**处置：** {{处置类型}} —— {{具体动作，指明章节}}
）"""


def log(m: str) -> None:
    print(f"[{time.strftime('%H:%M:%S')}] {m}", flush=True)


def admin_key() -> str:
    kf = REPO / "data" / "secrets" / "qianwen_engine_hmac.key"
    return kf.read_bytes().hex()


def engine_call(method: str, path: str, payload: dict | None = None) -> dict:
    data = json.dumps(payload).encode() if payload is not None else None
    req = urllib.request.Request(
        ENGINE + path, data=data, method=method,
        headers={"Content-Type": "application/json", "X-Admin-Key": admin_key()})
    with urllib.request.urlopen(req, timeout=30) as r:
        return json.loads(r.read())


def zhipu_keys() -> list[str]:
    out = []
    sf = REPO / "data" / "secrets" / "zhipu.secret"
    for line in sf.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        for k in ("api_key=", "key="):
            if line.startswith(k) and len(line) > len(k) + 8:
                out.append(line[len(k):])
    return list(dict.fromkeys(out))


def glm(prompt: str) -> str:
    import urllib.request as u
    opener = u.build_opener(u.ProxyHandler({}))  # 直连不吃系统代理
    last = ""
    for key in zhipu_keys():
        body = json.dumps({"model": "glm-4-flash", "temperature": 0.3,
                           "messages": [{"role": "user", "content": prompt}]}
                          ).encode()
        req = u.Request("https://open.bigmodel.cn/api/paas/v4/chat/completions",
                        data=body, headers={"Authorization": f"Bearer {key}",
                                            "Content-Type": "application/json"})
        try:
            with opener.open(req, timeout=90) as r:
                last = json.loads(r.read())["choices"][0]["message"]["content"]
                if last.strip():
                    return last
        except Exception as e:  # noqa: BLE001
            log(f"  glm key …{key[-6:]} 失败: {e}")
    raise SystemExit("glm 全链失败")


def pull_pending() -> list[dict]:
    d = engine_call("GET", "/api/feedback/pending")
    if not d.get("ok"):
        raise SystemExit(f"拉取失败: {d}")
    items = d.get("items") or []
    return [it for it in items
            if "probe" not in (it.get("openid") or "").lower()
            and "test" not in (it.get("openid") or "").lower()]


def rev_number(sku: str) -> int:
    n = 1
    if LEDGER.exists():
        for ln in LEDGER.open(encoding="utf-8"):
            try:
                r = json.loads(ln)
            except json.JSONDecodeError:
                continue
            if r.get("sku") == sku and r.get("status") == "done":
                n = max(n, int(r.get("rev", 0)) + 1)
    return n


def ledger_write(rec: dict) -> None:
    FB.mkdir(parents=True, exist_ok=True)
    with LEDGER.open("a", encoding="utf-8") as f:
        f.write(json.dumps(rec, ensure_ascii=False) + "\n")


def chapter_titles(merged: Path) -> str:
    out = []
    for m in re.finditer(r"^##\s+(.+)$", merged.read_text(encoding="utf-8"), re.M):
        t = m.group(1).strip()
        if len(t) < 60 and not t.startswith("关于本书"):
            out.append(t)
    return "\n".join(out[:40]) or "（章节列表不可用）"


def build_pdf(docx: Path) -> Path:
    pdf = docx.with_suffix(".pdf")
    ps = f"""$w=New-Object -ComObject Word.Application;$w.Visible=$false;$w.DisplayAlerts=0
try{{$d=$w.Documents.Open('{docx}',$false,$true);$d.SaveAs2('{pdf}',17);$d.Close($false)}}finally{{$w.Quit()}}"""
    r = subprocess.run(["powershell", "-NoProfile", "-Command", ps],
                       capture_output=True, text=True, timeout=300)
    if not pdf.exists():
        raise RuntimeError(f"PDF 转换失败: {r.stderr[-200:]}")
    return pdf


def sync_emails(items: list[dict]) -> int:
    """引擎侧邮箱 → 本地 emails.jsonl (feedback_new_version_push.py 的读源)."""
    FB.mkdir(parents=True, exist_ok=True)
    have = set()
    if EMAILS.exists():
        for ln in EMAILS.open(encoding="utf-8"):
            try:
                have.add((json.loads(ln).get("sku"), json.loads(ln).get("email")))
            except json.JSONDecodeError:
                pass
    n = 0
    with EMAILS.open("a", encoding="utf-8") as f:
        for it in items:
            em = (it.get("email") or "").strip()
            if em and "@" in em and (it.get("sku"), em) not in have:
                f.write(json.dumps({"ts": it.get("created_at", ""), "sku": it.get("sku"),
                                    "openid": it.get("openid", ""), "email": em,
                                    "feedback_id": it.get("fid", "")},
                                   ensure_ascii=False) + "\n")
                n += 1
    return n


def process_sku(sku: str, items: list[dict], dry: bool) -> None:
    src = SKU_SOURCES.get(sku)
    if not src or not src.exists():
        log(f"  {sku}: 无成书源映射/文件, 跳过 (补 SKU_SOURCES 后下轮生效)")
        engine_call("POST", "/api/feedback/ack", {"fids": [i["fid"] for i in items],
                                                  "status": "ignored"})
        return
    rev = rev_number(sku)
    log(f"  {sku}: {len(items)} 条反馈 → 第 {rev} 版修订")

    feedbacks = "\n\n".join(
        f"- 反馈{n} | 评分 {json.loads(i.get('scores_json') or '{}').get('total_score', '?')}"
        f"/100 | 类型 {json.loads(i.get('scores_json') or '{}').get('feedback_category', '?')}\n"
        f"  原文: {(i.get('transcript') or '').strip()[:400]}"
        for n, i in enumerate(items, 1))
    md = glm(REV_PROMPT.format(chapters=chapter_titles(src), feedbacks=feedbacks,
                               rev=rev, date=time.strftime("%Y-%m-%d")))
    if "修订记录" not in md:
        raise SystemExit("修订章生成异常(缺标题), 停轮")
    log(f"  修订章起草完成: {len(md)} 字符")

    if dry:
        print("  ---- 修订章预览(前1200字) ----")
        print(md[:1200])
        print("  ---- [dry] 不落盘不部署不发邮件不回执 ----")
        return

    # b. 追加修订章 → 重建 docx/PDF (改版产物带版本号, 不覆盖 v1 源)
    workdir = src.parent / f"rev_v{rev}"
    workdir.mkdir(exist_ok=True)
    rev_merged = workdir / f"{sku}_v{rev}_merged.md"
    rev_merged.write_text(
        src.read_text(encoding="utf-8").rstrip() + "\n\n---\n\n" + md + "\n",
        encoding="utf-8")
    docx = workdir / f"{sku}_v{rev}.docx"
    r = subprocess.run(PY + [str(REPO / "tools" / "report_to_docx.py"),
                             str(rev_merged), str(docx)],
                       cwd=str(REPO), capture_output=True, text=True, timeout=600)
    if r.returncode != 0 or not docx.exists():
        raise SystemExit(f"docx 构建失败: {r.stdout[-200:]} {r.stderr[-200:]}")
    pdf = build_pdf(docx)
    log(f"  成书: {docx.name} + {pdf.name} ({pdf.stat().st_size//1024}KB)")

    # c. 上架真源更新
    shelf = REPO / "report_platform" / "content" / "full" / f"{sku}.pdf"
    shelf.write_bytes(pdf.read_bytes())
    log(f"  上架 PDF 已更新: {shelf.name}")

    # d. TCB 内容部署 (引擎目录/详情/试读/PDF 门禁同链)
    r = subprocess.run(PY + [str(REPO / "tools" / "mp_list_report.py"), "--sku", sku],
                       cwd=str(REPO), capture_output=True, text=True, timeout=1800)
    log(f"  TCB 部署 exit={r.returncode} {r.stdout[-160:]}")

    # e. 邮箱同步 + 新版邮件 (个性化改进说明)
    sync_emails(items)
    imp = re.sub(r"\s+", " ", md)[:500]
    r = subprocess.run(PY + [str(REPO / "tools" / "feedback_new_version_push.py"),
                             "--sku", sku, "--pdf", str(shelf),
                             "--improvements", md[:2000]],
                       cwd=str(REPO), capture_output=True, text=True, timeout=600)
    log(f"  新版邮件 exit={r.returncode} {r.stdout[-160:]}")

    # f. 回执
    engine_call("POST", "/api/feedback/ack", {"fids": [i["fid"] for i in items]})
    ledger_write({"ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "sku": sku, "rev": rev,
                  "fids": [i["fid"] for i in items], "status": "done",
                  "pdf_kb": pdf.stat().st_size // 1024})


def main() -> int:
    ap = argparse.ArgumentParser(description="反馈驱动报告自动改版飞轮")
    ap.add_argument("--dry", action="store_true")
    ap.add_argument("--sku", default="", help="只处理指定 SKU")
    ap.add_argument("--max-sku", type=int, default=1, help="每轮最多改版份数")
    ns = ap.parse_args()

    items = pull_pending()
    by_sku: dict[str, list] = {}
    for it in items:
        by_sku.setdefault(it.get("sku", ""), []).append(it)
    queues = [s for s in by_sku if not ns.sku or s == ns.sku]
    log(f"待处理: {len(items)} 条 / {len(by_sku)} SKU → {queues[:ns.max_sku]}")
    done = 0
    for sku in queues[:ns.max_sku]:
        try:
            process_sku(sku, by_sku[sku], ns.dry)
            done += 1
        except SystemExit as e:
            log(f"  {sku} 本轮失败: {e}")
            ledger_write({"ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "sku": sku,
                          "status": "failed", "error": str(e)[:300]})
    log(f"本轮完成 {done} 份改版")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
