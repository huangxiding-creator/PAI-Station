# 分区路由细则（pan-hunter × bdn × baidu-drive × ebook-treasure）

四技能并存，各管一段。**先按本表路由，再动手**；跨区任务拆步走，不混用。

## 判别主轴

| 轴 | pan-hunter | bdn | baidu-drive | ebook-treasure |
|---|---|---|---|---|
| 侧 | **他人公开分享链**（全网发现） | 自家百度盘全盘（`/` 绝对路径） | 自家百度盘沙箱/官方 API 侧 | 本地中文书库索引 |
| 登录态 | 零凭据免登 | BDUSS 本地凭据（gitignored） | 官方授权 | 无 |
| 动作 | 搜链/列清单/探活/绿盘直下 | ls/upload/download/镜像/删改 | 沙箱内文件操作、记忆备份、转存、分享 | 书名→网盘下载清单 |

## 高频冲突裁决

| 场景 | 裁决 |
|---|---|
| 「帮我找 XX 资料的网盘链接」 | **pan-hunter search**（全网发现） |
| 「这条夸克/百度链接里有什么？能下吗？」 | **pan-hunter discover**（黄盘列表+探活+红绿灯）；绿盘链直接 download |
| 「下载这个蓝奏/UC/小飞机链接」 | **pan-hunter download**（五绿盘 adapter 直链） |
| 「下载这个百度/夸克分享链接」 | 发现层只列清单。交付=用户自有通道：百度→`bdn`（凭据插件）或官方客户端；夸克/阿里→官方 App。**pan-hunter 不代下黄盘** |
| 「把 E:\xxx 备份到网盘 /AI-Station-archive」 | **bdn upload/mirror** |
| 「转存别人分享的百度链接 / 建分享」 | **baidu-drive**（官方授权面；pan-hunter/bdn 都不做转存再分发——法务#4 无公开策展） |
| 「找一本《XXX》电子书」 | **ebook-treasure**（24071 本库直查；若零命中再回 pan-hunter search 泛搜） |
| 「开会员/加速/破解限速」 | 全线拒绝（法务红线：PanDownload 刑事案为界） |

## MCP 侧同构

MCP 头三工具（panhunter_search / panhunter_discover / panhunter_doctor）与 CLI 同源同边界；
黄盘交付类请求 MCP 也只回「发现层结果 + 指引自有通道」，不提供代下。
