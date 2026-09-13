"""M6.9 干净环境验收：一条命令跑通 M1-M6 全链（全假件，零网络零密钥）。

用法（干净机器/新用户目录）：
    python scripts/acceptance_e2e.py
任何一环失败即非零退出。产出的都是临时目录数据，验收完即焚。
"""
from __future__ import annotations

import subprocess
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

from paistation.dist.tiers import detect                # noqa: E402
from paistation.dist.wizard import FirstRunWizard        # noqa: E402
from paistation.execute.agent import AgentRunner         # noqa: E402
from paistation.execute.service import ExecutionService  # noqa: E402
from paistation.proactive.confirm import (               # noqa: E402
    ConfirmCenter, RecordingNotifier)
from paistation.proactive.taskcards import extract_task_cards  # noqa: E402
from paistation.skills.effects import EffectTracker      # noqa: E402
from paistation.skills.forge import SkillForge           # noqa: E402
from paistation.skills.market import SkillMarket, write_meta, read_meta  # noqa: E402,E501
from paistation.skills.sync import BackupSync            # noqa: E402

VOICE = {"ts": "2026-09-13T09:10:00", "type": "voice.transcript",
         "source": "mic",
         "text": "请帮我调研一下腾讯办公助手的定价策略，明天上午要结果。",
         "speaker": "user", "evidence": {"segment_ms": [0, 3200],
                                         "audio_hash": "ab12cd"}}


class FakeGateway:
    def chat(self, messages, **kw):
        return ("# 定价调研报告\n\n企业版 680 元/账号/年，谈判空间在框架折扣。",
                "fake")


def stage(name: str, fn, results: list) -> None:
    try:
        detail = fn() or ""
        results.append((name, True, str(detail)))
        print(f"[accept] ✓ {name} {detail}")
    except Exception as exc:  # noqa: BLE001 - 验收要的是逐环证据
        results.append((name, False, str(exc)[:200]))
        print(f"[accept] ✗ {name} {exc}")


def main() -> int:
    results: list[tuple[str, bool, str]] = []
    with tempfile.TemporaryDirectory(prefix="pai-accept-") as tmp:
        root = Path(tmp)

        # M6.1 硬件分级
        def s_tier():
            tier, settings = detect()
            return f"tier={tier} embedder={settings['embedder']}"
        stage("M6.1 硬件分级", s_tier, results)

        # M6.2 首启向导
        def s_wizard():
            out = FirstRunWizard(data_dir=root).run(answers={})
            assert out["done"] and out["scopes"]
            return f"scopes={len(out['scopes'])}"
        stage("M6.2 首启向导", s_wizard, results)

        # M3→M4 感知→卡→确认→执行→交付
        def s_chain():
            center = ConfirmCenter(notifier=RecordingNotifier(),
                                   store_dir=root / "tasks")
            card = extract_task_cards([VOICE])[0]
            center.route(card)
            center.confirm_by_appearance([card.card_id])
            runner = AgentRunner(gateway=FakeGateway(),
                                 runs_dir=root / "runs")
            svc = ExecutionService(store=center._store, runner=runner,
                                   deliverer_root=root / "data")
            svc.tick(paused=False)
            got = center.get(card.card_id)
            assert got.status == "done", got.status
            assert (root / "data" / "08 成果").is_dir()
            return f"card={card.card_id} 已交付"
        stage("M3-M4 任务执行交付全链", s_chain, results)

        # M6.4/6.5 技能锻造+效果回滚
        def s_skills():
            forge = SkillForge(data_dir=root / "data",
                               repo_dir=root / "skills")
            for i in range(3):
                forge.record_case({"ts": f"2026-09-13T1{i}:00:00",
                                   "task_title": f"归档合同{i}",
                                   "skill": None, "approach": "手工",
                                   "outcome": "success",
                                   "duration_s": 60, "artifacts": []})
            cand = forge.propose()[0]
            forge.promote(cand, approved=True)
            forge.promote(dict(cand, draft=cand["draft"] + "\n## v2\n"),
                          approved=True)
            tracker = EffectTracker(data_dir=root / "data", repo=forge.repo)
            tracker.set_baseline(cand["name"], 0.9)
            for i in range(5):
                tracker.record(cand["name"], False, f"任务{i}")
            assert tracker.suggest_rollbacks(), "劣化未出回滚建议"
            assert tracker.rollback(cand["name"])
            return f"skill={cand['name']} 升格两版+回滚成功"
        stage("M6.4/6.5 技能锻造与回滚", s_skills, results)

        # M6.6 GitHub 备份（本地 bare 当远端）
        def s_sync():
            remote = root / "backup.git"
            remote.mkdir()
            subprocess.run(["git", "init", "-q", "--bare", str(remote)],
                           check=True, capture_output=True)
            sync = BackupSync(data_dir=root / "data",
                              repo_dir=root / "skills")
            sync.configure(remote=str(remote), branch="main")
            out = sync.push()
            assert out["pushed"], out
            return "pushed→本地 bare"
        stage("M6.6 技能库备份推送", s_sync, results)

        # M6.8 市场元数据导出导入
        def s_market():
            repo = root / "skills"
            name_dir = next(d for d in repo.iterdir()
                            if d.is_dir() and (d / "SKILL.md").is_file())
            market = SkillMarket(base="https://example.invalid/market")
            write_meta(name_dir, {"author": "验收", "version": "1.0.0",
                                  "price": 0})
            zpath = market.export(str(name_dir), str(root / "out"))
            assert Path(zpath).is_file()
            dest = market.import_from(str(name_dir), str(root / "install"))
            assert read_meta(dest)["author"] == "验收"
            return Path(zpath).name
        stage("M6.8 技能包导出导入", s_market, results)

    failed = [r for r in results if not r[1]]
    print(f"\n[accept] {len(results) - len(failed)}/{len(results)} 环节通过"
          + ("，验收失败" if failed else "，干净环境验收通过 ✅"))
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
