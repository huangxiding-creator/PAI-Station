"""Claude Code 会话库挖掘：全部项目的真人 prompt 流 → 思想原声语料。

会话库=用户几个月来对 Claude 说过的话（jsonl，type=user 且 content
list 带 text 项）——比任何文档都高频、都口语化的第一人称思维流。
产出 SELF_PROFILE/cc_sessions/prompt_stream.jsonl + PROMPT_STREAM.md
（时间轴热度/项目分布/关键词/观点句标记命中）。全流式，不整载。
"""
from __future__ import annotations

import json
import re
from collections import Counter
from pathlib import Path

PROJ_ROOT = Path(r"C:\Users\91216\.claude\projects")
OUT_DIR = Path(r"E:\AI-Station\SELF_PROFILE\cc_sessions")

SKIP_PREFIX = ("<task-notification", "<system-reminder", "<cross-session",
              "Caveat:", "[Request interrupted", "<local-command",
              "<command-name", "<bash-input", "<bash-stdout",
              # 压缩续接：系统注入的 summary 以 user 身份落库，非真人
              "This session is being continued")
# 观点标记复用（feishu_opinions 同族思想）
OPINION = re.compile(r"我认为|我觉得|依我看|在我看来|我的判断|我主张|"
                     r"本质上是|本质是|关键在于|核心问题是|底层逻辑|"
                     r"归根结底|说白了")
MIN_LEN = 8


def human_prompts(path: Path):
    """单会话文件 → [(ts, text)]。"""
    out = []
    try:
        with path.open(encoding="utf-8", errors="replace") as fh:
            for ln in fh:
                try:
                    e = json.loads(ln)
                except Exception:
                    continue
                if e.get("type") != "user" or e.get("isMeta"):
                    continue
                c = (e.get("message") or {}).get("content")
                texts: list[str] = []
                if isinstance(c, str):
                    texts = [c]
                elif isinstance(c, list):
                    texts = [it.get("text", "") for it in c
                             if isinstance(it, dict) and it.get("type") == "text"]
                for t in texts:
                    t = t.strip()
                    if len(t) < MIN_LEN or t.startswith(SKIP_PREFIX):
                        continue
                    out.append((e.get("timestamp", ""), t))
    except OSError:
        pass
    return out


def main() -> int:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    stream = OUT_DIR / "prompt_stream.jsonl"
    n_total = n_opinion = 0
    per_day: Counter = Counter()
    per_proj: Counter = Counter()
    kw: Counter = Counter()
    opinion_rows = []
    with stream.open("w", encoding="utf-8") as w:
        for proj_dir in sorted(PROJ_ROOT.iterdir()):
            if not proj_dir.is_dir():
                continue
            proj = proj_dir.name
            for f in sorted(proj_dir.glob("*.jsonl")):
                for ts, t in human_prompts(f):
                    day = ts[:10] if ts else "?"
                    row = {"project": proj, "session": f.stem,
                           "ts": ts, "text": t}
                    w.write(json.dumps(row, ensure_ascii=False) + "\n")
                    n_total += 1
                    per_day[day] += 1
                    per_proj[proj] += 1
                    if OPINION.search(t):
                        n_opinion += 1
                        opinion_rows.append((ts, t))
    # 关键词：jieba 惰性
    try:
        import jieba
        have_jieba = True
    except Exception:
        have_jieba = False
    if have_jieba:
        # \u53ea\u6536\u542b\u4e2d\u6587\u7684 token\u2014\u2014prompt \u5e38\u6574\u6bb5\u7c98\u8d34\u82f1\u6587\u62a5\u9519\uff0c\u7eaf\u82f1\u6587\u8bcd\u65e0\u753b\u50cf\u4ef7\u503c
        with stream.open(encoding="utf-8") as fh:
            for ln in fh:
                t = json.loads(ln)["text"]
                for tok in jieba.cut_for_search(t):
                    if re.search(r"[\u4e00-\u9fff]", tok):
                        kw[tok] += 1
    STOP = {"然后", "一个", "我们", "可以", "这个", "就是", "还是", "什么",
            "现在", "一下", "没有", "觉得", "这个", "这样", "自己", "继续",
            "时候", "可能", "直接", "先", "帮我", "谢谢", "好的", "问题"}
    top_kw = [(k, n) for k, n in kw.most_common(120) if k not in STOP][:60]

    lines = [
        "# Claude Code 会话库·真人 prompt 流（第一遍全量）",
        "",
        f"- 会话库：{PROJ_ROOT}（{len(per_proj)} 项目 / prompt {n_total:,} 条）",
        f"- 观点标记命中（我认为/本质是/关键在于…）：**{n_opinion:,}** 条",
        f"- 生成：{stream.name}（全量逐条+溯源）；本文件=统计视图",
        "",
        "## 项目分布（Top 15）",
        "",
    ]
    for p, n in per_proj.most_common(15):
        lines.append(f"- {n:,} 条 · {p[:60]}")
    lines += ["", "## 月度热度（思想活跃度时间轴）", ""]
    per_month: Counter = Counter()
    for d, n in per_day.items():
        if d != "?":
            per_month[d[:7]] += n
    for m in sorted(per_month):
        bar = "█" * max(1, per_month[m] // 20)
        lines.append(f"- {m}  {per_month[m]:,}  {bar}")
    if have_jieba:
        lines += ["", "## 高频关键词（Top 60，去停用词）", ""]
        lines.append("、".join(f"{k}×{n}" for k, n in top_kw))
    lines += ["", "## 观点句样本（全部，按时间）", ""]
    for ts, t in sorted(opinion_rows):
        lines.append(f"- `{ts[:10]}` {t[:160]}")
    (OUT_DIR / "PROMPT_STREAM.md").write_text(
        "\n".join(lines), encoding="utf-8")
    print(f"prompt {n_total:,} 条（观点标记 {n_opinion:,}）"
          f" → {stream}")
    print(f"[写] {OUT_DIR / 'PROMPT_STREAM.md'}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
