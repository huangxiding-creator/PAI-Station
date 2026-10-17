# -*- coding: utf-8 -*-
"""feishu_files_leg.py — 飞书智库 file 附件批量入池腿 (1004大力采集令).

背景: 总包智库 wiki 树真身 = 6.6万+ file 附件节点 (vs 仅3.4k docx);
fetch 相只吃 docx 覆盖不到附件. 本腿流式吃附件:

  批循环 (批=300): 6线程下载 → 4线程预抽文本 → 持池锁批量写 manifest
  (行格式与 ammo_pool.ingest 逐字段一致, pending) → judge(limit=0)
  (此时暂存文件还在 → 正常判定入门槛账) → 删暂存 → state 记 done.

为什么自写批量 ingest 而非循环调 ap.ingest:
  ① ap.ingest 路径快路每次全 manifest 扫描 (O(n²), 66k 件纯浪费数小时);
  ② ap.judge 对文件丢失的行永远 pending 不计数 — 必须判完再删.
read_text_safe 打进程内缓存 (judge 二次读免重抽 PDF).

幂等: state jsonl 记已完成 node_token; 内容级去重 manifest dedup_key
兜底 (sink 上传过的电子书会被识别跳过). 礼节: 自有租户读, 0.4s 节流.
"""
import json
import os
import subprocess
import sys
import threading
import time
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\Auto_Manus")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")

LARK = (r"C:\Users\91216\AppData\Roaming\npm\node_modules"
        r"\@larksuite\cli\bin\lark-cli.exe")
NODES = Path(r"E:\AI-Station\tools\feishu_zongbao_nodes_verify.json")
BATTLE = (Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics")
          / "《四川电力设计咨询有限责任公司怎么干EPC总承包？》")
# 池外暂存: 入账班扫战役 02 目录, 窗口期文件被双路 ingest = 双计风险
STAGE = Path(r"E:\AI-Station\tools\_feishu_stage")
STATE = Path(r"E:\AI-Station\tools\feishu_files_state.jsonl")
CID = "EPC49-SEPDC"
ENGINE = "kb:lark_zhiku_file"
BATCH = 300
ILLEGAL = '<>:"/\\|?*'
ENV = {**os.environ, "LARKSUITE_CLI_NO_UPDATE_NOTIFIER": "1"}


def sanitize(title: str, tok: str) -> str:
    name = "".join(c for c in title if c not in ILLEGAL).strip() or tok
    # 1005 修复: token 插扩展名前保住后缀 — 旧版 xxx.pdf_MXRgwiyy 污染
    # 后缀, 7414 件二进制 (5115 PDF) 全按乱码误杀的根因
    p = Path(name)
    suf = p.suffix
    if len(suf) > 5 or not suf.isascii():
        suf, stem = "", name
    else:
        stem = p.stem
    return f"{stem[:60]}_{tok[:8]}{suf.lower()}"


def sniff_fix(dest: Path) -> Path:
    """魔数兜底: 标题无扩展名/说谎的件, 按 %PDF/PK 头补真后缀."""
    if dest.suffix.lower() in (".pdf", ".docx", ".pptx", ".doc", ".ppt",
                               ".txt", ".md"):
        return dest
    try:
        head = dest.read_bytes()[:4]
    except OSError:
        return dest
    new = None
    if head.startswith(b"%PDF"):
        new = dest.parent / (dest.name + ".pdf")
    elif head == b"PK\x03\x04":
        try:
            import zipfile
            names = zipfile.ZipFile(dest).namelist()
            s2 = ".pptx" if any(n.startswith("ppt/") for n in names) \
                else ".docx"
        except Exception:                       # noqa: BLE001 — 兜底
            s2 = ".docx"
        new = dest.parent / (dest.name + s2)
    if new:
        try:
            dest.rename(new)
            return new
        except OSError:
            pass
    return dest


def load_nodes_file() -> list:
    for _ in range(5):                   # 复核爬在增量写, 可能撞半截 JSON
        try:
            return json.loads(NODES.read_text(encoding="utf-8"))
        except (json.JSONDecodeError, OSError):
            time.sleep(20)
    raise SystemExit(f"[files-leg] {NODES.name} 5 次读取失败")


def load_done() -> set:
    if not STATE.exists():
        return set()
    return {json.loads(x).get("tok")
            for x in STATE.read_text(encoding="utf-8").splitlines()
            if x.strip()}


def record(rows: list[dict]) -> None:
    with STATE.open("a", encoding="utf-8") as f:
        for r in rows:
            f.write(json.dumps(r, ensure_ascii=False) + "\n")


