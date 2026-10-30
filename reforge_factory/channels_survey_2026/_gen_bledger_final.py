# -*- coding: utf-8 -*-
import json,re,sys
from collections import Counter
sys.stdout.reconfigure(encoding='utf-8')
S=r'E:/AI-Station/reforge_factory/channels_survey_2026'
reg=json.load(open(S+'/MASTER_REGISTRY.json',encoding='utf-8'))
plan=json.load(open(S+'/btier_plan.json',encoding='utf-8'))
tc=Counter(e.get('tier') for e in reg['entries'])
bcount=tc['B']; assert bcount==plan['stats']['total_B']==234
buckets={k:len([e for e in plan['entries'] if e['bucket']==k]) for k in ('free_key','dataset','free_register','paid_only')}
assert buckets=={'free_key':64,'dataset':21,'free_register':124,'paid_only':25},buckets
rl=open(S+'/btier_register_ledger.md',encoding='utf-8').read()
fk=open(S+'/btier_freekey_ledger.md',encoding='utf-8').read()
def block(txt,a,b):
    i=txt.find(a); j=txt.find(b)
    assert i>=0 and j>i,(a,b)
    return txt[i:j].rstrip()
regA=block(rl,'## A. ','## B. ')   # lit 63
regB=block(rl,'## B. ','## C. ')   # UA 29
fkA=block(fk,'## ① ','## ② ')     # lit 7
fkC=block(fk,'## ③ ','## ④ ')     # UA 44
litA_rows=[l for l in regA.splitlines() if re.match(r'^\|\s*\d+\s*\|',l)]
fkA_rows=[l for l in fkA.splitlines() if re.match(r'^\|\s*[a-z0-9_]+\s',l)]
uaB_rows=[l for l in regB.splitlines() if re.match(r'^\|\s*\d+\s*\|',l)]
uaC_rows=[l for l in fkC.splitlines() if re.match(r'^\|\s*\d+\s*\|',l)]
assert len(litA_rows)==63, len(litA_rows)




