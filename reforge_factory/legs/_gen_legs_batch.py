# -*- coding: utf-8 -*-
"""_gen_legs_batch — 渠道全接入令·腿批量建造生成器 (1025 腿批量令).

权威源: api_replica_bridge.py HTTP_ENGINES (134条); 差集=无腿引擎
(本令实测 119 条)。逐个生成薄腿 legs/<engine_id>_leg.py — 模板与
15 样板薄壳 (zenodo/datacite/dryad/...) 逐字同构, 只换 engine_id/
端点/帮助文本; 芯不重复, 共用 http_api_leg_core
(直连→代理链→散文式md→ingest骨架)。

端点配置分组 (同目录伴生件, 仅供本生成器引用):
  _leg_snippets_a.py  甲组: 学术/数据 API
  _leg_snippets_b.py  乙组: 搜索/新闻/通用网研
  _leg_snippets_c.py  丙组: 政府/金融/地信/国际组织
其余=骨架TODO (CLI/库型缺件/数据集直下面非检索端点/复刻件另有在役接入件)
— 端点以注册表 URL + q 探针落位, extract 如实返回零命中。

分型 (如实, 数字零造假):
  full     端点+解析均实装 (公开文档标准参数形态)
  semi     端点实装, 形态待实测校准 (或非检索清单面如实标注)
  skeleton 骨架TODO

铁律: 只增不删 — 已存在腿文件一律跳过不覆盖 (--force 仅限重生成本轮
产物); 桥表与芯不改动; 不 commit。编译门: 生成后逐个
py -X utf8 -m py_compile, 全绿为停机条件。
结果落 channels_survey_2026/_gen_legs_batch_result.json。

用法: py -X utf8 reforge_factory/legs/_gen_legs_batch.py
        [--force] [--only id1,id2] [--import-smoke]
"""
from __future__ import annotations

import argparse
import hashlib
import importlib.util
import json
import py_compile
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

import _leg_snippets_a as A                     # noqa: E402
import _leg_snippets_b as B                     # noqa: E402
import _leg_snippets_c as C                     # noqa: E402

LEGS_DIR = Path(__file__).resolve().parent
BRIDGE = LEGS_DIR / "api_replica_bridge.py"
CORE = LEGS_DIR / "http_api_leg_core.py"
RESULT_JSON = (LEGS_DIR.parent / "channels_survey_2026"
               / "_gen_legs_batch_result.json")

