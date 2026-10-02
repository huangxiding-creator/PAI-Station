# 部署上云与包上传全链配方（ECS+域名+备案+miniprogram-ci）

实录来源：`E:\AI-Station\WeAppForge\work\` 部署/点火/出码脚本 + `services/qianwen-engine/qianwen_engine/config.py` + qianwen-gc-proposal 记忆档案。全部片段照抄源文件，可按图索骥复用。

## 1. 引擎上云链

通道=阿里云云助手 `ecs RunCommand`（SSH 22 不对公网开），ECS 实例 `i-f8za6qhv365cwhti5y35`（47.120.43.20，region `cn-heyuan`）。远端布局 `/opt/qianwen/{services/qianwen-engine/qianwen_engine, data/secrets, data/qianwen, venv}`。服务形态=systemd 常驻 `qianwen-engine.service`。

| 环节 | 落点 | 脚本 |
|---|---|---|
| 全新装机（venv+依赖+systemd） | /opt/qianwen/ | work/ecs_deploy.py |
| 版本增量（tar 包→分片→重启→自检） | /opt/qianwen/services/qianwen-engine | work/ecs_deploy_v073.py |
| 本机防火墙放行 | ufw | work/ecs_open8869.py |
| DB 探针 | /opt/qianwen/data/qianwen/db.sqlite | work/ecs_probe2.py |

### 坑

- **坑 1：云助手 RunCommand 内容上限约 16KB**
  表象：整文件塞 `--CommandContent` 直接失败（app.py 17364B 即超）。
  根因：单条命令内容有硬上限，超限即被拒。
  修法：内容先 base64，按 15000 字符/片 `printf '%s' '<chunk>' >> /tmp/xx.b64` 追加落位，每片后 `wc -c` 校验累计长度，最后 `base64 -d | tar xzf -`。
- **坑 2：回包状态字段=InvocationStatus，等 Status 必超时**
  表象：轮询 `DescribeInvocationResults` 永远等不到结果。
  根因：状态字段名是 `InvocationStatus`（取值 `Finished/Success/Failed/Cancelled/Timeout`），且完成判据也可用 `ExitCode is not None`；`Output` 是 base64，需 `base64.b64decode` 后才是明文。
  修法：照抄 ecs_probe2.py 的轮询循环（见下配方）。
- **坑 3：双层墙漏一层=公网不通**
  表象：安全组已开端口，curl 仍超时。
  根因：ECS 本机 ufw active+deny incoming，`阿里云 SG` 与 `本机 ufw` 是两道独立的墙，只开 SG 不够。
  修法：`ufw allow 8869/tcp comment 'qianwen engine'`（work/ecs_open8869.py），SG 侧只能用户控制台开。
- **坑 4：--CommandContent 必须纯文本**
  表象：带引号/转义的脚本在远端炸出奇怪语法错。
  根因：命令内容经多层 shell 转手，引号地狱。
  修法：SQL/代码本体先 base64 成纯字母数字串再灌（ecs_probe2.py 定型：「--CommandContent 必须纯文本(SQL 本体 b64 直灌绕引号地狱)」），`--InstanceId.1` 数组形。

### 配方

systemd 常驻单元（ecs_deploy.py 原文，Restart=always 是常驻关键）：

```ini
[Unit]
Description=qianwen-engine (biaoxun KB)
After=network.target

[Service]
WorkingDirectory=/opt/qianwen/services/qianwen-engine
ExecStart=/opt/qianwen/venv/bin/python -m uvicorn qianwen_engine.app:app --host 0.0.0.0 --port 8869 --log-level warning
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
```

云助手执行+轮询骨架（ecs_probe2.py）：

```python
r = subprocess.run(
    ["aliyun", "ecs", "RunCommand", "--RegionId", REGION, "--InstanceId.1", IID,
     "--Type", "RunShellScript", "--Name", "probe-v072b", "--CommandContent", remote,
     "--Timeout", "120"],
    capture_output=True, text=True, timeout=90)
