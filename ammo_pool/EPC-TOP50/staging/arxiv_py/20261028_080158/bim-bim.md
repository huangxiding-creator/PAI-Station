# arXiv 官方API面 (arxiv.py 封装同面) 检索简报 | 数字化转型与BIM智能建造 BIM 智能建造 数字化 案例 方法

本件为渠道普查纳管 (1025令) 新接入的 arXiv 官方API面 (arxiv.py 封装同面) 渠道一次引擎运行的实测收割面。内容=命中条目的标题、元信息与摘要/描述摘录 (cred=data, 结构化一手元数据面), 数字均引擎实测零手填。

- 检索词: 数字化转型与BIM智能建造 BIM 智能建造 数字化 案例 方法
- 引擎: arXiv 官方API面 (arxiv.py 封装同面) (engine=arxiv_py) | 采集: 2026-10-28 08:21
- 通道: HTTP 200 via direct | https://export.arxiv.org/api/query

---

## Textured As-Is BIM via GIS-informed Point Cloud Segmentation

*2024-11-28 | Mohamed S. H. Alabassy*

原文: https://arxiv.org/pdf/2411.18898v1

**摘要/描述摘录:**
> Creating as-is models from scratch is to this day still a time- and money-consuming task due to its high manual effort. Therefore, projects, especially those with a big spatial extent, could profit from automating the process of creating semantically rich 3D geometries from surveying data such as Point Cloud Data (PCD). An automation can be achieved by using Machine and Deep Learning Models for object recognition and semantic segmentation of PCD. As PCDs do not usually include more than the mere position and RGB colour values of points, tapping into semantically enriched Geoinformation System (GIS) data can be used to enhance the process of creating meaningful as-is models. This paper presents a methodology, an implementation framework and a proof of concept for the automated generation of GIS-informed and BIM-ready as-is Building Information Models (BIM) for railway projects. The results show a high potential for cost savings and reveal the unemployed resources of freely accessible GIS data within.

## Improving BIM Authoring Process Reproducibility with Enhanced BIM Logging

*2023-05-29 | Suhyung Jang*

原文: https://arxiv.org/pdf/2305.18032v1

**摘要/描述摘录:**
> This paper presents an enhanced building information modeling (BIM) logger that captures building element geometry and attributes to accurately represent the BIM authoring process. The authors developed the logger and reproducing algorithm using the Revit C# API based on the analysis of information required to define building elements and associated attributes. The enhanced BIM log was evaluated through a case study of Villa Savoye designed by Le Corbusier, and the results show that it can accurately represent the BIM authoring process to a substantial level of reproducibility. The study provides a tool for capturing and reproducing the BIM authoring process. Future research can focus on improving the accuracy of the logging and reproducing algorithm and exploring further applications to automate the BIM authoring process using enhanced BIM logs.

## BIM-GPT: a Prompt-Based Virtual Assistant Framework for BIM Information Retrieval

*2023-04-18 | Junwen Zheng*

原文: https://arxiv.org/pdf/2304.09333v1

**摘要/描述摘录:**
> Efficient information retrieval (IR) from building information models (BIMs) poses significant challenges due to the necessity for deep BIM knowledge or extensive engineering efforts for automation. We introduce BIM-GPT, a prompt-based virtual assistant (VA) framework integrating BIM and generative pre-trained transformer (GPT) technologies to support NL-based IR. A prompt manager and dynamic template generate prompts for GPT models, enabling interpretation of NL queries, summarization of retrieved information, and answering BIM-related questions. In tests on a BIM IR dataset, our approach achieved 83.5% and 99.5% accuracy rates for classifying NL queries with no data and 2% data incorporated in prompts, respectively. Additionally, we validated the functionality of BIM-GPT through a VA prototype for a hospital building. This research contributes to the development of effective and versatile VAs for BIM IR in the construction industry, significantly enhancing BIM accessibility and reducing engineering efforts and training data requirements for processing NL queries.

## A Generalized LLM-Augmented BIM Framework: Application to a Speech-to-BIM system

*2024-09-26 | Ghang Lee*

原文: https://arxiv.org/pdf/2409.18345v1

**摘要/描述摘录:**
> Performing building information modeling (BIM) tasks is a complex process that imposes a steep learning curve and a heavy cognitive load due to the necessity of remembering sequences of numerous commands. With the rapid advancement of large language models (LLMs), it is foreseeable that BIM tasks, including querying and managing BIM data, 4D and 5D BIM, design compliance checking, or authoring a design, using written or spoken natural language (i.e., text-to-BIM or speech-to-BIM), will soon supplant traditional graphical user interfaces. This paper proposes a generalized LLM-augmented BIM framework to expedite the development of LLM-enhanced BIM applications by providing a step-by-step development process. The proposed framework consists of six steps: interpret-fill-match-structure-execute-check. The paper demonstrates the applicability of the proposed framework through implementing a speech-to-BIM application, NADIA-S (Natural-language-based Architectural Detailing through Interaction with Artificial Intelligence via Speech), using exterior wall detailing as an example.

## BIM-Loc: BIM-Integrated Discrepancy-Aware LiDAR-based Indoor Localization

