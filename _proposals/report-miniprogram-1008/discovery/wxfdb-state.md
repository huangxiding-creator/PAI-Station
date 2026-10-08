# agent3

# wxfdb55b184756e89e 在役版本考古结论

## 一句话结论
wxfdb（小程序名「总包学园」）的最新开发版已连续三轮被**总包说展示版**占据（v1.1.0→v1.1.1→v1.1.2，robot2 轨道），但**体验版钉位仍是学园商城 0.3.0**（0929 用户控制台选定，此后无改选记录）；正式版从未存在（两侧都未提审发布过）。

## appid 地图（全部文件实证）
| appid | projectname | 源码位置 | 上传密钥 |
|---|---|---|---|
| **wxfdb55b184756e89e** | zongbao-xueyuan（总包学园） | `E:\AI-Station\WeAppForge\projects\zongbao`（live 树，TS 工程）+ `E:\AI-Station\WeAppForge\work\zongbao_trial`（体验版四翻快照） | `E:\AI-Station\微信小程序\private.wxfdb55b184756e89e.key`(0927 13:41) + `E:\AI-Station\data\secrets\private.wxfdb55b184756e89e.key`(0927 22:29) |
| wxd096fc6994ef6f48 | zongbao-qianwen（总包说展示版主号） | `E:\AI-Station\website\zongbaoshuo-miniprogram` | `E:\AI-Station\微信小程序\private.wxd096fc6994ef6f48.key` |
| wx5cee1574ce45819b | zongbao-ai（总包AI顾问） | `E:\AI-Station\WeAppForge\projects\zongbao-ai` | `E:\AI-Station\data\secrets\private.wx5cee1574ce45819b.key` |

## 1. wxfdb 最近三次上传（新→旧，全有据）
1. **v1.1.2 总包说展示版**（2026-10-08，robot2，同包 448,773B）——commit 6f93765「v1.1.2 双号上传」，package.json 1.1.1→1.1.2 diff 在案
2. **v1.1.1 总包说展示版**（2026-10-08，robot2，448,773B）——commit 7474cf2「三年语料沉淀→十年知识沉淀」
3. **v1.1.0 总包说展示版**（2026-09-30 14:04-14:06，双号首传：wxd096 robot1 + wxfdb robot2）——物证三连：`work/qr_dev_zbs_v110.jpg`(14:04)、`work/qr_dev_zbs_xy_v110.jpg`(14:06)、`data/secrets/zongbao_mp_wxfdb.secret`(14:05)
再往前是学园侧：v0.3.0「总包学园 P0 商城基线·32份在售·体验版」（09-28，robot=1，810,293B，`upload_xueyuan_trial.mjs`）和 v0.0.1 WeAppForge 首航（09-27 22:31）。

## 2. 当前线上形态
- **最新开发版** = 总包说展示版 v1.1.2（robot2 轨道，10-08）
- **体验版** = 学园商城 0.3.0（0929 用户在 MP 控制台「版本管理→开发版本→0.3.0→选为体验版」，学园账本 #49 原文「用户已选体验版」；总包说侧全部用 `env_version=develop` 出码、且明记「直接开发版（不提审）」，从未走体验版轨道，故体验版钉位未被动过）
- **正式版** = 无（学园止于体验版；总包说 memory 明记「④直接开发版（不提审）」）

## 3. 两套代码位置与「下一版」主动权
- **学园商城**：live 树 `E:\AI-Station\WeAppForge\projects\zongbao`（project.config.json appid=wxfdb、projectname=zongbao-xueyuan；最后实质开发 09-28 23:37，10-02 随 commit 6337f5d 首次入 git）；上传通道 `E:\AI-Station\WeAppForge\work\upload_xueyuan_trial.mjs`（快照 work/zongbao_trial 四翻：p1关/apiEnv prod/mockApi false/PROD_BASE 47.120.43.20:8871）
- **总包说展示版**：`E:\AI-Station\website\zongbaoshuo-miniprogram`（project.config.json appid=wxd096，但 `tools/upload.js` 已参数化 `--appid --key --robot --desc`，可直传 wxfdb）
- **主动权事实归属：总包说侧**。09-30 起连续三轮（v1.1.0/1.1.1/1.1.2）都是总包说 upload.js 的 robot2 轨道在上传，学园通道 09-28 后零动作。但两侧都持有 wxfdb 密钥——学园重跑 upload_xueyuan_trial.mjs 即可占 robot1 轨发新开发版；唯一钉位资产「体验版=学园0.3.0」只有控制台手动改选才能换，脚本动不了。