#: 骨架TODO 登记表: id → 缺端点形态原因 (台账/腿内注释双落)
SKELETONS: dict[str, str] = {
    "damodaran": "静态目录直链数据集(估值基准库) — 目录清单/直链解析待接, 非检索端点",
    "damonwonghv_youtube_search_api": "python库型 — 缺件如实记不擅自安装",
    "enr_com": "经chinca.org镜像链复刻件在案; enr.com本体403不直接用 — 镜像链端点待接",
    "gosom_google_maps_scraper": "CLI型(go二进制) — 缺件如实记不擅自安装",
    "kituin_picimagesearch": "python聚合库型 — 缺件如实记不擅自安装",
    "last30days_skill": "CLI引擎在役=CLI_ENGINES.last30days(last30days_leg.py); 本id=registry技能资产登记, 不重复建实调面",
    "sec_edgar_2": "SEC EDGAR submissions JSON面需CIK参数 — 全文检索面见sec_edgar腿(实装)",
    "chinca": "复刻件在案 REPLICAS.chinca(chinca_api.py纯HTTP过闸件) — 非单HTTP检索端点, 走桥复刻件调",
    "key_zh_search_pro": "免key中文多引擎URL模板集 — 模板面接入待令(zh_search_pro同族)",
    "tapxworld_chinatextbook_43_5gb_2087": "GitHub raw数据集2087册 — 目录清单直下面待接(105KB/s实测在案)",
    "std_samr_gov_cn": "国标全文公开系统全链复刻在役(skill std-samr-gb) — 走技能件",
    "gb_gb_t_ebiaozhun": "eBiaozhun免登录链在役(skill gb-standard) — 走技能件",
    "book_dangdang_com": "复刻件+专项腿在役(REPLICAS.dangdang+dangdang_leg.py) — 本id=登记对齐薄壳, 实调走dangdang_leg",
    "weixin_sogou_com": "复刻件在案 REPLICAS.sogou(四段链非单HTTP) — 走桥复刻件调",
    "eia_eia": "生态环境部GovListChannel基座 — 渠道页面非检索API, GovList接入待令",
    "76_bid_powerchina_cn": "电建系76站爬线 — 站点清单/分站端点形态待接",
    "wenku_search": "复刻件在案 REPLICAS.wenku(wenku_full_api.py) — 走桥复刻件调",
    "pansou": "本地服务型(localhost起服后可用) — 服务未起如实失败",
    "yt_dlp_bili_yt": "CLI型yt-dlp(字幕/描述面) — 缺件如实记不擅自安装",
    "giiisp_com_keyless": "集思谱keyless英文腿 — 端点形态待逆向补齐",
    "opensanctions": "数据集免登录下载面+API需key — 直下面(大批量gz)接入待令",
    "agent_search": "封装库型 — 依赖安装/端点形态待接",
    "aiddata": "数据集免登录下载面 — 清单/直链待接",
    "bts_gov": "BTS CKAN/目录面定位待接(data.transportation.gov面)",
    "cc_index_table": "AWS Athena/SQL直查面 — 需AWS CLI凭证, 非HTTP免key",
    "gadm": "数据集直下面(shapefile/geopackage) — 非检索端点",
    "global_dam_watch_grand": "数据集直下面 — 非检索端点",
    "google_open_buildings": "GCS大数据集直下面 — 非检索端点",
    "googler": "CLI型(jarun/googler) — 缺件如实记不擅自安装",
    "hn_cli": "CLI型 — 检索面复用hn_algolia_api腿(实装)",
    "howdoi": "CLI型 — 缺件如实记不擅自安装",
    "inform_risk_index": "数据集直下面 — 非检索端点",
    "oecd_data_explorer": "门户型 — SDMX API面见oecd_data_explorer_sdmx腿",
    "ofac_sdn": "csv直下面(制裁名单整库) — 查询过滤=本地grep待接, 非检索端点",
    "opec_momr": "免费页面PDF直下面 — 月报清单/直链解析待接",
    "open_ownership_register": "数据集下载面(register API直连000待验在案)",
    "openstreetmap": "全量dump面 — 查询面走openstreetmap_overpass_api腿(半实装)",
    "our_world_in_data": "grapher CSV直链面 — 指标目录接入待接",
    "ourairports": "csv直下面(机场整库) — 非检索端点",
    "overture_maps_foundation": "S3/Azure大数据集直下面 — 非检索端点",
    "zquestz_s": "CLI型(s) — 缺件如实记不擅自安装",
    "searxng_cli": "CLI型 — 缺件如实记不擅自安装(实例清单面见searx_space腿)",
    "samtay_so": "CLI型(so) — 缺件如实记不擅自安装",
    "storm_hosted": "免登录网页UI(文章产出) — 无公开API, 采集面待接",
    "surfraw": "CLI型 — 缺件如实记不擅自安装",
    "tarzi": "Rust库型 — 依赖安装待令",
    "wayback_machine_downloader": "CLI型(gem) — 快照检索面复用wayback_machine_cdx_api腿(实装)",
    "wechat_article_search": "CLI型 — 缺件如实记不擅自安装",
    "wechatsogou": "pip库(代码冻结2021) — 微信垂直面复刻件在案(REPLICAS.sogou)",
    "wiki_tui": "CLI型 — 检索面复用wikipedia_api腿(实装)",
    "wikidata_sparql": "SPARQL查询面(需查询模板) — 简单实体面见wikidata腿(在役)",
    "world_bank_open_data": "指标面见worldbank腿(在役) — 本id=数据门户登记",
    "world_bank_ppi_database": "数据集直下面 — 非检索端点",
    "world_bank_projects_operations": "项目检索面见worldbank_projects腿(在役) — 本id=门户登记",
    "zh_search_pro": "本仓技能资产(免key URL模板多引擎) — 模板接入走技能面",
    "miga": "出版物PDF直下面 — 清单/直链待接",
    "mofcom_gov_cn": "国别指南PDF直下面 — 清单/直链解析待接",
    "94_85_orchestrator_py_manifest": "工厂渠道注册表manifest聚合线(94模块/85源) — 非单端点, 走orchestrator",
    "02_70": "战场落点多腿聚合线 — 非单端点",
    "sogou_com": "通用网页面待HTTP复刻; 微信垂直已复刻API化(REPLICAS.sogou)",
    "github_com": "深网官网爬虫线(Auto_Manus自研) — 非单端点",
    "baidu_com": "免登录网页可HTTP复刻 — 检索面见baidu_serp_api腿(半实装)",
    "usgs_nwis": "USGS水文站参数面(site/bBox参数) — 站点检索形态待接",
}

