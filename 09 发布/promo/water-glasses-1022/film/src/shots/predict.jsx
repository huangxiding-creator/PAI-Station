import React from 'react';
import {shot} from '../engine.js';
import {Caption, rollBind} from '../kit/stage.jsx';

const q = (id, sel) => document.querySelector(`section[data-shot="${id}"] ${sel}`);

// ai.png 3840×2160：风险预测卡右列 x2060-3780 y300-940 → 显示 1000×372（缩放 0.581）
// trend.png 3840×2160：主趋势图 x60-1960 y600-1300 → 显示 1000×368（缩放 0.526）
export function PredictView({shot: s}) {
  return <>
    <div style={{position: 'absolute', inset: 0, background: 'linear-gradient(180deg, #08131f, #0a1628 60%, #08131f)'}} />
    <div style={{position: 'absolute', left: 70, top: 190}}>
      <div className="kicker">PREDICT THE RISK</div>
      <div style={{fontSize: 74, fontWeight: 700, marginTop: 16, color: '#f4fafe'}}>预判风险</div>
    </div>
    <Caption style={{top: 345}}>{s.description}</Caption>
    {/* AI 智脑 · 风险预测（实拍） */}
    <div className="shot-frame js-ai" style={{left: 40, top: 425, width: 1000, height: 372}}>
      <span className="shot-tag">AI 智脑 · 实拍</span>
      <img src="material/console/ai.png" alt="风险预测"
        style={{left: -1197, top: -174, width: 2232, height: 1256}} />
    </div>
    {/* 预测大读数（±σ 母题复现） */}
    <div className="js-readout" style={{position: 'absolute', left: 90, top: 850, opacity: 0}}>
      <div className="num" style={{fontSize: 128, fontWeight: 700, color: '#fff', lineHeight: 1}}>
        <span className="js-pv">0</span>
        <span className="readout-sigma num" style={{fontSize: 56, marginLeft: 18}}>± 25</span>
        <span style={{fontSize: 52, color: '#9fd6f2', marginLeft: 14, fontFamily: 'inherit'}}>宗</span>
      </div>
      <div style={{fontSize: 32, color: '#a8d2ec', marginTop: 18}}>预计下周新增隐患 · AI 智脑实时生成</div>
    </div>
    {/* 隐患态势 12 个月（实拍，左→右擦出） */}
    <div className="shot-frame js-trend" style={{left: 40, top: 1235, width: 1000, height: 368}}>
      <span className="shot-tag">隐患态势 · 近 12 个月 · 实拍</span>
      <img src="material/console/trend.png" alt="隐患态势"
        style={{left: -32, top: -316, width: 2021, height: 1137}} />
    </div>
  </>;
}

export const buildPredict = tl => {
  const s = shot('predict');
  tl.set(q('predict', ''), {opacity: 1}, s.start);
  // 推近实拍卡
  tl.fromTo(q('predict', '.js-ai'), {opacity: 0, scale: 0.96, y: 26},
    {opacity: 1, scale: 1, y: 0, duration: 0.8, ease: 'expo.out'}, s.start);
  tl.fromTo(q('predict', '.caption'), {opacity: 0, y: 20}, {opacity: 1, y: 0, duration: 0.5}, s.start + s.descriptionAt);
  // p2 预测值落定（母题）
  tl.fromTo(q('predict', '.js-readout'), {opacity: 0, y: 30}, {opacity: 1, y: 0, duration: 0.55, ease: 'expo.out'}, s.start + 0.55);
  const st = {v: 0};
  rollBind('predict', q('predict', '.js-pv'), st, v => Math.round(v).toString());
  tl.fromTo(st, {v: 0}, {v: 130, duration: 0.95, ease: 'power2.out'}, s.start + 0.55);
  // p3 趋势实拍图从左擦出（clip 擦除，不重绘真实曲线）
  tl.fromTo(q('predict', '.js-trend'), {opacity: 0, y: 26}, {opacity: 1, y: 0, duration: 0.5, ease: 'expo.out'}, s.start + 2.7);
  tl.fromTo(q('predict', '.js-trend'),
    {clipPath: 'inset(0 100% 0 0)'},
    {clipPath: 'inset(0 0% 0 0)', duration: 1.6, ease: 'power2.inOut'}, s.start + 2.9);
  // p4 根因卡点亮：实拍卡上浮 + 底缘光条
  tl.to(q('predict', '.js-ai'), {y: -16, duration: 0.4, ease: 'power2.out'}, s.start + 4.8);
  tl.fromTo(q('predict', '.js-ai'), {boxShadow: '0 30px 80px rgba(2,10,20,.6)'},
    {boxShadow: '0 30px 80px rgba(2,10,20,.6), 0 0 0 3px rgba(72,192,216,.55)', duration: 0.4}, s.start + 4.8);
};