## 4. v1.1.2「双号上传」具体做法
脚本 = `E:\AI-Station\website\zongbaoshuo-miniprogram\tools\upload.js`（miniprogram-ci）：
- 第一次：`npm run upload`（= `node --require ./tools/no-localstorage.js tools/upload.js`，no-localstorage 是 Node25 localStorage 探针坑的遮蔽件）→ 默认 appid wxd096fc6994ef6f48、key `E:\AI-Station\微信小程序\private.wxd096fc6994ef6f48.key`、robot 1
- 第二次：同脚本加 `--appid wxfdb55b184756e89e --key E:\AI-Station\微信小程序\private.wxfdb55b184756e89e.key --robot 2`（robot2 防顶 robot1 旧记录）
- 版本号自动读 `package.json` 的 version=1.1.2，同包 448,773B，`--desc` 传描述
- 官网腿同步：`E:\AI-Station\website\zongbaoshuo\_deploy_v111.py`（通用部署器：gzip→b64 15000字符分片→阿里云云助手→远端 md5 校验→旧件 .bak 备份→原子 mv；ECS /www/ZongBaoShuo 单源，8884=301→8889；v1.1.2 远端 md5=40926e05，线上「三年=0/十年=30」）

## git 发布史（since 09-25，两路径共 4 条）
- 2ca933a (09-29)：zongbao-ai v0.5.1 备份收口——zongbao-ai 源码首入 git（+RUN_LEDGER 129 行）
- 6337f5d (10-02 10:28)：v0.7.6 提审收官——**projects/zongbao 学园源码首次入 git**（唯一一次）+ qw_tcb_prep 两脚本
- 8312c93 (10-02 11:26)：审核状态 API 纠错 + 阿里云旧轨清理五脚本（ecs_inventory 等）
- 305294f (10-07)：虚拟支付服务端收官（qw_tcb 腿，服务端侧，未动 wxfdb 小程序包）
另有总包说线 3 条：5d607db (10-02 双项目首入) → 7474cf2 → 6f93765 (10-08 v1.1.2)。

## 无独立仓
E:/ 盘与 E:/AI-Station 根下均无 zongbaoshuo 独立仓；官网 `website/zongbaoshuo/` 与小程序 `website/zongbaoshuo-miniprogram/` 都在 AI-Station 主仓内（1008 起 git 追踪+百度备份）。
robot_registry.jsonl（work/ 下，v0.4.2→0.8.0 robot 2-14）是 zongbao-ai（wx5cee）的 bootsim 上传序列，与 wxfdb 无关——wxfdb 的上传档案在 memory 文件+物证 mtime+学园账本。