inv = json.loads(r.stdout)["InvokeId"]
for _ in range(25):
    time.sleep(2)
    g = subprocess.run(
        ["aliyun", "ecs", "DescribeInvocationResults", "--RegionId", REGION,
         "--InvokeId", inv],
        capture_output=True, text=True, timeout=60)
    d = json.loads(g.stdout)
    res = d["Invocation"]["InvocationResults"]["InvocationResult"][0]
    st = res.get("InvocationStatus")
    if st in ("Finished", "Success", "Failed", "Cancelled", "Timeout"):
        print("Status:", st)
        print(res.get("Output", "")[:2500] or "(empty output)")
        sys.exit(0)
```

分片部署收尾（ecs_deploy_v073.py：备份现役→解包→编译→重启→自检）：

```bash
cd /opt/qianwen/services/qianwen-engine && \
mkdir -p /opt/qianwen/backup_v072 && cp -r qianwen_engine /opt/qianwen/backup_v072/ && \
base64 -d /tmp/qw_v073.b64 | tar xzf - && rm -f /tmp/qw_v073.b64 && \
/opt/qianwen/venv/bin/python -m py_compile qianwen_engine/*.py pot_seed_zhipu.py && echo COMPILE_OK && \
systemctl restart qianwen-engine && sleep 3 && \
systemctl is-active qianwen-engine && \
curl -s -o /dev/null -w 'local=%{http_code}\n' http://127.0.0.1:8869/api/health
```

分片公式：`shards = (len(b64) + 14999) // 15000`；每片后校验 `str(expected) in out.replace(" ", "")`。依赖安装走阿里云镜像：`pip install -q -i https://mirrors.aliyun.com/pypi/simple/ fastapi 'uvicorn[standard]' curl_cffi`。装机自检判据=`local_probe=401`（/api/quota 无 token 必须 fail-closed 回 401，回 200 反而错）。

## 2. 域名与备案链

nginx 真身在 docker 容器 `docker-nginx-1` 内，conf 落宿主 `/root/dify/docker/nginx/conf.d/`。点火五步（work/ecs_yrecepc_ignite.py，幂等可重跑，前置=用户已加 A 记录 域名→47.120.43.20）：

1. DNS 校验：`dig +short <域名> @223.5.5.5`，回包须含 `47.120.43.20`，否则中止。
2. 80 vhost 引导：仅 ACME challenge 路径 + 其余 `return 444`（备案期关站不裸奔），`nginx -t && nginx -s reload`。
3. certbot 签发：HTTP-01 webroot（见下配方）。
4. 全量 conf 替换：80=301 跳 443，443=ssl proxy 到内网引擎，热加载。
5. 公网自检：`public443=200` + `http80=301` + `certbot renew --dry-run`。

| 域名 | 结局 | 原因 |
|---|---|---|
| api.gcbrain.top | 备案卡步4（传图+人脸）弃用，订单 2032850488548 留作备用 | 未备案 80 口被边缘层截胡，证书签不了 |
| api.yrecepc.cn | 1001 点火收官 public443=200 | 用户已备案域，ACME 直通 |
| ai.epcschool.top | 1002 在役 | apex=epcschool.top 总包学园已备案域，Tencent 云全栈 |

### 坑

- **坑 1：未备案域名 80 口被边缘层截胡**
  表象：certbot HTTP-01 预签收 `403 unauthorized`，但容器内带 Host 探针回 404。
  根因：大陆 ECS 上未备案域名的 80 口流量被阿里云边缘拦截层直接截胡，自家 nginx 根本没轮到执行（webroot 挂载已验对齐）。
  修法：证书只能备案通过后签。对照证据：已备案域名（yrecepc.cn）ACME 探针=自家 nginx 404，边缘 403 不存在。DNS-01 预签是 fallback，未启用。
- **坑 2：certbot 成功判据假阴性**
  表象：step[3] 输出看不到成功字样，以为签发失败。
  根因：脚本用 `tail -6` 截尾，只截到捐赠 banner，成功行被吃掉。
  修法：重跑见 `Certificate not yet due for renewal` 即首轮已签成的铁证（幂等设计在此救场）。判定串含 `Successfully received certificate` / `Congratulations` / `Certificate not yet due for renewal` 三态任一。
- **坑 3：request 合法域名加不进 API**
  表象：`modify_domain` API 对自有 appid 回 40014。
  根因：该接口不适用自有小程序。
  修法：只能用户控制台手加（开发管理→开发设置→服务器域名 request 合法域名）。同理 DNS A 记录：CLI 无 alidns 权限、控制台浏览器自动化 15 轮攻坚失败，也是用户手加。
- **坑 4：beian 表单 textarea 首匹配是隐藏 JSON 槽**
  表象：备注文本误灌进名称字段，提交硬卡。
  根因：`tag:textarea` 首个匹配是隐藏 JSON 槽，真身要按 placeholder「请根据实际情况填写备注内容」匹配。

### 配方

全量 vhost（ecs_yrecepc_ignite.py 原文，占位=目标域名与引擎内网位）：

```nginx
server {
    listen 80;
    server_name <域名>;
    location /.well-known/acme-challenge/ { root /var/www/html; }
    location / { return 301 https://$host$request_uri; }
}
server {
    listen 443 ssl;
    http2 on;
    server_name <域名>;
    ssl_certificate /etc/letsencrypt/live/<域名>/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/<域名>/privkey.pem;
    ssl_protocols TLSv1.2 TLSv1.3;
    add_header Strict-Transport-Security "max-age=31536000" always;
    location / {
        proxy_pass http://172.29.8.146:8869;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_read_timeout 120s;
        proxy_send_timeout 120s;
        client_max_body_size 12m;
    }
}
```

certbot 签发（webroot 与证书目录都在宿主 certbot 卷，deploy-hook 让续期后自动 reload）：

```bash
certbot certonly --webroot -w /root/dify/docker/volumes/certbot/www \
  -d <域名> --email <登记邮箱> --agree-tos --non-interactive --no-eff-email \
  --config-dir /root/dify/docker/volumes/certbot/conf \
  --deploy-hook 'docker exec docker-nginx-1 nginx -s reload'
# 续期配置持久化：
mkdir -p /etc/letsencrypt && printf 'config-dir = /root/dify/docker/volumes/certbot/conf\n' > /etc/letsencrypt/cli.ini
# 热加载统一走：docker exec docker-nginx-1 nginx -t 2>&1 && docker exec docker-nginx-1 nginx -s reload
```

## 3. HTTPS 切轨配方

BASE_URL 从裸 IP 换到 HTTPS 域名=三步，缺一步即断链：

| 步 | 动作 | 执行方 |
|---|---|---|
| 1 | 前端 config.js `BASE_URL` → `https://<域名>`（保留测试 OVR 闸） | agent 改码 |
| 2 | mp 控制台 request 合法域名加 `https://<域名>` | 用户手加（40014 见坑 2-3） |
| 3 | 域名 443 证书+反代就绪（第 2 节点火） | agent 跑点火脚本 |

三切轨史（每次原因照抄记忆档案）：
- **gcbrain.top**：阿里云注册、实名过，ICP 备案卡步4（传图+人脸）→ 弃用；教训=未备案域名证书签不了，整条链死锁在备案。
- **api.yrecepc.cn**：用户已备案域，1001 点火 public443=200，v0.7.2（robot9，99,161B）以此域名上传。
- **ai.epcschool.top**：apex=epcschool.top 系总包学园已备案域、Tencent 云全栈，1002 切轨，v0.7.6 提审版 BASE_URL 所指。

### 坑

- **坑 1：IP 直连只在开发态可用**
  表象：手机任意网络可直连 `http://47.120.43.20:8869`，正式包却请求失败。
  根因：域名校验豁免靠「开发调试」手动开关，正式发布必须 HTTPS 域名+合法域名。
  修法：提审前完成三步切轨。

## 4. 小程序包上传链

上传器=work/upload_qianwen.mjs（miniprogram-ci）。用法：

```bash
NODE_OPTIONS="--require E:/AI-Station/WeAppForge/work/localstorage-shim.cjs" \
  node work/upload_qianwen.mjs [version] [desc]
```

关键参数（源文件原值）：appid `wx5cee1574ce45819b`，projectPath `projects/zongbao-ai`，privateKeyPath `E:/AI-Station/data/secrets/private.wx5cee1574ce45819b.key`，ignores `['node_modules/**/*']`，setting `{es6:true, es7:true, minify:true, autoPrefixWXSS:true}`。

