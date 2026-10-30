# -*- coding: utf-8 -*-
"""1025 渠道普查纳管令 — 登记生成器 (一次性工作脚本, 产物=channel_matrix.py +
api_replica_bridge.py 的只增插入块; .bak 已先行备份)。

数据源: MASTER_REGISTRY.json (A级142 + B级96 = 238条全量)。
规则: id=条目slug(停用词/短名防护; 15条已建腿用腿引擎名覆盖), 别名=slug/域名/gh全名/
条目名(>=4字符+停用词过滤, 防短别名误吞引擎标签)。
"""
from __future__ import annotations

import json
import re
import sys
from collections import Counter
from pathlib import Path
from urllib.parse import urlparse

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = Path(__file__).resolve().parent
REPO = HERE.parents[1]
REG = HERE / "MASTER_REGISTRY.json"
CM = REPO / "reforge_factory" / "completeness" / "channel_matrix.py"
ARB = REPO / "reforge_factory" / "legs" / "api_replica_bridge.py"

#: 已建腿的 15 条: 注册表条目名 → 腿引擎名 (= 渠道 id, 入池 engine 标签)
LEG_OVERRIDES = {
    "BLS Public Data API": "bls",
    "NIST Technical Series Publications": "nist",
    "Wikidata API": "wikidata",
    "World Bank Open Data API": "worldbank",
    "World Bank Projects & Operations API": "worldbank_projects",
    "DataCite API": "datacite",
    "Zenodo API": "zenodo",
    "re3data API": "re3data",
    "Dryad API": "dryad",
    "Eurostat API": "eurostat",
    "USAspending API": "usaspending",
    "Open Contracting Data Registry": "opendi",
    "HuggingFace Datasets API": "hf_datasets",
    "xorsoft web search (search.xorsoft.dev)": "xorsoft",
    "ddgr": "ddgr",
}

STOP = {"search", "mcp", "tool", "cli", "http", "json", "data", "open",
        "rest", "api", "mcp_server", "api_wrapper", "cli_tool", "zh_search",
        "browser", "web", "skill", "站", "the", "and", "for"}


def slugify(s: str) -> str:
    s = re.sub(r"[^0-9a-z]+", "_", s.lower()).strip("_")
    return re.sub(r"_+", "_", s)


def entry_id(e: dict, used: set) -> str:
    name = str(e.get("name", "")).strip()
    dk = str(e.get("dedup_key", ""))
    sid = LEG_OVERRIDES.get(name, "")
    if not sid:
        sid = slugify(name)
        if len(sid) < 4 or sid in STOP:          # 短名/停用词防护: 降级 dedup_key
            m = re.match(r"^(?:gh|gl):([^/]+)/(.+)$", dk)
            if m:
                sid = slugify(m.group(1)) + "_" + slugify(m.group(2))
            else:
                sid = slugify(dk.split(":", 1)[-1]) or "survey_" + slugify(name)
    base, i = sid, 2
    while sid in used:
        sid = f"{base}_{i}"
        i += 1
    used.add(sid)
    return sid


def aliases_for(e: dict, sid: str) -> list:
    out = [sid]
    name = str(e.get("name", ""))
    low = name.lower().strip()
    if 6 <= len(low) <= 60 and low not in STOP and low != sid:
        out.append(low)
    url = str(e.get("entry", ""))
    if url.startswith("http"):
        host = urlparse(url).netloc.lower()
        host = host[4:] if host.startswith("www.") else host
        if len(host) >= 6 and host not in STOP:
            out.append(host)
    dk = str(e.get("dedup_key", ""))
    if dk.startswith(("gh:", "gl:")):
        full = dk.split(":", 1)[1].lower()
        if len(full) >= 6 and full != sid:
            out.append(full)
    seen, dedup = {sid}, []
    for a in out:
        a = a.strip()
        if a and a not in seen and len(a) >= 4 and a not in STOP and not a.isdigit():
            seen.add(a)
            dedup.append(a)
    return dedup[:4]


