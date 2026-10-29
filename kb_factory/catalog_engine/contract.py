# -*- coding: utf-8 -*-
"""声明式可复现契约（P1 #9；调研 Top 模式 #9：rml-core + pygraft 的 mappings 描述文件）。

每次构建产出一份 MappingContract：同文档（input_hash）+ 同映射（rules）= 同 KB（schema_hash），
verify_reproducibility 用契约规则重放蓝图内每一件文件的分类决策，可离线验证。

复用与依赖：规则反向提取自 document_engine 的模式表（首中语义）；
保存格式=JSON 语法 + .yaml 后缀（JSON 是合法 YAML 1.2 子集，零第三方依赖）。

确定性纪律（沿 catalog_engine 宪法）：input_hash/schema_hash/rules 只由输入决定，
同输入必同契约（除 created_at 外逐字段相等）；created_at 是唯一非确定字段
（ISO 时间戳，供审计留痕，不参与任何哈希与验证）。
"""
from __future__ import annotations

import hashlib
import json
import re
from dataclasses import asdict, dataclass, fields
from datetime import datetime, timezone
from pathlib import Path
from typing import Optional

from .blueprint import canonical_json
from .document_engine import DocFile, _DOC_TYPE_PATTERNS
from .metadata import PERM_BY_BADGE

CONTRACT_ENGINE_VERSION = "kb-contract/1.0.0"

DEFAULT_TYPE = "其他"  # 引擎 classify_doc 的兜底分类


@dataclass
class MappingContract:
    """声明式映射契约：同 input_hash 文档 + 同 rules 映射 = 同 schema_hash KB。"""
    engine_version: str
    input_hash: str        # 输入文档列表的 sha256（仅输入字段，不含派生 doc_type）
    schema_hash: str       # 蓝图结构骨架（层/组/编号/路径）的 sha256
    rules: list[dict]      # 分类规则 [{"condition","action","target","hits"}]
    created_at: str        # ISO 时间戳（审计用，唯一非确定字段）


# ── 哈希 ───────────────────────────────────────────────────────────────────

# 输入字段闭集：只哈希输入，不含 doc_type（那是引擎派生输出，构建时被回写）
DOC_INPUT_FIELDS = ("title", "source", "fmt", "pages", "badge", "perm", "url", "size_kb")


def _sha256(s: str) -> str:
    return hashlib.sha256(s.encode("utf-8")).hexdigest()


def _doc_field(d, key):
    return d.get(key) if isinstance(d, dict) else getattr(d, key, None)


def compute_input_hash(documents: list) -> str:
    """输入文档列表的 sha256（canonical JSON，键序无关，列表序保留）。"""
    payload = [{k: _doc_field(d, k) for k in DOC_INPUT_FIELDS} for d in documents]
    return _sha256(canonical_json(payload))


def blueprint_skeleton(bp: dict) -> dict:
    """蓝图结构骨架：目录树形状（层/组/编号/路径/条目数），剥离文件内容与 UI 态。"""
    tree = bp.get("tree", {})
    l1 = []
    for n in tree.get("l1", []):
        l2 = [{k: v for k, v in g.items() if k not in ("files", "open")}
              for g in n.get("l2", [])]
        l1.append({k: v for k, v in n.items() if k not in ("l2", "open")} | {"l2": l2})
    return {"mode": tree.get("mode"), "root": tree.get("root"), "l1": l1}


def compute_schema_hash(bp: dict) -> str:
    """schema 的 sha256：同一骨架=同一 schema，蓝图结构一改即失配。"""
    return _sha256(canonical_json(blueprint_skeleton(bp)))


# ── 规则（文件名空间） ──────────────────────────────────────────────────────

# 蓝图留痕的是 sanitize_filename 后的文件名（空白与 / 等已删），故锚定式编号
# 标准的两条正则需镜像改写（GB/T→GBT、补 DLT），其余模式与引擎逐字相同。
# 引擎模式表新增条目会自动跟进（按序复制），仅含 "/" 的新模式需在此补镜像。
_NAME_SPACE_OVERRIDES = {
    0: r"^.{0,5}(GB|GBT|GBZ)\s*\d+",                                  # 国家标准
    1: r"^(SL|DL|JGJ|JT|TB|YB|QB|SY|SH|HG|CJJ|CJ|WS|YY|NB|DL/T|DLT)\s*\d+",  # 行业标准
}


def _name_space_patterns() -> list:
    """[(文件名空间正则, 分类标签)]，与引擎 _DOC_TYPE_PATTERNS 逐位对齐。"""
    return [(_NAME_SPACE_OVERRIDES.get(i, p), label)
            for i, (p, label) in enumerate(_DOC_TYPE_PATTERNS)]


