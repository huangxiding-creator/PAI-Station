"""公众号宣传文生成（M7.4 / PROPOSAL_M7 §5.4）。

09-09 晚转录公式：推荐序 + 用户价值 + 三级目录。
纯模板（零 LLM 成本、确定性输出）；排版转公众号用 md2wechat 资产（M8 接发布链）。
"""

import os

_MAX_PREVIEW_CHARS = 1500
_MAX_PREVIEW_SECTIONS = 1  # 宣传文只放首节试读，防泄正文


def _preview_cut(content: str) -> str:
    """试读截断：预算内回退到最后一个完整行，绝不悬空半句/半个加粗符。"""
    preview = content[:_MAX_PREVIEW_CHARS]
    cut = preview.rfind("\n")
    return preview[:cut] if cut != -1 else preview


def render_promo_article(plan: dict, price: int | str = "") -> str:
    """方案 → 公众号宣传文 markdown。"""
    title = plan.get("title", "")
    score = plan.get("score", 0)
    price_line = f"首发价 **¥{price}**（反馈可返钱）" if price else "首发优惠见文末"

    lines = [f"# {title}", "",
             f"> PAI-Station 方案铸造厂出品 · 思想密度分 {score}/100 · {price_line}", "",
             "## 推荐序", ""]
    first_section = None
    toc, seen = [], 0
    for ch in plan.get("chapters", []):
        toc.append(f"- **{ch.get('title', '')}**（{ch.get('framework', '')}）")
        for sec in ch.get("sections", []):
            seen += 1
            toc.append(f"  - {sec.get('title', '')}")
            if first_section is None:
                first_section = sec

    lines += ["市面上的行业报告，卖的是「看看就好」；这份方案，卖的是**能直接搬走用的作业**。",
              "", "它经一道可证伪的质量闸门出厂——**思想密度计**：", "",
              "- 每章标注思维模型（OODA/冰山模型/精益创业…36 卡弹药库选配）；",
              "- 每节至少 2 件抄作业组件：WBS 任务分解、业务公式、避坑清单、"
              "实操武器库、小案例、信息图…；",
              "- 四前提逐节落位：标准化 / 流程化 / 数据化 / 知识化；",
              f"- 本章目录三级封顶，密度分 {score}，未达 60 分的节自动重锻，"
              "重锻不过如实标注降级——**不假完成**。", ""]
    if plan.get("corpus_note"):
        lines += [f"> {plan['corpus_note']}", ""]

    lines += ["## 为什么值得", "",
              "你买的不是 PDF，是三样东西：", "",
              "1. **可直接执行的路线图**：L1 试点 90 天 → L2 推广 6 个月 → L3 重构 12 个月；",
              "2. **抄作业九件套**：表格给字段、清单给勾选项、公式给变量、"
              "案例给「背景-动作-结果」；",
              "3. **反馈返钱权**：写 15 分钟真诚反馈返 ¥100，70 分钟以上全退——"
              "你的每条反馈都会沉淀为下一版的免疫规则，方案会越卖越强。", ""]

    lines += ["## 三级完整目录", ""] + toc + [""]

    if first_section:
        lines += [f"## 试读：{first_section.get('title', '')}", "",
                  f"（节框架：{first_section.get('framework', '')}）", "",
                  _preview_cut(first_section.get("content", "")), "",
                  "……（完整版购买后解锁）", ""]

    lines += ["## 如何购买", "",
              "① 扫收款码支付 → ② 企业微信发送付款截图与邮箱 → ③ 24 小时内交付"
              "完整版 MD + DOCX 双格式。",
              "", "> 总包之声 · PAI-Station 方案铸造厂 · 你的电脑替你造钱", ""]
    return "\n".join(lines)


def save_promo(plan: dict, out_path: str, price: int | str = "") -> str:
    """宣传文落盘，返回路径。"""
    os.makedirs(os.path.dirname(out_path), exist_ok=True)
    with open(out_path, "w", encoding="utf-8") as f:
        f.write(render_promo_article(plan, price=price))
    return out_path
