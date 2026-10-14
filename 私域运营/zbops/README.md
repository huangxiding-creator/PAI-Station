# zbops — 总包私域运营台 P0（企微主体）

按 [ARCHITECTURE.md](../ARCHITECTURE.md) §8 路线图 P0 阶段实现：企微智能机器人长连接群答疑 + AI 编排闭环 + Guardian 护栏骨架 + 数据骨架。

## 模块

```
zbops/
├─ wecom/          企微通道层
│  ├─ core.py      wecom-core：access_token 缓存/刷新、API 客户端、错误码映射
│  ├─ aibot.py     智能机器人 wss 长连接网关（群@触发→AI→流式回复）
│  ├─ callback.py  回调接收服务（FastAPI，echostr 验证 + AES 解密）
│  └─ crypto.py    WXBizMsgCrypt（AES-256-CBC + SHA1 签名，官方算法）
├─ ai/             AI 编排层（唯一大脑）
│  ├─ gateway.py   模型网关：T1 小模型/T2 大模型路由、预算硬顶、降级链
│  ├─ retriever.py 智库检索：FTS5 关键词前置 + 条款级引用元数据
│  ├─ citation.py  引用校验器：条款号必须来自命中 chunk（防幻觉）
│  └─ pipeline.py  管线：规则预筛→意图→上下文→RAG→生成→校验→护栏→治理
├─ guardian/       护栏层（横切强制）
│  ├─ gateway.py   ActionGateway：急停→日历→令牌→审核→人审→审计→HMAC票据
│  ├─ moderation.py 三级词库审核闸（广告法/工程承诺类/涉政）
│  └─ ratelimit.py 四维令牌桶（SQLite 持久化，重启不清零）
├─ data/           数据骨架
│  ├─ schema.sql   core.db 建表（contacts/groups/messages/actions/freq_ledger/audit）
│  └─ store.py     单写者存储门面（SQLCipher 可选，默认明文+ACL）
└─ main.py         进程组装：无凭据=dry-run 自检，有凭据=上线运行
```

## 快速开始

```bash
cd 私域运营/zbops
py -m pip install -r requirements.txt

# 1) 自检（无需任何凭据）：加解密回环/票据链/词库/令牌桶/引用校验
py -I main.py selftest

# 2) 配置
copy config\config.example.yaml config\config.yaml   # 填入凭据（见下）

# 3) 运行（智能机器人长连接，免公网 IP）
py -I main.py run
```

## 上线前必须由主理人提供（对应 ARCHITECTURE §10 开放问题）

| 配置键 | 说明 | 获取方式 |
|---|---|---|
| wecom.corp_id | 企业 ID | 企微管理后台→我的企业 |
| wecom.aibot.secret | 智能机器人 Secret | 管理后台→应用管理→智能机器人 |
| wecom.agent.secret | 自建应用 Secret（回调用） | 管理后台→自建应用 |
| wecom.callback.token/aes_key | 回调加解密对 | 自建应用→接收消息配置 |
| ai.anthropic.key / ai.zhipu.key | 模型密钥 | 各开放平台 |
| kb.sources_dir | 智库 PDF 目录 | 总包智库导出 |

## 安全基线

- 凭据只入 config.yaml（.gitignore 已含）或环境变量，永不入库不进日志
- 一切出站动作经 Guardian 票据链，无票据执行器拒发
- kill switch：创建 `C:\zb-ops\runtime\breaker.on` 即全停
- 审计 append-only（JSONL 按日分片 + SQLite 索引 + 哈希链）
