# bdn 技能自检清单（2026-10-29，结果=当日实测，数字零造假）

验收口径：`python -I bdn.py --help` 与 16 个子命令 `--help` 实测输出的每个参数，在 references/commands.md 有对应行。

## 1. 参数覆盖（argparse 实测 → commands.md grep 命中数，0=FAIL）

实测命令：`python -I E:\AI-Station\逆向工程\baidu-netdisk\replica\bdn.py --help` 及各子命令 `--help`（2026-10-29 全部实跑，纯本地零网络）。

| 参数 | 归属命令 | commands.md 命中 | 判定 |
|---|---|---|---|
| `--cred` | 全局 | 1 | PASS |
| `--json` | 全 16 命令 | 17 | PASS |
| `--page` | ls/shares/recycle | 6 | PASS |
| `--num` | ls/tree/search/recycle | 8 | PASS |
| `--depth` | tree | 2 | PASS |
| `--max-requests` | tree | 2 | PASS |
| `--dir` | search | 2 | PASS |
| `--no-recursion` | search | 2 | PASS |
| `--confirm` | rm | 4 | PASS |
| `path`（位置） | ls/tree/mkdir/rename | 4 | PASS |
| `key`（位置） | search | 1 | PASS |
| `fsids`（位置） | meta | 1 | PASS |
| `newname`（位置） | rename | 1 | PASS |
| `src`/`dst`（位置） | mv/cp | 1/1 | PASS |
| `local`/`remote`（位置） | upload/download | 2/2 | PASS |
| `paths`（位置） | rm | 1 | PASS |

子命令 16/16（whoami quota ls tree search meta shares recycle doctor mkdir rename mv cp rm upload download）全在 SKILL.md 映射表与 commands.md 有节。

## 2. SKILL.md 行数 < 500

实测：92 行。PASS。

## 3. 技能目录零凭据

实测扫描（`grep -rEc "BDUSS=[A-Za-z0-9~-]{20}|STOKEN=|bduss\": \"[^*]"`）：零命中。
目录内容仅 SKILL.md + references/{commands,safety,zoning}.md + 本文件。PASS。

## 4. 官方 baidu-drive 技能零修改

实测：`git -C E:\AI-Station status --porcelain -- .claude/skills/baidu-drive/` 输出为空。PASS。

## 5. 调用形态验证

跨 cwd 绝对路径 `python -I E:\AI-Station\逆向工程\baidu-netdisk\replica\bdn.py quota --help`（自 E:\ 发起）：exit=0。PASS。

## 6. 事实来源声明

- 命令面/参数/默认值：bdn.py argparse 实测 --help（不臆造）。
- JSON 字段：bdn.py 各 cmd_* + bdncore/api.py（share_records 掩码在协议层）+ bdncore/transfer.py 引擎返回字典逐字段提取。
- 红线：PROPOSAL.md §六/§七改写为 agent 行为规范。
- 怪癖/实测数字：replica/README.md（搜索冒号怪癖/慢端点/tree 预算/秒传遗留/速度口径）。
