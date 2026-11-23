# -*- coding: utf-8 -*-
"""kb_dedupe_pass3.py — 去重三扫（通用收口）：台账内全部已复制源的安全清理。
与一/二扫的区别：候选=台账全部 copied 源（仍存在的），库副本用「变体+全库搜索」定位
（v2 归位会把副本挪进 45 库正确槽位，台账 dst_dir 是 v1 落点不可信）。
安全协议不变：源↔库逐文件对账全绿才删、只进回收站、挂载位未满的源保护跳过。"""
import sys, os, json, time, datetime, re

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from bdncore import BdnApi, BdnSession, RoutedApi, BdnApiError

api = RoutedApi(BdnApi(BdnSession()))
KB = "/超级总包知识库（动态更新）"
REF = "/03 总包生态/02 总包大脑-知识库"
FILE_CAP, DIR_CAP = 100000, 20000


def log(m):
    print(f"[{datetime.datetime.now():%H:%M:%S}] {m}", flush=True)


def clg(op, **kw):
    with open(os.path.join(HERE, "_kb_build", "changelog.jsonl"), "a", encoding="utf-8") as f:
        f.write(json.dumps({"ts": datetime.datetime.now().isoformat(timespec="seconds"),
                            "op": op, **kw}, ensure_ascii=False) + "\n")


