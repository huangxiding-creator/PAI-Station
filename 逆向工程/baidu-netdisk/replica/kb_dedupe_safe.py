# -*- coding: utf-8 -*-
"""kb_dedupe_safe.py — 全盘去重安全清理引擎 v2（用户 1123 令：已整体入库的源目录不再重复保存）。

安全协议（用户令「请一定要安全操作，不要发生文件丢失」）：
  1. 候选只来自台账 copied 记录，白名单制，台账外零触碰；
  2. 删除前源↔库对账：源侧每个文件（名+字节数）必须库侧同名同量存在；
     目录改名（知识库：前缀 / -NN 后缀净化）自动做变体匹配；
  3. 任何对不上 → RED/NODST/HUGE/ERROR 一律不删，落报告；
  4. 删除只进回收站（可还原）；彻底清箱由主会话在对账全绿后另行执行；
  5. 每删一项 changelog 落账。
"""
import sys, os, re, json, time, datetime

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from bdncore import BdnApi, BdnSession, RoutedApi, BdnApiError

api = RoutedApi(BdnApi(BdnSession()))
FILE_CAP = 20000
DIR_CAP = 4000
LEDGER = os.path.join(HERE, "_kb_build", "ledger.jsonl")
CHANGELOG = os.path.join(HERE, "_kb_build", "changelog.jsonl")
REPORT = os.path.join(HERE, "_kb_build", "dedupe_report.md")


def now():
    return datetime.datetime.now().isoformat(timespec="seconds")


def log(m):
    print(f"[{datetime.datetime.now():%H:%M:%S}] {m}", flush=True)


def clg(op, **kw):
    with open(CHANGELOG, "a", encoding="utf-8") as f:
        f.write(json.dumps({"ts": now(), "op": op, **kw}, ensure_ascii=False) + "\n")


