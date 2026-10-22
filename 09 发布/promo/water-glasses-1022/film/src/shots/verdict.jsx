import React from 'react';
import {shot} from '../engine.js';
import {Caption} from '../kit/stage.jsx';

const q = (id, sel) => document.querySelector(`section[data-shot="${id}"] ${sel}`);

// 阈值比对轴：3.2m→y330，1m = 360px；2.0m 阈值 y1050；测量带 [2.23,2.39] → y909-967
const AXIS_X = 300, T2 = 1050, BAND_TOP = 909, BAND_BOT = 967;

export function VerdictView({shot: s}) {
  return <>
    <img src="material/scene_write.jpg" alt=""
      style={{position: 'absolute', left: -150, top: 480, width: 1400, height: 'auto',
        filter: 'blur(16px) brightness(.22) saturate(.7)', transform: 'scale(1.2)'}} />
    <div style={{position: 'absolute', inset: 0, background: 'linear-gradient(180deg, rgba(6,26,46,.55), rgba(6,26,46,.86))'}} />
    <div style={{position: 'absolute', left: 70, top: 205}}>
      <div className="kicker">THREE-STATE VERDICT</div>
      <div style={{fontSize: 74, fontWeight: 700, marginTop: 16, color: '#f4fafe'}}>三态判定 · 有据可查</div>
    </div>
    {/* 三态图例 */}
    <div style={{position: 'absolute', right: 70, top: 235, display: 'flex', gap: 14}}>
      <span className="tag js-ldg js-ldg-ok" style={{fontSize: 24, padding: '8px 18px'}}>符合</span>
      <span className="tag js-ldg js-ldg-bad" style={{fontSize: 24, padding: '8px 18px', borderColor: 'rgba(240,168,120,.5)'}}>不符合</span>
      <span className="tag js-ldg js-ldg-mid" style={{fontSize: 24, padding: '8px 18px'}}>临界·转人工</span>
    </div>
    <Caption style={{top: 380}}>{s.description}</Caption>
    <svg width="1080" height="1920" viewBox="0 0 1080 1920" style={{position: 'absolute', inset: 0}}>
      {/* 纵轴 + 刻度 */}
      <g className="js-axis">
        <line x1={AXIS_X} y1="330" x2={AXIS_X} y2="1482" stroke="rgba(127,200,232,.55)" strokeWidth="3" />
        {[0, 1, 2, 3].map(m => <g key={m}>
          <line x1={AXIS_X - 14} y1={330 + m * 360} x2={AXIS_X} y2={330 + m * 360} stroke="rgba(127,200,232,.55)" strokeWidth="3" />
          <text x={AXIS_X - 30} y={330 + m * 360 + 10} fill="#7396ad" fontSize="30" fontFamily="Consolas, monospace" textAnchor="end">{m}.0m</text>
        </g>)}
        <text x={AXIS_X} y="300" fill="#7396ad" fontSize="26" fontFamily="Consolas, monospace">作业高度</text>
      </g>
      {/* 阈值虚线（clip 拉出） */}
      <g className="js-th" opacity="0">
        <clipPath id="thclip"><rect className="js-th-clip" x={AXIS_X} y={T2 - 10} width="0" height="20" /></clipPath>
        <line x1={AXIS_X} y1={T2} x2="880" y2={T2} stroke="#f0a878" strokeWidth="3.5" strokeDasharray="16 12" clipPath="url(#thclip)" />
        <text x="892" y={T2 - 8} fill="#f0a878" fontSize="32" fontWeight="700" fontFamily="Consolas, monospace">2.0 m</text>
        <text x="892" y={T2 + 30} fill="#d9a583" fontSize="24">阈值 · SL 398</text>
      </g>
      {/* 测量区间带 */}
      <g className="js-band">
        <rect x="560" y={BAND_TOP} width="320" height={BAND_BOT - BAND_TOP} fill="rgba(72,192,216,.30)" stroke="#48c0d8" strokeWidth="2.5" rx="6" />
        <line x1="560" y1={BAND_TOP} x2="880" y2={BAND_TOP} stroke="#8fe0f5" strokeWidth="2.5" />
        <line x1="560" y1={BAND_BOT} x2="880" y2={BAND_BOT} stroke="#8fe0f5" strokeWidth="2.5" />
        <text x="560" y={BAND_TOP - 18} fill="#bfe8f7" fontSize="30" fontFamily="Consolas, monospace">2.31 ± 0.08 m</text>
      </g>
    </svg>
    {/* 判定卡 */}
    <div className="verdict-card js-vcard" style={{position: 'absolute', left: 90, top: 1140, opacity: 0}}>
      <div className="verdict-head">
        <span className="zh">✕ 不符合</span><span className="en">NON-CONFORMANT</span>
      </div>
      <div className="verdict-body">测量区间整体越过阈值 —— 构成<b>高处作业</b>，列为隐患：核查安全带佩戴与临边防护。</div>
    </div>
    {/* 条款卡 */}
    <div className="clause-card js-ccard" style={{position: 'absolute', left: 90, top: 1360, opacity: 0}}>
      <div className="clause-no num">SL 398-2007</div>
      <div className="clause-name">《水利水电工程施工通用安全技术规程》· 高处作业判定阈值来源</div>
      <div className="clause-note">判定值 ±σ、阈值与条款依据随记录自动写入隐患台账（A.7 / A.11 格式）</div>
    </div>
    {/* 闭环 chips */}
    <div style={{position: 'absolute', left: 90, top: 1560, display: 'flex', gap: 20}}>
      <span className="tag js-chip1" style={{opacity: 0}}>✓ 量化判定写入台账</span>
      <span className="tag js-chip2" style={{opacity: 0}}>✓ 企微推送 · 3 分钟闭环</span>
    </div>
  </>;
}