robot 轮转（防顶替核心）：

```javascript
const CURSOR = 'work/robot_cursor.txt';
let last = 1;
try { last = parseInt(fs.readFileSync(CURSOR, 'utf-8').trim(), 10) || 1; } catch {}
const robot = (last % 30) + 1;
fs.writeFileSync(CURSOR, String(robot));
fs.appendFileSync('work/robot_registry.jsonl',
  JSON.stringify({ time: new Date().toISOString(), version, desc, robot }) + '\n');
```

上传成功判据=`UPLOAD_OK` 回包（含 subPackageInfo/pluginInfo）；上传后自动跑 `python work/trial_health_probe.py`，回包抓 `SUMMARY: CHANNEL_OK`。

### 坑

- **坑 1：Node25 localStorage 崩溃且 exit 0 假成功**
  表象：miniprogram-ci 抛 `getItem is not a function`；另一形态=exit 0 但顶层 await 永不落定、ESM 空转退出，看似成功实未传。
  根因：Node 25 的 global.localStorage 形状不符，miniprogram-ci debug.js `shouldRunInMainProcess` 探测 `localStorage.getItem`；corecompiler 子进程同样会崩，父进程 defineProperty 遮不到子进程。
  修法（二选一）：`NODE_OPTIONS=--no-experimental-webstorage`，或 `NODE_OPTIONS="--require work/localstorage-shim.cjs"` 父子同注。shim 全文：