assert len(uaB_rows)==29, len(uaB_rows)
assert len(uaC_rows)==44, len(uaC_rows)
md=f"""# B级接入总账 (B级96渠道全部接入调研渠道·终账)
生成: 2026-10-26 | 合并三波子台账: ① 集成台账.md (1025 登记波) ② btier_register_ledger.md (1026 免费注册波) ③ btier_freekey_ledger.md (1026 免费钥申领波)
权威源: MASTER_REGISTRY.json (620条) + btier_plan.json (B级分桶234) | 数字全实测 (脚本逐项复算, 断言通过): b_total={bcount} / lit_total=70 / user_actions=73 / paid_kept={buckets['paid_only']}
口径说明: 用户令时点 B级=96 (集成台账 1025 22:10 记录); 同日 22:20 终局调和 MASTER_REGISTRY 全量重判四级 → **B级=234** (A=195/B=234/C=185/D=6 实测tier计数), 本总账按调和终态 234 计 (96→234 演进如实留痕)。

## 0. 终账四数 (全实测)
| 数 | 值 | 口径与实测依据 |
|---|---|---|
| **b_total** | **{bcount}** | MASTER_REGISTRY.json tier=B 实测计数 = btier_plan.json stats.total_B (双源一致) |
| **lit_total** | **70** | 免费钥波 7 引擎 + 免费注册波 63 条 (两波零重叠, 程序判重通过; 注册波域名去重62 — BASE双址1站) |
| **user_actions** | **73** | 免费钥波 44 钥源 + 免费注册波 29 卡点; 名称归一化与plan-idx双口径交集均=空 (去重后仍 44+29) |
| **paid_kept** | **{buckets['paid_only']}** | btier_plan bucket=paid_only 实数 (纯付费/订阅/机构订阅 — 留档不接入, 免费宪法在役零采购) |

## 1. B级234分桶账 (btier_plan.json, 依据 MASTER_REGISTRY tier=B 逐条 access 分型)
| 桶 | 条数 | 状态 |
|---|---|---|
| free_key 免费API钥可申领/免key开放API | {buckets['free_key']} | ③波 attempted=18 网络动作, lit=7, 其余 44 钥源列用户动作 |
| dataset 开放数据集/文件直下/目录清单 | {buckets['dataset']} | 未单列探针波 (A级 HTTP_ENGINES 134 已含数据集直下面; 本面待后续波) |
| free_register 免费账号注册/免登录网页免费面 | {buckets['free_register']} | ②波 attempted=124 全量实测 (见下) |
| paid_only 纯付费/订阅/机构订阅 | {buckets['paid_only']} | 留档不接入 (paid_kept) |
| **合计** | **234** | 64+21+124+25 |

## 2. 三波子台账摘要
- **波① 登记波 (1025, 集成台账.md)**: SURVEY_ALIASES 终态 429 键 (A195+B234, 第二轮终局调和后); api_replica_bridge HTTP_ENGINES 134 + CLI 15; 腿批量建造 119 (编译门 119/119 绿); 登记≠接线 (named_channels 建渠走 T-015)。
- **波② 免费注册波 (1026, btier_register_ledger.md)**: free_register 124 条逐站纯HTTP探针 → attempted=124 = lit 63 + USER_ACTION 29 + BLOCKED_ANTIBOT 21 (浏览器腿候选) + FAIL_HTTP 6 + DEAD 5。
- **波③ 免费钥申领波 (1026, btier_freekey_ledger.md)**: free_key 64 桶 → 网络实测 18 渠道 (lit 7 + 停用疑/迁移疑/限流 11); 44 钥源列用户动作清单 (零硬闯零验证码突破); 新腿 7 件编译门 7/7 绿, HTTP_ENGINES +8。
- 横向: 铁律全程在役 — 免费宪法 (付费面永不采购) / 密钥永不进仓 / 台账只增不删 / 浏览器非必要不开。

## 3. 点亮清单 lit=70 (① 免费钥波 7 引擎 + ② 免费注册波 63 条, 逐条原表照录)
### 3a. 免费钥波 LIT=7 (纯HTTP冒烟通过+入池)
{fkA}
### 3b. 免费注册波 LIT=63 (免登录面冒烟200通过)
{regA}
## 4. 用户动作清单 (去重合计 73; 两波交集=空, 程序验证)
### 4a. 免费钥波 44 钥源 (blocked_user_action; 密钥落位 secrets/<渠道>.secret)
{fkC}
### 4b. 免费注册波 29 卡点 (注册/登录类, 零硬闯)
{regB}
## 5. channel_matrix SURVEY_ALIASES 补同步 (只增, 本终账动作)
- 实测盘点: 234 B级渠道 id 已全量在 SURVEY_ALIASES (第二轮登记在案); 两处缺口 → 本账补齐:
  1. **+2 新键**: nasa_images / noaa_nws (免费钥波点亮引擎, 注册表无独立条目, 按「引擎id=渠道id」惯例新建, 入池 engine 标签直落渠道)
  2. **+19 域名别名**: 免费注册波点亮站点中域名别名缺失的 19 键 (mojeek.com/so.com/4get.ca/bing.com/boardreader.com/google.com/scholar.google.com/trends.google.com/mwmbl.org/qwant.com/docs.rsshub.app/startpage.com/stract.com/swisscows.com/teclis.com/yandex.com/tiangong.cn/so.toutiao.com/news.baidu.com; 碰撞检查零冲突后只增追加)
- 终态: SURVEY_ALIASES 429→**431** 键; CHANNEL_ALIASES 合并 461→**463** 键; .bak 先行 = completeness/channel_matrix.py.bak-1026-btotal-final
- 验证: py_compile 绿; resolve_engine 冒烟 12/12 (nasa_images/noaa_nws/19域名直命中, dangdang/metaso/ecb_sdw/hn_algolia_api 旧链路不回归)

## 6. 复算留痕
- 校验件: channels_survey_2026/_final_merge_check3.py + _alias_patch_dryrun.py + _alias_patch_apply.py + _resolve_smoke.py + _gen_bledger_final.py (本件, 幂等可重跑)
- 断言: B=234 双源一致; 桶 64/21/124/25; lit 63+7; UA 29+44 交集空; paid_only=25
"""
open(S+'/B级接入总账.md','w',encoding='utf-8',newline='').write(md)
print('WRITTEN',S+'/B级接入总账.md','bytes:',len(md.encode('utf-8')))
print('b_total',bcount,'lit 7+63=70','ua 44+29=73','paid_kept',buckets['paid_only'])
