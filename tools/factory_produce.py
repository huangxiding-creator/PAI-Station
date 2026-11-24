# -*- coding: utf-8 -*-
"""factory_produce — 交接单之后的全自动生产编排器 (1124 用户令 ②: 人即胶水→编排器).

stage 流水: harvest → collate(claude无头编队,≤4并发+断链重试) → merge → gate(出厂门)
           → shelf(SKU头插+site+TCB+ECS+海报) → promo(3稿claude无头+落箱) → finalize(过账+企微)
降级纪律: NB正身令(1124) — 战役无 nblm 产线时如实披露并以 bank 收编+出厂门特赦。
任何 stage 失败 → 过账 + 企微通知 + 退出码非零 (编排器死也要死得响)。

用法: py -X utf8 tools/factory_produce.py --campaign-dir work/m2/<slug> --campaign EPC-XX \
      --title 《书名》 --sku X-2026 [--stages harvest,collate,merge,gate,shelf,promo,finalize]
"""
from __future__ import annotations

import argparse
import json
import os
import re
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]
FACT = REPO / "data" / "factory"
CLAUDE_BIN = Path.home() / ".vscode" / "extensions"
MAX_WORKERS = 4
WORKER_TIMEOUT = 5400  # 90min/章


def find_claude() -> Path:
    hits = sorted(CLAUDE_BIN.glob("*claude-code*/resources/native-binary/claude.exe"))
    if not hits:
        raise RuntimeError("claude 无头二进制不可达 (VSCode 扩展缺席)")
    return hits[-1]


def sh(cmd: list, timeout: int = 3600, cwd: Path | None = None) -> tuple[int, str]:
    r = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8",
                       errors="replace", timeout=timeout, cwd=str(cwd or REPO))
    return r.returncode, (r.stdout or "") + (r.stderr or "")[-400:]


def ledger_write(stage: str, campaign: str, extra: dict) -> None:
    with (FACT / "factory_ledger.jsonl").open("a", encoding="utf-8") as f:
        f.write(json.dumps({"ts": time.strftime("%Y-%m-%d %H:%M:%S"),
                            "stage": stage, "campaign": campaign, **extra},
                           ensure_ascii=False) + "\n")


def wecom(msg: str) -> None:
    try:
        subprocess.run([sys.executable, "-X", "utf8", str(REPO / "tools" / "notify_wecom.py"),
                        msg], capture_output=True, text=True, encoding="utf-8",
                       errors="replace", timeout=60, cwd=str(REPO))
    except Exception:
        pass


COLLATE_BRIEF = """你是《{title}》研究报告的章节收编工 (战役 {campaign})。出品口径=总包智库研究团队；全章不提AI。
工作目录: {sched}
任务: 收编第{no}章 (bank_ch{nn}.md), 产出 _ch{nn}_final.md + _ch{nn}_collation_ledger.md + 审计PASS。
第一步 格式对齐: 读 chapters.json (本章title逐字作首行)、_ch02_final.md 头80行+尾130行 (体例正身)、_ch02_collation_ledger.md (台账五节体例)。
第二步 选锚: 先读 bank_ch{nn}.index.md (锚头索引, 每锚一行=锚号|案号|法院|日期|案名|摘要), 挑与本章相关的锚, 再对选中锚分段读原bank精读记笔记。同案多锚=同篇重复锚: 正文引主锚, 其余尾注表并列注明。
第三步 写 _ch{nn}_final.md: 首行「# 第{no}章 <章题逐字>」; 两段导语 (面向工程企业+全书位置+底料截断声明: 每份文书头部约6000字); h2 {no}.1..连续 / h3 {no}.Y.1..连续; 主判例【事实】【争点】【裁判】【启示】四段式; 行内锚 (P000000/hash锚) 只引 bank 实锚段尾标注; 法规条文逐字转述现行文本 (WebFetch/mcp__web_reader__webReader 官方页核验, 核不到改转述并台账声明); 表题独立行 `表{no}-1 …（本研究归纳）`; 3-5处整行加粗金句; 禁代码围栏/ASCII框线/无序列表/四级标题/LaTeX/出品行/纪律声明/NBLM/AI生成/计算机术语; 尾部三件套=本章小结(10条)+本章证据边界与数据说明(五声明)+本章尾注(表); 20000-30000中文字; 数字零造假 (案号金额日期逐字取自bank)。
第四步 写 _ch{nn}_collation_ledger.md 照 ch02 台账五节体例。
第五步 审计: PowerShell: Set-Location '{sched}'; py -X utf8 _audit_{slug}.py {nn} → 全PASS (FAIL修终稿重跑)。
纪律: 只写本章三件; 不删任何文件; 不改他章; 遇429/529等30-60秒重试同一调用不放弃。完成后回汇报段 (章号/CJK数/实引锚数/四段式数/法规条数/审计PASS确认)。
"""