```javascript
try {
  Object.defineProperty(globalThis, 'localStorage', {
    get: () => ({ getItem: () => null, setItem: () => {}, removeItem: () => {} }),
    configurable: true,
  })
} catch {}
```

- **坑 2：同一 robot 再上传顶掉被钉记录 →「页面不存在」**
  表象：用户扫码报页面不存在，全部入口按线上版老页面表解析。
  根因：miniprogram-ci 同一 robot 再上传会替换该机器人名下的开发版本记录；体验版钉着该记录时即被顶掉，钉位悬空。
  修法：robot 1..30 轮转（cursor+registry 审计）+上传后自动通道体检；BROKEN 时给用户唯一修复动作：「版本管理→本次上传的开发版本→选为体验版（无API可代办）」。
- **坑 3：appid 抄错一字符=整套「账号被注销」假象**
  表象：CI 门 getrandstr 回 `-1 empty content`，主 API `cgi-bin/token` 回 40013 invalid appid，像账号被回收。
  根因：appid 一字符笔误（查了个不存在的 appid）；密钥文件名（微信官方命名）一直是对的。
  修法：**appid 与密钥文件名逐字符 diff**；差分对照（同机同网打另一 appid 三连过）是定海神针。
- **坑 4：目录名骗人传错真身**
  表象：上传 12.7KB 小包，用户体验版「页面不存在」。
  根因：曾并存两个同名辈前端（`projects/qianwen`=v0.1 孤儿：旧号时代/LAN BASE_URL/无 md2blocks），目录名骗人误传孤儿。
  修法：真身目录改名 `projects/zongbao-ai`、孤儿改名 `projects/_orphan_qianwen_v01_勿发布`，上传器直指真身目录。

### 通道体检语义（trial_health_probe.py 定型）

