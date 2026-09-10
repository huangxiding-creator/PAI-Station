"""工程研究报告生成器（M7.2 / PROPOSAL_M7 §4 深产品）。

与 FDE 共用重构引擎与编排内核（统一方案工厂），差异仅在覆盖线：
研究报告 schema = 议题定义 → 调研全景 → 逻辑重构(三层模型) → 经验地图
                  → 避坑清单 → 落地路径（AIResearch 七步工作流的产品化）。
深耕慢产：默认章数更多、语料上限更高。
"""

from paistation.foundry.fde import compose_plan
from paistation.foundry.reconstructor import Reconstructor

REPORT_COVERAGE = ("议题定义 → 调研全景 → 逻辑重构（三层思维模型）"
                   "→ 经验地图 → 避坑清单 → 落地路径")


def generate_report(engine: Reconstructor, theme: str, corpus: str, *,
                    n_chapters: int = 7, immune_rules: tuple | list = (),
                    checkpoint_path: str | None = None) -> dict:
    """深产品入口：研究报告覆盖线 + 更深骨架。"""
    return compose_plan(engine, theme, corpus, n_chapters=n_chapters,
                        coverage=REPORT_COVERAGE, immune_rules=immune_rules,
                        checkpoint_path=checkpoint_path)
