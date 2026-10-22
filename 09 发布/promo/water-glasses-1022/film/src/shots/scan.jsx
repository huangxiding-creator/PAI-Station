import React from 'react';
import {shot} from '../engine.js';
import {Split, reveal} from '../kit/text.jsx';
import {Caption, rollBind} from '../kit/stage.jsx';

const q = (id, sel) => document.querySelector(`section[data-shot="${id}"] ${sel}`);

// 现场照片（3840×1890 实测）：工人 x1423 · 作业面 y1190 · 地面 y1550（1m ≈ 156 源px）
// 显示缩放 0.55：主图 2112 宽，工人置于画面中部，1m ≈ 86 屏幕px
const MAIN = {left: -223, top: 345, width: 2112};
const GROUND = 1198, DECK = 1000, LINE_X = 670, M = 86;

export function ScanView({shot: s}) {
  return <>
    <img src="material/scene_write.jpg" alt=""
      style={{position: 'absolute', left: -320, top: 260, width: 1720, height: 'auto',
        filter: 'blur(22px) brightness(.34) saturate(.85)', transform: 'scale(1.3)'}} />
    <img src="material/scene_write.jpg" alt="" className="scene-main"
      style={{position: 'absolute', left: MAIN.left, top: MAIN.top, width: MAIN.width, height: 'auto'}} />
    <div className="pov-vignette" />
    {/* 第一视角四角框（眼镜取景感） */}
    <div className="js-reticle" style={{position: 'absolute', inset: 110}}>
      <div className="reticle" style={{left: 0, top: 0, borderRight: 0, borderBottom: 0}} />
      <div className="reticle" style={{right: 0, top: 0, borderLeft: 0, borderBottom: 0}} />
      <div className="reticle" style={{left: 0, bottom: 0, borderRight: 0, borderTop: 0}} />
      <div className="reticle" style={{right: 0, bottom: 0, borderLeft: 0, borderTop: 0}} />
    </div>
    {/* 语音指令气泡 */}
    <div className="voice-bubble js-voice" style={{position: 'absolute', left: '50%', top: 330}}>
      <span className="voice-dot" />
      <Split text="「扫描隐患」语音指令" lang="zh-CN" />
    </div>
    {/* 快门框 */}
    <div className="js-shutter" style={{position: 'absolute', left: 300, top: 580, width: 520, height: 700,
      border: '3px solid rgba(255,255,255,.92)', borderRadius: 26, opacity: 0}} />
    {/* HUD SVG：十字准星 + 测距线 */}
    <svg width="1080" height="1920" viewBox="0 0 1080 1920" style={{position: 'absolute', inset: 0}}>
      <g className="js-cross" opacity="0" style={{filter: 'drop-shadow(0 0 6px rgba(72,192,216,.9))'}}>
        <line x1="500" y1="830" x2="620" y2="830" stroke="#7fe0ff" strokeWidth="3" />
        <line x1="560" y1="770" x2="560" y2="890" stroke="#7fe0ff" strokeWidth="3" />
        <circle cx="560" cy="830" r="30" fill="none" stroke="#7fe0ff" strokeWidth="3" />
      </g>
      {/* 地面基准 */}
      <g className="js-ground" opacity="0">
        <line x1={LINE_X - 170} y1={GROUND} x2={LINE_X + 210} y2={GROUND}
          stroke="rgba(120,208,240,.75)" strokeWidth="2.5" strokeDasharray="10 8" />
        <text x={LINE_X - 170} y={GROUND + 40} fill="#8fd0ea" fontSize="26" fontFamily="Consolas, monospace">地面基准 · 参考物锚定</text>
      </g>
      {/* 测距主标线 */}
      <g className="js-mline">
        <line className="js-mline-l" x1={LINE_X} y1={GROUND} x2={LINE_X} y2={DECK}
          stroke="#48c0d8" strokeWidth="3" />
        <circle cx={LINE_X} cy={GROUND} r="10" fill="none" stroke="#48c0d8" strokeWidth="3" className="js-mline-p" />
        <circle cx={LINE_X} cy={DECK} r="10" fill="none" stroke="#48c0d8" strokeWidth="3" className="js-mline-p" />
        {/* 米刻度 */}
        {[1, 2].map(m => <g key={m} className="js-tick">
          <line x1={LINE_X - 12} y1={GROUND - m * M} x2={LINE_X + 12} y2={GROUND - m * M} stroke="#48c0d8" strokeWidth="2.5" />
          <text x={LINE_X + 22} y={GROUND - m * M + 9} fill="#8fd0ea" fontSize="26" fontFamily="Consolas, monospace">{m}m</text>
        </g>)}
      </g>
    </svg>
    {/* 读数卡（±σ 母题首现） */}
    <div className="readout-card js-readout" style={{position: 'absolute', left: 80, top: 1300, opacity: 0}}>
      <div className="num readout-value"><span className="js-rv">0.00</span> m</div>
      <div className="num readout-sigma" style={{marginTop: 8}}>± 0.08 <span style={{fontSize: 28, color: '#8fb8d2'}}>σ 不确定度</span></div>
      <div className="readout-label">作业面距地高度 · 单张照片测得</div>
    </div>
    <Caption style={{top: 1550}}>{s.description}</Caption>
  </>;
}

