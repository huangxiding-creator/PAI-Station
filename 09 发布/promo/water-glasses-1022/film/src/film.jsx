import React from 'react';
import {ShotContext} from './film-store.js';
import {shots} from './engine.js';
import {SHOT_VIEWS} from './shots/index.js';
export function Film() {
  return <main id="film" className="film-theme">
    {shots.map((s, i) => {
      const View = SHOT_VIEWS[s.id];
      if (!View) throw new Error(`No view for shot "${s.id}" in src/shots/index.js`);
      return <section key={s.id} data-shot={s.id} className={'shot shot-' + s.id} style={{zIndex: i + 1}}>
        <ShotContext.Provider value={s}><View shot={s} /></ShotContext.Provider>
      </section>;
    })}
    {/* 首帧海报：视频号取首帧为封面；前 0.3s 全遮、0.3-0.6s 淡出（builder 挂轴） */}
    <img id="poster" src="poster.png" alt="" />
  </main>;
}
