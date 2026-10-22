import React, {useRef, useEffect} from 'react';
import {onRender} from '../engine.js';

/** 底部水位线 — 水利母题底纹。纯时间函数：三层正弦带渐起渐落（由 driveWaterline 驱动）。 */
export function Waterline() {
  return <canvas className="waterline" width="1080" height="300" data-waterline="1" />;
}

/** 把水位线的 onRender 挂到指定镜头（canvas 必须在该镜头内）。 */
export function driveWaterline(id) {
  const host = document.querySelector(`section[data-shot="${id}"] canvas[data-waterline]`);
  if (!host) return;
  const ctx = host.getContext('2d');
  onRender(id, local => {
    const t = local;
    ctx.clearRect(0, 0, 1080, 300);
    for (let layer = 0; layer < 3; layer++) {
      const amp = 16 + layer * 10;
      const yBase = 118 + layer * 52;
      const phase = t * (0.55 + layer * 0.28) + layer * 1.9;
      const alpha = 0.10 + layer * 0.055;
      const wave = x => yBase + Math.sin(x / 210 + phase) * amp + Math.sin(x / 88 + phase * 1.7) * amp * 0.35;
      ctx.beginPath();
      ctx.moveTo(0, 300);
      for (let x = 0; x <= 1080; x += 12) ctx.lineTo(x, wave(x));
      ctx.lineTo(1080, 300);
      ctx.closePath();
      const g = ctx.createLinearGradient(0, yBase - amp, 0, 300);
      g.addColorStop(0, `rgba(72,192,216,${alpha})`);
      g.addColorStop(1, 'rgba(72,192,216,0)');
      ctx.fillStyle = g;
      ctx.fill();
      ctx.beginPath();
      for (let x = 0; x <= 1080; x += 12) x === 0 ? ctx.moveTo(x, wave(x)) : ctx.lineTo(x, wave(x));
      ctx.strokeStyle = `rgba(120,208,240,${alpha + 0.10})`;
      ctx.lineWidth = 2;
      ctx.stroke();
    }
  });
}

/**
 * 等宽数字滚动（确定性）：builder 里 tl.fromTo(state,{v:0},{v:target}) 驱动，
 * rollBind 注册 onRender 每帧把 state.v 写进 el —— 任意时刻文字都是 t 的纯函数。
 */
export function rollBind(id, el, state, fmt) {
  onRender(id, () => { if (el) el.textContent = fmt(state.v); });
}

/** 镜头说明字幕（plan.description 与画面一致，静音可读） */
export function Caption({children, style}) {
  return <div className="caption" style={style}>{children}</div>;
}