#: 薄腿模板 (与样板薄壳逐字同构; @@TOKEN@@ 替换)
TEMPLATE = '''# -*- coding: utf-8 -*-
"""@@EID@@ 腿 — @@REGNAME@@ (1025 渠道全接入令·腿批量建造; A级·@@TAGS@@).

注册表: reforge_factory/legs/api_replica_bridge.py HTTP_ENGINES (@@REGNAME@@,
@@REGURL@@, @@REGACCESS@@).
@@HELP@@
引擎调用+staging+ingest骨架照 last30days_leg.py 模式 (纯HTTP零浏览器,
共用芯 http_api_leg_core)。

用法: py reforge_factory/legs/@@EID@@_leg.py --campaign EPC-JIAGE
      --queries "construction cost index"
"""
from __future__ import annotations

@@IMPORTS@@

sys.path.insert(0, str(Path(__file__).resolve().parent))
import http_api_leg_core as core

SPEC = {"engine": "@@EID@@", "source": "@@SOURCE@@",
        "note": "@@NOTE@@"}


@@ENDPOINT@@


@@EXTRACT@@


if __name__ == "__main__":
    raise SystemExit(core.run(SPEC))
'''


def load_bridge() -> dict:
    spec = importlib.util.spec_from_file_location("arb_gen_batch", BRIDGE)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return dict(mod.HTTP_ENGINES)


def imports_block(extra: list[str]) -> str:
    lines = ["import sys", "from pathlib import Path"] + list(extra or [])
    lines.sort(key=lambda s: (s.startswith("from"), s))
    return "\n".join(lines)


def render(eid: str, reg: dict, cfg: dict | None) -> str:
    skeleton = cfg is None
    reason = (SKELETONS.get(eid, "端点形态未编入批量配置") if skeleton else "")
    if skeleton:
        mode, form = "skeleton", "骨架TODO"
        src = reg.get("name") or eid
        help_lines = [
            reason + "。",
            "本腿=登记薄壳: 端点以注册表 URL + q 探针落位, 解析面待接 —",
            "编译门绿即落位, 实调面待令 (运行如实零命中不伪造)。",
        ]
        imports = imports_block([])
        endpoint_code = (
            'def endpoint(query, rows):\n'
            '    # TODO(1025批量建造): ' + reason +
            '\n    # — 端点参数形态缺, 先以注册表 URL + q 探针落位\n'
            '    return ("' + reg["url"] + '", {"q": query}, {}, "GET", None)')
        extract_code = (
            'def extract(data):\n'
            '    # TODO(1025批量建造): 解析面待接 — 如实零命中 (不伪造)\n'
            '    return []')
        note = ("A级·%s·%s; batch1025骨架TODO: %s"
                % (reg["tags"], reg["access"], reason))
    else:
        mode, form = cfg["mode"], cfg["form"]
        src = cfg["src"]
        help_lines = list(cfg["help"])
        imports = imports_block(cfg.get("imports") or [])
        endpoint_code = ("def endpoint(query, rows):\n"
                         + cfg["ep"].strip("\n") + "\n")
        extract_code = ("def extract(data):\n" + cfg["ex"].strip("\n")
                        + "\n")
        tagtxt = ("batch1025实装" if mode == "full"
                  else "batch1025半实装(形态待实测校准)")
        note = "A级·%s·%s; %s: %s" % (reg["tags"], reg["access"],
                                      tagtxt, form)
    out = TEMPLATE
    for tok, val in [
        ("@@EID@@", eid), ("@@REGNAME@@", reg.get("name") or eid),
        ("@@REGURL@@", reg["url"]), ("@@REGACCESS@@", reg["access"]),
        ("@@TAGS@@", reg["tags"]), ("@@HELP@@", "\n".join(help_lines)),
        ("@@IMPORTS@@", imports), ("@@SOURCE@@", src),
        ("@@NOTE@@", note), ("@@ENDPOINT@@", endpoint_code.rstrip()),
        ("@@EXTRACT@@", extract_code.rstrip()),
    ]:
        out = out.replace(tok, val)
    return out