def download(tok: str, dest: Path) -> bool:
    for i in range(3):
        try:
            # lark-cli 路径白名单只认 cwd/临时/家目录 — cwd=目标目录+相对名
            cp = subprocess.run(
                [LARK, "drive", "+download", "--wiki-token", tok,
                 "--output", dest.name, "--overwrite", "--as", "user",
                 "--json"],
                capture_output=True, timeout=300, env=ENV, cwd=dest.parent)
            if cp.returncode == 0 and dest.exists() \
                    and dest.stat().st_size > 0:
                return True
            out = ((cp.stdout or b"") + (cp.stderr or b"")).decode(
                "utf-8", "replace")
            if "unsafe output path" in out:
                # 1005: lark-cli 拒「危险Unicode」文件名(弯引号等), 同名重试无意义
                print(f"[files-leg] dl拒名 {tok}: {out[:120]}", flush=True)
                return False
            if "99991400" in out or "frequency" in out:   # 飞书频控
                time.sleep(8 + 4 * i)
                continue
            if i:
                print(f"[files-leg] dl败 {tok}: {out[:200]}", flush=True)
        except (subprocess.TimeoutExpired, OSError) as e:
            if i:
                print(f"[files-leg] dl异常 {tok}: {e}", flush=True)
        time.sleep(2)
    return False


def bge_sim(text: str, qvec: list) -> float:
    """本地 Ollama bge-m3 语义相似度 (中文本职); 失败 fail-soft 返回 -1."""
    try:
        import urllib.request
        req = urllib.request.Request(
            "http://127.0.0.1:11434/api/embeddings",
            data=json.dumps({"model": "bge-m3",
                             "prompt": text[:2000]}).encode(),
            headers={"Content-Type": "application/json"})
        vec = json.loads(urllib.request.urlopen(
            req, timeout=120).read())["embedding"]
        s = sum(x * y for x, y in zip(vec, qvec))
        na = sum(x * x for x in vec) ** .5
        nb = sum(x * x for x in qvec) ** .5
        return s / (na * nb)
    except Exception:                           # noqa: BLE001 — fail-soft
        return -1.0


SEM_TH = 0.55          # 校准: 强相关0.76/对标0.63/泛0.45/小说0.27
QUERY = ("四川电力设计咨询有限责任公司 EPC工程总承包 输变电 新能源 "
         "电力设计院转型总承包 项目管理 设计采购施工")


def batch_ingest(ap, d: Path, texts: dict, todo: list, qvec: list) -> tuple:
    """持池锁批量写 manifest + 批内直判 (词面全文窗口 → bge 语义救回).

    绕开 ap.judge 的 O(池) 全池扫描与文件重读 — 判据同源
    (judge_heuristic(text, kws)), 行格式与 ap.judge 写出一致."""
    n_new = n_skip = tot = 0
    with ap._pool_lock(d):
        keys = ap._manifest_keys(d)
        s = ap._load_state(d)
        kws = s.get("kws", [])
        rows = []
        n_valid = 0
        for n in todo:
            fp = Path(n["_dest"])
            text = texts.get(str(fp), "")
            url = f"https://feishu.cn/wiki/{n['node_token']}"
            if ap.dedup_key(url, text) in keys:
                n_skip += 1
                continue
            if len(text) < 50:
                n_skip += 1
                continue
            ch = ap.count_chars(text)
            verdict, reason = ap.judge_heuristic(text, kws)
            if verdict == "rejected" and reason == "off_topic":
                sim = bge_sim((n.get("title") or "") + "\n" + text[:1500],
                              qvec)
                if sim >= SEM_TH:
                    verdict, reason = "valid", f"semantic_rescue_{sim:.3f}"
            rows.append({"ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
                         "engine": ENGINE, "source_path": str(fp),
                         "url_norm": ap.norm_url(url), "chars": ch,
                         "credibility": "archive",
                         "dedup_key": ap.dedup_key(url, text),
                         "judge": verdict, "judge_reason": reason,
                         "judge_engine": "heuristic",
                         "grade": ap.GRADE_MAP.get("archive", "C"),
                         "tree_node": "", "stance": "support"})
            keys.add(rows[-1]["dedup_key"])
            n_new += 1
            tot += ch
            if verdict == "valid":
                n_valid += 1
        if rows:
            with (d / "manifest.jsonl").open("a", encoding="utf-8") as f:
                for r in rows:
                    f.write(json.dumps(r, ensure_ascii=False) + "\n")
            vch = sum(r["chars"] for r in rows if r["judge"] == "valid")
            ns = {**s, "total_chars": s["total_chars"] + vch,
                  "items": s["items"] + n_valid,
                  "by_engine": {**s["by_engine"],
                                ENGINE: s["by_engine"].get(ENGINE, 0)
                                + vch},
                  "domains": [*s["domains"], "feishu.cn"][:2000]
                  if "feishu.cn" not in s["domains"] else s["domains"]}
            ap._save_state(d, ns)
    return n_new, n_skip, tot


