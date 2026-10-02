# -*- coding: utf-8 -*-
"""EPC50 生产环节衔接器 — 三门终判全过自动奠基成稿 (0926 用户令).

用户令: 「这次调研收官后，请进入下一步的研究报告生产环节」.
三门 (成稿启动裁决, 用户 0924 定):
  门1 弹药: 增量有效字数 ≥1000万 (epc50_gate.py 判定, 含反编造密度门);
  门2 一手: PRIMARY 构成比 >50% (gate 报告 composition);
  门3 额度: 军团今日额度打满 (fill 收官 待派0=1 / 军团额度尽; 登录墙不算).

链路: harvest_after_quota.done (收割落池) → 本器轮询三门 → 全过即:
  ① 建 03 CC报告初步框架/ 工作区 + 写成稿启动指令 (引用需求规格+华昕
     成熟模板+弹药水位账本); ② 落 KICKOFF 旗标; ③ 企微里程碑通知.
幂等: KICKOFF 旗标在即退出. 任一门未过 → 600s 后重判 (登录墙冷却期
军团会自动重试, 不人工干预).
"""
import json
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).parent
PY = sys.executable
BATTLE = Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics"
              r"\《中石化南京工程有限公司怎么干EPC总承包？》")
GATE_REPORT = BATTLE / "_pipeline" / "epc50_gate_report.json"
FRAME_DIR = BATTLE / "03 CC报告初步框架"
HARVEST_DONE = ROOT / "harvest_sessions" / "HARVEST_AFTER_QUOTA.done"
KICKOFF_FLAG = FRAME_DIR / "PRODUCTION_KICKED_OFF.flag"
KICKOFF_DOC = FRAME_DIR / "成稿启动指令.md"
# fill 收官行落点两处: 守卫拉起的 fill → Win python 的 /tmp = E:\tmp;
# 手动 nohup fill → data/fill_corps_out.log. 两处都扫.
FILL_LOGS = (Path(r"E:\tmp\epc50_corps_fill_guard.log"),
             ROOT / "data" / "fill_corps_out.log")
WECOM = Path(r"E:\AI-Station\tools\notify_wecom.py")
POLL_S = 600


def log(msg: str) -> None:
    print(f"[{time.strftime('%m-%d %H:%M:%S')}] {msg}", flush=True)


def gate3_quota_maxed() -> bool:
    """门3: 今日 fill 收官行含 待派0=1 (含军团额度尽变体); 登录墙不算."""
    today = time.strftime("%Y-%m-%d")
    for p in FILL_LOGS:
        try:
            tail = p.read_text(encoding="utf-8",
                               errors="replace").splitlines()[-60:]
        except OSError:
            continue
        for ln in tail:
            if "待派0=1" in ln and today in ln:
                return True
    return False


def refresh_gate() -> dict:
    """重跑弹药门 (收割新落盘件入账) → 回报告 dict."""
    subprocess.run([PY, str(ROOT / "epc50_gate.py")], cwd=str(ROOT),
                   capture_output=True, timeout=1800)
    return json.loads(GATE_REPORT.read_text(encoding="utf-8"))


def write_kickoff_doc(g: dict, primary_pct: float) -> None:
    FRAME_DIR.mkdir(parents=True, exist_ok=True)
    mc = g["manus_validity"]
    doc = f"""# EPC50 成稿启动指令 (三门终判自动生成 {time.strftime('%Y-%m-%d %H:%M')})

## 三门终判账

| 门 | 判据 | 实测 | 裁决 |
|---|---|---|---|
| 门1 弹药 | 增量有效字数 ≥1000万 (judge 判定才计数) | {g['total_chars']:,} 字 ({g['ratio']*100:.1f}%) | PASS |
| 门2 一手 | PRIMARY 构成比 >50% | {primary_pct:.1f}% | PASS |
| 门3 额度 | 军团今日额度打满 (待派0=1/军团额度尽) | fill 收官行实证 | PASS |

反编造门: 低引用 Manus 件 {len(mc['low_citation_files'])} 个 / {mc['excluded_chars']:,} 字已剔除不计弹药。

## 生产环节第一步: 报告框架

1. **规格**: 逐条执行 `00 研究报告需求/研究报告需求.txt` (≥10万字/麦肯锡逻辑/
   ≥10个典型EPC项目带可核验来源/商业主线四问每章必挂/盲评弱维度定向补强/
   无AI味/出版级排版)。
2. **成熟模板**: 参照华昕 `03 CC报告初步框架/框架v1_生成指令.md` 三级图纸
   (L1 类型学目录 → L2 模型组合拳 → L3 写作六律) + S0 价值锚定。
3. **弹药池水位**: 见 `_pipeline/epc50_gate_report.json` by_channel 账本
   (ima 知识库为主力, Manus 军团/秘塔/微信读书为辅)。
4. **融合承诺 (插件融合报告)**: 三态标注 fact·estimate·inference 全程贯标;
   下载原文才算数; 白名单三判据; Step 9 refine 轮; 五处数字一致性检查。
5. **框架产出后**: 框架v1.md + value_anchor.json 落本目录, 后续 06 初稿 →
   07 终稿 → 08 质量飞轮 按华昕全链推进。
"""
    KICKOFF_DOC.write_text(doc, encoding="utf-8")


def notify_wecom(g: dict, primary_pct: float) -> None:
    if not WECOM.is_file():
        return
    body = (f"EPC50 中石化南京工程 三门终判全过\n"
            f"弹药 {g['total_chars']/10000:.0f}万字 ({g['ratio']*100:.0f}%) | "
            f"一手占比 {primary_pct:.0f}% | 军团额度打满\n"
            f"研究报告生产环节已自动奠基 (03 框架工作区+成稿启动指令就位)")
    try:
        subprocess.run([PY, str(WECOM), "EPC50 成稿启动", body],
                       capture_output=True, timeout=60,
                       creationflags=0x08000000)
    except Exception:
        pass


def main() -> int:
    if KICKOFF_FLAG.is_file():
        log("KICKOFF 旗标在, 无事可做")
        return 0
    log("生产衔接器上岗: 等 收割落池 → 三门终判")
    while True:
        if KICKOFF_FLAG.is_file():
            return 0
        if not HARVEST_DONE.is_file():
            log("等收割落池 (harvest_after_quota)")
            time.sleep(POLL_S)
            continue
        g = refresh_gate()
        primary_pct = 100 * g["composition"]["primary_chars"] / max(
            1, g["total_chars"])
        g1 = bool(g["passed"])
        g2 = primary_pct > 50.0
        g3 = gate3_quota_maxed()
        log(f"三门: 弹药={'过' if g1 else '欠'}({g['total_chars']:,}) "
            f"一手={'过' if g2 else '欠'}({primary_pct:.1f}%) "
            f"额度={'满' if g3 else '未满'}")
        if g1 and g2 and g3:
            write_kickoff_doc(g, primary_pct)
            KICKOFF_FLAG.write_text(time.strftime("%Y-%m-%d %H:%M:%S"),
                                    encoding="utf-8")
            notify_wecom(g, primary_pct)
            log("三门全过 → 生产环节奠基完成 (03 工作区+启动指令+旗标+企微)")
            return 0
        time.sleep(POLL_S)


if __name__ == "__main__":
    sys.exit(main())
