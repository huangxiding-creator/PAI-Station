# -*- coding: utf-8 -*-
"""T24 单测：doc88 适配器配置发现腿——key2 info XML / key1 页面 m_main 双路解密（FR4.1）。

被测物 = kb_factory.harvest_engine.adapters.doc88（FR4.1：doc.php?act=info 取 key2 变体
base64 密文 XML；失败回退文档页 m_main.init 挖 key1 载荷解 71 键 JSON；WAF 特征字
「网络环境安全验证」→ blocked_waf 硬拒禁第三方镜像，R20/FR4.AC2）。

实测样本锚（DOC88_SPEC §5 活探针 2026-10-22，_probe/ 留档对照，目录不入 git 故全文内嵌）：
- p_code=69091550288：info 密文 11764 字符（key2）/ m_main 密文 10320 字符（key1）；
  119 页 3 层（headerPageInfo 50/50/19），ebt143.doc88.com，
  p_swf=63-20110912-20110912175543_7SOoC87j，p_allow_page_count=119，XML 无 p_download
  （m_main JSON 出 p_download="2"——非 1 即非免费直下件）。
- 通用性活探（本任务 2026-10-22，doc88 站内请求 5 发 ≤8 预算）：
  分类页 /list-1022.html 静态含 10 个 p-{code}.html 直链（首页 JS 动态无直链）；
  93243737771803（2026 上传，71 页单层 PPT）/ 60390909156220（2026 上传，56 页单层 PPTX）
  两新件 info 路全通，key2 码表 2026 件未轮换、XML 结构与 2011 件逐字段同构。

测试纪律（WORKER_CONVENTIONS）：
- 离线单测零网络：双路网络腿经 fetch 注入点喂确定性 (status, body)（任务卡明示注入点）；
- 实弹用例（@pytest.mark.live）= 真实网络 zero-mock；KB_HARVEST_SKIP_LIVE=1 时跳过并明示。
"""
import json
import os
import sys
from pathlib import Path

import pytest

_KB_DIR = Path(__file__).resolve().parents[2]  # kb_factory/
sys.path.insert(0, str(_KB_DIR))  # worktree 阶段 kb_factory 无 __init__.py：顶层导入 harvest_engine
if not (_KB_DIR / "channel_adapters" / "base.py").exists():
    for _anc in _KB_DIR.parents:  # worker worktree：channel_adapters 只读复用主仓真身
        if (_anc / "kb_factory" / "channel_adapters" / "base.py").exists():
            sys.path.insert(1, str(_anc))
            break

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名
    from kb_factory.channel_adapters.base import FileMeta
    from kb_factory.harvest_engine.adapters.base import (FOUR_STAGES, DownloadAdapter,
                                                         HarvestPlan, LadderResult,
                                                         WALL_BLOCKED_WAF)
    from kb_factory.harvest_engine.adapters.doc88 import (
        DOC88_KEY1_NAME, DOC88_KEY2_NAME, Doc88Config, Doc88ConfigError,
        Doc88DocNotFound, Doc88DownloadAdapter, Doc88Error, Doc88WAFBlocked, PageLoc,
        _curl_cffi_get, _leg_page, discover_config, extract_p_code, info_url, page_url,
        parse_info_xml, parse_m_main)
    from kb_factory.harvest_engine.codec import variant_b64 as vb
    from kb_factory.harvest_engine.envelope import EnvelopeOK, judge_doc88
except ImportError:  # pragma: no cover - worktree 阶段回退导入
    from channel_adapters.base import FileMeta
    from harvest_engine.adapters.base import (FOUR_STAGES, DownloadAdapter, HarvestPlan,
                                              LadderResult, WALL_BLOCKED_WAF)
    from harvest_engine.adapters.doc88 import (
        DOC88_KEY1_NAME, DOC88_KEY2_NAME, Doc88Config, Doc88ConfigError,
        Doc88DocNotFound, Doc88DownloadAdapter, Doc88Error, Doc88WAFBlocked, PageLoc,
        _curl_cffi_get, _leg_page, discover_config, extract_p_code, info_url, page_url,
        parse_info_xml, parse_m_main)
    from harvest_engine.codec import variant_b64 as vb
    from harvest_engine.envelope import EnvelopeOK, judge_doc88

_LIVE_SKIP = os.environ.get("KB_HARVEST_SKIP_LIVE") == "1"