*2026-06-12 | Yinqiang Zhang*

原文: https://arxiv.org/pdf/2606.14237v1

**摘要/描述摘录:**
> Accurate and robust localization is a fundamental requirement for service and inspection robots, particularly in feature-sparse indoor environments where traditional systems struggle due to a lack of distinct landmarks. While prior maps can enhance robustness, precise and compact maps capturing real-world details are often unavailable for new or frequently changing environments. This paper presents BIM-Loc, a novel discrepancy-aware LiDAR-based localization method that directly integrates Building Information Models (BIM) from the design phase. BIM-Loc simultaneously estimates trajectories aligned with the BIM coordinate system and identifies discrepancies between real-world observations and the as-designed BIM in an online fashion. Our core contributions include: (1) a novel multi-hit ray casting strategy for efficient BIM-point data association and projection of 3D observations into 2D texture space; (2) a pose graph optimization framework with BIM-integrated factors that enforces consistency among odometry, sequential scans, and BIM structures; and (3) a hierarchical Bayesian inference module that incrementally updates a continuous 2D surface representation for discrepancy detection, propagating updates from the pixel to the structure level. Extensive evaluations in both simulation and real-world applications demonstrate that BIM-Loc significantly outperforms state-of-the-art map-based methods in localization accuracy and robustness.

## BIM-SLAM: Integrating BIM Models in Multi-session SLAM for Lifelong Mapping using 3D LiDAR

*2024-08-28 | Miguel Arturo Vega Torres*

原文: https://arxiv.org/pdf/2408.15870v1

**摘要/描述摘录:**
> While 3D LiDAR sensor technology is becoming more advanced and cheaper every day, the growth of digitalization in the AEC industry contributes to the fact that 3D building information models (BIM models) are now available for a large part of the built environment. These two facts open the question of how 3D models can support 3D LiDAR long-term SLAM in indoor, GPS-denied environments. This paper proposes a methodology that leverages BIM models to create an updated map of indoor environments with sequential LiDAR measurements. Session data (pose graph-based map and descriptors) are initially generated from BIM models. Then, real-world data is aligned with the session data from the model using multi-session anchoring while minimizing the drift on the real-world data. Finally, the new elements not present in the BIM model are identified, grouped, and reconstructed in a surface representation, allowing a better visualization next to the BIM model. The framework enables the creation of a coherent map aligned with the BIM model that does not require prior knowledge of the initial pose of the robot, and it does not need to be inside the map.

## A Geometric-Relational Deep Learning Framework for BIM Object Classification

*2022-12-02 | Hairong Luo*

原文: https://arxiv.org/pdf/2212.00942v1

**摘要/描述摘录:**
> Interoperability issue is a significant problem in Building Information Modeling (BIM). Object type, as a kind of critical semantic information needed in multiple BIM applications like scan-to-BIM and code compliance checking, also suffers when exchanging BIM data or creating models using software of other domains. It can be supplemented using deep learning. Current deep learning methods mainly learn from the shape information of BIM objects for classification, leaving relational information inherent in the BIM context unused. To address this issue, we introduce a two-branch geometric-relational deep learning framework. It boosts previous geometric classification methods with relational information. We also present a BIM object dataset IFCNet++, which contains both geometric and relational information about the objects. Experiments show that our framework can be flexibly adapted to different geometric methods. And relational features do act as a bonus to general geometric learning methods, obviously improving their classification performance, thus reducing the manual labor of checking models and improving the practical value of enriched BIM models.

## Qwen-BIM: developing large language model for BIM-based design with domain-specific benchmark and dataset

*2026-02-24 | Jia-Rui Lin*

原文: https://arxiv.org/pdf/2602.20812v1

**摘要/描述摘录:**
> As the construction industry advances toward digital transformation, BIM (Building Information Modeling)-based design has become a key driver supporting intelligent construction. Despite Large Language Models (LLMs) have shown potential in promoting BIM-based design, the lack of specific datasets and LLM evaluation benchmarks has significantly hindered the performance of LLMs. Therefore, this paper addresses this gap by proposing: 1) an evaluation benchmark for BIM-based design together with corresponding quantitative indicators to evaluate the performance of LLMs, 2) a method for generating textual data from BIM and constructing corresponding BIM-derived datasets for LLM evaluation and fine-tuning, and 3) a fine-tuning strategy to adapt LLMs for BIM-based design. Results demonstrate that the proposed domain-specific benchmark effectively and comprehensively assesses LLM capabilities, highlighting that general LLMs are still incompetent for domain-specific tasks. Meanwhile, with the proposed benchmark and datasets, Qwen-BIM is developed and achieves a 21.0% average increase in G-Eval score compared to the base LLM model. Notably, with only 14B parameters, performance of Qwen-BIM is comparable to that of general LLMs with 671B parameters for BIM-based design tasks. Overall, this study develops the first domain-specific LLM for BIM-based design by introducing a comprehensive benchmark and high-quality dataset, which provide a solid foundation for developing BIM-related LLMs in

---

合计 8 条命中 (源状态与代理路径如实记录于台账; 零手填)。