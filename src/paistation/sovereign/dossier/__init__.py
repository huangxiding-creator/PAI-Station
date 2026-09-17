# -*- coding: utf-8 -*-
"""P0 主权卷宗（Sovereign Dossier v0）——DISRUPTION_PLAN 假设②落地。

三源统一 OKF 目录形态 + 一条命令导出人可读包 + git 独立版本化。
"""
from .build import build_dossier, build_profile, build_memory, build_evals, build_evidence
from .entries import OkfEntry, parse_entry, read_entry, write_entry, iter_entries
from .exporter import export_dossier
from .repo import init_repo, commit_snapshot, repo_status

__all__ = [
    "OkfEntry", "parse_entry", "read_entry", "write_entry", "iter_entries",
    "build_dossier", "build_profile", "build_memory", "build_evals",
    "build_evidence", "export_dossier",
    "init_repo", "commit_snapshot", "repo_status",
]
