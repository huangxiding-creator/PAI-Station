# 水利安全AI眼镜 定制版改造 · 需求与作战计划（Super-Skill 14 相执行账）

> 用户令（1103）：逆向 RokidAI.apk → 最小改动改造为水利安全AI眼镜专属 APP → 雷电模拟器 100% 完美运行。
> Super-Skill V4.1.16 全相位执行（不跳相）。

## Phase 0/1 · 愿景与可行性（裁决: CC-FPS≈0.78 可行）

**靶件**: RokidAI.apk 719MB sha256=f0b154e7… · com.rokid.sprite.aiapp v1.15.8.1013 · minSdk 29/targetSdk 35
**本质**: 网易易盾 7.6.1 加固（30 类 wrapper 壳 + libnesec.so 运行时解密真 dex）；UI 主原生 + Kuikly 局部；资产层（res+assets）不加密。
**品牌基因（V3 官网 47.120.43.20:8090）**: 标题「水利安全AI眼镜 | 定量测距分析 · 视觉量化判定 · 六项机制智能落地工具」；主色 #48C0D8(青)/#08233e(深蓝)/#1878D8(亮蓝)/浅底#F0F8FC；LOGO.png 200×200 RGBA 已提取至 brand/。

## 需求 → 改造点映射

| # | 需求 | 落点 | 层级 | 状态 |
|---|---|---|---|---|
| 1 | APP 名=水利安全AI眼镜 | `app_name_rokid`(values-zh/strings.xml, manifest label 引用) + 各语言 app_name* | 资源 | 待执行 |
| 1 | LOGO 换 V3 | `res/drawable/ic_app.png`（单密度，直接覆写 brand/LOGO.png） | 资源 | 待执行 |
| 1 | UI 与官网一致/零乐奇 | 主题色 token + 全量品牌串清扫（乐奇×23 strings + Rokid.txt + jsbridge×3） | 资源+代码 | 部分 |
| 2 | 唤醒词 乐奇→小禹 | UI 串(UserGuide_WakeUp_KeywordRokid 等×23)；引擎级 KWS(libMicrosoft kws + rfmasr) 待运行时探明 | 资源+待探 | 待执行 |
| 3 | 隐藏主页「学习与探索」 | 区块开关大概率在真 dex（home_Home_LearnExplore 串已知） | 代码 | 需脱壳 |
| 3 | 智能体商店·水利安全AI助手置顶 | 列表序=代码/服务端配置 | 代码 | 需脱壳 |
| 3 | 主页→排查 | `home_tab_glasses`/`home_title` 串 | 资源 | 待执行 |
| 4 | 社区页→V3官网手机版 | 候选容器 `com.rokid.ecology.webview.EcologyWebActivity`；nav_main.xml communityFragment 重指向 | 代码+资源 | 需脱壳 |
| 4 | 社区→主页 | `Community_tab` 串 | 资源 | 待执行 |
| 5 | 底导序: 扫描/主页/助手/相册/我的 | tab 序=真 dex（现状待运行时确认，扫描 tab 串未见明文） | 代码 | 需脱壳 |

## 关键路径与风险（RISK REGISTER）

- R1 **脱壳必要**: 易盾 7.6.1 → Frida 运行时 dump 真 dex（站内已验证 spawn 竞速能力）；脱壳后重打包去壳 + 重签名
- R2 **模拟器版本**: minSdk 29 > 雷电9(API28) → 装 LDPlayer 14 (Android 14, ldinst_14.0.34.1 下载中)
- R3 签名: apksigner 缺 → 检查 rea-tools/ReArk 签名链，必要时官方 build-tools
- R4 服务端驱动 UI 覆盖本地改配（default_config.json sceneConfig 线索）→ 运行时验证
- R5 自检/反调试（易盾常规）→ frida spawn 竞速 + 必要时 patch 检测点
- R6 模拟器检测 → LD 特性，运行时见招拆招

## 相位账

- P0/1 ✅ 本文档 · P2 ✅（APK 已在手；巨人件=站内四链+frida+apktool）
- P3 🔄 静态知识库（本文件+解码树）→ 运行时探查补全
- P4/5 待脱壳后细化代码级方案 · P6 WBS=本表映射 · P7/8 按表执行
- P9 模拟器验收（100% 门=五需求逐项+全功能冒烟）· P10 不完美即 Ralph Loop

## 暂停快照（1103 17:45 用户令暂停）

**下午战况**：脱壳出料环节穷尽 12 路自动化（系统选择器UIA/事件钩子/内存扫描×多时机/冷启/重装首脱/整机重启），选择器全天只在两次偶然条件下弹出过且未抓住。收割技术已全通（扫描器/attach/双进程），败因=出料面板不可复现。
**关键备件已就绪**：
- `pristine/pristine_resigned.apk`（纯净重建+自签隔离实验件，**未测**——恢复后首测：装机若跑=易盾无签名墙，问题在我的改动；若死=确认签名墙走 Plan B/LSPosed 或 libnesec patch）
- 静态改造版 `水利安全AI眼镜_v1_static.apk`（5语言品牌/LOGO/唤醒词/tab改名全落）
- BlackDex/LD14/frida/全部脚本机在 `逆向工程/rokid-rebrand/`
**恢复口令**：继续rokid——①先测 pristine 隔离实验 ②据结果走修补路线或 Plan B（LSPosed/Ghidra-libnesec）