def _fired_pattern_index(title: str) -> Optional[int]:
    """标题空间：引擎首中模式的下标（None=落到兜底「其他」）。"""
    for i, (pattern, _label) in enumerate(_DOC_TYPE_PATTERNS):
        if re.search(pattern, title):
            return i
    return None


def extract_rules(bp: dict, documents: list) -> list[dict]:
    """从蓝图反向提取分类规则：哪些条件导致了哪些分类决策。

    assign_to  规则=引擎模式表中真正击中过 ≥1 件文档的条目（按引擎优先序，
               条件改写为文件名空间正则，验证只依赖蓝图留痕的文件名，契约自足；
               未击中的模式剔除后不影响本批分类——首中语义下，任何被后位模式
               接住的文档都不可能命中过被剔除的模式，子集重放封闭）。
    place_under规则=蓝图实际出现的超越层及其吸收的 doc_type（层序=蓝图层序）。
    hits 记录该规则解释的决策数（决策证据，审计用）。
    """
    fired: dict = {}
    for d in documents:
        title = _doc_field(d, "title") or ""
        idx = _fired_pattern_index(title)
        label = _DOC_TYPE_PATTERNS[idx][1] if idx is not None else DEFAULT_TYPE
        dt = _doc_field(d, "doc_type")
        if dt != label:
            raise ValueError(
                f"文档分类与引擎规则不符（契约拒发）: title={title!r} "
                f"doc_type={dt!r} 引擎判定={label!r}")
        fired[idx] = fired.get(idx, 0) + 1

    rules = []
    nsp = _name_space_patterns()
    for idx in sorted(k for k in fired if k is not None):
        rx, label = nsp[idx]
        rules.append({"condition": f"title matches {rx}", "action": "assign_to",
                      "target": label, "hits": fired[idx]})
    if None in fired:
        rules.append({"condition": "default", "action": "assign_to",
                      "target": DEFAULT_TYPE, "hits": fired[None]})

    for l1 in bp.get("tree", {}).get("l1", []):
        types = [g.get("name") for g in l1.get("l2", [])]
        rules.append({
            "condition": "doc_type in " + json.dumps(types, ensure_ascii=False),
            "action": "place_under", "target": l1.get("name"),
            "hits": sum(g.get("file_count", len(g.get("files", [])))
                        for g in l1.get("l2", [])),
        })
    return rules


def _apply_assign_rules(name: str, assign_rules: list[dict]) -> Optional[str]:
    """按序求值 assign_to 规则（首中语义，与引擎一致）；无命中返回 None。"""
    prefix = "title matches "
    for r in assign_rules:
        cond = r.get("condition", "")
        if cond == "default":
            return r.get("target")
        if cond.startswith(prefix) and re.search(cond[len(prefix):], name):
            return r.get("target")
    return None


def _strip_ext(name: str, fmt: Optional[str]) -> str:
    """文件名去掉扩展名，还原可分类的标题态（sanitize 不可逆，只做最小还原）。"""
    if fmt and name.endswith("." + fmt):
        return name[: -(len(fmt) + 1)]
    return name


# ── 契约生成/保存/加载/验证 ─────────────────────────────────────────────────

def generate_contract(bp: dict, documents: list) -> MappingContract:
    """生成契约；发出前先自检——规则重放必须复现蓝图，否则拒发（ValueError）。"""
    contract = MappingContract(
        engine_version=bp.get("provenance", {}).get("engine") or CONTRACT_ENGINE_VERSION,
        input_hash=compute_input_hash(documents),
        schema_hash=compute_schema_hash(bp),
        rules=extract_rules(bp, documents),
        created_at=datetime.now(timezone.utc).isoformat(timespec="seconds"),
    )
    result = verify_reproducibility(bp, contract)
    if not result["identical"]:
        raise ValueError(f"契约无法复现蓝图（拒发）: {result['diff_details'][:3]}")
    return contract


def save_contract(contract: MappingContract, path: str) -> str:
    """YAML 兼容保存：JSON 语法写 .yaml 后缀（合法 YAML 1.2，零依赖可读回）。"""
    p = Path(path)
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps(asdict(contract), ensure_ascii=False, indent=2),
                 encoding="utf-8")
    return str(p)


def load_contract(path: str) -> MappingContract:
    data = json.loads(Path(path).read_text(encoding="utf-8"))
    known = {f.name for f in fields(MappingContract)}
    return MappingContract(**{k: v for k, v in data.items() if k in known})


