# 环节3：语音/环境声感知 — 全景 DIGEST

调研日期 2026-09-13 | 39 项 | 全部一手核实（GitHub API + 官方 README/基准页），星数/许可证为当日实值；查不到的数据标"未核实"。
去重基线：V2 已录 FunASR/SenseVoice(9242★)/faster-whisper/sherpa-onnx/vosk/RealtimeSTT/meetily/screenpipe —— 本轮只记新进展并大幅加深。

## 核心硬数据（先看这个）

**中文 ASR 在纯 CPU 上的新王座（FunASR 官方 llama.cpp 基准，184 段真实普通话，micro-CER normalize_zh，8 线程，模型加载除外）**：

| 系统 | CER% | 速度 | 体积 |
|---|---|---|---|
| SenseVoiceSmall (Q8 GGUF) | **8.17**（fp32 参考值 7.81） | **~20x 实时** | 449 MB (f16) |
| Paraformer (Q8) | 9.89（裸二进制+内置VAD：9.85） | ~21x 实时 | 401 MB |
| Fun-ASR-Nano (Q8) | 8.42（裸二进制：8.30） | LLM 自回归解码，慢于上两者 | 全套量化 ~1.3 GB |
| whisper.cpp base | 31.33 | 9.9x | 142 MB |
| whisper.cpp small | 22.12 | 4.6x | 466 MB |
| whisper.cpp large-v3-turbo | 23.15 | 3.2x | 1.6 GB |

**结论：中文场景 FunASR 系在每一档都比 whisper.cpp 精度高约 2.7 倍且更快** —— "中文一流 + CPU 实时"在 2026 年已不是权衡题。另：Paraformer ONNX 官方 RTF 0.110→0.038；Fun-ASR vLLM(H100) RTFx 340x/CER 8.20（GPU 服务档参考）。

## 一、全景表（39 项，按 A-G）

### A. 流式/实时 ASR（18）

