# DIGEST — 第 13 路：ANP 与 did:wba 去中心化身份预研（P3 意图结算预留）

- 日期：2026-09-17 ｜ 条目：30（A 组织全景 8 / B did:wba spec 5 / C agent 支付 7 / D DID 底座 7 / E 同类网络 3）
- 验证方式：gh api 全程实查（org repos / repo metadata / contents 文件级拉取 / code search）。WebSearch 与 webReader 周配额当日耗尽、WebFetch 域名安全预检被本机网络阻断，故非 GitHub 站点（ANP 官网 agent-network-protocol.com、Google AP2 官网 ap2-protocol.org、x402.org）未能亲自拉取，均未作为条目收录，仅在注明出处链的情况下于文中出现。
- 事实纠偏三则（相对任务书）：①任务书提到的 anp-fabric 仓库不存在（GitHub 全局搜索 0 结果，组织 18 仓清单中亦无）；②AgentConnect 已改名 anp（gh api 重定向实证），README 中旧链接仍指向旧名；③EIP-7702 全文 0 次提及 agent，是 EOA 代码委托（账户抽象）提案，与 agent 身份无直接规范内容，未收录。

---

## ① did:wba 确切语法与最小实现路径

### 一句话语法

**did:wba = did:web 的 agent 化扩展：`did:wba:<FQDN>[:<路径段…>:e1_<43位base64url指纹>]`——裸域名形态解析到 `https://<域名>/.well-known/did.json`，路径形态解析到 `https://<域名>/<路径>/did.json`，末段指纹是 DID 与用户自持 Ed25519 私钥的密码学绑定（e1_ profile 为默认且强制）。**

### spec 原文关键句（出处：ANP-03 v1.1，逐字精读）

URL: https://github.com/agent-network-protocol/AgentNetworkProtocol/blob/main/03-did-wba-method-design-specification.md

ABNF（spec 2.2 节原文）：

```abnf
base64url-char = ALPHA / DIGIT / "-" / "_"
path-segment   = 1*(ALPHA / DIGIT / "-" / "_" / ".")
e1-fingerprint = "e1_" 43base64url-char

wba-root-did = "did:wba:" domain-name
wba-path-did = "did:wba:" domain-name 1*(":" path-segment) ":" e1-fingerprint
wba-did      = wba-root-did / wba-path-did
```

方法名与域名规则（spec 2.1/2.2 节原文要点）：
- "The name string used to identify this DID method is `wba`… must be lowercase."
- "The method-specific identifier is a fully qualified domain name (FQDN) protected by TLS"— 域名必须与服务证书的 subjectAltName dNSName 匹配，**不得使用 IP 地址**；端口可带但冒号必须百分号编码为 `%3A`；路径用冒号代替斜杠做分隔。
- 与 did:web 的关系（spec 1.1 节原文）："This method is extended and optimized based on did:web, named did:wba"——之所以不直接改 did:web："reaching consensus with the original author on those modifications would be a long-term process. Therefore, we decided to use a new method name."

e1_ 指纹生成六步（spec 2.2.2 节，操作级原文）：
1. 选 Ed25519 绑定密钥，在 DID 文档中以 `Multikey`/`publicKeyMultibase` 表示且被 `authentication` 授权；
2. `publicKeyMultibase`（base58-btc）解码得 32 字节原始公钥，构造仅含必要字段的等价 JWK：`{"crv":"Ed25519","kty":"OKP","x":"<32字节的base64url无填充>"}`；
3. 按 RFC 7638 生成 thumbprint 输入（字段名字典序、无多余空白、UTF-8）；
4. SHA-256 得 32 字节摘要；
5. base64url 编码去 `=` 填充，固定 43 字符；
6. 加 `e1_` 前缀作为路径末段。

解析（Reading，spec 2.5.2 节原文要点）：冒号换斜杠→端口百分号解码→拼 `https://`→无路径则补 `/.well-known`→追加 `/did.json`→HTTP GET→校验文档 `id` 与被解析 DID 一致；**对 e1_ 路径型 DID 额外强制**："DID Document top-level `proof` must exist"且必须通过 `DataIntegrityProof` + `eddsa-jcs-2022` 验证、proof.verificationMethod 必须是 Ed25519 Multikey、其 RFC 7638 thumbprint 必须与路径末段 e1_ 指纹"completely consistent"。spec 原文重话："For `e1_` DIDs, there is no relaxed mode of 'DID Document does not contain `proof` and can still be parsed'."