export const buildVerdict = tl => {
  const s = shot('verdict');
  tl.set(q('verdict', ''), {opacity: 1}, s.start);
  tl.fromTo(q('verdict', '.js-axis'), {opacity: 0}, {opacity: 1, duration: 0.4}, s.start + 0.1);
  // v1 阈值线画出（clip 拉出，保留虚线样式）
  tl.set(q('verdict', '.js-th'), {opacity: 1}, 0);
  tl.fromTo(q('verdict', '.js-th-clip'), {attr: {width: 0}}, {attr: {width: 580}, duration: 0.8, ease: 'power2.inOut'}, s.start + 0.4);
  // v2 区间带滑入
  tl.fromTo(q('verdict', '.js-band'), {opacity: 0, x: 120}, {opacity: 1, x: 0, duration: 0.55, ease: 'expo.out'}, s.start + 1.1);
  // v3 判定卡 + 图例点亮
  tl.fromTo(q('verdict', '.js-vcard'), {opacity: 0, scale: 0.92, y: 26},
    {opacity: 1, scale: 1, y: 0, duration: 0.5, ease: 'expo.out'}, s.start + 2.2);
  tl.to(q('verdict', '.js-ldg-bad'), {backgroundColor: 'rgba(240,168,120,.28)', color: '#ffd9b8', duration: 0.3}, s.start + 2.3);
  tl.to(q('verdict', '.js-ldg-ok'), {opacity: 0.35, duration: 0.3}, s.start + 2.3);
  tl.to(q('verdict', '.js-ldg-mid'), {opacity: 0.35, duration: 0.3}, s.start + 2.3);
  // v4 条款卡
  tl.fromTo(q('verdict', '.js-ccard'), {opacity: 0, y: 34}, {opacity: 1, y: 0, duration: 0.5, ease: 'expo.out'}, s.start + 3.4);
  // v5/v6 chips
  tl.fromTo(q('verdict', '.js-chip1'), {opacity: 0, scale: 0.85}, {opacity: 1, scale: 1, duration: 0.35, ease: 'expo.out'}, s.start + 4.6);
  tl.fromTo(q('verdict', '.js-chip2'), {opacity: 0, scale: 0.85}, {opacity: 1, scale: 1, duration: 0.35, ease: 'expo.out'}, s.start + 4.9);
  tl.fromTo(q('verdict', '.caption'), {opacity: 0, y: 20}, {opacity: 1, y: 0, duration: 0.5}, s.start + s.descriptionAt);
};
