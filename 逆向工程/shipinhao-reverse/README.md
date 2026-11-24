# sph.py — 视频号后台 CLI

视频号助手后台（channels.weixin.qq.com）纯 HTTP 复刻件。逆向报告见 [API_MAP.md](API_MAP.md)。

## 快速开始

```bash
# 默认走保险库 cookie（F:/We-AIPO/data/state/channels_cookies_vault.json，S367 保活链维护）
python sph.py whoami
python sph.py post list --count 10
python sph.py stat overview
python sph.py live history --count 20
python sph.py shop orders --count 50
```

## 凭据三选一

```bash
python sph.py whoami                                  # ① 默认保险库
python sph.py --cookie "sessionid=..;wxuin=.." whoami # ② 显式 cookie
SPH_COOKIE="sessionid=..;wxuin=.." python sph.py whoami  # ③ 环境变量（CI 推荐）
```

## 命令全集（v1 全只读）

| 域 | 命令 |
|---|---|
| 身份 | `whoami` |
| 内容 | `post list [--page --count --type 0/3/4/5]` `post drafts` `post albums` `post get <objectId>` `post link [objectId]` |
| 数据 | `stat overview` `stat posts` `stat fans-trend` `stat fans-portrait` |
| 直播 | `live history [--page --count]` `live replays` `live last` |
| 互动 | `comment feeds` `comment list <exportId>` |
| 私信 | `msg sessions` `msg new` |
| 橱窗 | `shop status` `shop products` `shop orders [--page --count]` |
| 其他 | `notify list` `income detail` `member` `collection list` `profile sections` |

- `--json` 任何命令输出原始 JSON（管道/CI 消费）
- `comment list` 需 exportId：先 `post list --json` 取 exportId
- errCode≠0 直接报错退出（会话失效时先跑 s367_login.py 刷新保险库）

## 依赖

零第三方依赖（纯 urllib），python3.8+ 任意环境。