def verify_reproducibility(bp: dict, contract: MappingContract) -> dict:
    """用契约规则重新分类蓝图内每件文档，对比原落位是否一致。

    重放在文件名空间进行（蓝图自足，无需原始 DocFile）：对每件文件
    依 assign_to 规则首中定类、place_under 规则定层，与蓝图实际
    （L1 层/L2 分组）逐一比对；另核 schema_hash 是否仍钉住同一骨架。
    """
    assign_rules = [r for r in contract.rules if r.get("action") == "assign_to"]
    place_rules = [r for r in contract.rules if r.get("action") == "place_under"]

    def layer_of(dtype: Optional[str]) -> Optional[str]:
        if dtype is None:
            return None
        for r in place_rules:
            cond = r.get("condition", "")
            if not cond.startswith("doc_type in "):
                continue
            try:
                types = json.loads(cond[len("doc_type in "):])
            except json.JSONDecodeError:
                continue
            if dtype in types:
                return r.get("target")
        return None

    details = []
    got_hash = compute_schema_hash(bp)
    if got_hash != contract.schema_hash:
        details.append({"kind": "schema_hash_mismatch", "file": None,
                        "expected": contract.schema_hash, "got": got_hash})

    for l1 in bp.get("tree", {}).get("l1", []):
        for l2 in l1.get("l2", []):
            for f in l2.get("files", []):
                name = _strip_ext(f.get("name", ""), f.get("fmt"))
                got_type = _apply_assign_rules(name, assign_rules)
                got_layer = layer_of(got_type)
                if got_type != l2.get("name") or got_layer != l1.get("name"):
                    details.append({
                        "kind": "misplaced", "file": f.get("name"),
                        "expected": f"{l1.get('name')}/{l2.get('name')}",
                        "got": f"{got_layer}/{got_type}",
                    })
    return {"identical": not details, "diff_count": len(details),
            "diff_details": details}


# ── 合成领域（回归测试用，不烧真实 API） ────────────────────────────────────

# 13 类模板轮转：法规/国标/行标/国际标准/规范/工具书/案例/教材/范本/其他全覆盖。
# 纯算术确定性（无随机源，沿 catalog_engine 宪法）：同 name+同 n_docs 必产同列表。
_SYNTH_TEMPLATES = ("gbt", "gb", "sl", "dlt", "iso", "law", "reg", "std",
                    "book", "case", "edu", "tpl", "misc")
_FMT_CYCLE = ("pdf", "docx", "xlsx", "md")
_BADGE_CYCLE = ("green_free", "wenku_vip", "gb_free", "ima_public", "self_owned")
_SOURCE_CYCLE = ("wenku", "gb", "ima")


def generate_synthetic_domain(name: str, n_docs: int = 50) -> list:
    """生成合成领域的模拟 DocFile（多类型，供契约回归，零真实 API）。"""
    docs = []
    for i in range(n_docs):
        kind = _SYNTH_TEMPLATES[i % len(_SYNTH_TEMPLATES)]
        n1 = 100 + i * 7
        if kind == "gbt":
            title = f"GB/T {n1}-{2000 + i % 25} {name}总承包项目管理规范"
        elif kind == "gb":
            title = f"GB {50000 + i} {name}工程量清单计价标准"
        elif kind == "sl":
            title = f"SL {200 + i} {name}工程等级划分及洪水标准"
        elif kind == "dlt":
            title = f"DL/T {300 + i} {name}工程施工组织设计导则"
        elif kind == "iso":
            title = f"ISO {9000 + i} {name}质量管理体系要求"
        elif kind == "law":
            title = f"《中华人民共和国{name}法》"
        elif kind == "reg":
            title = f"《{name}建设质量管理条例》"
        elif kind == "std":
            title = f"{name}施工质量验收统一标准"
        elif kind == "book":
            title = f"{name}工程实务全书 第{i + 1}卷"
        elif kind == "case":
            title = f"{name}EPC总承包项目案例分析"
        elif kind == "edu":
            title = f"{name}施工安全培训教程"
        elif kind == "tpl":
            title = f"{name}EPC合同范本"
        else:
            title = f"关于成立{name}联合体施工协调机制的通知"
        badge = _BADGE_CYCLE[i % len(_BADGE_CYCLE)]
        docs.append(_synth_doc(title, i, badge))
    return docs


def _synth_doc(title: str, i: int, badge: str) -> DocFile:
    return DocFile(
        title=title,
        source=_SOURCE_CYCLE[i % len(_SOURCE_CYCLE)],
        fmt=_FMT_CYCLE[i % len(_FMT_CYCLE)],
        pages=40 + i * 3,
        badge=badge,
        perm=PERM_BY_BADGE.get(badge, "green"),
        size_kb=300 + i * 17,
    )
