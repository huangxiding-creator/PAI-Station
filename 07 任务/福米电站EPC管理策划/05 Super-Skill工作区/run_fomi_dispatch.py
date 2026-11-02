# -*- coding: utf-8 -*-
"""FOMI-EPC 调度启动器 — 避开 PowerShell 5.1 中文 argv 编码坑, 全程 UTF-8 无损.
用法:
  py -X utf8 run_fomi_dispatch.py init
  py -X utf8 run_fomi_dispatch.py dispatch A --dry-run
  py -X utf8 run_fomi_dispatch.py dispatch B
"""
import subprocess
import sys

PY = sys.executable
FACTORY = r"E:\AI-Station\reforge_factory"
CAMPAIGN = "FOMI-EPC"

WAVES = {
    "A": [  # 项目本体 + 几内亚国别实施条件 + 国际大奖对标
        "几内亚福米水电站",
        "几内亚 中国企业 水电 工程承包",
        "凯乐塔水电站 苏阿皮蒂 中国水电",
        "几内亚 施工 雨季 气候 物流 清关",
        "几内亚 劳工制度 安全风险 中资企业",
        "PMI 项目管理大奖 评选标准",
        "IPMA 国际卓越项目管理大奖 获奖项目",
        "几内亚 环评 移民安置 水电工程",
    ],
    "B": [  # EPC 管理方法论 + 标杆项目 + 黄河院/水电三局
        "EPC 项目管理策划 水利水电 总承包",
        "设计牵头 EPC 设计施工融合 国际工程",
        "FIDIC 银皮书 EPC 合同管理",
        "工程总承包管理规范 GB/T 50358",
        "莫莫克水利枢纽 工程总承包",
        "兰州水源地 EPC 项目管理",
        "黄河勘测规划设计研究院 工程总承包 业绩",
        "中国水电三局 海外 大坝施工",
    ],
    "C": [  # 二轮定向: 决疑与补齐 (1102 批准后)
        "莫特麦克唐纳 项目管理策划",
        "Mott MacDonald project execution plan infrastructure",
        "工商银行 绿色金融 赤道原则",
        "中国信保 水利水电 海外投资",
        "几内亚 所得税 税率 投资法",
        "几内亚 劳动法 外籍员工 配额",
        "水电三局 凯乐塔 苏阿皮蒂 几内亚",
        "国际EPC 项目执行计划 PEP 模板",
        "设计院 工程总承包 转型 案例",
        "几内亚 本地分包 采购 法规",
    ],
}


def run(cmd):
    print(">>>", " ".join(cmd[:6]), "...", flush=True)
    r = subprocess.run(cmd, cwd=r"E:\AI-Station")
    print("exit =", r.returncode, flush=True)
    return r.returncode


def main():
    mode = sys.argv[1] if len(sys.argv) > 1 else "help"
    if mode == "init":
        return run([PY, "-X", "utf8", FACTORY + r"\ammo_pool.py",
                    "init", CAMPAIGN, "--kw", "几内亚福米水电站EPC建设管理策划"])
    if mode == "dispatch":
        wave = sys.argv[2]
        extra = sys.argv[3:]
        cmd = [PY, "-X", "utf8", FACTORY + r"\channels_dispatcher.py",
               "--campaign", CAMPAIGN, "--kws", ",".join(WAVES[wave]),
               "--max-concurrent", "4", "--rows", "8"]
        cmd += extra
        return run(cmd)
    print(__doc__)
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
