import React from 'react';
import {shot} from '../engine.js';
import {onRender} from '../engine.js';
import {Caption, rollBind} from '../kit/stage.jsx';

const q = (id, sel) => document.querySelector(`section[data-shot="${id}"] ${sel}`);

export function HubView({shot: s}) {
  return <>
    <div style={{position: 'absolute', left: 70, top: 200}}>
      <div className="kicker">GUANLAN CONSOLE</div>
      <div style={{fontSize: 74, fontWeight: 700, marginTop: 16, color: '#f4fafe'}}>数据后台 · 观澜</div>
    </div>
    {/* 建立镜头：总览实拍全貌（≤1.2s）→ 推近 */}
    <div className="shot-frame js-est" style={{left: 40, top: 430, width: 1000, height: 563}}>
      <span className="shot-tag">实拍 · 2026-10-22</span>
      <img src="material/console/overview.png" alt="观澜总览" style={{left: 0, top: 0, width: 1000, height: 563}} />
    </div>
    <Caption style={{top: 355}}>{s.description}</Caption>
    {/* KPI 大读数（线上真实数据） */}
    <div style={{position: 'absolute', left: 90, top: 545, opacity: 0}} className="js-kpis">
      <div style={{marginBottom: 58}}>
        <div className="num kpi-big js-k1">0</div>
        <div className="kpi-label">在册危险源（处）· 12 行业</div>
      </div>
      <div style={{marginBottom: 58}}>
        <div className="num kpi-big js-k2">0</div>
        <div className="kpi-label">一般事故隐患（条）· 累计</div>
      </div>
      <div>
        <div className="num kpi-big js-k3">0</div>
        <div className="kpi-label">重大事故隐患（条）· 全部闭环督办</div>
      </div>
    </div>
    {/* 项目地图实拍 + 脉动（源图 x540-2800 y240-1140，缩放 0.398） */}
    <div className="shot-frame js-map" style={{left: 90, top: 1250, width: 900, height: 358, opacity: 0}}>
      <span className="shot-tag">全国项目分布 · 实拍</span>
      <img src="material/console/overview.png" alt="项目地图"
        style={{left: -215, top: -96, width: 1529, height: 860}} />
    </div>
    <div className="js-pulse" style={{position: 'absolute', inset: 0, pointerEvents: 'none'}} />
  </>;
}

export const buildHub = tl => {
  const s = shot('hub');
  tl.set(q('hub', ''), {opacity: 1}, s.start);
  // 建立镜头入 → 推近 KPI 区 → 退场
  const est = q('hub', '.js-est');
  tl.fromTo(est, {opacity: 0, scale: 0.97}, {opacity: 1, scale: 1, duration: 0.45, ease: 'expo.out'}, s.start);
  tl.to(est, {scale: 1.5, transformOrigin: '9% 45%', duration: 1.3, ease: 'power2.inOut'}, s.start + 1.0);
  tl.to(est, {opacity: 0, duration: 0.35, ease: 'power2.out'}, s.start + 2.25);
  tl.fromTo(q('hub', '.caption'), {opacity: 0, y: 20}, {opacity: 1, y: 0, duration: 0.5}, s.start + s.descriptionAt);
  // KPI 读数
  tl.fromTo(q('hub', '.js-kpis'), {opacity: 0, y: 40}, {opacity: 1, y: 0, duration: 0.6, ease: 'expo.out'}, s.start + 2.35);
  const rows = [['.js-k1', 302, 2.5], ['.js-k2', 1418, 2.9], ['.js-k3', 309, 3.3]].map(([sel, val, at]) => {
    const st = {v: 0};
    const el = q('hub', sel);
    rollBind('hub', el, st, v => Math.round(v).toLocaleString('en-US'));
    tl.fromTo(st, {v: 0}, {v: val, duration: 1.2, ease: 'power2.out'}, s.start + at);
    return el;
  });
  void rows;
  // 地图 + 脉动光点
  tl.fromTo(q('hub', '.js-map'), {opacity: 0, y: 30}, {opacity: 1, y: 0, duration: 0.55, ease: 'expo.out'}, s.start + 3.5);
  const pulses = document.createElement('div');
  onRender('hub', local => {
    const host = q('hub', '.js-map');
    if (!host) return;
    const marks = [[0.11, 0.35], [0.75, 0.16], [0.34, 0.85]];
    let i = 0;
    for (const m of marks) {
      i++;
      let dot = host.querySelector('.pulse-' + i);
      if (!dot) {
        dot = document.createElement('div');
        dot.className = 'pulse-' + i;
        dot.style.cssText = 'position:absolute;width:18px;height:18px;border-radius:50%;background:#48e0ff;pointer-events:none;z-index:2';
        host.appendChild(dot);
      }
      const ph = (local * 1.5 + i * 0.7) % 1.5;
      dot.style.left = (m[0] * 900 - 9) + 'px';
      dot.style.top = (m[1] * 358 - 9) + 'px';
      dot.style.opacity = String(Math.max(0, 0.9 - ph));
      dot.style.transform = `scale(${0.5 + ph})`;
    }
  });
};
