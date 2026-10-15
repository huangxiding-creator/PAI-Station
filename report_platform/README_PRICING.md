# README_PRICING — 诱饵定价三档实验（REQ-033 / T-021）

> 部署件**已就绪**（本目录 `pricing_experiment.py` + `content/pricing_EPC-BID26.json`），
> diff 在案（本 commit）。站点模板/服务文件**零改动**——接线由下方三步人工/值班执行，
> 接线后即满足 REQ-033.AC1「实验部署 diff 在案（平台页三档+诱饵变体+涨价状态可见）」。

## 一、实验假设与度量口径（N2 卷宗 §18）

- **基线**：经济学人订阅诱饵实验（Dan Ariely, MIT 样本）——三选项组（含同价诱饵）
  **84%** 选高价组合；去掉诱饵的两选项组仅 **32%**（+52pp）。
- **假设**：best（企业版 ¥1,999）旁挂同价劣势变体后，best 档选择率显著上移，
  向 84% 基线靠拢；good（¥199）承担走量。
- **度量口径**（事件已走现有 `/api/track`，`_SAFE_EVENT` 放行 `tier_*`）：
  - 各档选择率 = `tier_good / tier_better / tier_best / tier_best_decoy`
    各自点击数 ÷ 四者总和（同一 SKU）；
  - **主指标** = best 档选择率 =（`tier_best` + `tier_best_decoy`）÷ 四者总和；
  - 判读：开诱饵后 best 档选择率 ≥ 2× 对照基线 32%（即 ≥64%）→ 诱饵生效；
    未达则按 PROPOSAL 变现轴如实呈报缺口。
  - 对照方案：如需严格 A/B，可先跑 7 天「无诱饵变体」（渲染时略去 decoy 卡）
    再开 7 天「含诱饵」期，前后对比替代跨实验基线。

## 二、三档 + 同价诱饵 + 阶梯涨价（生成器实跑输出）

| 档 | 名称 | 现价 | 价带锚 | 角色 |
|---|---|---|---|---|
| good | 单章拆分购 | ¥199 | ¥199（固定） | 走量档 · 低价锚 |
| better | 全本专题报告 | ¥498 | ¥498-698（阶梯） | 主力成交档 |
| best | 企业版（多席位+更新流+内训） | ¥1,999 | ¥1,999-10,000（阶梯） | 高价锚档 · 诱饵宿主 |
| **decoy** | **企业版（单人授权 · 无更新流）** | **¥1,999（与 best 恒同价）** | — | 同价诱饵变体 |

- **同价不变式**：`decoy.price == best.price` 恒成立（best 涨档后诱饵镜像跟随），
  诱饵严格劣势（单席位/无更新流/无内训）→ best 成为占优选项。
- **公示式阶梯涨价**：每售满 **50 份**上浮 **10%**（取整到元），better 封顶 ¥698、
  best 封顶 ¥10,000。售量**只读订单库实读**（`orders` 表
  `state IN ('paid','partial_refunded')`，全额退款不计；无库/无表=0，绝不手拍）。
  当前零态：已售 0 份，售满 50 份后 better 涨至 ¥548。
- 价档锚复用 T-017 六层变现面（`reforge_factory/superline/product_family_gen.py`
  `PRICE_ANCHORS`）；调价只走「需求雷达+实验数据+用户批准」三签。

## 三、接线三步（值班执行；服务文件零改）

1. **生成/刷新部署件**（`pricing_<sku>.json` 是静态文件，`build_site.py` 只清
   `*.html`，json 常驻 `site/` 不受重建影响）：
   - 本地预演：`py report_platform/pricing_experiment.py --sku EPC-BID26 --out-dir report_platform/site`
   - 部署机实读生产售量：
     `cd /www/report_platform && python3 pricing_experiment.py --sku EPC-BID26 --db data/report_platform.db --out-dir site`
   - `deploy/deploy_ecs.py` 的 tar 包含 `site/`，随既有 site-only 部署链路自动上船。
2. **模板 include 位**：在 `build_site.py → build_report()` 的购买区
   （`<section id="buy"`）上方加一个渲染挂点（示例片段如下，原生 JS 零依赖，
   点击埋点直接用现有 `[data-ev]` → `/api/track` 通道，事件名
   `tier_good/tier_better/tier_best/tier_best_decoy`）：
   ```html
   <section id="pricingTiers" class="rv"><h2 class="sec"><em>肆</em>选择你的版本</h2>
   <div class="sec-sub" id="ladderNotice">（阶梯公示位）</div>
   <div id="tierCards" style="display:grid;gap:10px;margin-top:14px"></div>
   <script>
   (function(){var sku=document.body.getAttribute('data-sku')||'';
    fetch('/pricing_'+sku+'.json').then(function(r){return r.json();})
    .then(function(d){var g=d.tiers.good,b=d.tiers.better,s=d.tiers.best,dc=d.decoy;
     document.getElementById('ladderNotice').textContent=d.ladder.public_notice;
     var host=document.getElementById('tierCards');
     [[g,'tier_good'],[b,'tier_better'],[s,'tier_best'],[dc,'tier_best_decoy']]
     .forEach(function(p){var t=p[0],el=document.createElement('a');
      el.href='#buy';el.setAttribute('data-ev',p[1]);
      el.style.cssText='border:1px solid rgba(13,33,54,.15);border-radius:3px;'
       +'padding:14px 16px;text-decoration:none;color:#292418;display:block';
      if(t.key==='best'){el.style.borderColor='#C9A876';}      // best 描金边
      if(t.key==='best_decoy'){el.style.opacity='.62';}         // 诱饵降权
      el.innerHTML='<b style="font-size:15.5px">'+t.name+'</b>'
       +'<span style="float:right;font-family:serif;font-weight:700">¥'
       +t.price.toLocaleString()+'</span><div style="font-size:12.5px;'
       +'color:#8A7E66;margin-top:4px">'+t.format+' · '+(t.role||'')+'</div>';
      host.appendChild(el);});})
    .catch(function(){});})();
   </script>
   </section>
   ```
3. **重建并重启**：`py report_platform/build_site.py` 后
   `sudo systemctl restart report-platform`（服务名见
   `deploy/report-platform.service`；验证 `curl -s localhost:8885/pricing_EPC-BID26.json`）。

## 四、红线遵守记录

- `template.py / build_site.py / server.py / pay.py` 等既有服务文件零改动；
- 订单库只读（sqlite `mode=ro` URI 连接）；
- 输出只增：`pricing_experiment.py`、`tests/test_pricing_experiment.py`、
  `content/pricing_EPC-BID26.json`、本 README。