# ---- 实测密文全文（p_code=69091550288；注入自 _probe/ 原样字节，勿手改）----
_INFO_CIPHERTEXT = "wL9!DuXnFmtSEWlYDjUi0r!X3iJlDm1YBOleBTUittpOzqniwT!8BO9jwjRXoW1YBOs+wKNDvUpJtMND1jkX2qMV1qPS2LhFoq!8zQJAHW9kBq!8EN9ZBL!83tdLpMNsvtcR0LEQ0jHT0VVFwjXYEN9ZBL!8EN9eHuVlwjXhuU1MvtpJuUFrpGizcGiYbqsX0LLfb!VFoq!8zQJADmNdBq!8EN9XHuFlHW9VDgv+wKNDvUpJtMND0qM5otU+wK9XoQJhBWtjDQteFL!8EN9TFWBjDQteFL!83tdLpMNsvtcTotU+wK9XoQ1QBm1YFu5UwjRXoWpYHV9mDQxdHov+wKNDvUpJtMNDsMpOotU+wK9XoWpYHV9mDQxdHov+wIJAEOljwjXhuU1MvtpJuWhUFIJT2i8YEO5gzmpYHTn!zm1YDr8S0LMRzTP5zTMSzTH50LkR1qsX0jn!oTMW0K5XDmFFoq!8zQJAEOljwjRXoQ1QBj!83tdLpMNsvtcW0SUS0LMR0LkR0iUS0LMR0LkR0jMQ1qsU0V8QsU9YvTnQClVFwjXYEN9TFWH+wIJABohXCoxloQpZDus+wKNDvUpJtMND0NVFwjXYEN9lGIJZEmtAFOldBq!8EN9lHgpfDQ1UwjXhuU1MvtpJuWhUFIJT2i8YBuxU0qvTzmpYHTn!zm1YDtVFwjXYEN9lHgpfDQ1UwjRXoQBZEL!83tdLpMNsvtcRotU+wK9XoQBZEL!8EN9jDW5WBoxUBuv+wKNDvUpJtMND0tVFwjXYEN9jDW5WBoxUBuv+wIJAHuRcDQFAEONgBt9jDQteFL!83tdLpMNsvtcR0qlFoq!8zQJAHuRcDQFAEONgBt9jDQteFL!8EN9SBuVhCu5AEONgBt9jDQteFL!83tdLpMNsvtcXotU+wK9XoQxlDuNZDl9XHuFloW1YFu5UwjRXoQ1UHoplwjXhuU1MvtpJuTpFoq!8zQJAEQphFOs+wIJABohZEQv+wKNDvUpJtMND0tVFwjXYEN9lGOlTFL!8EN9TFIxVHQpACuH+wKNDvUpJtMND0tVFwjXYEN9TFIxVHQpACuH+wIJA1LPUwjXhuU1MvtpJuTJFoq!8zQJA1LPUwjRhDm5YFONUBt9UCuVlwjP8zWNeDm9UHoploQpZDus+wIJAEQpSFu1UwjRf3O!93jMiwjvV1q3T1qXYCL!8CKJewr3S3j!U1q0X0T38zWn+wOnnDjUi0S3+1LsU2qESwK9fwjRX3O!93jMiwjRlwjM8zWs+wIE+1qkVwK9QwjRfwjnU0qXYCL!8EL!U1qsS0Ts8zQP+wOX+0TkT1jXYDL!8zQP+wIPnDjUi0i3+wOs+0qXYBq!8FT!V2qs8zQE+wOn+2LvRwK9fwjRXwjvV2qMQ0qXYEL!8DL!S2qMUwK9cwjXYEL!8EKJewr3T3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1LHS0LnVwK9XwjRcwj3!1LP8zWX+wK9XwjRX3O!93jviwjRlwjM8zWs+wIE+1qkVwK9QwjRfwjnU0qXYCL!8EL!U1jv50js8zQP+wOX+0jkS2qXYDL!8zQP+wIPnDjUi1r3+wOs+0qXYBq!8FT!V2qs8zQE+wOn+2LvRwK9fwjRXwjvW1TnV1LXYEL!8DL!U0T0!wK9cwjXYEL!8EKJewr3W3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1LES0qkSwK9XwjRcwj0R0Ln8zWX+wK9XwjRX3O!93jEiwjRlwjM8zWs+wIE+1qkVwK9QwjRfwjnU0qXYCL!8EL!U1TsT0LP8zQP+wOX+0jkQ1TXYDL!8zQP+wIPnDjUi2K3+wOs+0qXYBq!8FT!V2qs8zQE+wOn+2LvRwK9fwjRXwjvQ2L3Q1TXYEL!8DL!T1jH!wK9cwjXYEL!8EKJewr353j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1LnR2qvVwK9XwjRcwj0X1Ls8zWX+wK9XwjRX3O!93jMX3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1LnU2qkXwK9XwjRcwjvT1TM8zWX+wK9XwjRX3O!93jMR3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1Ln50THRwK9XwjRcwj0X1Ln8zWX+wK9XwjRX3O!93jMS3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1LkS1LP5wK9XwjRcwjvS1qM8zWX+wK9XwjRX3O!93jMT3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1LkW1jHXwK9XwjRcwj3Q0Lv8zWX+wK9XwjRX3O!93jMU3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1Lk50THUwK9XwjRcwj3!1qs8zWX+wK9XwjRX3O!93jMV3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qPS0jM5wK9XwjRcwj0Q1jv8zWX+wK9XwjRX3O!93jMW3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qPV2qnTwK9XwjRcwj0W1qs8zWX+wK9XwjRX3O!93jMQ3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qP51j0!wK9XwjRcwjvU0L38zWX+wK9XwjRX3O!93jM!3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qMU0LvXwK9XwjRcwj0W1Ts8zWX+wK9XwjRX3O!93jM53j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qMQ1TMVwK9XwjRcwj0W1jE8zWX+wK9XwjRX3O!93j3X3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1q3R0TnSwK9XwjRcwjvX1Tn8zWX+wK9XwjRX3O!93j3R3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1q3V1LHXwK9XwjRcwj0S2L38zWX+wK9XwjRX3O!93j3S3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1q3!1TvSwK9XwjRcwjvT1L38zWX+wK9XwjRX3O!93j3T3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1q0T0LnUwK9XwjRcwjvS0L08zWX+wK9XwjRX3O!93j3U3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1q0Q0jnQwK9XwjRcwj351jP8zWX+wK9XwjRX3O!93j3V3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qvX0jvQwK9XwjRcwj0U1L38zWX+wK9XwjRX3O!93j3W3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qvT1jn5wK9XwjRcwj0X0qH8zWX+wK9XwjRX3O!93j3Q3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qvW1TPVwK9XwjRcwj0U0q38zWX+wK9XwjRX3O!93j3!3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qsX0qMQwK9XwjRcwjvU1qH8zWX+wK9XwjRX3O!93j353j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qsU1qETwK9XwjRcwj3!0Ls8zWX+wK9XwjRX3O!93j0X3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qsQ0TE!wK9XwjRcwj0T1L38zWX+wK9XwjRX3O!93j0R3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qHX1T3XwK9XwjRcwj0T1qM8zWX+wK9XwjRX3O!93j0S3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qHU0LERwK9XwjRcwjvT0jn8zWX+wK9XwjRX3O!93j0T3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qH!0Tk5wK9XwjRcwjvT1qs8zWX+wK9XwjRX3O!93j0U3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qES1TsUwK9XwjRcwj0R1Ln8zWX+wK9XwjRX3O!93j0V3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qEV2qPSwK9XwjRcwjvS2Lv8zWX+wK9XwjRX3O!93j0W3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qnX0qnWwK9XwjRcwj0R2Ls8zWX+wK9XwjRX3O!93j0Q3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qnT0TERwK9XwjRcwjvU0j08zWX+wK9XwjRX3O!93j0!3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qnQ1TkUwK9XwjRcwjvT1qv8zWX+wK9XwjRX3O!93j053j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qkS0qv!wK9XwjRcwjvX0q08zWX+wK9XwjRX3O!93jvX3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qkW0qHRwK9XwjRcwj0V2L08zWX+wK9XwjRX3O!93jvR3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qk51TvUwK9XwjRcwj0T1Ls8zWX+wK9XwjRX3O!93jvS3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1jPT0Ln5wK9XwjRcwj0U0TM8zWX+wK9XwjRX3O!93jvT3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1jPW1q3XwK9XwjRcwj0U1L08zWX+wK9XwjRX3O!93jvU3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1jP52qHTwK9XwjRcwj0T0qk8zWX+wK9XwjRX3O!93jvV3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1jMT0jnSwK9XwjRcwjvT0TP8zWX+wK9XwjRX3O!93jvW3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1jMQ1jMSwK9XwjRcwjvS0q08zWX+wK9XwjRX3O!93jvQ3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1j3R2L3VwK9XwjRcwj0V0qM8zWX+wK9XwjRX3O!93jv!3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1j3V0T0WwK9XwjRcwjvV0TH8zWX+wK9XwjRX3O!93jv53j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1j352LESwK9XwjRcwj0T1q38zWX+wK9XwjRX3O!93jsX3j!8Bq!RwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1j0T0j3UwK9XwjRcwj051Ls8zWX+wK9XwjRX3O!93jsR3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1LsT0L0SwK9XwjRcwj0S1jM8zWX+wK9XwjRX3O!93jsS3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1LsW0jkTwK9XwjRcwj0U2qH8zWX+wK9XwjRX3O!93jsT3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1Ls51Tn5wK9XwjRcwjvX1L38zWX+wK9XwjRX3O!93jsU3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1LHT2L0RwK9XwjRcwj0Q0Tn8zWX+wK9XwjRX3O!93jsV3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1LHQ1qH5wK9XwjRcwj0R0L08zWX+wK9XwjRX3O!93jsW3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1LEX1jESwK9XwjRcwj051js8zWX+wK9XwjRX3O!93jsQ3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1LEU1j0QwK9XwjRcwj0R1Lk8zWX+wK9XwjRX3O!93js!3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1LEQ1TnWwK9XwjRcwj051jn8zWX+wK9XwjRX3O!93js53j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1LnR1TsUwK9XwjRcwj0R1jv8zWX+wK9XwjRX3O!93jHX3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1LnU2qM!wK9XwjRcwjvR0Ts8zWX+wK9XwjRX3O!93jHR3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1Ln50LsTwK9XwjRcwj0T2LM8zWX+wK9XwjRX3O!93jHS3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1LkS1L0UwK9XwjRcwjvS0qs8zWX+wK9XwjRX3O!93jHT3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1LkW1jv5wK9XwjRcwjvU1LE8zWX+wK9XwjRX3O!93jHU3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qPR0LkWwK9XwjRcwj0!1Lk8zWX+wK9XwjRX3O!93jHV3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qPU2qvVwK9XwjRcwj0Q1LM8zWX+wK9XwjRX3O!93jHW3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qP!1jnWwK9XwjRcwj3Q2qk8zWX+wK9XwjRX3O!93jHQ3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qMR1LnVwK9XwjRcwj0R0qs8zWX+wK9XwjRX3O!93jH!3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qMU1jPXwK9XwjRcwjvU0TH8zWX+wK9XwjRX3O!93jH53j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qM50L0WwK9XwjRcwj0R1qE8zWX+wK9XwjRX3O!93jEX3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1q3S0qkTwK9XwjRcwj351qk8zWX+wK9XwjRX3O!93jER3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1q3V0qsSwK9XwjRcwj0U0LP8zWX+wK9XwjRX3O!93jES3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1q3!1qsSwK9XwjRcwj0V0q38zWX+wK9XwjRX3O!93jET3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1q0S0LHUwK9XwjRcwj0X1qn8zWX+wK9XwjRX3O!93jEU3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1q0V0q3SwK9XwjRcwj351qH8zWX+wK9XwjRX3O!93jEV3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1q0!0LE!wK9XwjRcwjvU0qP8zWX+wK9XwjRX3O!93jEW3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qvS1Ln!wK9XwjRcwjvS2Ls8zWX+wK9XwjRX3O!93jEQ3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qvW1TETwK9XwjRcwj0S2Ls8zWX+wK9XwjRX3O!93jE!3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qsX0Ls!wK9XwjRcwj0W2qP8zWX+wK9XwjRX3O!93jE53j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qsT1Tv!wK9XwjRcwj352LM8zWX+wK9XwjRX3O!93jnX3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qsW1T35wK9XwjRcwj350qn8zWX+wK9XwjRX3O!93jnR3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qs51jvQwK9XwjRcwj0R1TH8zWX+wK9XwjRX3O!93jnS3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qHS2L3TwK9XwjRcwjvT2Lk8zWX+wK9XwjRX3O!93jnT3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qHQ0jMSwK9XwjRcwj0T2Lv8zWX+wK9XwjRX3O!93jnU3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qEX1qkWwK9XwjRcwjvR1Lv8zWX+wK9XwjRX3O!93jnV3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qEU1TvXwK9XwjRcwj0W1js8zWX+wK9XwjRX3O!93jnW3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qE!1LPVwK9XwjRcwjvU0Tv8zWX+wK9XwjRX3O!93jnQ3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qnS2L05wK9XwjRcwjvU1LM8zWX+wK9XwjRX3O!93jn!3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qnQ0jnXwK9XwjRcwj0U0LM8zWX+wK9XwjRX3O!93jn53j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qkX1jnRwK9XwjRcwj0T0qs8zWX+wK9XwjRX3O!93jkX3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qkT2qkWwK9XwjRcwj350TE8zWX+wK9XwjRX3O!93jkR3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qkW2q0TwK9XwjRcwjvV0LH8zWX+wK9XwjRX3O!93jkS3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1jPR1L05wK9XwjRcwj0V1Tk8zWX+wK9XwjRX3O!93jkT3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1jPV0LM!wK9XwjRcwjvT2LH8zWX+wK9XwjRX3O!93jkU3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1jP51LPUwK9XwjRcwjvW2Lk8zWX+wK9XwjRX3O!93jkV3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1jMU0LkTwK9XwjRcwj0V2qv8zWX+wK9XwjRX3O!93jkW3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1jMQ1jnQwK9XwjRcwjvR1L38zWX+wK9XwjRX3O!93jkQ3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1j3R2L35wK9XwjRcwjvS1Ts8zWX+wK9XwjRX3O!93jk!3j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1j3W0qPUwK9XwjRcwj0U2LH8zWX+wK9XwjRX3O!93jk53j!8Bq!SwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1j351qkXwK9XwjRcwj0U1js8zWX+wK9XwjRX3O!93jMX0K3+wOs+0jXYBq!8FT!V2qs8zQE+wOn+2LvRwK9fwjRXwjHT0TPV1qXYEL!8DL!T0j0RwK9cwjXYEL!8EKJewr3R0LMiwjRlwj08zWs+wIE+1qkVwK9QwjRfwjnU0qXYCL!8EL!U1qv51T38zQP+wOX+1LsR0qXYDL!8zQP+wIPnDjUi0qPS3j!8Bq!TwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1Ls51LnTwK9XwjRcwj0X0j38zWX+wK9XwjRX3O!93jMX0S3+wOs+0TXYBq!8FT!V2qs8zQE+wOn+2LvRwK9fwjRXwjvW0jsX1qXYEL!8DL!T1LM!wK9cwjXYEL!8EKJewr3R0LviwjRlwj08zWs+wIE+1qkVwK9QwjRfwjnU0qXYCL!8EL!U1js50j08zQP+wOX+1LvS0jXYDL!8zQP+wIPnDjUi0qPV3j!8Bq!TwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1LEX0TvVwK9XwjRcwj0W1q08zWX+wK9XwjRX3O!93jMX1i3+wOs+0TXYBq!8FT!V2qs8zQE+wOn+2LvRwK9fwjRXwjvQ0Tk52LXYEL!8DL!U1L3XwK9cwjXYEL!8EKJewr3R0LEiwjRlwj08zWs+wIE+1qkVwK9QwjRfwjnU0qXYCL!8EL!U1TnU0qn8zQP+wOX+1LM!1LXYDL!8zQP+wIPnDjUi0qP!3j!8Bq!TwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1LnS1jPSwK9XwjRcwj0S1qk8zWX+wK9XwjRX3O!93jMX2r3+wOs+0TXYBq!8FT!V2qs8zQE+wOn+2LvRwK9fwjRXwjv!1qnW0qXYEL!8DL!T0Lk5wK9cwjXYEL!8EKJewr3R0qPiwjRlwj08zWs+wIE+1qkVwK9QwjRfwjnU0qXYCL!8EL!U2Ln51jP8zQP+wOX+0jnV1jXYDL!8zQP+wIPnDjUi0qMR3j!8Bq!TwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1LkR2LMWwK9XwjRcwjvR1LH8zWX+wK9XwjRX3O!93jMR0i3+wOs+0TXYBq!8FT!V2qs8zQE+wOn+2LvRwK9fwjRXwjv51qkW0jXYEL!8DL!T1qH!wK9cwjXYEL!8EKJewr3R0q0iwjRlwj08zWs+wIE+1qkVwK9QwjRfwjnU0qXYCL!8EL!U2qkV0TP8zQP+wOX+0T3U2LXYDL!8zQP+wIPnDjUi0qMU3j!8Bq!TwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qPS1TE!wK9XwjRcwjvS0qv8zWX+wK9XwjRX3O!93jMR1r3+wOs+0TXYBq!8FT!V2qs8zQE+wOn+2LvRwK9fwjRXwjsX1jk50jXYEL!8DL!T0qE5wK9cwjXYEL!8EKJewr3R0qHiwjRlwj08zWs+wIE+1qkVwK9QwjRfwjnU0qXYCL!8EL!V0qPR1TM8zQP+wOX+0T3S1LXYDL!8zQP+wIPnDjUi0qMQ3j!8Bq!TwK9lwjRQwjs51qXYFT!8CL!!1LM8zWn+wIP+1qMT0TkVwK9XwjRcwjvR0qP8zWX+wK9XwjRX3O!93jMR2K3+wOs+0TXYBq!8FT!V2qs8zQE+wOn+2LvRwK9fwjRXwjsR1TsX1qXYEL!8DL!T2qkUwK9cwjXYEL!8EKJewr3R0qkiwjRlwj08zWs+wIE+1qkVwK9QwjRfwjnU0qXYCL!8EL!V0jMU2qk8zQP+wOX+0jMS1LXYDL!8zQP+wK9XoQ1UEgtjFL!8zWpYHT!="    # key2 密文（doc.php?act=info 响应，11764 字符）
_MMAIN_CIPHERTEXT = "GTxSGu0i1kPc3gtZCL363meXBqDUCOjX0kNlCqNUFIJZ0qJgFg3XCqvQ3iRiHQ9duWr5DOsi1kMc3m2YBl9hEurf3kfRzLxkHurhBO9g3kfi0L3c3gJAHQ9jCp363kH50KjX2qsR0kn!3iRiDN9VDOXYHorACONUCp363k3R0qMe0Kje0q3izLxRuQlj3kfi0qPW2S3Q0S0izLxeCoViCuxAFovi1i3T0SsS2KH53iRiBO9gFo5ABmNeCp363kxh2kNh0Stk0KEhCkjTHQ2hHQCmCkEj2O0!1KrhHks!3iRiBmlkFV9dHoVl3kfiuIsUCqP5uIsW1o2iuIsV0QHQ3iRiDN9RHoElHQ9VBgvi1i3X0qjizLxRuQrYEQ5cBQNj3kfi0i3c3grlGIrAFg2YBi360LRiDO5gDONUFL363mhUEIJS1lRYuL9RBmDdCO9k1KndHQ9euL8T0KMXuL8R1tRY0qxDzSH50KjX2qsR0kn!3iRiDN9dHoVl3kfirVxNuIs!0mHXuIs!Hmtj2qPR0NXV1OxkCL3c3gJACO9kuQCYDmVhEL363lJMri3c3gxlBONUCorADN9ZCI0i1ixk0ksTrOEbqVE6tpeoEQ8SsjEp0NRY1stqDmeMFWvVGsvQDKhOss9N0oecDjnTqIZFpVxF2UhI1tlaBsVrqVxL1qrsHsxzDIv!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!VGjcSCqxXFlC6Do5t0IJtsqJXEl3XDqJl0N2S2qx0slr6Du0V0gJt3qxzqosTFUVu0medtWZXElnTpS2k0OlttkNXDQsXpWCHGgN3tKJXBlvXDNtt0OeMtgZz0QsTDoZoGgNdtqJRttMRFUhH0MeQCqJqEiMTFtxsGgNS2qxRtpMTpUVl0mcS2qxXFlx6DqJt0meSHSJZttHXDu2l0seQoIZXpN0RsVJo0gJtsSJa0Nh6pSJl0gNbtgZXBlsRDNtt0gNQ2qxq0QsTpW2H0IJpsWZXDSsTDNsh0je2CqxzDSsTpQ5qGgMRskJa0Q0RtNto0uNSCqNzElh6DuCr0OeSskxRtt0TpUUhGjcRCqxXFlC6Do5t0IJttqxaDSsRFSJl0jeQtKJZsl26Du0V0gJt3qxzqosTpUrp0N2QtgZX0NMTDqJk0NrttkNXDQsXpWCHGgNQtSJqFksXqNtt0jcSsgZz0OsTDoZoGgNdtqJRttsTsQ5t0INdCqxzqpMTqNxqGgNS2qxRtpMTpUVl0jedtKxasNr6DqJs0gNbHSJsttHXDu2l0seQoIZXEiMTDo5r0IJtsSJzFkt6pSJl0gNbtgZXBlsRDNtt0sed2qxasOsRFQ5o0mlpsWZXDSsTDNsh0je2CqxzFlnXpUVrGgNQoKxzpO0RtNto0uNSCqNzElh6DuHV0gNbsqJZtt0TDsnhGjcRCqxXFlC6Do5t0IJttqNXFlHRsVJl0N0StqN0sl26Du0V0gJt3qxzqosTDtJs0l2M3uZXElvRDuCk0NrttkNXDQsXpWCHGgNSskxaFksRFttq0INM2uZz0OsTDoZoGgNdtqJRttHRDtJH0l22CqJq0VvTqNxqGgNS2qxRtpMTpUVl0gN2sSJqFlC6DuCH0INvHSJsttHXDu2l0seQoIZXDVnTsW2p0gJtsSNXFlt6pSJl0gNbtgZXBlsRDNto0Oe2tqNXFmsRFUVs0lP9wp3c3mVhGNJdCUhlFoEfEL360k3QzLxZCl96FuPi1kPc3gZACO9kuQlj3kfi3iRiCWxYEuJAFovi1i3XHmvVEuhoEs8UFkEhFsebplJvBOxqEOEOBj5rqlZWrgJ2tKjR1MRVuL9tqS2Jpm5hqslUqj5UtKrSqo5cCqN1rm8SqWlIpolLvUsTrNRYoqMS0VN5oqlCGNlt1u25vm9!ssRStVxMpgjSDktMskNevgxgHQxSGMhXGIJDzVZ6uL8WDWrqqIl2pgtNrMVTDjxqol2lHuEIFsv!qOV5sqEJBUVjElEyFMriCo0SpmrLsgxgFohIojXwBNEfCkHasoCrBK2uGKNfHoZ!rNRY2Q5dtIMV2M52GsxHDtMVDUna0UEH1NCX0M0QtMN3qm9wCmNYGjva2urc1uh0pMsTBQX2HkNssoxrCWNCooVLtMXwuL8Q1peHpqxV1KEtFMCotShXsqxisUtXFWCC0SCTBgJYEICHoICFFNZHsKNipm9TBklatSCm2WJJ1tRYFOedrlCpFurFvlrOotZYrllSFM3UoI2QEtEmENJr0QNRDgrlBo2Yto5i1NJjoICaDsXerkEMCsHQstnXDUnWCOx!ojCL0IEZ0KlrFmN6vQCs1IZWsN2sBtlbFSl6pMlbDMhiCmCmtOlj1srIyS2q0QhRCORR2s231OEtoNtwGj9OGkCermrxroxgFkMQ0OsWolNeDoeTvW2LrsltpU5fvkrQyUNk2MxkyVRYqg2esMxotlZgBs2OHUVtsu3XsONjDs9VsNCf1MET0o9MGLejHshSooCxvVZCrNJxrUN3HjtOomxjGjVvFuZ2Ho9LsIjaqWPT1uPSsNxmtqJdvurhCtrkFglKvllsHmUUESrbBUhTCqNO2NJyGmxx0WNw0QNJoqliEO5OtpeT0OlQqOtb2jcV0K2YDQ9gtICxEmtiCt2TFOZoGOh5vWZb1M22pUlKsMVipQxsCsx3qtPXCsvXqk3aBtt5tSxKCttXBkvUtmeutUrcBOr30VsaCKryqqxeyWNfGktXHm9fBKNYDurrBONZqstgqMNJ2qhs1o3S2qPVDje5HUNwEQrw1trduL8aHt3SqtJqsieDzTeTDsEHtQEerMNNpjc!plN!CsCyrgfVFQEipscTpgEKHgtN1Mr12MDWEtCpEQERBS2hrlxdsW3aDmeu2jlb2gJYpUZWqVCytW2oGm9QsqNlBqtMoMtz0jXC2O5QpsXfqicaDgrx0gheyQfUHu3!qONXpO8Rrg23tqECvseY0I2YrVJWojrzssNIyUUQuL8atsNUqVJL1t2ysgN3ClJ3rm!XplRYEsXkCsNKpqxopKEKFsZ!2uCTFOxKtmXWotE6GghZtqtuEOtaCgJO0txCDjZerIfXpkNcGOCHvurVqkHSENN2oM50rQZUts0QFWDTuL9DzSxWrjZpHQ9V2lCVoN0!qONWCmZyDM5qEt25sjZpDsjSGO5CCM3W2I2TBMNIFQlfCtlLDQ3W2jNrpMZYqlZdrM!X0ie3DQxV2tCu1olXqNESquN10jR!oKNqFOCkDkxwsNRYGjxDzSJxqOhCHjlwDMVODStasj2RpQxQoo52BUxXuL92BuEWqKJYtglQDuZ3oMlapS2TBjCOyUeerlJKCOEUESxIoqJQDttuFOfUHltXDUZatltJtj8WCNZvsVNTDlxwHtRYpVHR2grtCUhxvmCU0WnS0gClFuEs0m5sEUxQourTts2UrolM2sNqvs2HqUNZ0UlCDoVYCuCNounX1M9rHuExHQxtvu2lsuJaBIEgESJL0jH5oOZ1DQxivt3SFmM!qjNp0SEcqm22otZqCIEZyQDREjjaolEDzQZdqIPVuL9rvUUaGOhL2urlvWEl1tCc2O9NrQjSGsCSFkl!slRY2oCF1NJqsOEeokr0pOxM2VNJHm5CEtRYrjN!2QrqEWZttOViCjDWtMhvElvUDKtYEQxwDicXokhrBNZ0CgEitQrwsUlkqTeYCVEzGIlxvtrQ2MxDzWrTpIxTsUeSojt0GKn5pMjXCmhorICZrMfUqlZpqmEHuL9uuL9QrVjS0SNw2l2xGIMVFgttrutxHSJlpulXDVrhvu2XqtCOCOlM0KtQpOe2Fm2vGor6rQrTEOeFGtnUpmraFthCEsCsFUEhts2VCm2qtUxT2klfqU55uL9SoNZpvlRYrofSGOxapkCKtONC0s5IqUhzqMtsEQlivjnVBU8WokJrFoNaGKxqEUXCqjCmBO91rgtayWh5tMVu1KrhCgCrqQHRGjtc2O9X2jxkDo2LojejomlyFulC1s2vpieMtUrZDklyGj35soUXHjXZtKhIEMlI2OhCGmhmFoZKqjxorShHGuhIDolRptEtGs5sEqsWCoNiqU5ZCVxmEsfQotxs0KPauL9vEMcTrVEv0IM5sIEDzWs5rU21tjNRoIEaCgN3vVCTpWtcto3UDqxo1uMaso2rsWhTDs2rtQNeHo9kGmetrtrgtOeMEuhXGjlKBmlxqtRYrst5Fs9uCMrIrmChqI0asK2jDVsVFVlVyQCzss5vEW2R1M9IEOXstVfWDKDa1MtSouJ1CmnTGIltouhOoMNtsg0W2S2m2mCbss8W0lEjsVJHEq3VHQ9U0uDTBUlDzQxvtQtk0UrCuL93CNCwsUvRHUCKrIN5DICmHoUSquEhGl2VsKrkqk3RCgh0uL9u0kMWqVETCjs!BmN22OlJsjZdGm2jpM8SyWH!tOXMomha0t3QpIjXCgNYGgtCqVJ6HlhWFSnTvl0WDlC!vm3aDNl2DtErGlCFstZSGsE2sI3QsslMBOrwqOt10khavtJNvWfUvlNW3iRiHm9YFV9ZCL363k0S0k3!0qvizLxlHgrAFO9SEL363mhUEIJS1lRYuL9lHgvX2K0dCO9k1KndHQ9e3iRiFoVguQhYDWvi1ixfEIrRDSZDzVRYDL5jBQ0!1L5kBQUizLxfCoNjCuxxBmCY3kfiuL3U2qsT0StD3iXD3kvV0SPS0lRizNRi2KsU1qDTuL3izLxfCoNjCuxvHoElpo5mBT363lRi2qJD3iXD3ksRuL3cuL3X1tRi3iRiFOthCOtTqO9hCN2UHurl3kfiuL3RuL3cuL3RuL3cuL3RuL3izLxmFuxSENCZCuEqEONUCp363lRi0NRizNRi0NRizNRi0NRi3iRiDN9SEQHi1i3Q0TUT0KMX0KjX0iUT0KMX0KjX0kMW2qsU0V8WsU9YvSnWFi3c3gJhDgrADmthCL360LRiDWxc3kfXzLxSDmXZCL363kDSHmHaDjXsFtRY0olj0mVequltBjf!0gleBOeRDgC!vktmFNCb2lJwsUtUrSJNHuJhEQNT2MtNHuZIpUVp0kr5oOhxBSNZtKJsFm!atOhg2WCcEQEkqSPUrkrtDqE3ElrKsMUizLxREoxcFu2f3kfXzLxcBQEZBmtj3kfi0L3c3mXYCQlduQVlBoxlDl9ZCL363i3c3m9WBlJVHmXZDQni1kPc3mCYDmVhEN9ZHQ9d3kfiwO3nHQXhDW09uLxZHQ9dCm9dELJiCTVRCOCD3k!m3Whl2Q3V1SXDzQ3+3iRiHQ9VBgrAHQ9jCp363k0X0SDS1q0T0SHS0S0X0SsS1q0U0SvS1q0X0SsS1q0W0jvS0q0R0SDS2S0T0SHS0S0S0jvS0k0S0SsS0S0U0SHS1qxM0SMTrK0R0jvS0q0R0SPS0K2K2kjT0KHS2j0Q0qDS2S0SrK3T2kjQ0SCO2jsQ2kCO2jsW2K3R2SPQvSDV2S0T0k2N0kHT0SD!2ksS2S0!0SsSvk2K0jHQ1q2N0jvS0q0W0SjS0k0Q0S0S0q0V0SjS2KxM2j3W0qCM0SDS2KHU2kjS0q0T0SMQ2qHV0SMW2KH!2SPQ1q0X0SPQ2SCJ2S3S0qHV0SvS2i3c3gtdFo9duWxlCmtTuQ2YCOsi1i3izLxVBmlYBl9kBQrl3kfi3iRiEutZCL363k3T2o3S2KjQ2O0SCoH52Os!CkNkCosW1OHQ2m3!0Khl3iRiCOeZCL363j2xDNtNpqPQGl05ssCrrotLqSlb0jXdCshu1or6stJj0oZaoKxXqtHXDtJq0jXdCs2xDOrMpUxsvWtQ1qJb0VC3FkJt0gN3tshs0oXLFmetvgNfBqJV0oXLDsshvmZ3tUhbBlnTqW2evmU5sUrVqltWEMZ2DO!9wp3c3mrYEQ5cBQNjuWJTFo2l3kfi1L!R0L3c3mxVGotTuQVYBmt53kfRzLxSEONUCs9TCOtTvQhlHQeZBmDi1kPc3mrcsmteHoldtOleCu0i1i3R3iRiDN9ZBmrlGL363kPizLxSEONUCsxYEoEfEL360LRiDWrhEOtMBQ2KFOtkFT360pRiEmlRuQrYHT360pRiDmCAEuxc3kfi3iRiDQtTEmtTuWrZBosi1kMW1q3Q0SMV1qvU1qMc3g2ZEOtVDmXADWrhEOlk3kfiFIrUDI06uL9DzW2UHurZHT5jBQ0!1L5kBQUizLxcFoVZEN9UGuJl3kfRzLxQFuPi1i3R3iRiEmlRuW2UHuxUuWrZBosi1kPc3gCZDN9lBmrAEOleCp360LRiDgEAFoHi1kPc3g2ZBuJcCp360LRiHo5YBgleBWtSuWvi1kJ9"  # key1 密文（文档页 m_main.init 参数，10320 字符）

