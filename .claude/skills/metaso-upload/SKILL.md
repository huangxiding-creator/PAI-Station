---
name: metaso-upload
description: 把本地文件（md 书籍/调研资料/文档）批量上传到秘塔知识库的任意指定目录（工程大脑/专题/自建子目录）。Use when 用户要求上传、同步、备份文件到秘塔（metaso.cn）、工程大脑，或给出 metaso 管理页 URL 让传东西时。内嵌安全铁律（只增不删、先冒烟、幂等台账、熔断）与目录解析（URL/cfid/按名建夹）。
---

# 秘塔知识库上传

项目内成熟管线：解析目标目录 → 冒烟 1 个 → 全量上传（台账断点续跑）→ 验收。
实现复用 waytoagi-sync 的生产级 `MetasoClient`（登录自愈/页内 fetch/幂等契约），
本 skill 只编排，不重新发明。

## 命令

```bash
# 目标三种给法（URL 最常用——用户从浏览器地址栏复制即可）：
.venv/Scripts/python.exe scripts/metaso_upload.py \
  --url "https://metaso.cn/subject-v2/<sid>/manage?cfid=<cfid>" <文件|目录...>
.venv/Scripts/python.exe scripts/metaso_upload.py \
  --cfid <cfid> [--subject <sid>] <文件|目录...>          # 已知 id 直给
.venv/Scripts/python.exe scripts/metaso_upload.py \
  --url <URL> --folder "调研/2026Q4" <文件|目录...>       # 目标下按名建/复用子目录（可嵌套）

# 开关：--smoke 只传第一个 | --dry-run 只列清单不开浏览器 | --docx 同时允许 docx
```

## 四步流程

1. **解析目标**：`--url` 从管理页地址提取 subject+cfid；`--folder` 逐级
   `create_folder`（已存在自动复用——errCode==1 → find_folder 兜底，幂等）。
2. **列清单**：先 `--dry-run` 确认文件集与大小（目录递归收 md，`_` 前缀目录跳过）。
3. **冒烟**：`--smoke` 传 1 个验证登录态与写权限，成功才全量。
4. **全量 + 验收**：2-4s 随机节流，断连 4 次自愈重试，连续 5 败熔断。
   台账 `data/metaso/_recon/upload_<cfid>.jsonl` 按 cfid 断点续跑（status=ok 跳过）。
   结束向用户报 ok/fail 表，提醒可到秘塔 UI 抽查。

## 安全铁律（硬约束）

- **只增不删**：永不调用任何删除/覆盖接口；传错目录只能报告用户，不擅自清理。
- **先冒烟后全量**：每次新目标 cfid 首跑必须 `--smoke`。
- **写接口不带 token header**：`meta-token` 只用于读接口（配方已在
  MetasoClient 内置，改端点时勿破坏此契约——带上会覆盖 cookie 写权限）。
- **节流 2-4s / 熔断 5 连败**：内置勿改；熔断后重跑即续传，无重复上传风险
  （errCode==1 = 已存在，视为幂等成功）。
- **格式政策**：默认只传 md；docx 需显式 `--docx`。

## 常见信号（速查）

| 信号 | 处置 |
|---|---|
| `errCode==1` | 文件已存在 = 幂等成功，不是失败 |
| 端口 9499 连接失败 + "尝试下一个" | profile 端口被占，fallback 自动换，继续跑 |
| `登录态无效` → 自动弹窗 | ensure_login 自动登录/等扫码；详见 playbook |
| 单文件 >900KB | 可传（实测 956KB ok，走页内 Blob→FormData） |
| 想知道某个目录的 cfid | 请用户从浏览器复制管理页 URL，别盲猜 |

## 故障与边界情况

详见 [references/playbook.md](references/playbook.md)——遇异常先读它再动手。