def kids_of(path):
    """列目录（自动翻页）；-9 返回 None。"""
    try:
        r = api.list_dir(path)
    except BdnApiError as ex:
        if ex.errno == -9:
            return None
        raise
    page = r.get("entries") or []
    total = r.get("total")
    while total and len(page) < min(total, 100000):
        try:
            r2 = api.list_dir(path, page=(len(page) // 1000) + 1, num=1000)
        except BdnApiError:
            break
        add = r2.get("entries") or []
        if not add:
            break
        page += add
        total = r2.get("total")
    return page


def variants(name):
    out = {name}
    s = name.replace("知识库：", "").replace("知识库:", "")
    out.add(s)
    out.add(re.sub(r"-\d+$", "", s))
    out.add(re.sub(r"-\d+$", "", name))
    return out


def resolve_dst(src_name, dst_dir):
    """在 dst_dir 下找源副本（含净化改名变体）。返回 (kind, dst_path) 或 ('missing', None)。"""
    kids = kids_of(dst_dir)
    if kids is None:
        return ("NODST", None)
    nm = {k.get("name"): k for k in kids}
    for v in variants(src_name):
        if v in nm:
            k = nm[v]
            return ("dir" if k.get("isdir") else "file", dst_dir.rstrip("/") + "/" + v)
    return ("NODST", None)


def walk_tree(root):
    files, ndirs = {}, 0
    try:
        queue = [root]
        while queue:
            d = queue.pop(0)
            page = kids_of(d)
            if page is None:
                if d == root:
                    return None  # 根已不存在
                continue
            for k in page:
                kp = k.get("path") or (d.rstrip("/") + "/" + (k.get("name") or ""))
                rel = kp[len(root):].lstrip("/")
                if k.get("isdir"):
                    ndirs += 1
                    if ndirs > DIR_CAP:
                        return ("TRUNC", files)
                    queue.append(kp)
                else:
                    files[rel] = int(k.get("size") or 0)
                    if len(files) > FILE_CAP:
                        return ("TRUNC", files)
        return ("OK", (files, ndirs))
    except BdnApiError as ex:
        log(f"  walk 异常 {root}: errno={ex.errno}")
        return ("ERR", None)


def verify(src, dst, kind):
    """返回 (verdict, detail)。GREEN=源侧全部文件库侧同名同量。"""
    if kind == "file":
        sp, dn = src.rsplit("/", 1), dst.rsplit("/", 1)
        s_kids = kids_of(sp[0]) or []
        d_kids = kids_of(dn[0]) or []
        s = {k.get("name"): int(k.get("size") or 0) for k in s_kids if not k.get("isdir")}
        d = {k.get("name"): int(k.get("size") or 0) for k in d_kids if not k.get("isdir")}
        if src.rsplit("/", 1)[-1] not in s:
            return ("GONE", "源文件不存在")
        if dst.rsplit("/", 1)[-1] not in d:
            return ("NODST", "库副本不存在")
        if s[src.rsplit("/", 1)[-1]] == d[dst.rsplit("/", 1)[-1]]:
            return ("GREEN", f"单文件 {s[src.rsplit('/',1)[-1]]}B 一致")
        return ("RED", "字节数不一致")
    w = walk_tree(src)
    if w is None:
        return ("GONE", "源已不存在")
    if w[0] == "TRUNC":
        return ("HUGE", "树超上限人工核")
    if w[0] == "ERR":
        return ("ERROR", "源树读取失败")
    sf, sdirs = w[1]
    w2 = walk_tree(dst)
    if w2 is None:
        return ("NODST", "库副本不存在")
    if w2[0] == "TRUNC":
        return ("HUGE", "库树超上限")
    if w2[0] == "ERR":
        return ("ERROR", "库树读取失败")
    df, _ = w2[1]
    miss = [k for k in sf if k not in df]
    diff = [k for k in sf if k in df and df[k] != sf[k]]
    if not miss and not diff:
        return ("GREEN", f"{len(sf)} 文件/{sdirs} 目录 全覆盖")
    return ("RED", f"缺{len(miss)} 差{len(diff)} 首2:{(miss or diff)[:2]}")


def main():
    led = [json.loads(l) for l in open(LEDGER, encoding="utf-8")]
    REF = "/03 总包生态/02 总包大脑-知识库"
    todo, seen = [], set()
    for x in led:
        if x.get("status") != "copied":
            continue
        src = x["src"]
        if src == REF or src.startswith(REF + "/"):
            continue  # 蓝本族 P0 已清
        key = (src, x.get("dst_dir"))
        if key in seen:
            continue
        seen.add(key)
        todo.append({"src": src, "dst_dir": (x.get("dst_dir") or "").rstrip("/")})
    log(f"待核候选 {len(todo)} 项")

    stat = {"GREEN": 0, "RED": 0, "HUGE": 0, "ERROR": 0, "NODST": 0, "GONE": 0}
    lines = ["# 全盘去重安全清理报告（%s）" % now(), ""]
    for i, c in enumerate(todo, 1):
        src_name = c["src"].rsplit("/", 1)[-1]
        kind, dst = resolve_dst(src_name, c["dst_dir"]) if c["dst_dir"] else ("NODST", None)
        if kind == "NODST":
            stat["NODST"] += 1
            clg("dedupe_skip", src=c["src"], verdict="NODST", detail="库侧未找到副本（含改名变体）")
            log(f"△ [{i}/{len(todo)}] NODST {c['src']}")
            lines.append(f"- △ NODST（未删）{c['src']}")
            continue
        v, detail = verify(c["src"], dst, kind)
        stat[v] = stat.get(v, 0) + 1
        mark = {"GREEN": "✓", "RED": "✗", "HUGE": "△", "ERROR": "!", "GONE": "·", "NODST": "△"}[v]
        log(f"{mark} [{i}/{len(todo)}] {v:5} {c['src']} ⇋ {dst}")
        if v == "GREEN":
            try:
                api.delete([c["src"]])
                clg("dedupe_clean", src=c["src"], dst=dst, verdict="GREEN", detail=detail)
                log(f"    ↳ 源已删（回收站）· 库副本 {dst}")
                lines.append(f"- ✓ 已删源（回收站）{c['src']} → {dst}（{detail}）")
            except BdnApiError as ex:
                if ex.errno in (-9, 12):
                    time.sleep(1.5)
                    gone = False
                    try:
                        kids_of(c["src"])
                    except BdnApiError as e2:
                        gone = (e2.errno == -9)
                    if gone:
                        clg("dedupe_clean", src=c["src"], dst=dst, verdict="GREEN-假失败", detail=detail)
                        log("    ↳ errno 假失败，复核确认已删")
                        lines.append(f"- ✓ 已删源（假失败复核确认）{c['src']} → {dst}")
                    else:
                        stat["ERROR"] += 1
                        clg("dedupe_err", src=c["src"], errno=ex.errno)
                        log(f"    ↳ 删除失败 errno={ex.errno}（保留源）")
                        lines.append(f"- ! 删除失败（保留源）{c['src']} errno={ex.errno}")
                else:
                    stat["ERROR"] += 1
                    clg("dedupe_err", src=c["src"], errno=ex.errno)
                    log(f"    ↳ 删除失败 errno={ex.errno}（保留源）")
                    lines.append(f"- ! 删除失败（保留源）{c['src']} errno={ex.errno}")
        elif v == "GONE":
            lines.append(f"- · 源已不存在 {c['src']}")
        else:
            clg("dedupe_skip", src=c["src"], dst=dst, verdict=v, detail=detail)
            lines.append(f"- {mark} {v}（未删）{c['src']} → {dst}（{detail}）")
        time.sleep(0.7)

    # 蓝本空壳复核
    log("复核蓝本空壳…")
    try:
        kids = kids_of(REF)
        if kids is not None:
            log(f"REF 残留 {len(kids)} 项")
            if not kids:
                try:
                    api.delete([REF])
                    log("空壳 REF 已删")
                except BdnApiError as ex:
                    log(f"REF 壳删除 errno={ex.errno}")
        else:
            log("REF 已不存在")
    except BdnApiError as ex:
        log(f"REF 复核失败 errno={ex.errno}")

    log(f"对账完成: {stat}")
    with open(REPORT, "w", encoding="utf-8") as f:
        f.write("\n".join(lines) + f"\n\n**统计**: {stat}\n\n删除均进回收站，清箱另令执行。\n")


if __name__ == "__main__":
    main()