# 注入完整性锚（DOC88_SPEC §5 实测头尾，防手改/截断；与 test_variant_b64 同源）
_INFO_HEAD = "wL9!DuXnFmtSEWlYDjUi0r!X3iJlDm1YBOleBTUittpOzqniwT!8BO9jwjRXoW1YBOs+wKNDvUpJtMND"
_MMAIN_HEAD = "GTxSGu0i1kPc3gtZCL363meXBqDUCOjX0kNlCqNUFIJZ0qJgFg3XCqvQ3iRiHQ9duWr5DOsi1kMc3m2Y"
_MMAIN_TAIL = "1kPc3g2ZBuJcCp360LRiHo5YBgleBWtSuWvi1kJ9"

SAMPLE_P_CODE = "69091550288"
SAMPLE_P_NAME = "GRE英语5000词"
SAMPLE_P_SWF = "63-20110912-20110912175543_7SOoC87j"
SAMPLE_EBTHOST = "https://ebt143.doc88.com"

# 通用性活探新件（2026-10-22 实测；/list-1022.html 分类页取样）
NEW_P_CODE_A = "93243737771803"   # 71 页单层 PPT（2026-08-31 上传）
NEW_P_CODE_B = "60390909156220"   # 56 页单层 PPTX（2026-09-25 上传）

