# -*- coding: utf-8 -*-
"""metaso_kb_leg — 秘塔知识库专题采集腿 (1024 metaso-kb 专项令 + API优先令).

架构 (同 dangdang_leg 模式, 纯 API 无浏览器降级 — metaso 面无浏览器腿):
  复刻件 metaso_kb_api (api_replica_bridge 第8件登记):
    检索面 (匿名公开, 已 5/5 贯通): GET /api/knowledge/{sid}/search?s=<kw> —
      用户自有专题「工程行业大脑」(25538 件文件) owner 已公开搜索;
    下载面 (owner 面, 协议已破待凭据): GET /api/file/{fid}/ticket →
      files.metaso.cn/api/file/{fid}/stream-download?ticket=...
      匿名得 4401「岛主暂未开放下载权限」→ 登录段 POST /login (RSA+meta-token)
      需有效账号 (1024 实测: 给定手机号未注册 code 2701, 待用户修正凭据后自动激活)。

链路: 关键词 → 知识库检索 (真实文件 size>0 择优) → 尝试下载原文件 (凭据墙=4401 如实记)
  → 落 staging/metaso_kb/ (下载件或文件清单md: 名/大小/页数/更新时间)
  → ammo_pool ingest (engine=metaso_kb, cred=research, url=专题真源)
  → 台账 channel_invocations.jsonl 追加 (api_replica: 前缀)。

产物: ammo_pool/<战役>/staging/metaso_kb/mkb_<fid>_<safe_name>(.bin|.md)
用法: py reforge_factory/legs/metaso_kb_leg.py EPC-OVERSEAS [--q "词1|词2"]
      [--limit 5] [--no-ingest] [--dl-limit 3]
红线: 只动用户自有专题 (DEFAULT_SID), 不碰他人公开专题; 下载件数保守 (默认≤3/词)。
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
import api_replica_bridge as arb               # noqa: E402 (1024 API优先桥)
REPO = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(REPO / "reforge_factory"))
from ammo_pool import ingest as pool_ingest    # noqa: E402 (URL 真源入池)


def safe_name(s: str, n: int = 40) -> str:
    return re.sub(r"[\\/:*?\"<>|\s]+", "_", s)[:n].strip("_") or "unnamed"


def harvest_api(query: str, limit: int, campaign: str, out_dir: Path,
                ingest: bool = True, dl_limit: int = 3, sid: str = "8673582927558737920") -> dict:
    """API 优先路径 (metaso 面无浏览器腿 — 复刻件抛错即如实失败, 不造假)。"""
    mod = arb.load("metaso_kb")
    cli = mod.MetasoKB(sid=sid, verbose=False)
    # 已入池 URL 集 (engine=metaso_kb) — 重复跳过如实分开计
    seen_urls: set[str] = set()
    mp = REPO / "ammo_pool" / campaign / "manifest.jsonl"
    if mp.is_file():
        try:
            for line in mp.read_text(encoding="utf-8").splitlines():
                if not line.strip():
                    continue
                j = json.loads(line)
                if j.get("engine") == "metaso_kb" and j.get("url_norm"):
                    seen_urls.add(j["url_norm"])
        except (json.JSONDecodeError, OSError):
            pass

    res = cli.search(query, page=0, size=50)
    files = [f for f in res["files"] if (f.get("size") or 0) > 0][:limit]
    n_dl = n_md = n_ing = 0
    blocked = None
    results = []
    for f in files:
        fid = f["id"]
        url = f"https://metaso.cn/subject-v2/{sid}?fileId={fid}"
        got_any = False
        if n_dl < dl_limit:                      # 下载保守 (专项令 ≤3)
            out = out_dir / f"mkb_{fid}_{safe_name(f['fileName'])}.bin"
            r = cli.download(fid, str(out))
            if r.get("ok"):
                n_dl += 1
                got_any = True
                results.append({"fid": fid, "name": f["fileName"][:40],
                                "kind": "file", "bytes": r["bytes"]})
                if ingest and url not in seen_urls:
                    if pool_ingest(campaign, str(out), "metaso_kb", url=url,
                                   cred="research") == 0:
                        seen_urls.add(url); n_ing += 1
            else:
                blocked = f"{r.get('stage')}:{r.get('errCode')} {r.get('errMsg')}"
            time.sleep(1.5)
        # 无下载件 (或下载被墙) → 文件情报 md (清单面真源入池)
        if not got_any:
            md = (f"# {f['fileName']}\n\n"
                  f"> 来源: 秘塔知识库专题·工程行业大脑 (metaso_kb_leg, 纯HTTP检索面)\n"
                  f"> URL: {url}\n> fileId: {fid}\n> size: {f.get('size')}B\n"
                  f"> pages: {f.get('pages')}\n> parentId: {f.get('parentId')}\n"
                  f"> updateTime: {f.get('updateTime')}\n> 检索词: {query}\n"
                  f"> 采集: {time.strftime('%F %T')}\n\n"
                  f"## 下载状态\n\n- 原文件下载: {'已落盘' if got_any else '未落盘(' + str(blocked) + ')'}\n"
                  f"- 该文件在知识库内的检索命中元数据如上 (题录级情报)\n")
            fp = out_dir / f"mkb_{fid}_{safe_name(f['fileName'])}.md"
            fp.write_text(md, encoding="utf-8")
            n_md += 1
            results.append({"fid": fid, "name": f["fileName"][:40], "kind": "meta-md"})
            if ingest and url not in seen_urls:
                if pool_ingest(campaign, str(fp), "metaso_kb", url=url,
                               cred="research") == 0:
                    seen_urls.add(url); n_ing += 1
    return {"hits": res["total"], "files": len(files), "downloaded": n_dl,
            "meta_md": n_md, "ingested": n_ing, "blocked": blocked,
            "results": results}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("campaign")
    ap.add_argument("--q", default="国际EPC")
    ap.add_argument("--limit", type=int, default=5, help="每词处理文件数(题录)")
    ap.add_argument("--dl-limit", type=int, default=3, help="每词下载上限(保守)")
    ap.add_argument("--sid", default="8673582927558737920", help="专题id(默认=用户自有工程行业大脑)")
    ap.add_argument("--no-ingest", action="store_true", help="只落 staging 不入池")
    ns = ap.parse_args()
    queries = ns.q.split("|") if "|" in ns.q else [ns.q]

    tot = {"hits": 0, "files": 0, "downloaded": 0, "meta_md": 0, "ingested": 0}
    last_blocked = None
    for q in queries:
        out_dir = REPO / "ammo_pool" / ns.campaign / "staging" / "metaso_kb"
        out_dir.mkdir(parents=True, exist_ok=True)
        print(f"[metaso_kb] '{q.strip()}' limit={ns.limit} dl≤{ns.dl_limit}", flush=True)
        try:
            r = harvest_api(q.strip(), ns.limit, ns.campaign, out_dir,
                            ingest=not ns.no_ingest, dl_limit=ns.dl_limit, sid=ns.sid)
        except Exception as e:                    # 墙/网络/依赖缺 — 如实打印不造假
            print(f"[metaso_kb] FAIL {q.strip()}: {type(e).__name__}: {str(e)[:160]}",
                  flush=True)
            continue
        for k in tot:
            tot[k] += r.get(k, 0) if isinstance(r.get(k), int) else 0
        last_blocked = r.get("blocked") or last_blocked
        for it in r["results"]:
            print(f"  [metaso_kb] {'DL ' if it['kind'] == 'file' else 'MD '} "
                  f"{it['name']} ({it.get('bytes', '')})", flush=True)
        arb.append_invocation(
            "metaso_kb",
            "api_replica:metaso_kb_api(知识库检索+原文件下载, 纯HTTP零浏览器)",
            q.strip(),
            f"命中{r['hits']}/题录{r['files']}/下载{r['downloaded']}/清单md{r['meta_md']}"
            + (f"/入池{r['ingested']}" if not ns.no_ingest else "/未入池(no-ingest)")
            + (f" [下载墙: {r['blocked']}]" if r.get("blocked") else ""),
            note="1024 metaso-kb 专项令: 秘塔知识库专题腿; 匿名检索面贯通, "
                 "下载面待 owner 凭据修正(4401岛主权限/手机号未注册2701)自动激活",
            campaign=ns.campaign)
        time.sleep(2)
    print(f"== 秘塔知识库专题腿: 命中{tot['hits']} / 题录{tot['files']} / "
          f"下载{tot['downloaded']} / 清单md{tot['meta_md']} / 入池{tot['ingested']}"
          + (f" (下载墙: {last_blocked})" if last_blocked else ""))


if __name__ == "__main__":
    main()
