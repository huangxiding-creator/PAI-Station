# GLOBAL-LAW 渠道台账（1124 用户令：纳入研报产线调研渠道 + 保持动态联系）

- 上游: github.com/lexifina/global-law（The world's law in git；CC0；991 辖区语料；上游高频更新，pushed_at 常当日）
- 本地库: `E:\AI-Station\global-law\repo`（depth-1 快照，ghfast 镜像克隆；仅本仓 config 有 ghfast 改写，全局未动）
- 接入器: `E:\AI-Station\global-law\glaw.py`（REST 搜索 + 本地 git 历史四命令 + sync 动态联系）
- 中国法子模块: china/national/acts → lexifina/china-law（~900MB，含民法典/部门规章/公报，In-force 日期史）

## 产线用法（S1/法规核验/涉外）

| 场景 | 命令 |
| --- | --- |
| 法条逐字对照（本地零联网，免撞限流峰） | `py -X utf8 glaw.py log/show ...`（子模块 add 后） |
| 涉外调研（OVERSEAS/储能出海战役） | `py -X utf8 glaw.py search "general contractor" --jurisdiction vietnam` |
| 辖区盘点 | `py -X utf8 glaw.py juris vietnam` / `juris china` |
| 条文沿革（每一条是谁哪天写进去的） | `py -X utf8 glaw.py log <provision-path>` |
| 动态联系（用户令） | `py -X utf8 glaw.py sync`（上游体检，--pull 快进；每战役 S1 前跑一次） |

## 纪律

- REST 搜索=引擎端实时，无需本地库；本地 law.py=需先 `glaw.py add <辖区>` 拉子模块
- 引用法条仍按「法规与示范文本引用清单」纪律：优先官方页，global-law 作本地逐字对照与沿革考证（In-force 日期精确到 commit）
- 判例语料（caselaw 语料）不替代判例池收编——只作涉外先例参考（case_check/resolve_citations 工具在库）
- sync 只进不删：fetch+快进，不删任何本地件
