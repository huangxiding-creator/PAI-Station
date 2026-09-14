# 故障与边界手册（weread-download）

只在遇到异常/边界情况时读本文。

## 登录态（最高频故障）

**症状**：`WeReadAuthError: 登录失效 errCode=-2012`。

**机制**：cookie（`wr_skey` 等，存 `data/weread/_auth/weread_auth.json`）通常隔天失效；
而浏览器 profile（`data/browser_profile/`）存活更久。搜索接口对过期 cookie 宽松
——搜索成功 ≠ 登录态有效，章节接口才是真判据。

**处置**：
1. `.venv/Scripts/python.exe scripts/weread_login.py 300`
2. 三种结局：
   - 窗口闪开即关 + 打印 `SUCCESS vid=...`：profile 自动登录成功，cookie 已刷新
     （用户说"没看到你打开微信读书"就是这种——解释即可，不是故障）；
   - 窗口停留等待：需要用户用微信扫码（人类动作，别代劳）；
   - 超时退出：重跑一次，仍失败则检查网络/代理。
3. 重登录后重跑提取链——日计数器只在成功落书时 +1，失败不耗配额。

## 提取进程判活（勿误杀）

节流 1.5~3.5s/章下，大书 10~17 分钟/本是正常水位（实测：42 章 14.9min、
72 章 16.5min、13 章轻书 2.5min）。后台任务输出长时间空白多为管道缓冲，
不是卡死。判活三件套：

```bash
tasklist //FI "IMAGENAME eq python.exe"        # 进程在
stat -c "%y" data/weread/_recon/extract.lock   # 锁持有（注意：venv 启动器会拉起
                                                # 一个系统 python 子进程，同一任务）
ls -t data/weread/ | head -3                   # 书目录只在落盘时出现
```

进程在 + 锁在 → 继续等。目录已出现 → 该本已完成。

## 书目数据边界

- **抢读版/试读**：`partial=True` 或 `maxFreeChapter` 截断；章节会标 `skipped:<原因>`。
  处置：报告用户，建议换正式版，或等会员账号覆盖后重抓（重抓=整目录覆盖跑一次）。
- **空文章节**：`skipped` 为空但 `text` 空——多为篇题页/书名页/分隔页（html 只有
  标题标记），无内容损失；验收报告注明数量即可。
- **目录名 slug**：书名含 `/:?` 等 Windows 非法字符时替换为 `_`（如
  `怎么做调研_如何写报告`）；按 bookId 查书最稳，别按目录名硬匹配。

## 熔断

`_recon/circuit_break.json` 出现即当日止损：不再重试，向用户报告断点
（已成功哪些、剩余哪些明日续——每本书独立，无跨书依赖）。

## 下游衔接（提示用户，勿自动执行）

提取完成只到原料层。用户要"用"这本书时：
- `scripts/weread_book_products.py skill <书目录> --depth study` → 技能包（agentskills 规范）
- `scripts/weread_book_products.py cards <书目录>` → RIA 卡（人审后 commit 入复习队列）
- 金标准参考：智能商业 86K token → 7.9× 技能包（2026-09-10 实跑）

## 安全红线回顾

日限 3 本 / 书间 ≥120s / 节流内置勿改 / 只读接口 / 熔断即停。
放宽任何一条前必须问用户——收紧（更保守）可自主执行。