- `pages/my/my`（线上版 1.0.7 表内真实存在）回图 = API 通道活着 → `CHANNEL_OK`。
- `pages/ask/ask` 回 41030 = 预期常数（不在老表，与钉位无关）。
- 钉位状态 API 不可读（`wxa/getversion`=40066 第三方专属）；真判据=用户手机扫「码内显式 page」码+引擎雷达（answers 表新流量）。

## 5. 出码交付链

统一走 `wxa/getwxacodeunlimit`，token 从 `cgi-bin/token`（grant_type=client_credential，secret 读 `E:/AI-Station/data/secrets/zongbao_qianwen_mp.secret`），一律 `curl_cffi requests` + `impersonate="chrome"` 过 TLS 指纹 WAF。

| 出码器 | env_version | 用途 | 用法 |
|---|---|---|---|
| work/qr_dev_fire.py | develop | 免钉位通道：指向最新开发版，管理员/项目成员扫码即开，钉位无关 | `python qr_dev_fire.py [scene]` 默认 v051 |
| work/qr_trial_fire.py | trial | 体验版码：码内显式 page，免疫线上老表 | `python qr_trial_fire.py [scene]` |
| work/scheme_fire_030.py | trial | generatescheme 桌面拉起 + 体验码双出 | 直跑 |

核心 payload（qr_dev_fire.py 原文，scene 为 argv）：

```python
payload = ('{"page":"pages/ask/ask","scene":"%s","check_path":false,'
           '"env_version":"develop","width":430}' % SCENE).encode("utf-8")
r = requests.post(f"https://api.weixin.qq.com/wxa/getwxacodeunlimit?access_token={at}",
                  data=io.BytesIO(payload),
                  headers={"Content-Type": "application/json"},
                  impersonate="chrome", timeout=60)
b = r.content
kind = "png" if b[:4] == b"\x89PNG" else ("jpg" if b[:3] == b"\xff\xd8\xff" else None)
```

三铁律：
- **page 显式 + check_path=false**：无路径入口（最近使用/会话卡/控制台自带码）默认页解析参照线上版老页面表——只有 `check_path=false` 才走码内新解析。
- **env_version 三态**：develop/trial/release 按交付对象选；正式发布后海报码切 release（第 7 节）。
- **scene ≤32 字**：引擎海报通道用 `scene="s=p&a={aid}"` 形态。

### 坑

- **坑 1：check_path=true 当钉位探针=恒假阴性**
  表象：钉位健康时真页面 `pages/ask/ask` 也回 41030。
  根因：check_path=true 只按「线上版已发布」的页面表校验，读不到钉位状态。
  修法：该探针只做通道体检（坑见第 4 节）；出码一律 check_path=false。
- **坑 2：无路径入口按老表解析必 404**
  表象：换版后最近使用/会话卡打开报页面不存在。
  根因：老表只有 home/home 与 my/my，新包无 home 页即 404。
  修法：包级根治=pages/home/home 兼容跳板页（落地即 `wx.reLaunch('/pages/ask/ask')`，app.json 五页 home 殿后）；码级根治=**永不404码配方**：`page="pages/home/home"`（新老包双环境都在表）+ `env_version=trial` + `check_path=false`，任何解析路径必命中。
- **坑 3：回包不总是图**
  表象：写盘后打不开。
  根因：失败时 API 回 JSON 错误体。
  修法：magic 判图（`\x89PNG` / `\xff\xd8\xff`），非图打印 `b[:200]` 排错；注意海报通道回包是 JPEG。

## 6. secrets 双落位纪律

config.py 原则：**本文件不落任何密钥**，一切走 `SECRETS_DIR`（可环境变量覆盖，容器内挂载点）：

```python
SECRETS_DIR = Path(os.environ.get("SECRETS_DIR") or (REPO / "data" / "secrets"))
DATA_DIR = Path(os.environ.get("DATA_DIR") or (REPO / "data" / "qianwen"))
```

