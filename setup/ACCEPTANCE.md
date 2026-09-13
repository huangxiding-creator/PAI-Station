# M6.9 干净环境验收清单

目标：证明「新 Windows 笔记本 + 双击安装包」能从零跑通 M1-M6，
不依赖开发机的任何残留（venv/模型/密钥/git 仓库历史）。

## A. 一键自动验收（开发机/CI，每天可跑）

```powershell
.venv\Scripts\python.exe -X utf8 scripts\acceptance_e2e.py
```

六环全过返回 0：硬件分级 / 首启向导 / 感知→执行→交付全链 /
技能锻造+回滚 / 备份推送（本地 bare）/ 技能包导出导入。
全假件零网络零密钥；产物在临时目录，验收完即焚。

## A+. 干净房验证（2026-09-13 已通过 ✅）

```powershell
.venv\Scripts\python.exe -X utf8 scripts\cleanroom_test.py
```

模拟新机器：产 wheel+离线 wheels → 临时目录全新 venv（零 dev 依赖）
→ `pip install --no-index` 纯离线装 → 干净房内 `--version` + A 节六环。
**首跑实证**：paistation 1.0.0 可跑、6/6 环节通过、退出码 0。
这是 B 节真 VM 双击之外能自动化的全部。

## B. 虚拟机双击验收（发布前必做一次）

环境：全新 Windows 10/11 VM（或新用户目录），只装：

1. Python 3.11+（勾 Add to PATH）——installer 前置条件
2. Inno Setup 6（仅构建机需要；VM 只收 Setup.exe）

步骤：

| # | 动作 | 通过标准 |
|---|------|----------|
| 1 | 构建机：`setup\build.ps1` → `ISCC setup\installer.iss` | 测试全绿 + Setup.exe 产出 |
| 2 | VM：双击 `PAI-Station-Setup-1.0.0.exe` | 免管理员、装到 `%LOCALAPPDATA%\PAI-Station\app` |
| 3 | 装后自动跑 `postinstall.ps1` | venv 离线建成、doctor 5+ 项 ✓ |
| 4 | 托盘随装启动（勾选框） | 托盘图标出现，暂停/退出可用 |
| 5 | VM 断网重装一遍 | 断网也能装（离线 wheels）✓ |
| 6 | VM 内：`app\.venv\Scripts\python.exe -X utf8 scripts\acceptance_e2e.py` | 6/6 环节通过 |
| 7 | （可选联网）`python scripts\fetch_bge_m3.py` | 模型下载成功后 vec 检索仍绿 |
| 8 | 卸载 | app 目录清掉、`%LOCALAPPDATA%\PAI-Station` 数据保留 |

## C. 红线回看（每项都要在 VM 上眼见为实）

- [ ] 卸载不删用户数据（记忆神圣）
- [ ] 断网安装不炸（离线 wheels + 无模型降级 hashing）
- [ ] 全程不需要管理员权限
- [ ] 密钥零落盘（向导只记环境变量名；`wizard.json` 无 sk- 字样）
