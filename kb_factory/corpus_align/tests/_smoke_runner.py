# -*- coding: utf-8 -*-
"""smoke 子进程真跑器（test_corpus_align 专用，非测试件）。

为什么要子进程：HF 网络开关（HF_HUB_OFFLINE / HF_ENDPOINT）在 huggingface_hub
import 时定格，进程内改 env 不生效——三档环境（默认/离线缓存/镜像）必须各自
干净进程跑，如实还原部署侧真实形态。输出行格式：
    KBA_SMOKE_RESULT <json>（ensure_ascii 传输，父进程 loads 回 Unicode）
"""
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))  # kb_factory/ 入 sys.path

from corpus_align import align_corpus  # noqa: E402
from catalog_engine import build_blueprint  # noqa: E402


def build_docs():
    """63 件三主题中文小语料（合同编/劳动争议/公司治理，词面强可分）。"""
    docs = []
    for i in range(21):
        docs.append({"title": f"民法典合同编通则司法解释解读{i}",
                     "text": f"民法典 合同编 合同效力 违约责任 缔约过失 合同解除 "
                             f"司法解释 第{i}讲 实务要点 裁判规则"})
        docs.append({"title": f"劳动争议仲裁案例汇编{i}",
                     "text": f"劳动争议 劳动仲裁 工伤认定 经济补偿金 加班费 违法解除 "
                             f"劳动合同 案例分析 第{i}辑 裁判要旨"})
        docs.append({"title": f"公司治理与股权架构实务{i}",
                     "text": f"公司治理 股权架构 董事会决议 股东会 公司章程 董事忠实义务 "
                             f"治理实务 第{i}篇 尽职调查 股权转让"})
    return docs


def main():
    bp = build_blueprint({"domain": "律师事务所知识库",
                          "keywords": ["民法典", "诉讼", "合规", "尽职调查", "劳动争议"],
                          "intent": "诉讼与合规", "size_hint": "small"})
    res = align_corpus(build_docs(), bp, match_threshold=0.40)
    json.dumps(res, ensure_ascii=False)  # 全结果 JSON 可序列化门（cloudfn/落盘传输面）
    print("KBA_SMOKE_RESULT " + json.dumps(res, ensure_ascii=True))


if __name__ == "__main__":
    main()