WAF_BODY = "<html><body>网络环境安全验证，请稍后再试。</body></html>"


def _sample_xml_config() -> Doc88Config:
    """实测 info 密文 → key2 解 → XML 解（多测试共用；密文损坏会在锚测试先炸）。"""
    return parse_info_xml(vb.decode(DOC88_KEY2_NAME, _INFO_CIPHERTEXT))


def _sample_json_config() -> Doc88Config:
    """实测 m_main 密文 → key1 解 → JSON 解（页面回退路同构件）。"""
    return parse_m_main(json.loads(vb.decode(DOC88_KEY1_NAME, _MMAIN_CIPHERTEXT)))


# ---------- 样本完整性锚（数字零造假门） ----------

def test_fr41_embedded_sample_integrity():
    """内嵌两段密文长度与头尾锚须与 _probe/ 实测逐字一致。"""
    assert len(_INFO_CIPHERTEXT) == 11764
    assert _INFO_CIPHERTEXT.startswith(_INFO_HEAD)
    assert len(_MMAIN_CIPHERTEXT) == 10320
    assert _MMAIN_CIPHERTEXT.startswith(_MMAIN_HEAD) and _MMAIN_CIPHERTEXT.endswith(_MMAIN_TAIL)


# ---------- p_code 提取（纯解析零网络） ----------

