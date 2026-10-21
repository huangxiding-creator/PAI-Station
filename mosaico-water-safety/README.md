# 水利安检卡（Water-Safety Card）

灵珠「水利安全AI助手」→ 乐鑫 ESP-Mosaico（ESP32-S31）板载复刻。八意图智能体 + 112KB 板端水利安全知识 + 中文语音交互 + AMOLED 显示 + 企微推送闭环。

## 目录结构

```
mosaico-water-safety/
├── firmware/            # esp-mosaico-claw fork（Apache-2.0, 改动见 DIVERGENCE.md）
│   └── fatfs_image/system/.recovery/   # 预烧资产（由转换器生成, 勿手改）
├── assets/              # 资产源（人设三件/九技能/知识包）—— 改这里
├── secrets/             # webhook 真值（gitignored）
├── tools/lingzhu2claw/  # convert.py(资产→预烧) + distill_knowledge.py(知识蒸馏)
├── scripts/             # extract_lingzhu*.py(灵珠提取) build_wsl.sh flash_win.py push_voice_data.py
├── assets/tts/          # esp-sr 小乐音色库(2.9MB, 推送到设备 /tts/ 即启用语音播报)
├── RESEARCH_DOCKET/     # 灵珠提取件(canvas×6/bot_info/人设/提示词库) + 调研档案
├── tests/battery.json   # 对拍测试集(24意图探针+30知识题)
└── firmware_out/        # 构建产物 bin
```

## 日常改资产 → 出固件（三步）

```
# 1 改 assets/ 下的技能/人设/知识
# 2 重新预烧 + 构建
py tools/lingzhu2claw/convert.py --max-kb 128
wsl -e bash -lc 'sed -i "s/\r$//" /mnt/e/AI-Station/mosaico-water-safety/scripts/build_wsl.sh; bash /mnt/e/AI-Station/mosaico-water-safety/scripts/build_wsl.sh'
# 3 烧录（板子已跑出厂固件→USB CDC 自动烧录）
py scripts/flash_win.py COM<x>
```

## 首次上手指引（用户）

1. 烧录：首次裸板需手动进下载模式（关机→按住 BOOT→按 POWER），随后 `py scripts/flash_win.py COM<x> --full`
2. 配网：开机后连 Wi-Fi 热点 `esp-claw-XXXXXX` 或等设备进入配网页 → `http://esp-claw.local/`
3. 配 LLM：Web 控制台 → LLM 设置 → 确认 DeepSeek 预设（默认已指向）→ 粘贴 API key → 保存
4. 传音色（语音播报，一次性）：`py scripts/push_voice_data.py --host <设备IP>` → 重启设备，日志见 `TTS ready`
5. 开测：按住 AI 键说「操作演示」→ 跟随引导（此步起回复同步语音播报）

## 八意图指令表（语音/文字均可）

扫描隐患 / 快速巡查 / 播报新闻 / 知识问答(直接问) / 设置项目名称为XX / 操作演示 / 我要提意见 / 查找危险源 / 通知整改(同步到群)

## 纪律红线

- 灵珠平台只读（提取脚本全只读）；secrets/ 永不入仓；固件遵守 Apache-2.0（上游声明保留）
- 对拍测试以 tests/battery.json 为准，零造假记录

## 状态

见 .super-skill/tasks.json（T1-T16 实时台账）。
