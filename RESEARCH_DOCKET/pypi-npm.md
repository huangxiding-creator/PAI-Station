# 频道：PyPI/npm 关键依赖盘点（缝合件清单）

## 已在用户生态验证过（直接复用）
- DrissionPage 4.1.x（★12,421）：浏览器自动化 + 收发包双模式 —— 用户指定，Fund-Fortune venv 已有
- zhipu SDK / openai 兼容端点：glm-4-flash（128K，30 并发）→ glm-4.7-flash（200K）→ glm-z1-flash（推理）链 —— We-AIPO zhipu.py 已含 _AdaptivePacer 限流降级
- python-docx：Word 专业排版输出（用户机器已装）
- tenacity、APScheduler（★7,624）、watchdog（★7,405）：重试/调度/文件监听

## 频道接入（新增）
- lark-oapi：飞书官方 SDK，WebSocket 长连接
- dingtalk-stream：钉钉 Stream Mode 官方 SDK
- requests：企微自建应用/Webhook（官方 REST，无需重 SDK）

## 感知层（新增）
- faster-whisper（★25,247）/ FunASR（★~20k）/ SenseVoice（★9,242，中文 CER 减半、169x 实时）：语音转写三级方案
- RealtimeSTT（★10,111）：实时听写（英文场景/兜底）
- PaddleOCR（★88,913）/ RapidOCR（轻量 CPU）/ Umi-OCR（★47,107，中文桌面 OCR 标杆）
- mss / dxcam：低开销截图（滚动 10 分钟留存）

## 文档→MD（新增）
- MarkItDown（微软）/ MinerU（★79,235，复杂 PDF 最强）/ docling（IBM，★66,026，表格公式）/ marker（★39,531）
- 策略：Office→MarkItDown，扫描件 PDF→MinerU/ocr 后备

## 存储/检索（新增）
- sqlite-vec 或 LanceDB（嵌入向量）+ SQLite FTS5（BM25 中文分词 via jieba）
- 免重型服务：不用 Qdrant/Milvus，绿色便携版原则

## 桌面壳（新增）
- pywebview（★6,008，轻量，配本地 HTML UI）或 Flet（★16,649）；系统托盘 pystray；开机自启 WinSW（★14,280）或 schtasks
