# ARCHITECTURE — LayaForge

（图与分层说明见 PROPOSAL §2 六层缝合；本档记 ADR 决策记录）

## ADR-1 服务形态：独立 HTTP 服务 vs 进程内嵌入
**决策：独立 laya-server（127.0.0.1）**。理由：8 接线位分属 4+ 个进程/3 个 Python 运行时，
进程内嵌入=每进程 1.6GB VRAM×N+各自冷加载 23s；服务化=一份显存一份热、客户端零依赖
（urllib，沿 JudgmentClient transport 抽象）。推论锁：模型推理串行化（threading.Lock），
50ms/次下吞吐上限 ~20 QPS，远超本项目密度。

## ADR-2 引擎置换点：JudgmentClient transport 层
**决策：不动 ask() 主链，只换 transport**。ask() 的 body 构造/answers 解析/熔断/重试/fail-soft
对两引擎全等——laya transport=同 JSON POST 到 localhost、免鉴权、timeout 5s。
风险最小、回滚=ini 一行。

## ADR-3 检查点策略：首版仅 multilingual
zh/en 全覆盖（本机实测 en 83.3% 亦可用它），VRAM 1603MB；english 检查点待 VRAM 余量
实测后可选追加。微调产物 = 独立目录 checkpoint-ft-v{N}，服务配置指向，回归门过才切。

## ADR-4 训练配方：官方 notebook 单卡适配
fp32 全程（#185 头 300× 尺度禁 AMP）+梯度检查点+micro-batch 2-4+4 epochs；
温度 held-out 拟合（#186）。训练在服务空闲窗（晚间）跑，服务不中断（检查点热换）。

## ADR-5 平价门数据口径
E1-E3 重放必须用**原实验同款 state/questions**（E3 教训：换措辞=换实验）；
基线数字取自 RESEARCH_DIGEST B 表 Jev 实测列。
