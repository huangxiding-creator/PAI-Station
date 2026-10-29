# bdn × baidu-drive 分区路由表

两个百度网盘技能并存，按**作用域与意图**分区触发。一张表定走向：

| 意图 | 技能 | 理由 |
|---|---|---|
| 网盘根目录/全盘列目录（`ls /`） | **bdn** | 全盘绝对路径是 bdn 专属域 |
| 全盘/某目录搜索、递归树 | **bdn** | 同上 |
| 网盘配额、账号画像、链路体检 | **bdn** | 只读控制面 |
| 上传/下载（远端路径 / 开头，全盘任意位置） | **bdn** | 全盘写/传输 |
| 把 E:\xxx 镜像备份到 /AI-Station-archive/... | **bdn** | 批量镜像=bdn 编排剧本（mkdir+upload+ls 对账） |
| 在网盘建/删/改/移动文件夹（全盘） | **bdn** | 全盘写面（rm 双确认） |
| 回收站查看（全盘） | **bdn** | recycle 只读 |
| 我的分享记录查看（只读） | **bdn** | shares 只读 |
| 文件元信息（fs_id） | **bdn** | meta |
| /apps/bdpan/ 沙箱内任何操作 | baidu-drive | 沙箱=官方 bdpan 专属域 |
| Agent 记忆备份/恢复（kimiclaw/maxclaw/qclaw/openclaw） | baidu-drive | 记忆链固定走官方 CLI |
| 转存别人的分享链接 | baidu-drive | bdn 无转存命令；且 PROPOSAL 红线不碰他人数据——仅当用户明示转存需求时由官方技能承接 |
| 新建分享链接 | baidu-drive | bdn 只能读分享记录（shares） |
| 开会员/会员操作 | baidu-drive | 会员域归官方 |
| 网盘内 PPT 生成 | baidu-wenku-aippt-personal | 已独立技能 |

判定口诀：**远端路径以 / 开头且指向全盘 → bdn；出现 /apps/bdpan/、记忆、转存、会员字样 → baidu-drive。**

双向说明：
- 本技能（bdn）文档各处已标注 DO NOT TRIGGER 指向官方技能。
- 官方 baidu-drive 技能**不改一个字**（update.sh 覆写+遥测令冲突）；若其触发词与本技能重叠（如「网盘」「百度网盘」），按上表作用域判定，不由措辞判定。