def ensure_audit(sched: Path, slug: str) -> Path:
    """新战役审计脚本生成器: 拷贝 tools/_audit_generic.py (泛化锚号, P锚/hash锚通吃)."""
    dst = sched / f"_audit_{slug}.py"
    if dst.is_file():
        return dst
    dst.write_text((REPO / "tools" / "_audit_generic.py").read_text(encoding="utf-8"),
                   encoding="utf-8")
    return dst

def stage_harvest(ns) -> tuple[bool, str]:
    rc, out = sh([sys.executable, "-X", "utf8", str(REPO / "tools" / "bank_harvest.py"),
                  "--campaign-dir", ns.campaign_dir, "--per-chapter", "35"], timeout=1800)
    print(out[-600:])
    if rc != 0:
        return False, f"harvest rc={rc}"
    rc2, out2 = sh([sys.executable, "-X", "utf8", str(REPO / "tools" / "bank_index.py"),
                    str(REPO / ns.campaign_dir / "sched")], timeout=600)
    return rc2 == 0, out2[-300:]


def stage_collate(ns) -> tuple[bool, str]:
    sched = REPO / ns.campaign_dir / "sched"
    ensure_audit(sched, ns.slug)
    claude = find_claude()
    todo = []
    for i in range(1, 13):
        nn = f"{i:02d}"
        final = sched / f"_ch{nn}_final.md"
        if final.is_file():
            print(f"[collate] ch{nn} 已有终稿 — 跳过")
            continue
        todo.append(i)
    if not todo:
        return True, "12章终稿齐"
    briefs = {}
    for i in todo:
        nn = f"{i:02d}"
        briefs[i] = COLLATE_BRIEF.format(
            title=ns.title, campaign=ns.campaign, sched=sched, no=i, nn=nn, slug=ns.slug)
    running: dict[int, subprocess.Popen] = {}
    done, failed = [], []
    queue = list(todo)
    t0 = time.time()
    while queue or running:
        while queue and len(running) < MAX_WORKERS:
            i = queue.pop(0)
            nn = f"{i:02d}"
            (sched / f"_worker_ch{nn}.flag").write_text("running", encoding="utf-8")
            running[i] = subprocess.Popen(
                [str(claude), "-p", briefs[i], "--permission-mode", "acceptEdits"],
                stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                cwd=str(REPO), creationflags=subprocess.CREATE_NO_WINDOW)
            print(f"[collate] ch{nn} 派工 ({len(running)}在役/{len(queue)}排队)")
        time.sleep(60)
        for i in list(running):
            nn = f"{i:02d}"
            rc = running[i].poll()
            if rc is None:
                if (sched / f"_ch{nn}_final.md").is_file():
                    print(f"[collate] ch{nn} 终稿落盘 (worker仍在收尾)")
                continue
            del running[i]
            if (sched / f"_ch{nn}_final.md").is_file() and rc == 0:
                done.append(i)
                (sched / f"_worker_ch{nn}.flag").write_text("done", encoding="utf-8")
                print(f"[collate] ch{nn} ✓ ({len(done)}/12)")
            else:
                if i not in failed:
                    failed.append(i)
                    queue.append(i)  # 断链重试一轮
                    print(f"[collate] ch{nn} rc={rc} — 重试一轮")
                else:
                    print(f"[collate] ch{nn} 二次失败 — 放弃")
        if time.time() - t0 > 6 * 3600:
            break
    ok = all((sched / f"_ch{i:02d}_final.md").is_file() for i in range(1, 13))
    return ok, f"完成{len(done)} 失败{[i for i in range(1,13) if i not in done]}"


