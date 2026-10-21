# -*- coding: utf-8 -*-
"""W7 冒烟运行器：环境三件套 + CLI --once（经 main()，与 py -3 -m 同路）。

- KB_LOCAL_CORPUS → samples/smoke/corpus（语料覆盖）
- KB_WECOM_NOTIFY=0 → 冒烟不触发真企微通知
- KB_SMTP_SECRET → 指向不存在的路径（演示 SMTP 缺配→降级分支）
"""
import os
import sys
from pathlib import Path

SMOKE = Path(__file__).resolve().parent
REPO_ROOT = SMOKE.parents[3]

sys.path.insert(0, str(REPO_ROOT))
os.environ["KB_LOCAL_CORPUS"] = str(SMOKE / "corpus")
os.environ["KB_WECOM_NOTIFY"] = "0"
os.environ["KB_SMTP_SECRET"] = str(SMOKE / "_no_smtp.secret.ini")

from kb_factory.fulfillment.__main__ import main  # noqa: E402

if __name__ == "__main__":
    raise SystemExit(main(["--once", "--base", str(SMOKE)]))
