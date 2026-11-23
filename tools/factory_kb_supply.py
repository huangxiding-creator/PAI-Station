# -*- coding: utf-8 -*-
"""factory_kb_supply.py — B3 研报供弹钩子（1123《超级总包知识库 100× 总案》）。
新报告 S8 收官后调用：把正式 PDF 入库 64 库「11 总包智库独家研报全量」
（SKU_标题.pdf 体例，幂等）+ 刷新引擎 C1/C2 数据面 + 企微通知。

用法：
  py -3 tools/factory_kb_supply.py --pdf <本地PDF> --sku <SKU> [--title <标题>]
  py -3 tools/factory_kb_supply.py --latest            # 自动取 report.json 头插位最新 SKU
入库失败不抛异常退出（研报产线主流程不被本钩子卡死），失败详情落日志供人工补。
"""
import sys, os, json, argparse, datetime, re

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REP_DIR = os.path.join(REPO, "逆向工程", "baidu-netdisk", "replica")
sys.path.insert(0, REP_DIR)

KB_LIB_DIR = "/超级总包知识库（动态更新）/64. 总包研究成果库/11 总包智库独家研报全量"
RJ = os.path.join(REPO, "report_platform", "content", "report.json")


def sku_title(sku):
    try:
        for r in json.load(open(RJ, encoding="utf-8"))["reports"]:
            if r.get("sku") == sku:
                return r.get("title") or ""
    except Exception:
        pass
    return ""


def sanitize(s):
    return re.sub(r'[\\/:*?"<>|]', "-", s).strip()


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--pdf", required=False)
    ap.add_argument("--sku", required=False)
    ap.add_argument("--title", required=False)
    ap.add_argument("--latest", action="store_true")
    a = ap.parse_args()

    if a.latest and not (a.pdf and a.sku):
        try:
            head = json.load(open(RJ, encoding="utf-8"))["reports"][0]
            a.sku = a.sku or head.get("sku")
            a.title = a.title or head.get("title")
            a.pdf = a.pdf or os.path.join(REPO, "report_platform", "content", "full", f"{a.sku}.pdf")
        except Exception as e:
            print(f"[kb_supply] 头插位读取失败: {e}")
            return 0
    if not (a.pdf and a.sku):
        print("[kb_supply] 需要 --pdf + --sku（或 --latest）")
        return 0
    if not os.path.isfile(a.pdf):
        print(f"[kb_supply] PDF 不存在: {a.pdf}")
        return 0

    title = sanitize((a.title or sku_title(a.sku) or "").strip("《》"))
    out = f"{a.sku}_{title}.pdf" if title else f"{a.sku}.pdf"
    remote = f"{KB_LIB_DIR}/{out}"
    try:
        from bdncore import BdnApi, BdnSession, RoutedApi, BdnApiError
        from bdncore.transfer import UploadEngine
        api = RoutedApi(BdnApi(BdnSession()))
        try:
            api.mkdir(KB_LIB_DIR)
        except BdnApiError:
            pass
        have = {x.get("name") for x in (api.list_dir(KB_LIB_DIR).get("entries") or [])}
        if out in have:
            print(f"[kb_supply] 已在库（幂等跳过）: {out}")
            return 0
        eng = UploadEngine(api)
        try:
            eng.upload(a.pdf, remote, rtype=3)
        finally:
            eng.close()
        print(f"[kb_supply] 已入库: {remote}")
        # changelog 落账
        with open(os.path.join(REP_DIR, "_kb_build", "changelog.jsonl"), "a", encoding="utf-8") as f:
            f.write(json.dumps({"ts": datetime.datetime.now().isoformat(timespec="seconds"),
                                "op": "report_supply", "sku": a.sku, "file": out},
                               ensure_ascii=False) + "\n")
    except Exception as e:
        print(f"[kb_supply] 入库失败（不阻研报产线，人工补）: {str(e)[:200]}")
        return 0

    # 引擎数据面刷新（失败不阻断）
    try:
        subprocess_run = __import__("subprocess").run
        r = subprocess_run([sys.executable, "-I", "-X", "utf8",
                            os.path.join(REP_DIR, "kb_engine_data.py")],
                           capture_output=True, text=True, encoding="utf-8",
                           errors="replace", timeout=120, cwd=REP_DIR)
        print(f"[kb_supply] 引擎数据面刷新 exit={r.returncode}")
    except Exception as e:
        print(f"[kb_supply] 引擎刷新失败: {str(e)[:120]}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