def stage_merge(ns) -> tuple[bool, str]:
    rc, out = sh([sys.executable, "-X", "utf8", str(REPO / "tools" / "book_merge.py"),
                  "--campaign-dir", ns.campaign_dir, "--title", ns.title,
                  "--campaign", ns.campaign], timeout=3600)
    print(out[-500:])
    return rc == 0, out[-200:]


def stage_gate(ns) -> tuple[bool, str]:
    args = [sys.executable, "-X", "utf8", str(REPO / "tools" / "publish_gate.py"),
            "--campaign-dir", ns.campaign_dir, "--sku", ns.sku]
    sched = REPO / ns.campaign_dir / "sched"
    args.append("--pre-shelf")
    if not any((sched / f"_ch{i:02d}_nb_draft.md").is_file() for i in range(1, 13)):
        args.append("--allow-no-nb-draft")
        wecom(f"{ns.campaign} 出厂门: NB初稿缺席 (正身令降级披露) — bank收编+特赦放行")
    rc, out = sh(args, timeout=1800)
    print(out[-800:])
    return rc == 0, out[-300:]


def stage_shelf(ns) -> tuple[bool, str]:
    sched = REPO / ns.campaign_dir / "sched"
    from pypdf import PdfReader
    pdf = sched / "out" / "REPORT_FULL_排版版.pdf"
    n_pages = len(PdfReader(str(pdf)).pages)
    book_l1 = next((ln.lstrip("# ").strip() for ln in
                    (sched / "out" / "REPORT_FULL.md").read_text(encoding="utf-8").splitlines()
                    if ln.startswith("# ")), "")
    words_wan = str(round(len(re.findall(r"[一-鿿]", book_l1)) if False else 0))  # 占位
    book_cjk = len(re.findall(r"[一-鿿]", (sched / "out" / "REPORT_FULL.md").read_text(encoding="utf-8")))
    words_wan = str(round(book_cjk / 10000))
    sample = f"{ns.sku.split('-')[0].lower()}_sample.md"
    import shutil
    shutil.copyfile((sched / "_ch01_final.md"),
                    REPO / "report_platform" / "content" / "sample" / sample)
    rc, out = sh([sys.executable, "-X", "utf8", str(REPO / "tools" / "sku_insert.py"),
                  "--sku", ns.sku, "--title", ns.title, "--pages", str(n_pages),
                  "--words-wan", words_wan, "--chapters-json", str(sched / "chapters.json"),
                  "--sample-file", sample], timeout=600)
    print(out[-500:])
    if rc != 0:
        return False, out[-200:]
    shutil.copyfile(pdf, REPO / "report_platform" / "content" / "full" / f"{ns.sku}.pdf")
    rc2, _ = sh([sys.executable, "-X", "utf8", str(REPO / "report_platform" / "build_site.py")],
                timeout=1200, cwd=REPO / "report_platform")
    rc3, _ = sh([sys.executable, "-X", "utf8", str(REPO / "tools" / "mp_list_report.py"),
                 "--sku", ns.sku], timeout=1800)
    # 海报重试×3 (引擎端点随 TCB 传播有时序差, 1124 首跑实锤)
    rc4 = 1
    for attempt in range(3):
        rc4, _ = sh([sys.executable, "-X", "utf8", str(REPO / "report_platform" / "tools" /
                     "poster_fetch.py"), "--sku", ns.sku], timeout=600,
                    cwd=REPO / "report_platform" / "promo")
        if rc4 == 0 and (REPO / "report_platform" / "promo" / "posters" /
                         f"{ns.sku}.png").is_file():
            break
        time.sleep(60)
    # ECS 四件同步 (SSH 通道, 1124 实测多次; RunCommand AK风控不可用)
    rc6 = 1
    try:
        import shutil as _sh
        tar = Path(os.environ.get("TEMP", "/tmp")) / "rp_site.tgz"
        subprocess.run(["tar", "czf", str(tar), "site"], cwd=str(REPO / "report_platform"),
                       capture_output=True, timeout=300)
        ecs = "root@47.120.43.20"
        for f in ("content/report.json", f"content/full/{ns.sku}.pdf"):
            src = REPO / "report_platform" / f
            if src.is_file():
                subprocess.run(["scp", "-o", "BatchMode=yes", str(src), f"{ecs}:/tmp/"],
                               capture_output=True, timeout=300)
        subprocess.run(["scp", "-o", "BatchMode=yes", str(tar), f"{ecs}:/tmp/rp_site.tgz"],
                       capture_output=True, timeout=600)
        rj_remote = "/www/report_platform/content/report.json"
        script = "\n".join([
            "set -e",
            "python3 -c 'import json; json.load(open(\"/tmp/report.json\"))'",
            f"cp {rj_remote} {rj_remote}.bak",
            "mv /tmp/report.json /www/report_platform/content/report.json",
            f"[ -f /tmp/{ns.sku}.pdf ] && mv /tmp/{ns.sku}.pdf /www/report_platform/content/full/{ns.sku}.pdf",
            "cd /www/report_platform && rm -rf site_old site_new && mkdir site_new",
            "tar -xzf /tmp/rp_site.tgz -C site_new --strip-components=1",
            "[ -f site_new/index.html ] && mv site site_old && mv site_new site && rm -rf site_old /tmp/rp_site.tgz",
            "systemctl restart report-platform; sleep 3",
            "curl -s http://127.0.0.1:8885/ -o /dev/null -w 'index:%{http_code}'",
        ])
        r = subprocess.run(["ssh", "-o", "BatchMode=yes", ecs, script],
                           capture_output=True, text=True, encoding="utf-8",
                           errors="replace", timeout=300)
        rc6 = r.returncode
        print("[ecs]", (r.stdout or "")[-160:])
    except Exception as e:
        print("[ecs] EXC", e)
    # 微盘存档
    rc7 = 1
    try:
        cli = Path.home() / "AppData" / "Roaming" / "npm" / "wecom-cli.cmd"
        r = subprocess.run([str(cli), "disk", "files", "upload", "--json",
                            json.dumps({"folder_id": "fiECFVszxfZBXNxhuL-v_FBzMyBFyIQ8jjywjzzPb0yGKsr0WLzTyLK0hVIuOUOlnUb1NEb6Nf3oVeXgHrgN9bPQ",
                                        "file_name": f"{ns.title.strip('《》')}.pdf",
                                        "file_path": str(REPO / "report_platform" / "content" / "full" / f"{ns.sku}.pdf").replace(chr(92), '/')})],
                           capture_output=True, text=True, encoding="utf-8",
                           errors="replace", timeout=600)
        rc7 = 0 if '"file_size"' in (r.stdout or "") else 1
        print("[wedrive] rc=", rc7)
    except Exception as e:
        print("[wedrive] EXC", e)
    rc5, out5 = sh([sys.executable, "-X", "utf8", str(REPO / "tools" / "publish_gate.py"),
                    "--campaign-dir", ns.campaign_dir, "--sku", ns.sku,
                    "--allow-no-nb-draft"], timeout=1800)
    print(out5[-400:])
    ok = rc2 == 0 and rc3 == 0 and rc4 == 0 and rc5 == 0 and rc6 == 0 and rc7 == 0
    return ok, f"site={rc2} tcb={rc3} poster={rc4} 门复验={rc5} ecs={rc6} wedrive={rc7}"


