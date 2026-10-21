# ARCHITECTURE — 水利安检卡

## 总体
```
[灵珠侧(只读源)] --提取脚本--> IR/人设/语料 --转换器(Python)--> 板端资产包
板端资产 = identity.md/soul.md + router_rules.json + skills/* + knowledge/*.md
          --预烧 .recovery/FATFS--> [esp-mosaico-claw fork 固件]
固件 --WSL idf.py build--> bin --Windows esptool/USB CDC--> 板
板 --Wi-Fi HTTPS--> DeepSeek API / 博查搜索 / 新闻站 / 企微webhook / 飞书API
```

## ADR-1 构建环境
WSL2 Ubuntu24.04 + ESP-IDF **v6.1 标签**(实测含 esp32s31, 816 文件)。回退: master@7b9cc1ac(vibe 官方钉)。
烧录: bin 拷回 Windows, esptool(pip) 或出厂 CDC 自动烧录; 浏览器 Web Serial 备用。

## ADR-2 固件策略: fork esp-mosaico-claw@2e1017e
不改框架核心; 只动 `fatfs_image/system/.recovery/`(人设/规则预烧) + `main/` 少量配置(默认 LLM backend 指向 DeepSeek 预设、默认 allowlist)。上游更新走 git rebase 通道。

## ADR-3 意图路由双通道
- 确定性(扫描隐患/快速巡查/操作演示/播报新闻/我要提意见/设定项目): router_rules.json 前缀命中 → run_agent(带模式注入, 仿 mosaico ai_create mode-enum) 或 run_script
- 模糊: 默认路由到 agent, 人设+技能目录自路由

## ADR-4 知识双层
- P1: `knowledge/*.md` 挂 /fatfs (静态蒸馏, 断网可用) — 技能「查知识库」先检索板端 md, 未命中再联网
- P2(可选): 观澜 ECS /api/rag (POST {q, topk} → {chunks[]}) — http_request + allowlist
语料管线: docx → 提纯 md → 分块(标题树) → 人工抽检 30 题

## ADR-5 LLM
NVS: llm_backend=openai_compatible, llm_base_url=https://api.deepseek.com, llm_model=deepseek-chat(v4), key 用户 Web 台填入(默认预置空, 首次配置引导)。vision 腿(M5 后): supports_vision=on, 换多模态模型。

## ADR-6 资产转换器（本项目核心自有代码）
`tools/lingzhu2claw/`: IR(canvas json) + persona → 板端资产包。输入=RESEARCH_DOCKET/lingzhu_extract/, 输出=fatfs_image/system/.recovery/ 覆盖件。可重复运行(幂等), 基线冻结参数化。

## 缝合契约（DoD→准入）
| 上游 | DoD | 下游准入 |
|---|---|---|
| 提取件 | JSON schema 校验过 | 转换器可跑 |
| 转换器 | 生成物清单+md 语法校验 | 固件 build 过 |
| 固件 build | idf.py build exit 0 + bin 尺寸报告 | 烧录 |
| 烧录 | esptool 校验 OK + 串口日志见启动 | 对拍测试 |
| 对拍 | 24 意图+30 知识题达标率 | 收官 |