DID Document 必填字段（spec 2.5 节）：`@context`（必含 `https://www.w3.org/ns/did/v1`，e1 文档另必含 `https://w3id.org/security/data-integrity/v2` 与 `.../multikey/v1`）、`id`、`verificationMethod`（e1 路径型必须至少一个 Ed25519 Multikey 绑定键；E2EE 场景建议另含 `X25519KeyAgreementKey2019` 密钥协商键，签名/协商键分离）、`authentication`（绑定键必须被授权）、顶层 `proof`（e1 下必填，cryptosuite 固定 eddsa-jcs-2022，proofPurpose 固定 assertionMethod）。可选：`assertionMethod`、`keyAgreement`、`service`（类型支持 `AgentDescription` / `ANPHandleService` / `ANPMessageService`）。

跨平台认证（spec 3 节）：客户端首请求用 RFC 9421 `Signature-Input`/`Signature` 头签名（keyid 必须是完整 DID URL 如 `did:wba:example.com:user:alice:e1_<fp>#key-1`），带消息体时加 RFC 9530 `Content-Digest`；服务端拉对端 DID 文档验证签名后经 `Authentication-Info` 响应头返回 access token（推荐 JWT），后续请求走 Bearer。最小签名覆盖：`@method`、`@target-uri`、`content-digest`。

### 创建一个合法 did:wba 的最小步骤（spec 2.5.1 Create 原文 + 实现印证）

1. 拥有一个域名（注册商申请，DNS 指向托管服务）；
2. 生成 Ed25519 密钥对，按上述六步算出 `e1_<指纹>`；
3. 写 DID 文档 JSON-LD（含必填字段+顶层 proof），放到 `https://<域名>/.well-known/did.json`（裸域）或 `https://<域名>/<路径>/e1_<指纹>/did.json`（路径型）；
4. 完事——"The did:wba method specification does not specify specific HTTP API operations"，注册即文件发布，无链、无注册商合约。

官方参考实现：did-wba-example（FastAPI，自动生成 DID 文档+私钥）与 anp SDK（`anp/authentication/did_wba.py` + `anp/proof/did_wba_binding.py`，另有 go/rust/dart 移植）。

---

## ② ANP 的 agent 结算协议形态（任务卡→支付的证据链）

URL: https://github.com/agent-network-protocol/AgentNetworkProtocol/blob/main/application/10-anp-agent-payment-protocol-specification.md

**谱系**：AP2 原版是 Google 2025 年 9 月发布的开放协议（官网 https://ap2-protocol.org/，本机直连不通未能亲验，出处为 ANP-10 spec 原文与 Custena 全景报告交叉引用）。ANP-10 是其在 ANP 框架内的去中心化改编，spec 1.3.2 节给出改编表：身份从支付网络既有体系→**did:wba**；通信从 A2A/MCP 扩展→ANP 元协议；凭证从严格 W3C VC→**JWT/JWS 轻量实现**；支付方式从卡组织 pull 支付→**支付宝/微信二维码优先**；M1 砍掉 IntentMandate（无人值守预授权），M2 再上。

**四角色**：Shopper Agent（买方代理）、Merchant Agent（卖方代理）、Credentials Provider（凭证提供方，M1 允许并入 SA）、Payment Processor（支付处理方）。

**三凭证构成证据链**：
- `CartMandate`（购物车授权）：订单明细+支付二维码+商家签名 `merchant_authorization`（RS256/ES256K 签 `cart_hash = SHA-256(JWS(contents))`）；
- `PaymentMandate`（支付授权）：用户扫码完成第三方支付后，SA 以用户私钥对 `transaction_data`（cart_hash+pmt_hash）签名生成 `user_authorization`；
- `DeliveryReceipt`（交付回执）：商家可选回传的发货/服务证明。

**四阶段流程**（spec 2.3 节 mermaid 图）：建车（create_cart_mandate）→用户授权（扫码支付+提交支付证明）→支付处理（send_payment_mandate，MA 验双签+双哈希，PP 确认）→交付确认（transaction_id+DeliveryReceipt）。

**安全机制表**（spec 2.3.3 原文）：数据完整性=cart_hash；商家认证=merchant_authorization；用户授权=user_authorization；防重放=jti 全局唯一；时间窗=iat/exp（建议 15 分钟）；**身份绑定=cnf 字段绑定持有者 DID**——这就是"任务卡→支付"可审计链的扣环：每个凭证都锚定到 did:wba 身份上。

**对标格局**（Custena 全景报告，2026-04）：HTTP 402 系 x402（Linux Foundation，6620★，USDC on Base，V2 已支持钱包会话）/ MPP（Stripe+Tempo，2026-03-18 主网，法币+加密同信封）/ L402（Lightning Labs，macaroon 可复用凭证）；卡组织系 Visa TAP+ICC、Mastercard Agent Pay（SD-JWT 三层凭证+Verifiable Intent 开源）、Amex ACE、Google AP2；商务系 UCP/ACP。关键事实：**Visa TAP 与 Mastercard 的 agent 身份验证都收敛到 RFC 9421 HTTP Message Signatures——与 did:wba 的认证机制同一原语**，说明 PAI-Station 押注 RFC 9421 签名方向的通用性。A2A 本体实查（specification/ 目录仅 proto+json，无 payment 文件）不带结算；MCP 无官方计费扩展（生态内以 mcp-payments-library、Custena 适配层等第三方补位）。