export const buildScan = tl => {
  const s = shot('scan');
  tl.set(q('scan', ''), {opacity: 1}, s.start);
  // 现场照片缓入
  tl.fromTo(q('scan', '.scene-main'), {scale: 1.05, opacity: 0}, {scale: 1, opacity: 1, duration: 0.8, ease: 'expo.out'}, s.start);
  tl.fromTo(q('scan', '.js-reticle'), {opacity: 0}, {opacity: 1, duration: 0.5}, s.start + 0.2);
  // s1 十字准星
  tl.fromTo(q('scan', '.js-cross'), {opacity: 0, scale: 0.7, transformOrigin: '560px 830px'},
    {opacity: 1, scale: 1, duration: 0.45, ease: 'expo.out'}, s.start + 0.7);
  // s2 语音气泡
  const voice = q('scan', '.js-voice');
  tl.fromTo(voice, {opacity: 0, y: -36}, {opacity: 1, y: 0, duration: 0.45, ease: 'expo.out'}, s.start + 1.3);
  tl.set(voice, {xPercent: -50}, 0);
  reveal(tl, voice.querySelector('.split'), s.start + 1.45, {stagger: 0.035, from: {opacity: 0, y: 10}});
  // s3 快门
  tl.fromTo(q('scan', '.js-shutter'), {opacity: 0, scale: 1.03}, {opacity: 1, scale: 1, duration: 0.09, ease: 'none'}, s.start + 2.0);
  tl.to(q('scan', '.js-shutter'), {opacity: 0.25, duration: 0.3, ease: 'power2.out'}, s.start + 2.12);
  // s4 测距线拉出 + 地面基准
  tl.fromTo(q('scan', '.js-ground'), {opacity: 0}, {opacity: 1, duration: 0.4}, s.start + 2.7);
  const line = q('scan', '.js-mline-l');
  const len = GROUND - DECK;
  tl.set(line, {attr: {'stroke-dasharray': len, 'stroke-dashoffset': len}}, 0);
  tl.to(line, {attr: {'stroke-dashoffset': 0}, duration: 1.4, ease: 'power2.inOut'}, s.start + 2.8);
  tl.fromTo(q('scan', '.js-mline-p'), {opacity: 0},
    {opacity: 1, duration: 0.25, ease: 'none', stagger: 1.4}, s.start + 2.8);
  tl.fromTo(q('scan', '.js-tick'), {opacity: 0}, {opacity: 1, duration: 0.3, stagger: 0.5}, s.start + 3.3);
  // s5 读数落定（数字滚动 0→2.31 + 卡片弹入）
  const card = q('scan', '.js-readout');
  tl.fromTo(card, {opacity: 0, x: -50}, {opacity: 1, x: 0, duration: 0.5, ease: 'expo.out'}, s.start + 4.0);
  const st = {v: 0};
  rollBind('scan', q('scan', '.js-rv'), st, v => v.toFixed(2));
  tl.fromTo(st, {v: 0}, {v: 2.31, duration: 0.62, ease: 'power2.out'}, s.start + 3.9);
  // 字幕
  tl.fromTo(q('scan', '.caption'), {opacity: 0, y: 20}, {opacity: 1, y: 0, duration: 0.5, ease: 'power2.out'}, s.start + s.descriptionAt);
};