def test_fr41_extract_p_code_bare_and_urls():
    assert extract_p_code(SAMPLE_P_CODE) == SAMPLE_P_CODE
    assert extract_p_code(f"https://www.doc88.com/p-{SAMPLE_P_CODE}.html") == SAMPLE_P_CODE
    assert extract_p_code(f"https://www.doc88.com/p-{NEW_P_CODE_A}.html") == NEW_P_CODE_A
    assert extract_p_code(f"/p-{SAMPLE_P_CODE}.html") == SAMPLE_P_CODE
    assert extract_p_code(info_url(SAMPLE_P_CODE)) == SAMPLE_P_CODE      # doc.php?act=info&p_code=
    assert extract_p_code("https://www.doc88.com/doc.php?act=download&pcode=123456") == "123456"


def test_fr41_extract_p_code_rejects_invalid():
    assert extract_p_code("") is None
    assert extract_p_code("12345") is None                       # <6 位
    assert extract_p_code("abc123456") is None                    # 非纯数字
    assert extract_p_code("https://example.com/p-123456.html") is None   # 非 doc88 域
    assert extract_p_code("https://ebt143.doc88.com/getebt-xxx.ebt") is None  # ebt CDN 资产路径
    assert extract_p_code("https://www.doc88.com/list-1022.html") is None     # 分类页无 p_code
    assert extract_p_code(None) is None


