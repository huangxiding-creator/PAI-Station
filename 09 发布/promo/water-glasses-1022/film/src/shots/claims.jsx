import React from 'react';
import {shot} from '../engine.js';
import {Waterline, driveWaterline, Caption, rollBind} from '../kit/stage.jsx';

const q = (id, sel) => document.querySelector(`section[data-shot="${id}"] ${sel}`);

export function ClaimsView({shot: s}) {
  return <>
    <div style={{position: 'absolute', left: 70, top: 235}}>
      <div className="kicker">HARD METRICS</div>
      <div style={{fontSize: 78, fontWeight: 700, marginTop: 18, color: '#f4fafe'}}>五项硬指标</div>
    </div>
    <div style={{position: 'absolute', left: 65, top: 465, display: 'flex', flexDirection: 'column', gap: 44}}>
      <div className="metric-card">
        <div className="num metric-num js-r1" style={{minWidth: 400}}>0.0<span className="metric-unit">%</span></div>
        <div>
          <div className="metric-label">工程高频场景识别准确率</div>
          <div className="metric-src">双层架构视觉复核 · 阈值型误报下降 50% 以上<br/>来源：产品官网 VALUE 01</div>
        </div>
      </div>
      <div className="metric-card">
        <div className="num metric-num" style={{minWidth: 470, fontSize: 100}}>
          <span className="metric-from num">4–6h</span>
          <span className="metric-arrow">➝</span>
          <span className="js-r2">0.0</span><span className="metric-unit">h</span>
        </div>
        <div>
          <div className="metric-label">单次巡检时长</div>
          <div className="metric-src">边走边识别 · 发现率提升超 200%<br/>来源：产品官网 VALUE 02</div>
        </div>
      </div>
      <div className="metric-card">
        <div className="num metric-num" style={{minWidth: 470, fontSize: 100}}>
          <span className="metric-from num">¥1.6万</span>
          <span className="metric-arrow">➝</span>
          <span>¥</span><span className="js-r3">0</span>
        </div>
        <div>
          <div className="metric-label">单台成本（元 · 降至 3000 元以下）</div>
          <div className="metric-src">VLM + RAG 替代大样本训练 · 跨场景泛化<br/>来源：产品官网 VALUE 04</div>
        </div>
      </div>
    </div>
    <Caption style={{top: 1585}}>{s.description}</Caption>
    <Waterline />
  </>;
}

export const buildClaims = tl => {
  const s = shot('claims');
  tl.set(q('claims', ''), {opacity: 1}, s.start);
  driveWaterline('claims');
  const cards = q('claims', '').querySelectorAll('.metric-card');
  cards.forEach((el, i) => {
    tl.fromTo(el, {opacity: 0, y: 70}, {opacity: 1, y: 0, duration: 0.6, ease: 'expo.out'}, s.start + 0.4 + i * 1.5);
  });
  tl.fromTo(q('claims', '.caption'), {opacity: 0, y: 20}, {opacity: 1, y: 0, duration: 0.5, ease: 'power2.out'}, s.start + s.descriptionAt);
  // 数字滚动：state.v 驱动 + onRender 回写，任意帧确定性
  const st1 = {v: 0}, st2 = {v: 6}, st3 = {v: 16000};
  const e1 = q('claims', '.js-r1'), e2 = q('claims', '.js-r2'), e3 = q('claims', '.js-r3');
  rollBind('claims', e1, st1, v => v.toFixed(1));
  rollBind('claims', e2, st2, v => v.toFixed(1));
  rollBind('claims', e3, st3, v => Math.round(v).toLocaleString('en-US'));
  tl.fromTo(st1, {v: 0}, {v: 96.5, duration: 1.1, ease: 'power2.out'}, s.start + 0.5);
  tl.fromTo(st2, {v: 6}, {v: 1.5, duration: 1.1, ease: 'power2.out'}, s.start + 2.0);
  tl.fromTo(st3, {v: 16000}, {v: 3000, duration: 1.1, ease: 'power2.out'}, s.start + 3.5);
};
