# -*- coding: utf-8 -*-
"""FOMI-EPC 提案呈批企微通知驱动件 (防 shell 中文编码坑)."""
import sys

sys.path.insert(0, r"E:\AI-Station\tools")
import notify_approval_wecom as nw                     # noqa: E402

TITLE = "【呈批】几内亚福米水电站EPC建设管理策划·编制提案 v1.0"

DETAIL = """**调研底座**: 68渠道全动用+语料池4580条/3743万字(2000万字门187%)·10路精读+5路外网研究+4路一手档案深学
**提案核心**: 工行13疑虑读者工程×三层对标(GB/PMBOK/PMI/IPMA)×151条素材重构台账×17章目录框架v1.1×零编造数字基准表执法
**四项请批**: ①批准编制路线(目录v1.1+管线+日程:11-09初稿/11-16定稿对齐11-17工行会) ②口径三裁决(合同额表述/苏阿皮蒂角色/报批vs初设双表述) ③督办素材供给(最小图片8件今日催收+三大硬缺口:国际业绩明细/投标80页方案/数字化证据包) ④批准后即启二轮调研+NBLM产线
提案全文: 07 任务/福米电站EPC管理策划/05 Super-Skill工作区/PROPOSAL.md"""

if __name__ == "__main__":
    sys.argv = ["notify", TITLE, DETAIL]
    raise SystemExit(nw.main())
