import React from 'react';
import {shot} from '../engine.js';
import {Split, reveal} from '../kit/text.jsx';
import {Waterline, driveWaterline} from '../kit/stage.jsx';

const q = (id, sel) => document.querySelector(`section[data-shot="${id}"] ${sel}`);

const INDUSTRIES = ['水利', '电力', '建筑', '市政', '新能源', '核电'];

export function CloseView({shot: s}) {
  return <>
    <div className="brand-glass js-hero" style={{position: 'absolute', left: 100, top: 330, width: 880, height: 584, opacity: 0}}>
      <img src="site/hero_main.png" alt="水利安全AI眼镜" style={{width: '100%', height: '100%', objectFit: 'cover'}} />
    </div>
    <div className="js-brandrow" style={{position: 'absolute', left: 0, right: 0, top: 990, display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 24, opacity: 0}}>
      <img src="site/LOGO.png" alt="logo" style={{width: 84, height: 84}} />
      <div style={{fontSize: 62, fontWeight: 700, color: '#f4fafe'}}>水利安全AI眼镜</div>
    </div>
    <h1 className="h-title js-title" style={{position: 'absolute', left: 90, top: 1120, margin: 0, fontSize: 128}}>
      <div><Split text="发现隐患" lang="zh-CN" /></div>
      <div><Split text="预判风险" lang="zh-CN" /></div>
    </h1>
    <div className="js-beam beam" style={{opacity: 0}} />
    <div className="js-chips" style={{position: 'absolute', left: 60, right: 60, top: 1490, display: 'flex', gap: 16, justifyContent: 'center', flexWrap: 'wrap', opacity: 0}}>
      {INDUSTRIES.map(x => <span key={x} className="tag" style={{fontSize: 26, padding: '10px 26px'}}>{x}</span>)}
    </div>
    <div className="js-contact" style={{position: 'absolute', left: 0, right: 0, top: 1590, textAlign: 'center', fontSize: 30, color: '#a8d2ec', opacity: 0}}>
      {s.description}
    </div>
    <Waterline />
  </>;
}

export const buildClose = tl => {
  const s = shot('close');
  tl.set(q('close', ''), {opacity: 1}, s.start);
  driveWaterline('close');
  // e1 产品图与品牌回归
  tl.fromTo(q('close', '.js-hero'), {opacity: 0, y: 60, scale: 0.97},
    {opacity: 1, y: 0, scale: 1, duration: 1.0, ease: 'expo.out'}, s.start + 0.6);
  tl.fromTo(q('close', '.js-brandrow'), {opacity: 0, y: 24}, {opacity: 1, y: 0, duration: 0.6, ease: 'expo.out'}, s.start + 1.0);
  const lines = q('close', '.js-title').querySelectorAll('.split');
  lines.forEach((l, i) => reveal(tl, l, s.start + 0.8 + i * 0.4, {stagger: 0.055, from: {opacity: 0, y: 34, filter: 'blur(12px)'}}));
  // e3 光束扫过标题
  tl.set(q('close', '.js-beam'), {opacity: 1}, s.start + 2.55);
  tl.fromTo(q('close', '.js-beam'), {x: -320}, {x: 1180, duration: 0.6, ease: 'power2.inOut'}, s.start + 2.6);
  tl.to(q('close', '.js-beam'), {opacity: 0, duration: 0.15}, s.start + 3.2);
  // e4 行业 chips
  tl.fromTo(q('close', '.js-chips'), {opacity: 0}, {opacity: 1, duration: 0.3}, s.start + 3.2);
  tl.fromTo(q('close', '.js-chips').children, {opacity: 0, scale: 0.8},
    {opacity: 1, scale: 1, duration: 0.4, ease: 'expo.out', stagger: 0.09}, s.start + 3.2);
  // e5 预约信息
  tl.fromTo(q('close', '.js-contact'), {opacity: 0, y: 16}, {opacity: 1, y: 0, duration: 0.5, ease: 'power2.out'}, s.start + 4.4);
};
