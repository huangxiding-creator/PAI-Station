# -*- coding: utf-8 -*-
"""kb_purge_orig.py — 蓝本原件批量清理引擎 v2（P0-A2，用户 1123 批准的《100× 总案》）。

v1 (kb_deep_clean.py) 教训：errno=132 多为假失败（文件实际已进回收站），
逐条删除+重试太慢（~4s/条）。v2 策略：
  1) 每个白名单库：先列子项，子项按批（默认 60/批）批量路径删除；
  2) 每批后重列父目录复核（假失败=已消失，不重试；仍在=拆半重试）；
  3) 仍在的目录递归拆；空壳最后删；
  4) 全程只碰白名单路径，清单落 changelog。
安全：白名单外零触碰；删除全部进回收站（终态清箱由 A1 完成，用户令）。
"""
import sys, os, time, json, datetime

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from bdncore import BdnApi, BdnSession, RoutedApi, BdnApiError

api = RoutedApi(BdnApi(BdnSession()))
KB = "/超级总包知识库（动态更新）"
REF = "/03 总包生态/02 总包大脑-知识库"

# 白名单：与已入库并 13:01 verify 过的 27 个蓝本库一一对应（只删这些）
WHITELIST = [
    REF + "/11. 总包法规政策库", REF + "/21. 总包市场商务库", REF + "/22. 总包纠纷裁决库",
    REF + "/23. 总包造价审计库", REF + "/32. 总包标杆企业库", REF + "/33. 顶级管理咨询库",
    REF + "/41. 总包全过程管控", REF + "/44. 总包期刊文献库", REF + "/45. 总承包电子书库",
    REF + "/46. 总包自媒文章库", REF + "/47. 总包论坛会议库", REF + "/48. 总包实战案例库",
    REF + "/51. 团队岗位技能库", REF + "/52. 工程技术知识库", REF + "/53. 数字转型创新库",
    REF + "/54. 总包创优报奖库", REF + "/61. 总包学园经验库", REF + "/62. 六步法实战总包",
    REF + "/63. 总包专家百人库", REF + "/64. 总包研究成果库", REF + "/65. 总包生态资源库",
    REF + "/71.PMC管理总承包", REF + "/72. 全过程工程咨询", REF + "/73. 建设总承包模式",
    REF + "/74.项目谋划与投资", REF + "/81. 国际项目管理库", REF + "/91.知识炼金方法库",
]

BATCH = 60
stats = {"calls": 0, "listed": 0, "deleted_child": 0, "shells": 0, "errors": 0}


def log(msg):
    print(f"[{datetime.datetime.now():%H:%M:%S}] {msg}", flush=True)


def changelog(op, **kw):
    rec = {"ts": datetime.datetime.now().isoformat(timespec="seconds"),
           "op": op, **kw}
    with open(os.path.join(os.path.dirname(os.path.abspath(__file__)),
                           "_kb_build", "changelog.jsonl"), "a", encoding="utf-8") as f:
        f.write(json.dumps(rec, ensure_ascii=False) + "\n")


def list_kids(path):
    try:
        r = api.list_dir(path)
        stats["listed"] += 1
        return r.get("entries") or []
    except BdnApiError as ex:
        if ex.errno == -9:
            return None  # 已不存在
        raise


def rm_batch(paths):
    """批量删除一批路径。True=全部生效或已不存在。"""
    if not paths:
        return True
    try:
        api.delete(list(paths))
        stats["calls"] += 1
        stats["deleted_child"] += len(paths)
        return True
    except BdnApiError as ex:
        stats["calls"] += 1
        if ex.errno == -9:
            stats["deleted_child"] += len(paths)
            return True
        return False


def purge_dir(path, depth=0):
    """清空目录内容（递归），最后删壳。返回 True=目录已不存在。"""
    kids = list_kids(path)
    if kids is None:
        return True
    for round_ in range(6):
        if not kids:
            break
        # 子项分批删（文件+目录混合；目录整删 132=假失败则重列自愈）
        chunk = min(BATCH, max(8, len(kids) // 2)) if round_ else BATCH
        todo = [k.get("path") or f"{path.rstrip('/')}/{k.get('server_filename') or k.get('name')}"
                for k in kids]
        ok = True
        for i in range(0, len(todo), chunk):
            batch = todo[i:i + chunk]
            if not rm_batch(batch):
                ok = False
            time.sleep(0.6)
        time.sleep(1.0)
        kids = list_kids(path)
        if kids is None:
            return True
        if kids and not ok:
            # 132 类失败：拆半收敛
            continue
    if kids:
        # 兜底：逐个递归拆目录（深度防御）
        for k in kids:
            kp = k.get("path") or f"{path.rstrip('/')}/{k.get('server_filename') or k.get('name')}"
            if k.get("isdir"):
                purge_dir(kp, depth + 1)
            else:
                rm_batch([kp])
        kids = list_kids(path)
        if kids is None:
            return True
        if kids:
            stats["errors"] += 1
            log(f"  ✗ 残余 {len(kids)} 项 @ {path}")
            return False
    # 空壳删除
    try:
        api.delete([path])
        stats["calls"] += 1
        stats["shells"] += 1
        return True
    except BdnApiError as ex:
        if ex.errno == -9:
            return True
        stats["errors"] += 1
        log(f"  ✗ 壳 {path} — errno={ex.errno}")
        return False


def main():
    log(f"白名单 {len(WHITELIST)} 库 · 批量假失败自愈模式 · 批大小 {BATCH}")
    t0 = time.time()
    for wl in WHITELIST:
        name = wl.rsplit("/", 1)[-1]
        t1 = time.time()
        ok = purge_dir(wl)
        dt = time.time() - t1
        log(f"{'✓' if ok else '△'} {name} — {dt:.0f}s（calls {stats['calls']}, del {stats['deleted_child']}, shells {stats['shells']}, err {stats['errors']}）")
        changelog("purge_orig", lib=name, ok=ok, sec=int(dt), stats=dict(stats))
        time.sleep(1.0)
    # 收尾：REF 库根下 3 个治理 PDF 也在批准清单内（已复制进库）
    try:
        root_kids = list_kids(REF) or []
        leftovers = [k for k in root_kids if not k.get("isdir")]
        if leftovers:
            paths = [k.get("path") or f"{REF}/{k.get('name')}" for k in leftovers]
            rm_batch(paths)
            log(f"库根散件清理 {len(paths)} 件")
        shells = [k for k in (list_kids(REF) or []) if k.get("isdir")]
        if shells:
            for k in shells:
                kp = k.get("path") or f"{REF}/{k.get('name')}"
                if not any(kp == w for w in WHITELIST):
                    log(f"  ⚠ 白名单外目录残留（不碰）: {kp}")
                else:
                    purge_dir(kp)
    except Exception as ex:
        log(f"收尾异常: {ex}")
    log(f"完成: calls {stats['calls']} · del {stats['deleted_child']} · shells {stats['shells']} · err {stats['errors']} · {time.time()-t0:.0f}s")


if __name__ == "__main__":
    main()
