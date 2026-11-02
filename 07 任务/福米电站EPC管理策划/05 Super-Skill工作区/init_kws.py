# -*- coding: utf-8 -*-
"""FOMI-EPC 池课题关键词拓宽重设 (judge 启发式按 kws 判相关; 单词窄门误伤已证)."""
import sys
from pathlib import Path

sys.path.insert(0, r"E:\AI-Station\reforge_factory")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import ammo_pool                                        # noqa: E402

KWS = ("几内亚 福米 水电站 EPC 工程总承包 项目管理 兰州水源地 黄河勘测规划设计研究院 "
       "水电三局 莫莫克 水利水电 FIDIC 国际工程 海外工程 凯乐塔 几内亚 管理体系 "
       "管理策划 质量 安全 进度 合同 采购 设计 施工 风险 造价 监理 数字化 BIM "
       "策划 组织设计 施工组织 移民 环保 属地 用工 清关 物流 融资 担保 税务")

d = ammo_pool._camp_dir("FOMI-EPC")
s = ammo_pool._load_state(d)
s = {**s, "kws": ammo_pool.parse_kws(KWS)}
ammo_pool._save_state(d, s)
print("[kws] 重设后课题关键词 %d 个: %s" % (len(s["kws"]), "、".join(s["kws"][:12]) + "…"))