def compile_gate(path: Path) -> tuple[int, str]:
    """编译门: py_compile 逐个过 (进程内 doraise — py 启动器卡壳规避,
    与 py -X utf8 -m py_compile 同一 stdlib 编译器)。"""
    try:
        py_compile.compile(str(path), doraise=True)
        return 0, ""
    except py_compile.PyCompileError as e:
        return 1, str(e)[-400:]
    except OSError as e:
        return 1, "%s: %s" % (type(e).__name__, e)


def import_smoke(path: Path) -> tuple[int, str]:
    """编译门之上的模块导入冒烟 (不触发 __main__, 零网络)。"""
    try:
        spec = importlib.util.spec_from_file_location(
            "legsmoke_" + "".join(ch if ch.isalnum() else "_"
                                  for ch in path.stem), path)
        mod = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(mod)
        assert callable(mod.endpoint) and callable(mod.extract)
        return 0, ""
    except Exception as e:                      # noqa: BLE001 (冒烟如实记)
        return 1, "%s: %s" % (type(e).__name__, e)[:300]


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--force", action="store_true",
                    help="重生成本轮批量产物 (仅限本生成器生成的腿)")
    ap.add_argument("--only", default="",
                    help="逗号分隔引擎id — 只处理这些")
    ap.add_argument("--import-smoke", action="store_true",
                    help="编译门外加模块导入冒烟")
    ns = ap.parse_args()

    engines = load_bridge()
    only = {s.strip() for s in ns.only.split(",") if s.strip()}
    real_cfg: dict[str, dict] = {**A.GROUP_A, **B.GROUP_B, **C.GROUP_C}

    # 覆盖完整性校验: 配置里不得出现注册表之外的 id (防笔误)
    stray = sorted(set(real_cfg) - set(engines))
    if stray:
        print("[gen] 配置含注册表外id(笔误?): %s" % stray)
        return 2

    missing = [e for e in engines
               if not (LEGS_DIR / (e + "_leg.py")).is_file()]
    if only:
        if ns.force:                      # force 可重指向已存在件 (仅限本批)
            missing = [e for e in only if e in engines]
        else:
            missing = [e for e in missing if e in only]
    todo = []
    for e in missing:
        if e in real_cfg:
            todo.append((e, real_cfg[e]))
        elif e in SKELETONS:
            todo.append((e, None))
        else:
            print("[gen] 覆盖缺口(需补配置): %s" % e)
            return 2
    print("[gen] HTTP_ENGINES=%d | 待建差集=%d | 本次处理=%d"
          % (len(engines), len([e for e in engines
                                if not (LEGS_DIR / (e + "_leg.py")).is_file()]),
             len(todo)))

    rows, n_ok = [], 0
    for eid, cfg in todo:
        reg = engines[eid]
        fp = LEGS_DIR / (eid + "_leg.py")
        mode = cfg["mode"] if cfg else "skeleton"
        form = cfg["form"] if cfg else "骨架TODO"
        src = cfg["src"] if cfg else (reg.get("name") or eid)
        if fp.is_file() and not ns.force:
            rows.append({"engine": eid, "file": fp.name, "mode": mode,
                         "form": form, "src": src, "compile_rc": None,
                         "compile_err": "", "state": "skipped_exists"})
            continue
        body = render(eid, reg, cfg)
        marker = "# batch1025 generated by _gen_legs_batch.py (force可重生)"
        if fp.is_file() and ns.force and marker not in fp.read_text(
                encoding="utf-8"):
            rows.append({"engine": eid, "file": fp.name, "mode": mode,
                         "form": form, "src": src, "compile_rc": None,
                         "compile_err": "force重生被拒(非本批产物)",
                         "state": "refused_not_batch"})
            continue
        fp.write_text(body + "\n" + marker + "\n", encoding="utf-8",
                      newline="\n")
        rc, err = compile_gate(fp)
        state = "generated_compiled" if rc == 0 else "generated_compile_FAIL"
        ism = (0, "")
        if rc == 0 and ns.import_smoke:
            ism = import_smoke(fp)
            if ism[0] != 0:
                state = "generated_importsmoke_FAIL"
        if rc == 0 and ism[0] == 0:
            n_ok += 1
        rows.append({"engine": eid, "file": fp.name, "mode": mode,
                     "form": form, "src": src, "compile_rc": rc,
                     "compile_err": err or ism[1], "state": state})
        print("  [%s] %-8s %s" % (state, mode, fp.name))

    n_full = sum(1 for r in rows if r["mode"] == "full")
    n_semi = sum(1 for r in rows if r["mode"] == "semi")
    n_skel = sum(1 for r in rows if r["mode"] == "skeleton")
    # --only 补跑时与上轮结果合并 (台账权威=注册表全量差集)
    prev: dict[str, dict] = {}
    if RESULT_JSON.is_file():
        try:
            prev = {r["engine"]: r for r in json.loads(
                RESULT_JSON.read_text(encoding="utf-8")).get("engines", [])}
        except (json.JSONDecodeError, OSError, KeyError):
            prev = {}
    merged = {**prev, **{r["engine"]: r for r in rows}}
    rows_all = [merged[e] for e in engines if e in merged]
    m_full = sum(1 for r in rows_all if r["mode"] == "full")
    m_semi = sum(1 for r in rows_all if r["mode"] == "semi")
    m_skel = sum(1 for r in rows_all if r["mode"] == "skeleton")
    m_green = sum(1 for r in rows_all
                  if r["state"] in ("generated_compiled", "skipped_exists"))
    result = {
        "generated_at": time.strftime("%Y-%m-%d %H:%M:%S"),
        "http_engines_total": len(engines),
        "legs_before": sorted(e for e in engines
                              if (LEGS_DIR / (e + "_leg.py")).is_file()
                              and e not in merged),
        "bridge_md5": hashlib.md5(BRIDGE.read_bytes()).hexdigest(),
        "core_md5": hashlib.md5(CORE.read_bytes()).hexdigest(),
        "bridge_or_core_modified": False,
        "counts": {"this_run": len(rows), "processed": len(rows_all),
                   "full": m_full, "semi": m_semi, "skeleton": m_skel,
                   "compile_or_smoke_green": m_green},
        "engines": rows_all,
    }
    RESULT_JSON.write_text(json.dumps(result, ensure_ascii=False, indent=1),
                           encoding="utf-8")
    print("[gen] 完成: 本轮%d (实装%d/半实装%d/骨架%d | 绿%d) | 合并全量%d "
          "(绿%d/%d)"
          % (len(rows), n_full, n_semi, n_skel, n_ok, len(rows_all),
             m_green, len(rows_all)))
    print("[gen] 结果: %s" % RESULT_JSON)
    return 0 if n_ok == len(rows) else 1


if __name__ == "__main__":
    raise SystemExit(main())
