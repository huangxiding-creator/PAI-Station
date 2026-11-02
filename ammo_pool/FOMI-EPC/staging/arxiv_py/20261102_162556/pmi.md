# arXiv 官方API面 (arxiv.py 封装同面) 检索简报 | PMI 项目管理大奖 评选标准

本件为渠道普查纳管 (1025令) 新接入的 arXiv 官方API面 (arxiv.py 封装同面) 渠道一次引擎运行的实测收割面。内容=命中条目的标题、元信息与摘要/描述摘录 (cred=data, 结构化一手元数据面), 数字均引擎实测零手填。

- 检索词: PMI 项目管理大奖 评选标准
- 引擎: arXiv 官方API面 (arxiv.py 封装同面) (engine=arxiv_py) | 采集: 2026-11-02 16:26
- 通道: HTTP 200 via direct | https://export.arxiv.org/api/query

---

## Asymmetric response to PMI announcements in China's stock returns

*2018-06-12 | Yingli Wang*

原文: https://arxiv.org/pdf/1806.04347v1

**摘要/描述摘录:**
> Considered an important macroeconomic indicator, the Purchasing Managers' Index (PMI) on Manufacturing generally assumes that PMI announcements will produce an impact on stock markets. International experience suggests that stock markets react to negative PMI news. In this research, we empirically investigate the stock market reaction towards PMI in China. The asymmetric effects of PMI announcements on the stock market are observed: no market reaction is generated towards negative PMI announcements, while a positive reaction is generally generated for positive PMI news. We further find that the positive reaction towards the positive PMI news occurs 1 day before the announcement and lasts for nearly 3 days, and the positive reaction is observed in the context of expanding economic conditions. By contrast, the negative reaction towards negative PMI news is prevalent during downward economic conditions for stocks with low market value, low institutional shareholding ratios or high price earnings. Our study implies that China's stock market favors risk to a certain extent given the vast number of individual investors in the country, and there may exist information leakage in the market.

## A Statistical Inference Framework for PMI Estimation and SGNS Word Embeddings

*2026-10-04 | Zhongqi Fan*

原文: https://arxiv.org/pdf/2610.05058v1

**摘要/描述摘录:**
> Pointwise Mutual Information (PMI) is a core measure of testing word association, and Skip-gram with Negative Sampling (SGNS) is essentially a method that implicitly factorizes a shifted PMI matrix. However, a systematic and well-rounded characterization of finite-sample uncertainty in PMI estimation remains absent and imperative to venture into. We provide a statistical framework for PMI estimation and its connection to SGNS. We prove consistency, asymptotic unbiasedness, and asymptotic normality of the empirical PMI estimator, derive its variance via the Delta method, and, applying stochastic approximation theory, obtain a variance decomposition for SGNS-based PMI estimation that separates data variance from optimization variance. Simulation experiments validate the Delta method approximation. Real-data experiments on the Brown Corpus (d = 100) reveal that SGNS systematically deviates from the theoretical relationship PMI + log K. The empirical relationship shows an attenuated PMI coefficient, an amplified log K effect, and a positive intercept, indicating systematic bias. Word analogy validation confirms the models are effective. The failure to validate the variance decomposition under low-dimensional conditions does not diminish its theoretical value; rather, it identifies the unbiasedness assumption as the key bottleneck and clarifies the gap between asymptotic theory and practice, providing implications for both practice and theory.

## Interference-Aware PMI selection for MIMO systems in an O-RAN scenario

*2025-04-20 | Rawlings Ntassah*

原文: https://arxiv.org/pdf/2504.14745v1

**摘要/描述摘录:**
> The optimization of Precoding Matrix Indicators (PMIs) is crucial for enhancing the performance of 5G networks, particularly in dense deployments where inter-cell interference is a significant challenge. Some approaches have leveraged AI/ML techniques for beamforming and beam selection, however, these methods often overlook the multi-objective nature of PMI selection, which requires balancing spectral efficiency (SE) and interference reduction. This paper proposes an interference-aware PMI selection method using an Advantage Actor-Critic (A2C) reinforcement learning model, designed for deployment within an O-RAN framework as an xApp. The proposed model prioritizes user equipment (UE) based on a novel strategy and adjusts PMI values accordingly, with interference management and efficient resource utilization. Experimental results in an O-RAN environment demonstrate the approach's effectiveness in improving network performance metrics, including SE and interference mitigation.

## Identifying Factors to Help Improve Existing Decomposition-Based PMI Estimation Methods

*2024-08-31 | Anna-Maria Nau*

原文: https://arxiv.org/pdf/2409.09056v1