def main() -> int:
    limit = int(sys.argv[sys.argv.index("--limit") + 1]) \
        if "--limit" in sys.argv else 0
    import ammo_pool as ap
    import urllib.request as _ur
    _rq = _ur.Request("http://127.0.0.1:11434/api/embeddings",
                      data=json.dumps({"model": "bge-m3",
                                       "prompt": QUERY}).encode(),
                      headers={"Content-Type": "application/json"})
    qvec = json.loads(_ur.urlopen(_rq, timeout=120).read())["embedding"]
    print(f"[files-leg] 课题 query 向量就绪 dim={len(qvec)}", flush=True)

    # read_text_safe 进程内缓存: 预抽一遍, judge 零重抽
    cache: dict = {}
    _orig = ap.read_text_safe

    def cached(p):
        k = str(p)
        if k not in cache:
            cache[k] = _orig(Path(k))
        return cache[k]

    ap.read_text_safe = cached

    STAGE.mkdir(parents=True, exist_ok=True)
    d = ap._camp_dir(CID)
    st = {"ok": 0, "skip": 0, "fail": 0, "new_chars": 0}

    for sweep in range(50):           # 外圈: 复核爬在涨, 跑完一轮吃增量
        nodes = load_nodes_file()
        files, seen = [], set()
        for n in nodes:
            if n.get("obj_type") == "file" \
                    and n.get("node_token") not in seen:
                seen.add(n["node_token"])
                files.append(n)
        done = load_done()
        todo = [n for n in files if n["node_token"] not in done]
        if limit:
            todo = todo[:limit]
        print(f"[files-leg] sweep#{sweep} 附件 {len(files)} | "
              f"done {len(done)} | 本轮 {len(todo)}", flush=True)
        if not todo:
            break
        for bi in range(0, len(todo), BATCH):
            batch = todo[bi:bi + BATCH]
            t0 = time.time()
            n_new = n_skip = tot = 0
            # 流水线: 下载线程完成一件立即喂抽取队列 (两段重叠)
            import queue as _q
            fq: _q.Queue = _q.Queue()
            texts: dict = {}

            def dl_feed(n):
                dest = Path(STAGE / sanitize(n.get("title") or "",
                                             n["node_token"]))
                n["_dest"] = str(dest)
                n["_ok"] = download(n["node_token"], dest)
                if not n["_ok"]:
                    # 1005 修: 标题含「危险Unicode」被 lark-cli 拒名 →
                    # 纯 ASCII token 兜底名重试 (manifest 记 title, 语义不丢)
                    fb = dest.with_name(n["node_token"] + dest.suffix)
                    if download(n["node_token"], fb):
                        dest, n["_dest"], n["_ok"] = fb, str(fb), True
                if n["_ok"]:
                    fixed = sniff_fix(dest)
                    if fixed != dest:
                        n["_dest"] = str(fixed)
                    fq.put(n)

            def ex_worker():
                while True:
                    n = fq.get()
                    if n is None:
                        return
                    texts[n["_dest"]] = _orig(Path(n["_dest"])) or ""
                    fq.task_done()

            exs = [threading.Thread(target=ex_worker, daemon=True)
                   for _ in range(6)]
            for t_ in exs:
                t_.start()
            with ThreadPoolExecutor(16) as ex:  # 16并发=4h实测安全档,24撞99991400
                list(ex.map(dl_feed, batch))
            for _ in exs:
                fq.put(None)
            for t_ in exs:
                t_.join()
            got = [n for n in batch if n.get("_ok")]
            if got:
                cache.update(texts)
                n_new, n_skip, tot = batch_ingest(ap, d, texts, got, qvec)
                st["ok"] += len(got)
                st["skip"] += n_skip
                st["new_chars"] += tot
            st["fail"] += len(batch) - len(got)
            done_rows = [{"ts": time.strftime("%F %T"),
                          "tok": n["node_token"],
                          "title": (n.get("title") or "")[:60],
                          "status": "ok" if n.get("_ok") else "dl_fail",
                          "chars": ap.count_chars(
                              texts.get(n.get("_dest", ""), "") or "")}
                         for n in batch]
            record(done_rows)
            for n in batch:                 # 判完才删 (judge 要读文件)
                try:
                    Path(n["_dest"]).unlink(missing_ok=True)
                except OSError:
                    pass
            cache.clear()
            print(f"[files-leg] 批 {bi // BATCH + 1}/"
                  f"{(len(todo) + BATCH - 1) // BATCH} | +{len(got)} "
                  f"({n_new}新/{n_skip}跳) | fail {st['fail']} | "
                  f"批耗时 {time.time() - t0:.0f}s", flush=True)
    s = json.loads((d / "pool_state.json").read_text(encoding="utf-8"))
    print(f"[files-leg] 完: ok {st['ok']} | skip {st['skip']} | "
          f"fail {st['fail']} | 门槛账 {s['total_chars']:,} 字 "
          f"({100 * s['total_chars'] / 200_000_000:.2f}% of 2亿)",
          flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