| 项目 | 规模 | 许可 | 新进展/要点 | 对 V3 价值 | 鲜度 |
|---|---|---|---|---|---|
| [Fun-ASR](https://github.com/QwenAudio/Fun-ASR) | 1535★, Nano 800M | Apache-2.0 | 通义新一代：7方言+26口音、远场高噪93%、官方 llama.cpp/GGUF 单二进制（Win 预编译）、字级 CTC 时间戳、vLLM 流式 SDK | ★★★★★ 新王座 | 09-10 |
| [FunASR](https://github.com/modelscope/FunASR) | 20286★, v1.4.15 | MIT | websocket 2pass 服务、triton、llama.cpp runtime v0.2.6、MOSS 转写+日志方案 | ★★★★★ 服务化骨架 | 09-10 |
| [SenseVoice-Small](https://github.com/QwenAudio/SenseVoice) | 9297★（V2 后 +55） | MIT | 官方 Docker、时间戳对齐、GGUF Q8 CER 8.17@20x；自带情感+音频事件标签 | ★★★★★ 性价比之王 | 09-10 |
| [sherpa-onnx](https://github.com/k2-fsa/sherpa-onnx) | 14738★ | Apache-2.0 | 全家桶：流式ASR+KWS+说话人+VAD+音频标注+标点，Windows 原生 | ★★★★★ 统一运行时 | 09-11 |
| [whisper.cpp](https://github.com/ggml-org/whisper.cpp) | 53637★ | MIT | 中文 CER 22-31%（官方同机对比），英文/生态仍是标准 | ★★★ 英文备胎 | 09-11 |
| [faster-whisper](https://github.com/SYSTRAN/faster-whisper) | 25363★ | MIT | 停更于 2025-11；RealtimeSTT 默认引擎 | ★★ V2已录 | 2025-11 |
| [RealtimeSTT](https://github.com/KoljaB/RealtimeSTT) | 10127★ | MIT | CPU 档改为 sherpa-onnx 双模型（流式预览+终稿精修），带鉴权 WS server | ★★★★ 完整参考 | 08-30 |
| [Moonshine Voice](https://github.com/moonshine-ai/moonshine) (+[Micro](https://petewarden.com/2026/07/14/launching-moonshine-micro/)) | 11059★ | MIT | 1MB 级模型到超 Whisper-large-v3 精度；Micro 520KB RAM 跑 50 词命令识别（$0.80 芯片）；**英文 only** | ★★ 超轻量参照 | 08-31 |
| [Vosk](https://github.com/alphacep/vosk-api) | 15126★ | Apache-2.0 | V2已录；50MB 极小模型仍在，中文精度被碾压 | ★★ | 08-09 |
| [WeNet](https://github.com/wenet-e2e/wenet) | 5237★ | Apache-2.0 | U2++ 流式/非流式统一，MS 有中文在线模型，int8 边缘 | ★★★ Plan B | 09-07 |
| [FireRedASR/2S](https://github.com/FireRedTeam/FireRedASR) | 1984★+677★ | Apache-2.0 | 中文 SOTA CER 3.05；2026-02 发 2S 全家桶(ASR+VAD+LID+标点)；CPU RTF 未核实 | ★★★ 离线高精档 | 06-02 |
| [FunASR-GGML](https://github.com/huaxin0/FunASR-GGML) | 126★ | MIT | 985M(SANM+Qwen3-0.6B) 单 GGUF、CPU 实时麦克风流、热词注入 C ABI、Windows DLL | ★★★ 嵌入路线样本 | 07-22 |
| [streaming-sensevoice](https://github.com/pengzhendong/streaming-sensevoice) | 470★ | Apache-2.0 | 伪流式 SenseVoice + 热词 + WebSocket(MP3 前端) | ★★★★ 最短路径 | 06-15 |
| [SenseVoice.cpp](https://github.com/lovemefan/SenseVoice.cpp) | 574★ | MIT | 纯 C++ 移植，无 Python | ★★★ | 2025-12 |
| [Qwen2.5-Omni](https://github.com/QwenLM/Qwen2.5-Omni) | 4076★, 7B | Apache-2.0 | 端到端音频理解+生成；CPU 非 realtime | ★★ 离线解读 | 2025-06 |
| [Qwen2-Audio](https://github.com/QwenLM/Qwen2-Audio) | 2098★ | 未标注 | 已被 Omni 取代 | ★ | 2025-04 |
| [MiniCPM-o 2.6](https://github.com/OpenBMB/MiniCPM-V) | 26362★(并入), 8B | Apache-2.0 | 音频路径可省视觉模块省 3GB；Int4 仍需 8-10GB | ★ | 09-08 |
| [PaddleSpeech](https://github.com/PaddlePaddle/PaddleSpeech) | 12683★ | Apache-2.0 | 依赖栈重，Win 常驻不优 | ★★ | 08-12 |

### B. 唤醒词（5）

| 项目 | 规模 | 许可 | 要点 | 价值 |
|---|---|---|---|---|
| [sherpa-onnx KWS](https://k2-fsa.github.io/sherpa/onnx/kws/index.html) | 中文 zipformer 3.3M 参数 | Apache-2.0 | **免训练**：keywords.txt 写拼音即换唤醒词，阈值可调；issue #2678 提醒对模糊发音敏感 | ★★★★★ 中文最低成本 |
| [openWakeWord](https://github.com/dscripka/openWakeWord) | 2764★ | Apache-2.0 | 100% 合成数据训练（Colab <1h，中文可行，社区有实测）；目标误接受 <0.5 次/时、误拒 <5%；内置 Silero 门控 + verifier 声纹二段 | ★★★★ |
| [Porcupine](https://picovoice.ai/docs/quick-start/porcupine-python/) | 闭源商用 SDK | 专有(个人免费层, 细节未核实) | 商用级误触标杆；控制台训词；付费兜底 | ★★★ |
| [wyoming-openwakeword](https://github.com/rhasspy/wyoming-openwakeword) | 205★ | Apache-2.0 | HA 生态封装 | ★★ |
| [microWakeWord](https://github.com/kahrendt/microWakeWord) | 14★ | Apache-2.0 | MCU 级合成训练方法论 | ★ |

### C. VAD（4）

| 项目 | 规模 | 许可 | 要点 |
|---|---|---|---|
| [silero-vad](https://github.com/snakers4/silero-vad) | 10201★, ~1.7MB | MIT | 30ms 块 <1ms 单核；30min 音频 CPU ~20s；比 WebRTC 误错率低 ~4x（多源一致）；用 ONNX 版免 torch |
| [FSMN-VAD](https://huggingface.co/FunAudioLLM/fsmn-vad-GGUF) | FunASR 默认 | 随 FunASR | 有官方 GGUF；llama.cpp 裸二进制内置，分段边界差 <10ms，SenseVoice 裸跑即达 8.01 CER |
| [py-webrtcvad](https://github.com/wiseman/py-webrtcvad) | 2498★ | 未标注 | 上一代，仅极端环境 |
| [TEN VAD](https://huggingface.co/TEN-framework/ten-vad) | TEN 11120★ | Apache-2.0+附加条件 | 自称优于 Silero（可复现基准，自家口径）；watch-list |

### D. 说话人分离/日志（3）

| 项目 | 规模 | 许可 | 要点 |
|---|---|---|---|
| [3D-Speaker (CAM++)](https://github.com/modelscope/3D-Speaker) | 3133★ | Apache-2.0 可商用 | 中文说话人日志（分段-聚类+自动人数）；语义增强日志（结合 ASR 文本归属）；Fun-ASR 官方组合件 |
| [pyannote-audio](https://github.com/pyannote/pyannote-audio) | 10539★ | MIT(代码)/模型 HF gated | community-1 管线需 HF token+条款；CPU 慢（社区实测 30min 音频 GPU 12s）；离线档备选 |
| [SpeechBrain](https://github.com/speechbrain/speechbrain) | 11818★ | Apache-2.0 | 科研兜底，栈重 |

### E. 环境声事件分类（5）

| 项目 | 规模 | 许可 | 要点 |
|---|---|---|---|
| [YAMNet](https://www.tensorflow.org/hub/tutorials/yamnet) | Google 官方, 521 类 | Apache-2.0 生态 | MobileNetV1，CPU/TFLite 边缘友好；常开哨兵首选（固定类目） |
| [PANNs](https://github.com/qiuqiangkong/audioset_tagging_cnn) | 1777★ | MIT | 527 类，比 YAMNet 精度高一档，CPU 仍可跑 |
| [AST](https://github.com/YuanGongND/ast) | 1477★ | BSD-3 | 精度标杆但重，离线档 |
| [CLAP](https://github.com/LAION-AI/CLAP) | 2270★ | CC0 | **零样本**：自然语言提示判定事件（"有人在开电话会"），语义层粘合剂，低频调用 |
| [MediaPipe Audio Classifier](https://developers.google.com/edge/mediapipe/solutions/audio/audio_classifier) | LEAN 官方方案 | Apache-2.0 | 与 YAMNet 重叠，优先级低 |

补充：**SenseVoice 自带音频事件标签**（音乐/掌声/笑声等）——ASR 与环境事件一石二鸟，常开链路里 E 类可近乎零成本先享一半。

### F. Windows 音频采集（2）

| 项目 | 规模 | 许可 | 要点 |
|---|---|---|---|
| [PyAudioWPatch](https://github.com/s0d3s/PyAudioWPatch) | 241★ | Apache-2.0 | WASAPI loopback（录系统声，含蓝牙耳机），预编译 wheel，Recall.ai 赞助；坑：无声时丢流（Microsoft Learn 有记录）→ 需静音保活 |
| [python-sounddevice](https://github.com/spatialaudio/python-sounddevice) | 1271★ | MIT | 麦克风通道标准件；不自带 loopback |

（原版 PyAudio 已被 PyAudioWPatch 取代；MSVC 编译坑不再需要碰。）

### G. 服务化/成品管线参考（2+）

| 项目 | 规模 | 许可 | 要点 |
|---|---|---|---|
| [LiveTranslate](https://github.com/TheDeathDragon/LiveTranslate) | 647★ | MIT | **Windows 全管线成品**：loopback+麦克风混音 → Silero VAD(32ms) → SenseVoice/FunASR-Nano/faster-whisper 可换 → OpenAI 兼容 LLM 流式 → 悬浮字幕；Remote ASR 卸载；MS/HF 双源 |
| [whisper_streaming](https://github.com/ufal/whisper_streaming) | 3671★ | MIT | LocalAgreement 3.3s 延迟；作者已宣布被 SimulStreaming 取代——策略思想仍可移植 |
| FunASR runtime server | 见 A 类 | MIT | websocket 2pass + 多语言客户端（G 类骨架已并入 FunASR 条目） |
| meetily（V2 已录 30373★） | — | MIT | 会议→摘要成品参照，不在本轮重复展开 |

## 二、推荐感知栈（文字版数据流图）

```
┌─ 采集层 ──────────────────────────────────────────────┐
│ 麦克风: python-sounddevice (备选: sherpa-onnx 内置采集)  │
│ 系统声: PyAudioWPatch WASAPI loopback (会议/微信语音)    │
│         + 无声保活(Silence Injection) 防 WASAPI 丢流     │
└──────────────┬────────────────────────────────────────┘
               ▼
┌─ VAD 守门（常开, <1% CPU）────────────────────────────┐
│ silero-vad ONNX (1.7MB, <1ms/块, MIT)                 │
│ 备选: FSMN-VAD GGUF (走 llama.cpp 单二进制时零接线)     │
└──────┬───────────────────────────┬───────────────────┘
       ▼ 无语音:休眠               ▼ 检出语音
┌─ 环境声哨兵(低频) ──┐   ┌─ 分流层 ──────────────────────┐
│ YAMNet 521类(1s/次) │   │ ①唤醒通道(仅麦克风):           │
│ CLAP 零样本提示      │   │   sherpa-onnx KWS(3.3M,拼音词表)│
│ "电话会/键盘/门铃"   │   │   备选: openWakeWord(自训中文词) │
│ →场景状态机          │   │ ②对话通道(mic+loopback):       │
│ (会议开始/结束事件)  │   │   → ASR → 说话人归属           │
└─────────────────────┘   └──────┬───────────────────────┘
                                 ▼
┌─ ASR 层（CPU 8线程, 20x 实时余量）─────────────────────┐
│ 主力: SenseVoice-Small int8 (CER 8.17, ~450MB,         │
│       自带事件+情感标签, sherpa-onnx 或 GGUF 裸二进制)   │
│ 流式中间稿: streaming-sensevoice 伪流式 / Paraformer    │
│       流式(2pass: 中间结果+终稿)                        │
│ 升级档: Fun-ASR-Nano GGUF (方言口音+字级时间戳,         │
│        llama.cpp 单二进制 1.3GB)                       │
│ 热词: SeACo-Paraformer 热词表 / KWS 词表 / GGML 注入    │
└──────────────┬────────────────────────────────────────┘
               ▼
┌─ 说话人层（谁在说）───────────────────────────────────┐
│ CAM++ (3D-Speaker, Apache-2.0, FunASR 管线即插)        │
│ 备选: pyannote community-1(离线档, gated)              │
└──────────────┬────────────────────────────────────────┘
               ▼
┌─ 语义层（环节2/4的本地 LLM 接力）──────────────────────┐
│ 转写+说话人+场景事件 → 待办抽取/会议纪要 (本环节出口)    │
│ 参考成品: LiveTranslate(管线同构), meetily(会议→摘要)   │
└───────────────────────────────────────────────────────┘
```

**一句话**：sounddevice+PyAudioWPatch 双路采集 → silero-vad 守门 → sherpa-onnx KWS（拼音免训练唤醒）+ YAMNet/CLAP（环境事件）分流 → SenseVoice-Small int8 常开转写（升级 Fun-ASR-Nano GGUF）→ CAM++ 说话人归属 → 交给本地 LLM 抽待办。

## 三、CPU 常开功耗与内存预算估算

| 层 | 常驻内存 | CPU 占用 | 依据 |
|---|---|---|---|
| silero-vad (ONNX) | ~5-10MB | <1% 单核（<1ms/30ms块） | 官方 |
| sherpa-onnx KWS (int8 3.3M) | ~10-20MB | ~1-3% | 模型规模推算，未核实 |
| YAMNet (1s/次) | ~10-30MB | 平均 <2% | 边缘部署多源 |
| SenseVoice int8（按需加载） | ~300-500MB（含运行时） | 说话时 ~5-15%（RTF 0.05 @8线程），静默时 0 | 官方 20x 实时 |
| CAM++ | ~30-50MB | 说话时 ~2-5% | 模型规模推算，未核实 |
| **合计（Python 进程）** | **~0.6-1GB** | **静默 <5%，会议中 ~15-25%** | — |
| 替代路线：llama.cpp 单二进制（Fun-ASR-Nano+FSMN-VAD） | 权重 1.3GB + 运行 ~2GB | 说话时更高（0.6B LLM 解码），静默同上 | 官方标注"LLM decode 慢于 encoder-only" |

8GB 内存机：走 Python+SenseVoice int8 路线（<1GB）安全；16GB 机可常驻 Fun-ASR-Nano。24h 稳定性三坑：①WASAPI loopback 无声丢流（需保活）②Python 长循环内存泄漏（需 watchdog+定期重建流）③Windows 睡眠/独占模式抢占（需电源策略+设备切换重连）。

## 四、Top5 缝合推荐

1. **Fun-ASR（QwenAudio）**——中文 CPU ASR 新王座：官方 llama.cpp/GGUF 单二进制 + 方言口音覆盖 + 字级时间戳，"whisper.cpp 之于 Whisper"的中国答案。
2. **sherpa-onnx**——感知全家桶统一运行时：流式 ASR+KWS+VAD+说话人+音频标注一个库全包，Windows 原生，Apache-2.0。
3. **SenseVoice-Small**——常开性价比之王：CER 8.17 @ 20x 实时 @ 449MB，还白送情感+音频事件标签（环境解读一石二鸟）。
4. **silero-vad**——常开守门员：<1ms/块、1.7MB、MIT，全生态默认件。
5. **LiveTranslate**——Windows 全管线成品参照：loopback→VAD→多引擎ASR→LLM→悬浮字幕，与本推荐栈技术同构，直接解剖缝合。

## 五、3 条硬启示

1. **"中文一流 + CPU 实时"的权衡已消失**：FunASR 系在 CPU 8 线程上 20x 实时、CER 8-10%，同机 whisper.cpp 中文 22-31%——为 PAI-Station 选中文 ASR 时，Whisper 系已不在候选名单（仅英文备胎），且官方 GGUF 路线让"单二进制常驻"成为可能。
2. **中文唤醒词可以零训练落地**：sherpa-onnx KWS 改拼音文本文件即换词（3.3M 参数），openWakeWord 用合成数据 <1 小时自训中文词（<0.5 误触/时目标）；但误触防线必须三层叠加（阈值 + VAD 门控 + 声纹 verifier），单层必翻车。
3. **环境声→待办的最短路径不是"更全的分类器"而是组合拳**：SenseVoice 自带事件标签（近零成本）+ YAMNet 固定类目哨兵 + CLAP 自然语言零采样判定（低频），三层拼出"会议开始/有人在说话/键盘/门铃"；真正难的不是模型，是 24h 常开的 Windows 音频工程（loopback 保活、watchdog、功耗策略）。

## 六、风险与红线

- **隐私红线（最高优先）**：环境声持续解读 = 录音设备常开。必须：本地优先不上云、录音即弃（只留文本/事件标签）、硬件级麦克风指示灯不可绕过、按 App/时段/地点的静默白名单（如浏览器播放影视时自动暂停语义层）、原始音频默认零落盘。这是产品生死线，不是功能项。
- **误唤醒**：开源 KWS 对模糊发音敏感（sherpa issue #2678）；唤醒后的指令建议"高风险动作二次确认"（唤醒只是开麦，执行需确认或限白名单动作）。
- **许可细节**：pyannote community-1 模型 HF gated（需 token+接受条款，商用需确认）；Porcupine 免费层仅个人用途且细节随官网变动；Qwen2-Audio repo 无 SPDX 标注；TEN 框架 Apache-2.0 带附加条件。CAM++/sherpa-onnx/SenseVoice/Fun-ASR 均 Apache-2.0/MIT 可商用。
- **音频 LLM 幻觉**：Qwen2.5-Omni/MiniCPM-o 等 7-9B 音频模型在 8-16GB 无独显 Windows 上 CPU 非 realtime（FP16 17GB+，Int4 5-10GB），只能当"离线复盘"器官，绝不能进常开链路。
- **长稳**：WASAPI loopback 无声丢流有微软官方记录；Python 音频循环需 watchdog；Moonshine 系英文 only 不能用中文主链路；Fun-ASR llama.cpp runtime 尚年轻（v0.2.6，Windows 预编译刚落地），生产采用需锁版本+留 sherpa-onnx 退路。