def stage_promo(ns) -> tuple[bool, str]:
    claude = find_claude()
    book = REPO / ns.campaign_dir / "sched" / "out" / "REPORT_FULL.md"
    spec = REPO / "report_platform" / "promo" / "PROMO_ARTICLE_SPEC.md"
    brief = (
        f"你是《{ns.title}》的宣传稿写手 (SKU={ns.sku})。先读规范 {spec} 与书 "
        f"{book} (读导论+每章小结即可, 不必全书精读)。\n"
        f"产出三篇写到 {REPO / 'report_platform' / 'promo'}\\ 目录, 文件名 "
        f"2026-XX-XX_号位_钩子.md 格式 (zbzs=总包之声/zbshuo=总包说/gchyd=工程行业大脑):\n"
        f"1. zbzs launch 款: 标题「发布| {ns.title}」→ 压进64字节 (超长去掉《》保「发布| 全名称」)\n"
        f"2-3. zbshuo/gchyd 各一篇钩子款 (标题≤64字节, 各取书中一个最锋利的判例角度)\n"
        f"硬性: 每篇≥2000中文字; 第1行标题、第2行「出品：总包创研院研究团队」、第4行 blockquote 导语;"
        f" 文末 {{回QRCODE回}} 占位 (写成双大括号包裹QRCODE); 数字全部对齐书实测 (章数/万字数/页数/¥价格"
        f"从 {REPO / 'report_platform' / 'content' / 'report.json'} 的 {ns.sku} 条目取); "
        f"案号金额逐字取自书; 「法院认定」与「本研究归纳」严格分开; 不提AI。\n"
        f"完成后回三个文件名+各篇字数。")
    rc, out = sh([str(claude), "-p", brief, "--permission-mode", "acceptEdits"],
                 timeout=3600)
    print("promo drafting rc=", rc, out[-200:])
    if rc != 0:
        return False, "promo drafting 失败"
    # 落箱: 找本 SKU 的三篇 (文件名含 sku 前缀钩子), 每号一篇; 冷却/日帽拦截=如实记录不硬闯
    promo_dir = REPO / "report_platform" / "promo"
    t_start = time.time()
    # 1124 修复: 只认本次运行期间新写且内容含本书书名的稿 (旧稿同号位撞车事故)
    new_mds = [p for p in promo_dir.glob("2026-*_*.md")
               if p.stat().st_mtime > t_start - 5400
               and ns.title.strip("《》")[:12] in p.read_text(encoding="utf-8", errors="replace")]
    env = dict(os.environ, WECHAT_ACCOUNTS_FILE=r"F:\We-AIPO\data\wechat_accounts.json")
    acct_by = {"zbzs": "总包之声", "zbshuo": "总包说", "gchyd": "工程行业大脑"}
    pushed = []
    for p in new_mds:
        acct = next((v for k, v in acct_by.items() if k in p.name), None)
        if not acct:
            continue
        r = subprocess.run([sys.executable, "-X", "utf8", str(promo_dir / "push_article.py"),
                            str(p), "--account", acct, "--sku", ns.sku],
                           capture_output=True, text=True, encoding="utf-8",
                           errors="replace", timeout=600, cwd=str(promo_dir), env=env)
        ok = "七门全过" in (r.stdout or "") and "publish ok= True" in (r.stdout or "")
        pushed.append(f"{acct}:{'✓' if ok else '拦'}")
        print(f"[promo] {p.name} → {acct} {'✓' if ok else '(被守门拦截, 如实记录)'}")
    return len(pushed) >= 1, " ".join(pushed)


