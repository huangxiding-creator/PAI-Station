# -*- coding: utf-8 -*-
"""1025 渠道普查纳管令 · 第二轮登记 (调和终态恢复+增量)。

背景: 第一轮登记(21:55, A+B 238条+CLI15腿+HTTP表88条)于 22:16 被并行会话回滚
(两文件恢复 pre-survey1025.bak; 15腿件/http_api_leg_core 幸存, 见时间戳)。本脚本在
终局调和后的 MASTER_REGISTRY.json (A195/B234, tier_basis 逐条在案) 上一次性重建:
  ① channel_matrix.py SURVEY_ALIASES = 全量 A+B 429 条 (含原238身份的等价恢复,
     其中22条原svc聚合条目因重建塌缩并入既有键, 塌缩键单列一id)
  ② api_replica_bridge.py CLI_ENGINES 15腿 + HTTP_ENGINES A级直调表
规则与第一轮 _integrate_1025.py 完全一致 (id=slug+停用词防护, LEG_OVERRIDES,
别名>=4字符+停用词过滤; HTTP inc/exc 过滤器原样)。只增不删, .bak 已在。
"""
from __future__ import annotations
import json, re, sys
from collections import Counter
from pathlib import Path
from urllib.parse import urlparse

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = Path(__file__).resolve().parent
REPO = HERE.parents[1]
REG = HERE / "MASTER_REGISTRY.json"
CM = REPO / "reforge_factory" / "completeness" / "channel_matrix.py"
ARB = REPO / "reforge_factory" / "legs" / "api_replica_bridge.py"

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
        if len(sid) < 4 or sid in STOP:
            m = re.match(r"^(?:gh|gl):([^/]+)/(.+)$", dk)
            host = ""
            url = str(e.get("entry", ""))
            if url.startswith("http"):
                h = urlparse(url).netloc.lower()
                host = h[4:] if h.startswith("www.") else h
            elif re.match(r"^[A-Za-z0-9.\-]+\.[A-Za-z]{2,}", url.split("/")[0].split()[0]):
                host = url.split("/")[0].split()[0].lower()   # 无scheme域名形 (baidu.com / sogou.com ...)
            if m:
                sid = slugify(m.group(1)) + "_" + slugify(m.group(2))
            elif slugify(dk.split(":", 1)[-1]):
                sid = slugify(dk.split(":", 1)[-1])
            elif slugify(host):
                sid = slugify(host)          # 中文name:键条目降级取域名 (百度/sogou等)
            else:
                sid = "survey_" + slugify(name)
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
    print("调和终态 A+B:", len(ab), Counter(e["tier"] for e in ab))
    used: set = set()
    rows = []
    for e in sorted(ab, key=lambda x: (x.get("tier", ""), str(x.get("name", "")))):
        sid = entry_id(e, used)
        rows.append((e, sid, aliases_for(e, sid)))
    print("登记条目:", len(rows), "唯一渠道id:", len({r[1] for r in rows}))
    sid_of = {id(e): sid for e, sid, _ in rows}          # 条目→渠道id (HTTP 同名用)

    # ---- ① channel_matrix.py: SURVEY_ALIASES 块 (只增; 已在则跳过=幂等) ----
    text = CM.read_text(encoding="utf-8")
    if "SURVEY_ALIASES" in text:
        print("channel_matrix.py: SURVEY_ALIASES 已在, 跳过插入 (幂等)")
    else:
        lines = []
        for e, sid, al in rows:
            tier = e.get("tier", "")
            tags = "/".join(e.get("tags", []))
            nm = str(e.get("name", "")).replace('"', "'")
            lines.append(f'    "{sid}": {json.dumps(al, ensure_ascii=False)},'
                         f'  # {tier}级·{tags}·{nm}')
        block = (
            "\n#: ---- 1025 渠道普查纳管令(第二轮·终局调和): MASTER_REGISTRY.json\n"
            "#: A+B级 429 条全量登记 (调和终态 by_tier_all A=195/B=234, tier_basis 逐条\n"
            "#: 在案; 第一轮 238 条登记 22:16 被回滚, 本轮含其等价恢复+新判增量)。\n"
            "#: .bak=completeness/channel_matrix.pre-survey1025.bak。\n"
            "#: id=注册表条目slug(停用词/短名防护; 已建腿15条用腿引擎名覆盖, 见\n"
            "#: channels_survey_2026/集成台账.md), 别名=slug/域名/gh全名(>=4字符+停用词\n"
            "#: 过滤, 防短别名误吞引擎标签)。只增不删: 并入存量渠道键时extend不去除原别名。\n"
            "#: 已知塌缩: 重建致17条原svc聚合条目并入dom:github.com键(单列id github_com,\n"
            "#: 原判A整体恢复), 拆分留主会话裁定。\n"
            "#: 登记≠接线: 新渠道进渠道册(named_channels)前不计入 C 轴分母, 建渠走 T-015 SOP。\n"
            "SURVEY_ALIASES: dict[str, list[str]] = {\n"
            + "\n".join(lines) +
            "\n}\n"
            "# 只增合并: 与存量渠道同名键(如 arxiv)并入, 不覆盖不删除\n"
            "for _k in list(SURVEY_ALIASES):\n"
            "    _cur = CHANNEL_ALIASES.setdefault(_k, [])\n"
            "    _cur.extend(_a for _a in SURVEY_ALIASES[_k] if _a not in _cur)\n"
        )
        anchor = "#: cross:*/rss:* 基名 → 渠道"
        assert anchor in text, "锚点异常"
        text = text.replace(anchor, block + "\n" + anchor, 1)
        CM.write_text(text, encoding="utf-8", newline="\n")
        print("channel_matrix.py 插入 SURVEY_ALIASES:", len(lines), "条")

    # ---- ② api_replica_bridge.py: CLI_ENGINES 15腿 + HTTP_ENGINES 表 ----
    atext = ARB.read_text(encoding="utf-8")
    assert "HTTP_ENGINES" not in atext, "重复插入"
    assert '"worldbank_projects": {' not in atext, "CLI腿已登记(与回滚事实矛盾)"
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

    inc = re.compile(r"免登录|免key|no-?key|匿名|官方JSON|REST|SDMX|SPARQL|RSS|直下|直链|直取")
    exc = re.compile(r"MCP|浏览器|闭源|本地CLI|登录态|自托管|桥接|本地在盘|源码镜像|"
                     r"playwright|客户端逆向|JS挑战|滑块|需SESSDATA|需key\(")
    hrows, skipped = [], Counter()
    for e in ents:
        if e.get("tier") != "A":
            continue
        acc = str(e.get("access", ""))
        if not inc.search(acc) or exc.search(acc):
            skipped[acc[:24]] += 1
            continue
        url = str(e.get("entry", ""))
        if not url.startswith("http"):
            url = "tool://" + (sid_of.get(id(e)) or "x")
        kind = ("dataset" if re.search(r"数据集|下载|直下|csv|PDF", acc)
                else "python_lib" if "python库" in acc else "http_api")
        # 引擎名= SURVEY 渠道 id 同名 (entry_id 产物, 中文空slug自动降级dedup_key, 防 x_2_2 垃圾id)
        hrows.append((sid_of.get(id(e)) or "x", e, url, kind))
    usedh: set = set()
    hlines = []
    for sid0, e, url, kind in hrows:
        sid = sid0
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
        "\n#: 1025 渠道普查纳管令(第二轮·终局调和): A级 HTTP/CLI 直调引擎登记表 —\n"
        "#: 调和终态 A=195 中免登录API/免key HTTP/数据集直下类 (MCP服务器/浏览器类/\n"
        "#: 自托管类不在此表, 全量见 MASTER_REGISTRY, 第一轮88条本轮等价重建+增量)。\n"
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
          "HTTP_ENGINES", len(hlines), "条 (A级排除", sum(skipped.values()), "条)")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