def kids_of(path):
    try:
        r = api.list_dir(path)
    except BdnApiError as ex:
        if ex.errno == -9:
            return None
        raise
    page = r.get("entries") or []
    total = r.get("total")
    while total and len(page) < min(total, 200000):
        r2 = api.list_dir(path, page=(len(page) // 1000) + 1, num=1000)
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


def walk_tree(root):
    files, ndirs = {}, 0
    try:
        queue = [root]
        while queue:
            d = queue.pop(0)
            page = kids_of(d)
            if page is None:
                if d == root:
                    return None
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


def verify(src, dst):
    # 文件类候选：必须显式字节级比对（1124 实锤：空树==空树的空洞 GREEN 是流程漏洞）
    import os as _os
    src_parent = src.rsplit("/", 1)[0] if "/" in src else "/"
    try:
        sk = kids_of(src_parent) or []
        src_is_file = any((not k.get("isdir")) and k.get("name") == src.rsplit("/", 1)[-1] for k in sk)
    except Exception:
        src_is_file = False
    if src_is_file:
        sname = src.rsplit("/", 1)[-1]
        dname = dst.rsplit("/", 1)[-1]
        sp, dp = src.rsplit("/", 1)[0], dst.rsplit("/", 1)[0]
        s = {k.get("name"): int(k.get("size") or 0) for k in (kids_of(sp) or []) if not k.get("isdir")}
        d = {k.get("name"): int(k.get("size") or 0) for k in (kids_of(dp) or []) if not k.get("isdir")}
        if sname not in s:
            return ("GONE", "源文件不存在")
        if dname not in d:
            return ("NODST", "库副本不存在")
        if s[sname] == d[dname] and s[sname] > 0:
            return ("GREEN", f"单文件 {s[sname]}B 字节级一致")
        return ("RED", f"字节数不一致 src={s[sname]} dst={d[dname]}")
    w = walk_tree(src)
    if w is None:
        return ("GONE", "源已不存在")
    if w[0] in ("TRUNC", "ERR"):
        return ("HUGE" if w[0] == "TRUNC" else "ERROR", "源树")
    sf, sdirs = w[1]
    w2 = walk_tree(dst)
    if w2 is None:
        return ("NODST", "库副本不存在")
    if w2[0] in ("TRUNC", "ERR"):
        return ("HUGE" if w2[0] == "TRUNC" else "ERROR", "库树")
    df, _ = w2[1]
    if len(sf) == 0 and sdirs == 0:
        return ("RED", "源树为空（空洞 GREEN 防线拒绝）")
    miss = [k for k in sf if k not in df]
    diff = [k for k in sf if k in df and df[k] != sf[k]]
    if not miss and not diff:
        return ("GREEN", f"{len(sf)} 文件/{sdirs} 目录 全覆盖")
    return ("RED", f"缺{len(miss)} 差{len(diff)} 首2:{(miss or diff)[:2]}")


def find_dst(src):
    name = src.rstrip("/").rsplit("/", 1)[-1]
    for key in dict.fromkeys(list(variants(name))):
        if not key or len(key) < 3:
            continue
        try:
            r = api.search(key, dir_path=KB, recursion=1, page=1, num=30)
            for e in (r.get("entries") or []):
                if e.get("name") == name or e.get("name") == key:
                    return e.get("path")
        except BdnApiError:
            pass
        time.sleep(0.4)
    return None


def main():
    led = [json.loads(l) for l in open(os.path.join(HERE, "_kb_build", "ledger.jsonl"), encoding="utf-8")]
    p = json.load(open(os.path.join(HERE, "_kb_build", "plan.json"), encoding="utf-8"))
    units = p.get("units") or []
    copied_pairs = {(x["src"], x.get("dst_dir")) for x in led if x.get("status") == "copied"}
    srcs = sorted({x["src"] for x in led if x.get("status") == "copied"
                   and not (x["src"] == REF or x["src"].startswith(REF + "/"))})
    log(f"三扫候选（台账已复制源）: {len(srcs)}")
    stat = {}
    for i, src in enumerate(srcs, 1):
        # 源还在吗
        try:
            kids_of(src)
        except BdnApiError as ex:
            if ex.errno == -9:
                stat["GONE"] = stat.get("GONE", 0) + 1
                continue
            raise
        except Exception:
            stat["ERR"] = stat.get("ERR", 0) + 1
            continue
        # 挂载位保护：还有未复制挂载 → 跳过
        uncopied = sum(1 for u in units if u.get("src") == src and (u["src"], u.get("dst_dir")) not in copied_pairs)
        if uncopied:
            stat["DEFER"] = stat.get("DEFER", 0) + 1
            continue
        # 单文件候选
        name = src.rstrip("/").rsplit("/", 1)[-1]
        dst = None
        try:
            kids = kids_of(os.path.dirname(src) or "/") or []
            isfile = not any(k.get("isdir") and k.get("name") == name for k in kids if k.get("name") == name)
        except Exception:
            isfile = False
        found = find_dst(src)
        if found:
            dst = found
        if not dst:
            stat["NODST"] = stat.get("NODST", 0) + 1
            continue
        v, detail = verify(src, dst)
        stat[v] = stat.get(v, 0) + 1
        if v == "GREEN":
            try:
                api.delete([src])
                clg("dedupe_clean_p3", src=src, dst=dst, detail=detail)
                log(f"✓ [{i}/{len(srcs)}] 已删源（回收站）{src} → {dst}（{detail}）")
            except BdnApiError as ex:
                if ex.errno in (12,):
                    time.sleep(2)
                    gone = False
                    try:
                        kids_of(src)
                    except BdnApiError as e2:
                        gone = (e2.errno == -9)
                    if gone:
                        clg("dedupe_clean_p3", src=src, dst=dst, detail=detail + "（假失败复核）")
                        log(f"✓ [{i}] 已删源（假失败复核确认）{src}")
                    else:
                        stat["ERR-DEL"] = stat.get("ERR-DEL", 0) + 1
                        log(f"! [{i}] 删除失败 errno={ex.errno}（保留源）{src}")
                else:
                    stat["ERR-DEL"] = stat.get("ERR-DEL", 0) + 1
                    log(f"! [{i}] 删除失败 errno={ex.errno}（保留源）{src}")
        else:
            log(f"{v} [{i}/{len(srcs)}] {src} ⇋ {dst}（{detail}）")
        time.sleep(0.6)
    log(f"三扫完成 {stat}")


if __name__ == "__main__":
    main()
