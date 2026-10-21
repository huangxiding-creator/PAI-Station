# RESEARCH_DOCKET — ESP-Mosaico 开发板（Channel: 官方文档+GitHub, 2026-10-21 实测核验）

来源: mosaico.espressif.com/zh/ · docs.espressif.com ESP-Mosaico UG V1.2 · ESP32-S31 datasheet PRELIMINARY v0.5 · gh api orgs/esp-mosaico/repos

## 芯片: ESP32-S31（全新硅片, 非 S3!）

- 具体料号: **ESP32-S31NRV16**（板上）, QFN80, 60 GPIO
- HP: **RISC-V 32位双核 @最高320MHz**（RV32IMAFC + Zc/Zb + 自研 XespV AI/DSP + XespLoop, 每核FPU, Sv32 MMU）; LP: 单核 RISC-V @40MHz; CoreMark 2195 (6.86/MHz)
- 存储: **16MB 片内封装 PSRAM** + 512KB HP SRAM + 32KB LP SRAM + 320KB ROM; 板载 **16MB SPI NOR (程序) + 128MB SPI NAND (资源)**
- 无线: Wi-Fi 6 (2.4G ax) + BT 5.4 (LE+Classic) + 802.15.4 (Thread 1.4/Zigbee 3.0)
- 数据手册 v0.5 = PRELIMINARY（新芯片, 文档尚未定稿）

## 板载硬件 (UG V1.2)

- 屏: **2.16" 480×480 AMOLED (QSPI, CO5300) + 电容触摸**（触摸IC文档说CST9220/BSP说CST9217, 官方源自相矛盾）
- 音频: **单麦克风** (LMA2718B331, 无阵列) + NS4150B 3W 单声道功放 + ES8311 mono codec (I2S)
- 摄像头: **非板载** — 磁吸扩展模块 (OV3640 / SC101IOT), **仅左槽**支持 ⚠️ 隐患扫描vision需另购摄像头模块
- 传感: BMI270 六轴IMU + 双BMM150磁力计(磁吸模块识别/多板拓扑) + BQ27220 电量计; 震动马达; 65mAh电池+充电
- 按键: POWER / BOOT(GPIO61 下载模式) / **AI功能键(GPIO7)**
- USB: 单 Type-C USB2.0 HS OTG（供电+调试+CDC）; 裸芯只支持ROM下载模式, 出厂固件带USB CDC虚拟串口→自动烧录+日志
- 扩展: 双磁吸槽(H1/H2, EEPROM自识别@I2C 0x50/0x51) + 2x10P 2.54mm 排针

## GitHub org esp-mosaico (gh api 实测)

| 仓库 | 内容 | 许可 | 状态 |
|---|---|---|---|
| esp-mosaico-bsp | 板级驱动+统一C API+**~20示例**(摄像头人脸/COCO检测、ESP-SR中文TTS+唤醒词、LVGL、Matter周边) | **Apache-2.0** ✓可复用 | 25★, 2026-10-21 活跃 |
| esp-mosaico-claw | **出厂固件源码**, 内嵌 esp-claw submodule; Agent运行时(会话/记忆/技能/Lua扩展/**MCP client+server**)、语音识别、Wi-Fi配网、Web配置、OTA | **Apache-2.0** ✓可复用 | 18★, 2026-10-17 |
| esp-mosaico-vibe | AI-agent 开发工作区(mosaico.py CLI+模拟器+MCP接Claude Code) | ⚠️无license, 仅参考 | 38★ |
| esp-mosaico-utils | ESP-Iris组件+Developer Gateway+Web Workbench | ⚠️无license, 仅参考 | 4★ |
| esp-mosaico-matter | Matter hub/bridge | ⚠️无license, 仅参考 | 2★ |

上游: **espressif/esp-claw** — "Chat Coding AI agent framework for IoT devices", **2273★, Apache-2.0**, 2026-10-19 活跃

## 工具链与烧录

- ESP-IDF **6.2+**, `idf.py --preview set-target esp32s31`; claw固件: `idf.py bmgr -c ./boards -b esp_mosaico`
- 烧录: ①出厂固件在位→USB CDC自动烧录+`idf.py -p COMx flash monitor` ②浏览器 Web Serial 烧录 (mosaico.espressif.com/zh/firmware-update, 整包16MB, **擦全盘**) ③手动ROM模式: 关机按住BOOT再按POWER
- 出厂固件现版: **ESP-Mosaico-Claw v0.5.0 (2026-10-16)**
- 双模式: Vibe Mode(开机按住AI键, 装应用/配网) vs ROM下载模式

## 官方背书 esp-claw（明示）

- UG: 「**推荐结合 ESP-Claw 应用开发框架进行开发**」
- 官网: 「ESP-Claw: ESP-Mosaico 内置的 AI 智能体框架」; 出厂固件即基于 ESP-Claw

## 对本项目的直接含义

1. **复刻路径 sanctioned**: 官方出厂固件=esp-claw 应用 → 我们的工作=在 esp-mosaico-claw 基础上做 clone-and-adapt（Apache-2.0 合法），把水利安全智能体做成板上 agent + 技能
2. 摄像头模块是 vision 隐患扫描的前置（左槽 OV3640/SC101IOT）；无摄像头时该意图降级
3. 板子能力面（AMOLED触摸屏+语音+Wi-Fi6+MCP）> 灵珠眼镜交互面 → 映射可行
4. ESP-SR 中文 TTS/唤醒词示例已在 BSP → 中文语音链路有官方示例背书