def test_fr41_url_builders():
    assert info_url(SAMPLE_P_CODE) == \
        f"https://www.doc88.com/doc.php?act=info&p_code={SAMPLE_P_CODE}"
    assert page_url(SAMPLE_P_CODE) == f"https://www.doc88.com/p-{SAMPLE_P_CODE}.html"


# ---------- 方法1：info XML 解析（key2 已解明文入参） ----------

def test_fr41_parse_info_xml_real_sample():
    """实测 119 页 XML：任务卡点名字段全解出 + 层头表 + 每页定位表。"""
    cfg = _sample_xml_config()
    assert isinstance(cfg, Doc88Config)
    assert cfg.source == "info_xml"
    assert cfg.p_code == SAMPLE_P_CODE
    assert cfg.p_name == SAMPLE_P_NAME
    assert cfg.p_pagecount == 119
    assert cfg.p_allow_page_count == 119
    assert cfg.p_ebthost == SAMPLE_EBTHOST
    assert cfg.p_swf == SAMPLE_P_SWF
    assert cfg.p_download is None          # 该件 XML 无 p_download（如实 None，不造假）
    assert cfg.p_404 == "0"
    assert cfg.header_sizes == (455235, 453032, 454972)     # 3 层 PH 大小表
    assert len(cfg.pages) == 119
    assert cfg.pages[0] == PageLoc(1, 595, 841, 455235, 3936)   # 第 1 页 L1
    assert cfg.pages[49].level == 1 and cfg.pages[50].level == 2  # 50/50 分层边界
    assert cfg.pages[50].offset == 453032                     # L2 首页偏移==L2 层头大小
    assert cfg.pages[100].offset == 454972                    # L3 首页偏移==L3 层头大小
    assert cfg.pages[118] == PageLoc(3, 595, 841, 521499, 2124)  # 第 119 页 L3
    assert {loc.level for loc in cfg.pages} == {1, 2, 3}
    assert cfg.is_free_download is False


XML_MIN = (
    '<?xml version="1.0" encoding="UTF-8"?><doc>'
    '<p_code><![CDATA[123456]]></p_code>'
    '<p_name><![CDATA[合成样例]]></p_name>'
    '<p_pagecount><![CDATA[2]]></p_pagecount>'
    '<p_swf><![CDATA[63-20110912-20110912175543_x]]></p_swf>'
    '<p_ebthost><![CDATA[https://ebt999.doc88.com]]></p_ebthost>'
    '<p_404><![CDATA[0]]></p_404>'
    '<annotate_time>0</annotate_time>'
    '<p_struct><h n="1">100</h>'
    '<p n="1"><e>1</e><w>100</w><h>200</h><p>100</p><l>50</l></p>'
    '<p n="2"><e>1</e><w>100</w><h>200</h><p>150</p><l>60</l></p>'
    '</p_struct></doc>')


def test_fr41_parse_info_xml_synthetic_minimal():
    """合成最小 XML：可选字段缺省如实 None；非 CDATA 标量（annotate_time）不碍解析。"""
    cfg = parse_info_xml(XML_MIN)
    assert (cfg.p_code, cfg.p_pagecount) == ("123456", 2)
    assert cfg.p_allow_page_count is None and cfg.p_download is None
    assert cfg.header_sizes == (100,)
    assert cfg.pages == (PageLoc(1, 100, 200, 100, 50), PageLoc(1, 100, 200, 150, 60))