| 文件（只列路径，绝不写值） | 用途 |
|---|---|
| zongbao_qianwen_mp.secret | 小程序 appid/appsecret（出码+token） |
| private.wx5cee1574ce45819b.key | miniprogram-ci 上传密钥（文件名=微信官方命名） |
| metaso_kb_session.json | KB 网页会话 |
| zhipu.secret | 智谱免费池（多 key 行式，chmod 600 不进 git 不全显） |
| virtual_pay.secret | 虚拟支付 offer_id/product_id/env 三行 |
| qianwen_engine_hmac.key | 引擎 HMAC |

双落位：本地 `E:/AI-Station/data/secrets/` + ECS `/opt/qianwen/data/secrets/`。ECS 侧灌法（ecs_deploy.py，b64 直灌避免引号地狱）：

```python
sec_cmds = [
    f"printf %s '{base64.b64encode(p.read_bytes()).decode()}'"
    f" | base64 -d > /opt/qianwen/data/secrets/{n}"
    for n, p in SECRETS.items()
]
```

云助手探针纪律：**secret 只留 ECS 侧**——远端跑 sqlite3 直查，回包只带状态/长度类 JSON（如 `POSTER|<aid>|<env>|<len>`），密钥永不出机器。真引擎 DB=`/opt/qianwen/data/qianwen/db.sqlite`（`qianwen.db` 是空壳诱饵，config 里 DB_PATH=db.sqlite）。

## 7. 发布日切换清单

一行令：`POSTER_QR_ENV_VERSION = "trial"` → `"release"`（config.py 第 79 行；注释原意：海报码指向版本，发布当日切 release 一行即切——正式版未发布前置 release 会开出旧 1.0.7）。

⚠ 本机与线上曾被误置 release 双双回 trial 的教训在案（台账#71 同型）：**两处必须同步切**。

自动切换器=work/poster_qr_switch_release.py（幂等可重跑），流程：

| 步 | 动作 | 判据 |
|---|---|---|
| 1 | 发布活体门：check_path=true 探 release 页面表 `pages/ask/ask` | 回图=0.7.x 已发布；41030=release 仍旧版，45s 复探×5，仍不在表则 ABORT（此刻切=海报码重演「页面不存在」） |
| 2 | 本机 flip：config.py 文本替换 trial→release，回读断言 `"release"` 在行 | `[local] OK` |
| 3 | ECS flip：`sed -i` 同款替换 + py_compile + systemctl restart + is-active + `/api/health` | `local_probe=200` 且 grep 到 `"release"` |

ECS 侧切换命令（照抄）：

```bash
cd /opt/qianwen/services/qianwen-engine \
  && sed -i 's|POSTER_QR_ENV_VERSION = "trial"|POSTER_QR_ENV_VERSION = "release"|' qianwen_engine/config.py \
  && grep -n POSTER_QR_ENV_VERSION qianwen_engine/config.py \
  && /opt/qianwen/venv/bin/python -m py_compile qianwen_engine/*.py \
  && systemctl restart qianwen-engine && sleep 3 \
  && systemctl is-active qianwen-engine \
  && curl -s -o /dev/null -w 'local_probe=%{{http_code}}' http://127.0.0.1:8869/api/health
```

收尾三件：
- 海报缓存按 env 隔离自动失效重生成，**无需清缓存**。
- CloudBase 若有部署位：config 同步切（记忆档案 1002 收尾令：config.py:79 + ECS + CloudBase 同步——以记忆档原令为准，CloudBase 侧按当期实际部署形态核对）。
- 验证=重新生成海报，确认新码 env=release 且扫码进正式版页面。

### 坑

- **坑 1：正式版未发布就切 release**
  表象：海报码扫出旧 1.0.7 报「页面不存在」。
  根因：release 页面表仍指向旧线上版，新包页面不在表。
  修法：发布活体门（先探表后切），等控制台「版本管理→发布」完成传播后重跑切换器即自动完成。
