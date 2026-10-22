import React from 'react';
import {shot} from '../engine.js';
import {Waterline, driveWaterline, Caption} from '../kit/stage.jsx';

const q = (id, sel) => document.querySelector(`section[data-shot="${id}"] ${sel}`);

const CX = 540, CY = 890, R = 330;
const NODES = ['查找', '研判', '预警', '防范', '处置', '责任'];
const ang = i => (-90 + i * 60) * Math.PI / 180;
const px = i => CX + R * Math.cos(ang(i));
const py = i => CY + R * Math.sin(ang(i));
const lx = i => CX + R * 1.42 * Math.cos(ang(i));
const ly = i => CY + R * 1.42 * Math.sin(ang(i));

export function LoopView({shot: s}) {
  return <>
    <div style={{position: 'absolute', left: 70, top: 205}}>
      <div className="kicker">SIX MECHANISMS · ONE LOOP</div>
      <div style={{fontSize: 74, fontWeight: 700, marginTop: 16, color: '#f4fafe'}}>六项机制 · 一键闭环</div>
    </div>
    <svg width="1080" height="1920" viewBox="0 0 1080 1920" style={{position: 'absolute', inset: 0}}>
      {/* 环线 */}
      <polygon className="js-ring" points={NODES.map((_, i) => `${px(i)},${py(i)}`).join(' ')}
        fill="none" stroke="rgba(72,192,216,.75)" strokeWidth="3.5" strokeLinejoin="round" opacity="0" />
      {NODES.map((n, i) => <g key={n} className={'loop-node js-node-' + (i + 1)}>
        <circle cx={px(i)} cy={py(i)} r="20" />
        <text x={lx(i)} y={ly(i)} textAnchor="middle" dominantBaseline="middle">{n}</text>
        <text className="idx" x={px(i)} y={py(i) + 48} textAnchor="middle">0{i + 1}</text>
      </g>)}
    </svg>
    {/* 环心：真实智能体界面 */}
    <div className="brand-glass js-agent" style={{position: 'absolute', left: CX - 330, top: CY - 162, width: 660, height: 324, opacity: 0}}>
      <img src="material/agent/智能体首界面.jpg" alt="水利安全助手智能体" style={{width: '100%', height: '100%', objectFit: 'cover', objectPosition: 'top'}} />
    </div>
    <div className="js-note" style={{position: 'absolute', left: 70, right: 70, top: 1450, textAlign: 'center', opacity: 0}}>
      <div style={{fontSize: 40, fontWeight: 600, color: '#e8f4fd'}}>一条语音指令 · 全程免转录</div>
      <div style={{fontSize: 30, color: '#8fb8d2', marginTop: 12}}>识别即归档 · 可审计 · 对齐水利部《六项机制实施工作指南》</div>
    </div>
    <div className="beam js-beam" style={{left: -300, opacity: 0}} />
    <Caption style={{top: 1600}}>{s.description}</Caption>
    <Waterline />
  </>;
}

export const buildLoop = tl => {
  const s = shot('loop');
  tl.set(q('loop', ''), {opacity: 1}, s.start);
  driveWaterline('loop');
  // 环心界面
  tl.fromTo(q('loop', '.js-agent'), {opacity: 0, scale: 0.94}, {opacity: 1, scale: 1, duration: 0.6, ease: 'expo.out'}, s.start + 0.2);
  // 六节点逐拍点亮
  NODES.forEach((n, i) => {
    const g = q('loop', '.js-node-' + (i + 1));
    tl.to(g.querySelector('circle'), {fill: '#48c0d8', stroke: '#a8ecff', duration: 0.22, ease: 'power2.out'}, s.start + 0.8 + i * 0.5);
    tl.to(g.querySelector('text'), {fill: '#ffffff', duration: 0.22}, s.start + 0.8 + i * 0.5);
    tl.fromTo(g, {opacity: 0.35}, {opacity: 1, duration: 0.2}, s.start + 0.72 + i * 0.5);
  });
  // 环线整圈画出
  const ring = q('loop', '.js-ring');
  const ringLen = 6 * 2 * R * Math.sin(Math.PI / 6) * 1.02; // 六边形周长≈6×边长
  tl.set(ring, {attr: {'stroke-dasharray': ringLen, 'stroke-dashoffset': ringLen}}, 0);
  tl.to(ring, {attr: {'stroke-dashoffset': 0}, duration: 3.4, ease: 'none', opacity: 1}, s.start + 0.7);
  tl.set(ring, {opacity: 1}, s.start + 0.7);
  // l7 闭合光束
  tl.set(q('loop', '.js-beam'), {opacity: 1}, s.start + 4.15);
  tl.fromTo(q('loop', '.js-beam'), {x: 0}, {x: 1500, duration: 0.55, ease: 'power2.inOut'}, s.start + 4.2);
  tl.to(q('loop', '.js-beam'), {opacity: 0, duration: 0.2}, s.start + 4.75);
  // 底注
  tl.fromTo(q('loop', '.js-note'), {opacity: 0, y: 26}, {opacity: 1, y: 0, duration: 0.55, ease: 'expo.out'}, s.start + 4.8);
  tl.fromTo(q('loop', '.caption'), {opacity: 0, y: 20}, {opacity: 1, y: 0, duration: 0.5}, s.start + s.descriptionAt);
};