def test_fr41_parse_info_xml_missing_fields_raise():
    with pytest.raises(Doc88ConfigError, match="p_ebthost"):
        parse_info_xml('<?xml version="1.0"?><doc><p_code>1</p_code>'
                       "<p_pagecount>1</p_pagecount><p_swf>x</p_swf></doc>")
    with pytest.raises(Doc88ConfigError, match="p_struct"):
        parse_info_xml('<?xml version="1.0"?><doc><p_code>1</p_code>'
                       "<p_pagecount>1</p_pagecount><p_swf>x</p_swf>"
                       "<p_ebthost>https://ebt1.doc88.com</p_ebthost></doc>")
    with pytest.raises(Doc88ConfigError, match="XML 解析失败"):
        parse_info_xml('<?xml version="1.0"?><doc><p_code>1')   # 截断件


# ---------- 方法2：页面 m_main JSON 解析（key1 已解明文入参） ----------

def _mmain_min_payload() -> dict:
    return {"p_code": "123456", "p_name": "合成样例", "p_pagecount": 2, "pageCount": 2,
            "ebt_host": "https://ebt999.doc88.com", "p_swf": "63-x",
            "p_download": "2", "headerInfo": '"100"',
            "pageInfo": vb.encode(DOC88_KEY1_NAME, "1-100-200-100-50,1-100-200-150-60")}


def test_fr41_parse_m_main_real_sample_parity():
    """实测 m_main JSON 与 info XML 双路逐条等价（SPEC §5：pageInfo 119 条与 XML 一致）。"""
    cfg_j = _sample_json_config()
    assert cfg_j.source == "page_m_main"
    assert (cfg_j.p_code, cfg_j.p_name) == (SAMPLE_P_CODE, SAMPLE_P_NAME)
    assert cfg_j.p_pagecount == 119
    assert cfg_j.p_ebthost == SAMPLE_EBTHOST and cfg_j.p_swf == SAMPLE_P_SWF
    assert cfg_j.p_download == "2" and cfg_j.is_free_download is False
    assert cfg_j.p_allow_page_count is None    # 71 键 JSON 实测无此键（如实 None）
    assert cfg_j.header_sizes == (455235, 453032, 454972)
    assert cfg_j.pages == _sample_xml_config().pages     # 两法页表逐条一致


def test_fr41_parse_m_main_synthetic_min_and_errors():
    cfg = parse_m_main(_mmain_min_payload())
    assert cfg.pages == (PageLoc(1, 100, 200, 100, 50), PageLoc(1, 100, 200, 150, 60))
    assert cfg.header_sizes == (100,) and cfg.p_download == "2"
    assert parse_m_main({**_mmain_min_payload(), "p_pagecount": "x"}) .p_pagecount == 2  # pageCount 兜底
    bad = {**_mmain_min_payload()}
    del bad["headerInfo"]
    with pytest.raises(Doc88ConfigError, match="headerInfo"):
        parse_m_main(bad)
    with pytest.raises(Doc88ConfigError, match="pageInfo"):
        parse_m_main({**_mmain_min_payload(), "pageInfo": vb.encode(DOC88_KEY1_NAME, "1-100-200")})


# ---------- discover_config：双路编排 + WAF/404/两法皆折 ----------

class _Recorder:
    """确定性网络注入件：按 URL 前缀分发 (status, body)，并记录全部请求 URL。"""

    def __init__(self, routes, default=(200, "")):
        self.routes = routes
        self.default = default
        self.urls = []

    def __call__(self, url, timeout):
        self.urls.append(url)
        for prefix, resp in self.routes.items():
            if url.startswith(prefix):
                return resp
        return self.default


def test_fr41_discover_method1_success():
    fetch = _Recorder({"https://www.doc88.com/doc.php?act=info": (200, _INFO_CIPHERTEXT)})
    cfg = discover_config(SAMPLE_P_CODE, fetch=fetch, timeout=7.5)
    assert cfg.source == "info_xml" and cfg.p_pagecount == 119
    assert fetch.urls == [info_url(SAMPLE_P_CODE)]          # 方法1 成功零回退请求
    assert fetch.urls[0].endswith(f"p_code={SAMPLE_P_CODE}")


def test_fr41_discover_fallback_to_method2():
    """方法1 折（HTTP 403）→ 回退页面路 m_main（key1）成功。"""
    page_html = f'<html><script>m_main.init("{_MMAIN_CIPHERTEXT}");</script></html>'
    fetch = _Recorder({
        "https://www.doc88.com/doc.php?act=info": (403, "Forbidden"),
        "https://www.doc88.com/p-": (200, page_html)})
    cfg = discover_config(SAMPLE_P_CODE, fetch=fetch)
    assert cfg.source == "page_m_main" and cfg.p_pagecount == 119
    assert fetch.urls == [info_url(SAMPLE_P_CODE), page_url(SAMPLE_P_CODE)]


def test_fr41_discover_key2_garbage_falls_back():
    """方法1 返回非密文垃圾（key2 解不开）→ 不炸、回退方法2。"""
    page_html = f'<script>m_main.init("{_MMAIN_CIPHERTEXT}");</script>'
    fetch = _Recorder({
        "https://www.doc88.com/doc.php?act=info": (200, "<html>503</html>"),
        "https://www.doc88.com/p-": (200, page_html)})
    assert discover_config(SAMPLE_P_CODE, fetch=fetch).source == "page_m_main"


def test_fr41_discover_waf_leg1_fallback_leg2_success():
    """方法1 命中 WAF 特征字 → 该腿折；页面路通则仍可收（端点级 WAF，非环境级）。"""
    page_html = f'<script>m_main.init("{_MMAIN_CIPHERTEXT}");</script>'
    fetch = _Recorder({
        "https://www.doc88.com/doc.php?act=info": (200, WAF_BODY),
        "https://www.doc88.com/p-": (200, page_html)})
    cfg = discover_config(SAMPLE_P_CODE, fetch=fetch)
    assert cfg.source == "page_m_main"


def test_fr41_discover_waf_both_legs_hard_reject_fr4_ac2():
    """FR4.AC2：双路皆命中「网络环境安全验证」→ blocked_waf 硬拒；全程零第三方域请求（R20）。"""
    fetch = _Recorder({"https://www.doc88.com/": (200, WAF_BODY)})
    with pytest.raises(Doc88WAFBlocked, match="blocked_waf|R20") as ei:
        discover_config(SAMPLE_P_CODE, fetch=fetch)
    assert ei.value.wall_status == WALL_BLOCKED_WAF
    assert isinstance(ei.value, Doc88Error)
    assert all(u.startswith("https://www.doc88.com/") for u in fetch.urls)  # 禁第三方镜像


def test_fr41_discover_doc_not_found_p404():
    """p_404=1 → Doc88DocNotFound（硬拒，不再回退）。"""
    xml404 = ('<?xml version="1.0"?><doc><p_code><![CDATA[000000]]></p_code>'
              '<p_pagecount><![CDATA[0]]></p_pagecount><p_swf><![CDATA[x]]></p_swf>'
              '<p_ebthost><![CDATA[https://ebt1.doc88.com]]></p_ebthost>'
              '<p_404><![CDATA[1]]></p_404></doc>')
    fetch = _Recorder({
        "https://www.doc88.com/doc.php?act=info": (200, vb.encode(DOC88_KEY2_NAME, xml404)),
        "https://www.doc88.com/p-": (200, "<html>404</html>")})
    with pytest.raises(Doc88DocNotFound, match="p_404"):
        discover_config("000000", fetch=fetch)
    assert len(fetch.urls) == 1     # 404 判死即止，不试页面路


def test_fr41_discover_both_legs_fail_config_error():
    fetch = _Recorder({
        "https://www.doc88.com/doc.php?act=info": (200, "not-base64!!"),
        "https://www.doc88.com/p-": (200, "<html>无 m_main</html>")})
    with pytest.raises(Doc88ConfigError, match="方法2"):
        discover_config(SAMPLE_P_CODE, fetch=fetch)


