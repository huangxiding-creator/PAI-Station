# 故障与边界手册（metaso-upload）

只在遇到异常/边界情况时读本文。

## 依赖链

`scripts/metaso_upload.py` → import `.claude/skills/waytoagi-sync/scripts/upload_metaso.py`
（生产配方：DrissionPage 持久 profile + CRC32 稳定端口 + 页内 fetch）。
若报 `ModuleNotFoundError: upload_metaso`：检查 skill 目录是否被移动/改名。

## 浏览器与登录态

- **profile 启动失败（端口 9499 被占）**：ensure_browser 自动 fallback 下一个
  profile/端口，日志出现「尝试下一个」后紧跟「浏览器就绪」即正常，勿手动干预。
- **登录态失效**：ensure_login 流程 = 页面标记检查 → API 探测 → 读
  `E:\CPOPC\We-AIPO\.env` 账号自动登录 → 都失败才弹可见窗口等人工。
  自动登录成功时窗口闪开即关——用户"没看到窗口"不代表失败。
- **登录账号不是目标知识库账号**：上传会落到错误的空间。上传前若用户提过
  多账号，先 `GET /api/knowledge/{sid}/search` 读接口验证 subject 可见性。

## 目标目录解析

- **用户只给目录名不给 URL**：先在秘塔 UI 该目录页复制地址栏 URL（含 cfid），
  再跑 `--url`。**不要**用名字盲猜搜索后直接传——同名目录会传错地方。
- **`--folder` 建夹失败**（create 返回空）：多为登录态过期或目录层级超限，
  先 ensure_login 重试；仍失败则报告用户改用直传 cfid。
- **嵌套建夹**：`--folder "a/b"` 逐级建，任一级失败即停（不会传到半路目录）。

## 上传契约（改代码前必读）

- 写端点：`PUT /api/file/{cfid}`（FormData：file/fileName/type）；
  建夹：`PUT /api/file/{parentId}/folder` body `{"name": ...}`。
- **写请求绝不带 `token` header**——cookie 认证；`meta-token` 只给读接口
  （`GET /api/knowledge/{sid}/search`）带上。搞反 = 401/权限覆盖。
- 成功 = HTTP 200 **且** `errCode==0`；`errCode==1` = 同名已存在（幂等，视为成功）。
- 每 150 次页内 fetch 自动刷新管理页（防标签页内存累积崩溃），勿删。

## 台账与断点

`data/metaso/_recon/upload_<cfid>.jsonl`：一行一文件 `{path,status,info,ts}`，
status=ok 的重跑自动跳过。**同一文件内容更新后想重传**：不能靠重跑（会被
跳过且服务端 errCode==1 幂等拦截）——改名上传或人工在 UI 替换，并向用户说明。

## 大文件与规模水位（实测 2026-09-14）

- 单文件 956KB md 正常（页内 Blob→FormData，timeout=120s 内完成）。
- 13 本书 5.2MB 全量 44s（含 2-4s 节流）——秘塔对 md 上传无感知限速，
  瓶颈只在节流纪律本身。超百文件长跑参考「长跑任务晚间执行」惯例。

## 只增不删红线

任何情况下不调用删除接口、不"清理传错的文件"。传错位置 → 报告用户，
由用户在 UI 自行处理（或明确授权后才可动，删除永远需要显式授权）。
