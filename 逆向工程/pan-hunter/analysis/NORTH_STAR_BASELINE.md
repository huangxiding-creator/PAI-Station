# NORTH STAR 基线（W1 · 2026-10-31）

> 数字全实测：逐发台账 analysis/northstar_hits.jsonl；抽书 seed=20261031 可复现。

## 口径
- 书源：ebook-treasure-chest all-books.json（24071 本）随机抽 **200** 本
- 搜索：**2 源/本书轮转**（9 活源全批覆盖；主射 400 发 ≤400 预算；含代理重试共 548 发入台账）
- 间隔≥2s 随机/源内串行/全源并发≤4；curl_cffi impersonate=chrome124

## 四数
1. **找到链接的书数：182/200（91.0%）**
2. 命中源数分布（每书，0-2 源口径）：{1: 131, 2: 51}
3. 链接盘型分布（去重/书）：{'quark': 138, 'xunlei': 68, 'baidu': 45, 'aliyun': 34, 'uc': 15, '139': 2, '189': 1, '123': 1}
4. **绿盘可下率：15/200（7.5%）**（书级=至少一条一级绿盘链；实际可下性另由 W1_GREEN_GATES 十盘真件门实证）

## 源命中排名（书数）
- melost: 45
- mikuclub: 45
- bixin: 43
- hunhepan: 31
- pansearch: 29
- panhunt: 14
- naspt: 13
- tg_tgsearchers7: 12
- miosou: 1

## 搜索账
- 主射 400 发；台账总发 548（含网络失败代理重试）
- 耗时 1039s
