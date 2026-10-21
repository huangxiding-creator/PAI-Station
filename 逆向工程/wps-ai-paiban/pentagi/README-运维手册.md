# PentAGI 本机全栈 — 运维手册

- **部署日**：2026-10-21（REA×reverse-skill×PentAGI 组合战役）
- **版本**：PentAGI 2.2.0-ce（vxcontrol/pentagi:latest）
- **位置**：WSL `RE-Ubuntu`（root）内 `/root/pentagi`；镜像经 docker.m.daocloud.io 等国内加速拉取
- **栈构成**：pentagi（主服务）+ pgvector（向量库）——最小栈；scraper/graphiti/langfuse/observability 可按需追加

## 访问

| 入口 | 地址 |
|---|---|
| Web UI | https://localhost:8443 （Windows 浏览器直达，自签证书点「继续访问」；首次访问注册第一个账号即为管理员） |
| API | 同址 `/api/v1/…`（凭据走 Web UI 会话/OAuth） |

## 供能

- **LLM**：GLM（智谱 open.bigmodel.cn，key 取自 `E:\AI-Station\data\secrets\zhipu.secret`，掩码写入 `/root/pentagi/.env` 的 `GLM_API_KEY`）
- **Embedding**：同 key 指向 `embedding-3`（`EMBEDDING_URL=https://open.bigmodel.cn/api/paas/v4`，provider=openai 兼容层）
- 换/加 provider：改 `/root/pentagi/.env` 对应 `*_API_KEY/*_SERVER_URL`（支持 OpenAI/Anthropic/Gemini/DeepSeek/GLM/Kimi/Qwen/MiniMax/Mistral/xAI/Ollama/自定义 OpenAI 兼容端点）→ `docker compose up -d pentagi` 重建生效

## 日常操作（均在 `wsl -d RE-Ubuntu` 内）

```bash
cd /root/pentagi
docker compose ps                 # 栈状态
docker compose logs -f pentagi    # 跟日志
docker compose stop               # 停栈（数据保留）
docker compose up -d              # 起栈
docker compose down               # 删容器（命名卷数据保留：pentagi_pentagi-*）
```

## 本役踩坑账（复用时必读）

1. **WSL NAT DNS 全死**（172.17.32.1:53 超时）→ resolv.conf 已固化公网 DNS（223.5.5.5/119.29.29.29）+ `wsl.conf generateResolvConf=false`；改后须 `systemctl restart docker` 刷新容器内嵌 DNS
1b. **systemd-resolved 会把 resolv.conf 改回 127.0.0.53 stub**（其上游损坏 → server misbehaving）→ 根治：`/etc/systemd/resolved.conf` 写 `DNS=223.5.5.5 119.29.29.29` + `DNSStubListener=no` → `systemctl restart systemd-resolved` → resolv.conf 写实义公网 DNS → `systemctl restart docker`（见 fix_dns.sh）
2. **quay.io 不可达**拖死全栈 → 最小栈跳过 postgres-exporter（纯监控件，非依赖）；**起栈永远用 `docker compose up -d pentagi`**（带服务名），裸 up 会拉全栈再撞 quay
3. `docker compose up | tail` 管道会吞退出码 → 部署脚本必须 `set -o pipefail`
4. wsl.exe 传内联 bash 长命令会碎 → 一律走 `/mnt/e/.../*.sh` 脚本文件
5. Docker Desktop 不存在也不需要——引擎就在 RE-Ubuntu（29.9.0 + compose v5.6.0，root/systemd）
6. 容器内验 GLM 连通性：wget 打 API 根路径得 **HTTP 401 = 可达**（到达网关被拒鉴权），不是故障

## 与 WPS AI排版 战役的关系

PentAGI 在本战役中承担「安全体检 AI 团队」角色：对已测绘的攻击面（wpscloudsvr 0.0.0.0:46608
私有协议、CEF 侧边栏、云端链路）可发起授权范围内的自动化评估 flow；目标限本机/本仓资产，
**禁止**对其余第三方目标发起任何测试。逆向成果与攻击面台账见上级目录《逆向报告.md》。

## 部署件清单

- `make_env.py` — .env 生成器（密钥猎取+随机化，掩码输出）
- `deploy.sh` / `deploy2.sh` / `deploy3.sh` — 三役部署脚本（含 DNS 修复与重试逻辑）
- `fix_embedding.sh` — embedding 补配
