# SWF 工具链许可证核对表（NFR6：GPL 隔离）

> 任务：KB-HARVEST Wave2 T12 | 核对日期：2026-10-22 | 核对人：T12 工人
> 核对方式：全部**本机实测**（license 文件/API license 字段/`-version` 横幅/`-help` 横幅），
> 非转抄文档；逐项注明证据来源。依据：REQUIREMENTS NFR6「FFDec(presse) 子进程调用不进仓」。

## 核对表

| 组件 | 版本（实测） | 许可证（实测证据） | 来源坐标 | 获取方式 | 进我方 git？ | 调用方式 |
|---|---|---|---|---|---|---|
| FFDec（JPEXS Free Flash Decompiler） | 26.4.0（`ffdec.jar -help` 首行横幅实测；注意 CHANGELOG.md 首条仍为 26.3.0，滞后不可作版本源） | **GPL-3.0**（`rea-tools/ffdec/license.txt` 实测=GPL v3 全文；`com.jpexs.decompiler.flash.metainfo.xml` 标 `project_license: GPL-3.0-or-later`） | 上游 `jindrapetrik/jpexs-decompiler`；自举坐标取原工具同源 fork `cmy2008/jpexs-decompiler`（DOC88_SPEC §1.7） | `py -3 -m kb_factory.harvest_engine.tools.fetch_toolchain --ensure ffdec`（本机 26.4.0 已预装，直用零下载） | 否（`rea-tools/` 已被 .gitignore L196 覆盖） | 仅子进程 `java -jar ffdec.jar …`（`pdf/swf_toolchain.py`），不 import 其码、不拷贝源码/二进制进仓 |
| presse | v0.0.2（GitHub latest release tag 实测；本机二进制 `presse.exe --help` 可用） | **GPL-3.0**（GitHub API `/repos/cmy2008/presse` license 字段=GPL-3.0；其 fork 源 `SimonBure/presse` 同为 GPL-3.0——两仓一致，2026-10-22 API 实测。任务卡「待核」项已核结） | `cmy2008/presse`（fork of `SimonBure/presse`） | `py -3 -m kb_factory.harvest_engine.tools.fetch_toolchain --ensure presse`（本机缺位→本任务实测真实拉取落位：release API→下载 zip→解包→`rea-tools/presse/presse.exe`） | 否（同上 gitignore） | 仅子进程 `presse merge <files…> --optimize -o <out>` |
| JDK（FFDec 运行时） | Temurin 21.0.12.1+1 LTS（`java -version` 实测） | **GPL-2.0-with-classpath-exception**（Temurin 发行版许可；classpath 例外允许任意许可的程序调用 JVM——对我们仅是进程宿主） | Adoptium Temurin | 不在自举射程（工作站预装约定 `rea-tools/jdk-*`；ensure 只报缺不代装） | 否 | 仅进程宿主（FFDec 的 JVM） |
| doc88_extractor（机制参考源） | —（源码留档 `engine/SPECS/_repos/doc88/`，仅 13 文件 curl 留档） | GPL-3.0（ABOUT.md 自述） | `cmy2008/doc88_extractor` | 不获取不安装——DOC88_SPEC §4 方案B：机制重写，规格由探针独立复现 | 留档在 SPECS（规格证据链，不 import 不执行） | 零调用：`kb_factory` 全树无任何 doc88 原码 import（test_nfr6 静态门钉死） |

## NFR6 结论（发布门口径）

1. **零 GPL import**：`pdf/swf_toolchain.py` 与 `tools/fetch_toolchain.py` 的 import 面
   经静态扫描门（`test_nfr6_zero_gpl_import_in_t12_modules`）钉死——无 fitz(AGPL)、
   无 doc88 原工具码。帧 RECT 修正为本仓独立实现（DOC88_SPEC §4 方案B：位级
   机制重写，协议常量与机制不受版权保护）。
2. **子进程隔离**：FFDec/presse 均以独立进程调用（命令行见 DOC88_SPEC §1.7，
   26.4.0 `-help export` 实测复核），不修改其源码、不随我方产物分发其二进制
   → GPL 义务不传导至 kb_factory 代码。
3. **不进仓**：工具落位区 `E:\AI-Station\rea-tools\`（.gitignore L196 覆盖）；
   自举下载缓存 `rea-tools/.downloads/` 同区。若未来随包分发 FFDec/presse 二进制
   （如客户端打包），须附 GPL 全文与源码 offer——当前形态无此义务。
4. **升级注意**：FFDec 换版后 `-help` 横幅与 CLI 行为需回归（帧数 0 静默零输出、
   目录模式子目录名=完整文件名含 .swf，均以 26.4.0 实测为准并已入测试）。