def test_fr41_discover_network_exception_falls_through():
    def boom_info(url, timeout):
        if "doc.php" in url:
            raise OSError("connection reset")
        return 200, f'<script>m_main.init("{_MMAIN_CIPHERTEXT}");</script>'
    cfg = discover_config(SAMPLE_P_CODE, fetch=boom_info)
    assert cfg.source == "page_m_main"


def test_fr41_discover_bad_p_code_raises():
    with pytest.raises(Doc88ConfigError, match="p_code"):
        discover_config("not-a-doc88-url", fetch=_Recorder({}))


def test_fr41_p_code_mismatch_falls_back():
    """info 路解出的 p_code 与请求不符（错拿他件配置）→ 如实弃用走回退。"""
    xml_other = XML_MIN.replace("123456", "999999")   # 他件合法配置（p_code 不符）
    fetch = _Recorder({
        "https://www.doc88.com/doc.php?act=info": (200, vb.encode(DOC88_KEY2_NAME, xml_other)),
        "https://www.doc88.com/p-": (200, f'<script>m_main.init("{_MMAIN_CIPHERTEXT}");</script>')})
    cfg = discover_config(SAMPLE_P_CODE, fetch=fetch)
    assert cfg.source == "page_m_main" and cfg.p_code == SAMPLE_P_CODE


# ---------- 信封对接（envelope.judge_doc88 消费 to_mapping） ----------

def test_fr41_to_mapping_envelope_ok():
    verdict = judge_doc88(_sample_xml_config().to_mapping())
    assert isinstance(verdict, EnvelopeOK)
    assert verdict.facts["p_pagecount"] == 119
    assert verdict.facts["p_ebthost"] == SAMPLE_EBTHOST
    assert verdict.facts["p_download"] is False       # XML 缺省 → 非免费件（如实）
    assert verdict.facts["p_allow_page_count"] == 119


# ---------- DownloadAdapter 子类骨架契约 ----------

def test_fr41_adapter_class_contract():
    """四段契约：段1 仍桩；段3 fetch_ladder 已按 T32 接线实装 L1 主径；段4 verify 已按
    T36 实装（2026-10-22 任务卡授权改动：原 NotImplementedError 桩断言改为「裸 result
    无产物/无 manifest 事实 → False」——四门 CLI/判空路口径见 adapters/doc88.py T36 段
    与 test_doc88_waf.py）。"""
    adapter = Doc88DownloadAdapter()
    assert issubclass(Doc88DownloadAdapter, DownloadAdapter)
    assert adapter.site == "doc88" and adapter.channel == "doc88"
    assert FOUR_STAGES == ("search", "plan", "fetch_ladder", "verify")
    with pytest.raises(NotImplementedError, match="选品"):
        adapter.search("水利", 10)
    result = adapter.fetch_ladder(HarvestPlan(meta=FileMeta(title="x", fmt="pdf")))
    assert isinstance(result, LadderResult) and result.ok is False  # T32 接线后：映射不抛
    assert result.wall_status is None and "p_code" in result.detail
    assert adapter.verify(LadderResult(ok=True)) is False  # T36 实装后：无产物即 False（不抛桩错）


def test_fr41_adapter_plan_discovers_and_stashes():
    """段2 plan=配置发现腿：FileMeta（URL 或 extra.p_code）→ 配置落 extra + 实测页数回填。"""
    fetch = _Recorder({"https://www.doc88.com/doc.php?act=info": (200, _INFO_CIPHERTEXT)})
    adapter = Doc88DownloadAdapter(fetch=fetch)
    meta = FileMeta(title="GRE 样例", fmt="pdf",
                    source_url=f"https://www.doc88.com/p-{SAMPLE_P_CODE}.html")
    plan = adapter.plan(meta)
    assert isinstance(plan, HarvestPlan) and plan.meta is meta
    assert meta.extra["p_code"] == SAMPLE_P_CODE
    assert meta.extra["doc88_config"]["p_pagecount"] == 119
    assert meta.extra["doc88_config"]["p_ebthost"] == SAMPLE_EBTHOST
    assert meta.pages == 119                      # 实测回填（原 None）

    meta2 = FileMeta(title="裸 p_code 件", fmt="ppt")   # 仅 extra.p_code（无 source_url）路径
    meta2.extra["p_code"] = SAMPLE_P_CODE
    plan2 = Doc88DownloadAdapter(fetch=fetch).plan(meta2)
    assert plan2.meta.extra["doc88_config"]["source"] == "info_xml"


def test_fr41_adapter_plan_waf_marks_wall_status_fr4_ac2():
    fetch = _Recorder({"https://www.doc88.com/": (200, WAF_BODY)})
    adapter = Doc88DownloadAdapter(fetch=fetch)
    meta = FileMeta(title="被墙件", fmt="pdf",
                    source_url=f"https://www.doc88.com/p-{SAMPLE_P_CODE}.html")
    with pytest.raises(Doc88WAFBlocked):
        adapter.plan(meta)
    assert meta.extra["wall_status"] == WALL_BLOCKED_WAF    # NFR1 统一落点


def test_fr41_adapter_plan_no_p_code_raises():
    adapter = Doc88DownloadAdapter(fetch=_Recorder({}))
    with pytest.raises(Doc88ConfigError, match="p_code"):
        adapter.plan(FileMeta(title="无定位件", fmt="pdf", source_url="https://doc88.com/list-1.html"))


# ---------- 实弹（真实网络 zero-mock；KB_HARVEST_SKIP_LIVE=1 跳过） ----------

_LIVE_REASON = "KB_HARVEST_SKIP_LIVE=1：实弹用例跳过（真实网络未跑，公约第4条）"


@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason=_LIVE_REASON)
def test_fr41_live_info_real_sample():
    """FR4.1 主验收实弹 1 份：69091550288 经 curl_cffi(impersonate=chrome) 取 info → key2→XML。"""
    cfg = discover_config(SAMPLE_P_CODE, fetch=_curl_cffi_get, timeout=30.0)
    assert cfg.source == "info_xml"
    assert cfg.p_code == SAMPLE_P_CODE and cfg.p_pagecount == 119
    assert cfg.p_ebthost == SAMPLE_EBTHOST and cfg.p_swf == SAMPLE_P_SWF
    assert cfg.p_allow_page_count == 119
    assert len(cfg.pages) == cfg.p_pagecount
    assert cfg.header_sizes == (455235, 453032, 454972)


@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason=_LIVE_REASON)
def test_fr41_live_new_docs_generalization():
    """通用性活探固化：2026 新件两份（分类页 /list-1022.html 取样）info 路全通。"""
    for p_code, pages in ((NEW_P_CODE_A, 71), (NEW_P_CODE_B, 56)):
        cfg = discover_config(p_code, fetch=_curl_cffi_get, timeout=30.0)
        assert cfg.source == "info_xml" and cfg.p_code == p_code
        assert cfg.p_pagecount == pages            # 2026-10-22 实测页数（零造假：漂移即红）
        assert len(cfg.pages) == cfg.p_pagecount
        assert cfg.p_ebthost.startswith("https://ebt")
        assert len(cfg.header_sizes) >= 1 and cfg.p_404 != "1"


@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason=_LIVE_REASON)
def test_fr41_live_page_fallback_leg():
    """失败回退页面路实弹：文档页挖 m_main → key1 → 71 键 JSON → 页表与 info 路一致。"""
    cfg, reason, waf = _leg_page(SAMPLE_P_CODE, _curl_cffi_get, 30.0)
    assert cfg is not None and not waf, reason
    assert cfg.source == "page_m_main" and cfg.p_pagecount == 119
    assert cfg.pages == _sample_xml_config().pages
