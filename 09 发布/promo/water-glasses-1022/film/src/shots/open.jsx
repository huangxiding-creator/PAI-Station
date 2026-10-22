import React from 'react';
import {shot} from '../engine.js';
import {Split, reveal} from '../kit/text.jsx';
import {Waterline, driveWaterline, Caption} from '../kit/stage.jsx';

const q = (id, sel) => document.querySelector(`section[data-shot="${id}"] ${sel}`);

export function OpenView({shot: s}) {
  return <>
    <div className="site-cam" style={{position: 'absolute', left: 0, top: -220, width: 1080, height: 1920}}>
      <iframe className="site-frame" src="site/index.html" title="水利安全AI眼镜官网" />
    </div>
    <div className="stage-scrim" />
    <div style={{position: 'absolute', left: 70, right: 70, top: 930}}>
      <div className="kicker js-kicker" style={{position: 'relative', paddingLeft: 54}}>
        <span style={{position: 'absolute', left: 0, top: '50%', width: 36, height: 3, background: '#48c0d8', transform: 'translateY(-50%)'}} />
        WATER-SAFETY AI GLASSES · V3.0
      </div>
      <h1 className="h-title" style={{margin: '24px 0 0', fontSize: 140}}>
        <div><Split text="发现隐患" lang="zh-CN" /></div>
        <div><Split text="预判风险" lang="zh-CN" /></div>
      </h1>
      <div className="h-sub js-desc" style={{marginTop: 30, fontSize: 36}}><Split text={s.description} lang="zh-CN" by="word" /></div>
    </div>
    {/* 左缘标尺刻度 — 定量测距母题（封面层同款） */}
    <svg className="js-ruler" width="70" height="520" viewBox="0 0 70 520" style={{position: 'absolute', left: 30, top: 940, opacity: 0}}>
      <line x1="52" y1="0" x2="52" y2="520" stroke="rgba(120,208,240,.5)" strokeWidth="2" />
      {Array.from({length: 11}, (_, i) => (
        <line key={i} x1={52 - (i % 5 === 0 ? 18 : 10)} y1={i * 52} x2="52" y2={i * 52}
          stroke="rgba(120,208,240,.55)" strokeWidth="2" />
      ))}
    </svg>
    <div className="js-chips" style={{position: 'absolute', left: 70, right: 70, top: 1450, display: 'flex', gap: 18, flexWrap: 'wrap'}}>
      <span className="tag">10200+ 份水利专业文档</span>
      <span className="tag">1300+ 法规标准</span>
      <span className="tag">72 条量化阈值规则</span>
    </div>
    <Waterline />
  </>;
}

export const buildOpen = tl => {
  const s = shot('open');
  const sec = q('open', '');
  tl.set(sec, {opacity: 1}, s.start);
  // o1 水位线升起
  const wl = q('open', '.waterline');
  tl.fromTo(wl, {opacity: 0}, {opacity: 1, duration: 1.2, ease: 'power2.out'}, s.start + 0.2);
  driveWaterline('open');
  // o2 官网 hero 缓入
  tl.fromTo(q('open', '.site-cam'),
    {y: -90, scale: 1.055, opacity: 0},
    {y: 0, scale: 1, opacity: 1, duration: 1.25, ease: 'expo.out'}, s.start + 0.6);
  // o3 标题逐字
  reveal(tl, q('open', '.js-kicker'), s.start + 2.45, {stagger: 0.012});
  const lines = q('open', '.h-title').querySelectorAll('.split');
  lines.forEach((l, i) => reveal(tl, l, s.start + 2.6 + i * 0.55, {stagger: 0.07, from: {opacity: 0, y: 40, filter: 'blur(14px)'}}));
  reveal(tl, q('open', '.js-desc .split'), s.start + s.descriptionAt, {stagger: 0.04, from: {opacity: 0, y: 18}});
  // o4 chips 弹入 + 标尺刻度
  tl.fromTo(q('open', '.js-chips').children,
    {opacity: 0, scale: 0.82},
    {opacity: 1, scale: 1, duration: 0.5, ease: 'expo.out', stagger: 0.12}, s.start + 4.6);
  tl.fromTo(q('open', '.js-ruler'), {opacity: 0}, {opacity: 1, duration: 0.7, ease: 'power2.out'}, s.start + 3.4);
  // 首帧海报淡出（skill 规范：前 0.3s 全遮，0.3-0.6s 淡出）
  tl.fromTo('#poster', {opacity: 1}, {opacity: 0, duration: 0.3, ease: 'none'}, 0.3);
};