def main() -> int:
    reg = json.loads(REG.read_text(encoding="utf-8"))
    ents = reg["entries"]
    ab = [e for e in ents if e.get("tier") in ("A", "B")]
    used: set = set()
    rows = []
    for e in sorted(ab, key=lambda x: (x.get("tier", ""), str(x.get("name", "")))):
        sid = entry_id(e, used)
        rows.append((e, sid, aliases_for(e, sid)))
    print("登记条目:", len(rows), "唯一渠道id:", len({r[1] for r in rows}))

    # ---- ① channel_matrix.py: SURVEY_ALIASES 块 (只增) ----
    lines = []
    for e, sid, al in rows:
        tier = e.get("tier", "")
        tags = "/".join(e.get("tags", []))
        nm = str(e.get("name", "")).replace('"', "'")
        lines.append(
            f'    "{sid}": {json.dumps(al, ensure_ascii=False)},'
            f'  # {tier}级·{tags}·{nm}')
    block = (
        "\n#: ---- 1025 渠道普查纳管令: channels_survey_2026/MASTER_REGISTRY.json\n"
        "#: A+B级 238 条全量登记 (by_tier_all A=142/B=96, 2026-10-25 13:47 UTC\n"
        "#: 四路sweep归并主注册表; .bak=completeness/channel_matrix.pre-survey1025.bak)。\n"
        "#: id=注册表条目slug(停用词/短名防护; 已建腿15条用腿引擎名覆盖, 见\n"
        "#: channels_survey_2026/集成台账.md), 别名=slug/域名/gh全名(>=4字符+停用词\n"
        "#: 过滤, 防短别名误吞引擎标签)。只增不删: 并入存量渠道键时extend不去除原别名。\n"
        "#: 登记≠接线: 新渠道进渠道册(named_channels)前不计入 C 轴分母, 建渠走 T-015 SOP。\n"
        "SURVEY_ALIASES: dict[str, list[str]] = {\n"
        + "\n".join(lines) +
        "\n}\n"
        "# 只增合并: 与存量渠道同名键(如 arxiv)并入, 不覆盖不删除\n"
        "for _k in list(SURVEY_ALIASES):\n"
        "    _cur = CHANNEL_ALIASES.setdefault(_k, [])\n"
        "    _cur.extend(_a for _a in SURVEY_ALIASES[_k] if _a not in _cur)\n"
    )
    text = CM.read_text(encoding="utf-8")
    anchor = "#: cross:*/rss:* 基名 → 渠道"
    assert anchor in text and "SURVEY_ALIASES" not in text, "锚点异常/重复插入"
    text = text.replace(anchor, block + "\n" + anchor, 1)
    CM.write_text(text, encoding="utf-8", newline="\n")
    print("channel_matrix.py 插入 SURVEY_ALIASES:", len(lines), "条")

    # ---- ② api_replica_bridge.py: CLI_ENGINES 增 15 腿 + HTTP_ENGINES 表 ----
    atext = ARB.read_text(encoding="utf-8")
    assert "HTTP_ENGINES" not in atext, "重复插入"
    cli_anchor = (
        '        "python":  REPO / "vendors" / "last30days-skill" / ".venv"\n'
        '                  / "Scripts" / "python.exe",\n'
        "    },\n}"
    )
    assert cli_anchor in atext, "CLI_ENGINES 锚点未找到"
    leg_lines = []
    for name, eng in sorted(LEG_OVERRIDES.items(), key=lambda kv: kv[1]):
        leg_lines.append(
            f'    "{eng}": {{                                   # 1025 纳管令·{name[:30]}\n'
            f'        "script": REPO / "reforge_factory" / "legs" / "{eng}_leg.py",\n'
            '        "python":  Path("py"),\n'
            "    },")
    new_cli = (
        '        "python":  REPO / "vendors" / "last30days-skill" / ".venv"\n'
        '                  / "Scripts" / "python.exe",\n'
        "    },\n"
        + "\n".join(leg_lines) + "\n}"
    )
    atext = atext.replace(cli_anchor, new_cli, 1)

    # HTTP_ENGINES: A级 HTTP/CLI 直调登记
    inc = re.compile(r"免登录|免key|no-?key|匿名|官方JSON|REST|SDMX|SPARQL|RSS|直下|直链|直取")
    exc = re.compile(r"MCP|浏览器|闭源|本地CLI|登录态|自托管|桥接|本地在盘|源码镜像|"
                     r"playwright|客户端逆向|JS挑战|滑块|需SESSDATA|需key\(")
    hrows, skipped_kind = [], Counter()
    for e in ents:
        if e.get("tier") != "A":
            continue
        acc = str(e.get("access", ""))
        if not inc.search(acc) or exc.search(acc):
            skipped_kind[acc[:24]] += 1
            continue
        url = str(e.get("entry", ""))
        if not url.startswith("http"):
            url = "tool://" + slugify(str(e.get("name", "x")))     # 非URL条目占位
        kind = ("dataset" if re.search(r"数据集|下载|直下|csv|PDF", acc)
                else "python_lib" if "python库" in acc else "http_api")
        hrows.append((slugify(str(e.get("name", ""))) or "x", e, url, kind))
    usedh: set = set()
    hlines = []
    for sid0, e, url, kind in hrows:
        sid = LEG_OVERRIDES.get(str(e.get("name", "")), sid0)
        while sid in usedh:
            sid += "_2"
        usedh.add(sid)
        tags = "/".join(e.get("tags", []))
        nm = str(e.get("name", "")).replace('"', "'")[:60]
        acc = str(e.get("access", "")).replace('"', "'")[:48]
        hlines.append(
            f'    "{sid}": {{"kind": "{kind}", "url": "{url}",\n'
            f'              "access": "{acc}", "tags": "{tags}", "name": "{nm}"}},')
    http_block = (
        "\n#: 1025 渠道普查纳管令: A级 HTTP/CLI 直调引擎登记表 — 注册表A级中免登录API/\n"
        "#: 免key HTTP/数据集直下类 (MCP服务器/浏览器类不在此表, 全量见 MASTER_REGISTRY)。\n"
        "#: 登记=可寻址(引擎名→端点+访问面), 实调走 legs/<engine>_leg.py 轻量采集腿\n"
        "#: (已建15腿, 见 channels_survey_2026/集成台账.md); 引擎名与 channel_matrix\n"
        "#: SURVEY_ALIASES 渠道 id 同名 (入池 engine 标签直落渠道)。\n"
        "HTTP_ENGINES: dict[str, dict[str, str]] = {\n"
        + "\n".join(hlines) +
        "\n}\n"
    )
    h_anchor = "_mod_cache: dict[str, object] = {}"
    assert h_anchor in atext
    atext = atext.replace(h_anchor, http_block + "\n" + h_anchor, 1)
    ARB.write_text(atext, encoding="utf-8", newline="\n")
    print("api_replica_bridge.py: CLI_ENGINES +", len(leg_lines), "腿;",
          "HTTP_ENGINES", len(hlines), "条 (A级排除", sum(skipped_kind.values()), "条)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