---

## ③ PAI-Station swarm 接线建议：placeholder → 真 did:wba

现状：swarm 身份为 `did:wba:placeholder:<site_id>`。升级分两档：

### 一步能做（本机，零新基建，当天）

1. **密钥与指纹**：每 site 生成 Ed25519 密钥对（本机openssl/PyNaCl 即可），按 spec 六步派生 `e1_<43字符>`。核心算法 ~40 行，anp SDK `anp/proof/did_wba_binding.py`（Python）可直接参考或 vendor。
2. **DID 字符串就位**：把记账键升级为 `did:wba:<真域名>:site:<site_id>:e1_<指纹>` 形态先行占位（此时尚不可解析，但密钥→身份的绑定已真实成立，积分账本签名可立即用该私钥做 Ed25519 签名）。
3. **DID 文档生成**：本地写好 JSON-LD（@context 四件套、Multikey 绑定键、authentication/assertionMethod、X25519 keyAgreement、顶层 DataIntegrityProof/eddsa-jcs-2022 proof），纳入 git 版本化——spec 2.5.3 原文即建议"Use a version control system such as git… to manage updates to DID documents"。

### 需要基建（阿里云 ECS + 域名，可复用现有 gcblog.net 体系）

1. **HTTPS DID 端点**：nginx 在 443 暴露 `/.well-known/did.json`（域级身份）与 `/site/<site_id>/e1_<指纹>/did.json`（路径型）。注意：did:wba **禁止 IP 直连**（spec 2.2 "must not contain IP addresses"），47.120.43.20 不能出现在 DID 里；8881/8882/8883 若要进 DID 需写成 `gcblog.net%3A8881`（端口百分号编码），更干净的做法是 443 反代。
2. **TLS 证书**：证书 subjectAltName 的 dNSName 必须匹配 DID 域名（spec 明确不得依赖 CN）。现有 Let's Encrypt/阿里云证书体系即可。
3. **proof 闭环**：e1 profile 下 proof 缺失=解析必败（无宽松模式），发布前必须用 anp SDK 的 verifier（`did_wba_verifier.py`）自测解析+验签全链路。
4. **（可选，第二阶段）WNS Handle**：密钥轮换会换 DID（"when the binding key changes, the path-type DID also changes"，spec 1.2/2.5.3），稳定名靠 WNS Handle（`/.well-known/handle/<name>` 双向绑定，ANP-04）。轮换频率低可暂缓。
5. **（可选）AP2 结算预留**：P3 意图结算若走 ANP 路线，任务卡→支付的证据链=CartMandate(商家签名)+PaymentMandate(cnf 绑 DID)+DeliveryReceipt，全部 JWT/JWS，身份层直接复用上述 did:wba。对照实验可接 nevermined-io/payments-py 或 x402 Python SDK。

**采用前须知的风险事实**：did:wba 未进入 W3C 官方 DID 方法注册表（w3c/did-extensions code search 0 命中，实查）；ANP 组织自述未发币、spec 仍在快速迭代（vNext 草案并行）；但机制底座（did:web + RFC 9421/9530 + RFC 7638）全部是成熟 W3C/IETF 标准，即便 ANP 生态失败，密钥→指纹→域名文档的实现资产可无损退化为 did:web 兼容形态（Appendix B 保证了这条退路）。

---

## ④ Top 5

| # | 条目 | 为什么最重要 |
|---|------|--------------|
| 1 | [ANP-03 did:wba Method Specification v1.1](https://github.com/agent-network-protocol/AgentNetworkProtocol/blob/main/03-did-wba-method-design-specification.md) | 语法/指纹/文档/解析/认证的唯一权威，953 行已逐字精读并摘录 |
| 2 | [AgentNetworkProtocol 主仓](https://github.com/agent-network-protocol/AgentNetworkProtocol)（1431★） | ANP 1.1 全套 spec 索引（03/04/07/08/09/10+附录），生态入口 |
| 3 | [anp SDK（原 AgentConnect）](https://github.com/agent-network-protocol/anp)（348★） | did:wba+AP2 官方多语言实现，placeholder 升级的直接代码路径 |
| 4 | [x402-foundation/x402](https://github.com/x402-foundation/x402)（6620★） | agent 支付的事实标准旗舰（Linux Foundation），P3 结算对标基准 |
| 5 | [Custena/agent-payment-protocols 全景报告](https://github.com/Custena/agent-payment-protocols) | 十余协议分层格局+多协议姿态决策框架，选型必读 |