## Key Facts
- projects/zongbao 的 project.config.json：appid=wxfdb55b184756e89e，projectname=zongbao-xueyuan（学园商城 live 树直接持有 wxfdb） (E:/AI-Station/WeAppForge/projects/zongbao/project.config.json 4-5)
- 总包说展示版 project.config.json：appid=wxd096fc6994ef6f48，projectname=zongbao-qianwen (E:/AI-Station/website/zongbaoshuo-miniprogram/project.config.json 2-4)
- upload.js 参数化双号上传：默认 wxd096 robot1，可用 --appid/--key/--robot 覆盖传 wxfdb；版本号读 package.json (E:/AI-Station/website/zongbaoshuo-miniprogram/tools/upload.js 18-20, 40-45)
- package.json v1.1.2：description「总包千问小程序 CI 工具链 (miniprogram-ci 上传/预览/提审)」，scripts.upload 内嵌 no-localstorage 遮蔽 (E:/AI-Station/website/zongbaoshuo-miniprogram/package.json 3-9)
- 学园上传脚本 upload_xueyuan_trial.mjs：appid wxfdb、projectPath work/zongbao_trial、体验版四翻快照注释、默认版本 0.3.0 (E:/AI-Station/WeAppForge/work/upload_xueyuan_trial.mjs 1-16)
- 学园账本 #39：v0.3.0「总包学园 P0 商城基线·32份在售·体验版」robot=1 上传 810,293B + 用户控制台选体验版一步 (E:/AI-Station/_proposals/xueyuan-market/RUN_LEDGER.md 194 (Phase 11 体验版 0.3.0 上传收官))
- 学园账本 #49（0929 体验版启用日）：「用户已选体验版（控制台步①完成）」+256 张 trial 码池首灌——体验版钉位=学园 0.3.0 的直接证据 (E:/AI-Station/_proposals/xueyuan-market/RUN_LEDGER.md 227-229)
- memory 档案：0930 双号同包部署 v1.1.0（wxd096 robot1 / wxfdb robot2，448,773B）；v1.1.1/v1.1.2 均 robot2 同包；总包说「直接开发版（不提审）」 (C:/Users/91216/.claude/projects/e--AI-Station/memory/zongbaoshuo-showcase-miniprogram.md 13, 15, 17, 19)
- commit 6f93765 (10-08 15:34)「v1.1.2 双号上传+官网已上线」：改 content.js/products.js/package.json(1.1.1→1.1.2)/index.html/_deploy_v111.py 五文件 (E:/AI-Station (git show 6f93765 --stat) commit 6f93765db90d8f643620a2711dffdcee77d8789c)
- 双号上传物证三连：qr_dev_zbs_v110.jpg(mtime 0930 14:04)、qr_dev_zbs_xy_v110.jpg(0930 14:06)、zongbao_mp_wxfdb.secret(0930 14:05)——wxfdb 换轨承载总包说的文件级实证 (E:/AI-Station/WeAppForge/work/qr_dev_zbs_xy_v110.jpg + E:/AI-Station/data/secrets/zongbao_mp_wxfdb.secret 文件 mtime)
- wxfdb 双落位密钥均在盘：微信小程序/private.wxfdb55b184756e89e.key(0927 13:41) + data/secrets/private.wxfdb55b184756e89e.key(0927 22:29)——两套代码都有上传能力 (E:/AI-Station/微信小程序/ 与 E:/AI-Station/data/secrets/ ls -la)
- 学园源码唯一一次入 git = 6337f5d (10-02 10:28:17 +0800)「v0.7.6 提审收官」，live 树文件最后实质改动 09-28 23:37 (E:/AI-Station/WeAppForge/projects/zongbao/ (git log + ls -la) commit 6337f5d)
- _deploy_v111.py 头部注释：总包说官网 index.html 上 ECS 通用部署器，gzip→b64 15000c 分片→云助手→远端 md5 校验→备份→原子替换，双口 8884/8889 同 root /www/ZongBaoShuo（8884=301→8889） (E:/AI-Station/website/zongbaoshuo/_deploy_v111.py 2-4, 15-18)
- work/robot_registry.jsonl（v0.4.2→0.8.0，robot 2-14）属 zongbao-ai 总包AI顾问序列（desc 全为顾问版本史），与 wxfdb 无关 (E:/AI-Station/WeAppForge/work/robot_registry.jsonl 末行 2026-10-08T09:34 v0.8.0 robot:14)
- E:/ 盘与 AI-Station 根下无 zongbaoshuo 独立仓；官网+小程序均在主仓 website/ 下 (E:/ (ls) 目录清点)

## Risks
- 「体验版仍=学园0.3.0」是基于『无改选记录』的推断：若用户 0930 后曾在 MP 控制台手动把体验版改选为总包说 v1.1.x，则此结论翻车——只读侦察无法探微信后台
- robot 序列（robot1/robot2）与三次上传的精确时间戳来自 memory 会话档案（originSessionId 199d4c7c）+物证 mtime 交叉，非 git 提交直录；微信后台版本列表本身不可只读探证
- 总包说 v1.1.0 之前的首次上传（如 v1.0.0，目录创建于 09-27 14:09）无任何档案记录，本报告不猜
- projects/zongbao 学园 live 树自 09-28 后未再开发，若直接重跑 upload_xueyuan_trial.mjs 会以 09-28 快照顶掉 robot1 开发版记录（不会动体验版钉位）
- wxfdb 密钥双落位（微信小程序/ 与 data/secrets/ 各一份），两套代码都保有上传能力——『下一版主动权』本质是双方共持，现状倾斜只因学园侧静默

## Open Questions
- 总包说 v1.1.0 之前（0927-0928 目录创建期）是否有过 v1.0.x 单号首传到 wxd096？档案未记，memory 双号史从 v1.1.0 起笔
- 学园「下一版」是否还排期：账本遗留 D-1 分包重构工单（正式版前必做）+虚拟支付 offer_id 等用户步，若重启学园线将发生 wxfdb 双轨争用，建议先立 appid 分工约定
- submit_audit.js（总包说提审脚本）存在但从未启用——总包说是否永远止步开发版/体验版轨道，还是未来会正式提审占领 wxfdb 正式版位？