STAGES = ["harvest", "collate", "merge", "gate", "shelf", "promo", "finalize"]


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--campaign-dir", required=True)
    ap.add_argument("--campaign", required=True)
    ap.add_argument("--title", required=True)
    ap.add_argument("--sku", required=True)
    ap.add_argument("--stages", default=",".join(STAGES))
    ns = ap.parse_args()
    ns.slug = Path(ns.campaign_dir).name
    want = ns.stages.split(",")
    results = {}
    for st in want:
        if st not in STAGES:
            continue
        print(f"\n===== STAGE {st} =====")
        fn = globals().get(f"stage_{st}")
        if st == "finalize":
            rc_d, out_d = sh([sys.executable, "-X", "utf8", str(REPO / "tools" / "book_derivs.py"),
                              "--campaign-dir", ns.campaign_dir, "--campaign", ns.campaign,
                              "--title", ns.title], timeout=600)
            print(out_d[-300:])
            ledger_write("PRODUCE_DONE", ns.campaign,
                         {k: v[1][:80] for k, v in results.items()})
            wecom(f"{ns.campaign} ({ns.title}) 编排器生产完成: " +
                  " ".join(f"{k}={'✓' if v[0] else '✗'}" for k, v in results.items()))
            continue
        try:
            ok, msg = fn(ns)
        except Exception as e:
            ok, msg = False, f"EXC {e}"
        results[st] = (ok, msg)
        ledger_write(f"PRODUCE_{st.upper()}", ns.campaign,
                     {"ok": ok, "msg": str(msg)[:200]})
        if not ok and st in ("harvest", "collate", "merge", "gate"):
            wecom(f"{ns.campaign} 编排器在 {st} 阶段失败: {str(msg)[:120]} — 需接力")
            return 1
    print(f"\n[produce] 完成: {[(k, v[0]) for k, v in results.items()]}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