**摘要/描述摘录:**
> Accurately assessing the postmortem interval (PMI) is an important task in forensic science. Some of the existing techniques use regression models that use a decomposition score to predict the PMI or accumulated degree days (ADD), however, the provided formulas are based on very small samples and the accuracy is low. With the advent of Big Data, much larger samples can be used to improve PMI estimation methods. We, therefore, aim to investigate ways to improve PMI prediction accuracy by (a) using a much larger sample size, (b) employing more advanced linear models, and (c) enhancing models with factors known to affect the human decay process. Specifically, this study involved the curation of a sample of 249 human subjects from a large-scale decomposition dataset, followed by evaluating pre-existing PMI/ADD formulas and fitting increasingly sophisticated models to estimate the PMI/ADD. Results showed that including the total decomposition score (TDS), demographic factors (age, biological sex, and BMI), and weather-related factors (season of discovery, temperature history, and humidity history) increased the accuracy of the PMI/ADD models. Furthermore, the best performing PMI estimation model using the TDS, demographic, and weather-related features as predictors resulted in an adjusted R-squared of 0.34 and an RMSE of 0.95. It had a 7% lower RMSE than a model using only the TDS to predict the PMI and a 48% lower RMSE than the pre-existing PMI formula. The best ADD estimation mo

## Squashed Shifted PMI Matrix: Bridging Word Embeddings and Hyperbolic Spaces

*2020-02-27 | Zhenisbek Assylbekov*

原文: https://arxiv.org/pdf/2002.12005v2

**摘要/描述摘录:**
> We show that removing sigmoid transformation in the skip-gram with negative sampling (SGNS) objective does not harm the quality of word vectors significantly and at the same time is related to factorizing a squashed shifted PMI matrix which, in turn, can be treated as a connection probabilities matrix of a random graph. Empirically, such graph is a complex network, i.e. it has strong clustering and scale-free degree distribution, and is tightly connected with hyperbolic spaces. In short, we show the connection between static word embeddings and hyperbolic spaces through the squashed shifted PMI matrix using analytical and empirical methods.

## Low-Rank Approximation of Matrices for PMI-based Word Embeddings

*2019-09-21 | Alena Sorokina*

原文: https://arxiv.org/pdf/1909.09855v1

**摘要/描述摘录:**
> We perform an empirical evaluation of several methods of low-rank approximation in the problem of obtaining PMI-based word embeddings. All word vectors were trained on parts of a large corpus extracted from English Wikipedia (enwik9) which was divided into two equal-sized datasets, from which PMI matrices were obtained. A repeated measures design was used in assigning a method of low-rank approximation (SVD, NMF, QR) and dimensionality of the vectors (250, 500) to each of the PMI matrix replicates. Our experiments show that word vectors obtained from the truncated SVD achieve the best performance on two downstream tasks, similarity and analogy, compare to the other two low-rank approximation methods.

## A Simple Language Model based on PMI Matrix Approximations

*2017-07-17 | Oren Melamud*

原文: https://arxiv.org/pdf/1707.05266v1

**摘要/描述摘录:**
> In this study, we introduce a new approach for learning language models by training them to estimate word-context pointwise mutual information (PMI), and then deriving the desired conditional probabilities from PMI at test time. Specifically, we show that with minor modifications to word2vec's algorithm, we get principled language models that are closely related to the well-established Noise Contrastive Estimation (NCE) based language models. A compelling aspect of our approach is that our models are trained with the same simple negative sampling objective function that is commonly used in word2vec to learn word embeddings.

## Correspondence Analysis and PMI-Based Word Embeddings: A Comparative Study

*2024-05-31 | Qianqian Qi*

原文: https://arxiv.org/pdf/2405.20895v3

**摘要/描述摘录:**
> Popular word embedding methods such as GloVe and Word2Vec are related to the factorization of the pointwise mutual information (PMI) matrix. In this paper, we establish a formal connection between correspondence analysis (CA) and PMI-based word embedding methods. CA is a dimensionality reduction method that uses singular value decomposition (SVD), and we show that CA is mathematically close to the weighted factorization of the PMI matrix. We further introduce variants of CA for word-context matrices, namely CA applied after a square-root transformation (ROOT-CA) and after a fourth-root transformation (ROOTROOT-CA). We analyze the performance of these methods and examine how their success or failure is influenced by extreme values in the decomposed matrix. Although our primary focus is on traditionalstatic word embedding methods, we also include a comparison with a transformer-based encoder (BERT) to situate the results relative to contextual embeddings. Empirical evaluations across multiple corpora and word-similarity benchmarks show that ROOT-CA and ROOTROOT-CA perform slightly better overall than standard PMI-based methods and achieve results competitive with BERT.

---

合计 8 条命中 (源状态与代理路径如实记录于台账; 零手填)。