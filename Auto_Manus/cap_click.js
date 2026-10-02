(() => {
  const img = document.querySelector(".verify-img-panel img") || document.querySelector("img[src^='data:']");
  if (!img) return JSON.stringify({err: "no img"});
  const r = img.getBoundingClientRect();
  const pts = [["邵",32,50],["帝",108,76],["滦",226,142],["拦",157,121]]; // 指令序
  const toC = (ix, iy) => [r.x + ix * r.width / img.naturalWidth,
                           r.y + iy * r.height / img.naturalHeight];
  const planned = pts.map(([ch, ix, iy]) => { const [x, y] = toC(ix, iy);
    return {ch, clientX: +x.toFixed(1), clientY: +y.toFixed(1)}; });
  const fire = (x, y) => {
    const el = document.elementFromPoint(x, y) || img;
    const opts = {bubbles: true, cancelable: true, view: window,
                  clientX: x, clientY: y, button: 0, buttons: 1};
    for (const T of ["pointerdown","mousedown","pointerup","mouseup","click"]) {
      try { el.dispatchEvent(T.startsWith("pointer")
        ? new PointerEvent(T, opts) : new MouseEvent(T, opts)); } catch(e) {}
    }
    return el.tagName;
  };
  let t = 200;
  const hitLog = [];
  pts.forEach(([ch, ix, iy], k) => {
    const [x, y] = toC(ix, iy);
    setTimeout(() => { hitLog.push(ch + ":" + fire(x, y)); }, t);
    t += 400 + Math.floor(Math.random() * 400);
  });
  window.__capHits = hitLog;
  return JSON.stringify({planned, rect: {x: r.x, y: r.y, w: r.width, h: r.height},
                         natural: {w: img.naturalWidth, h: img.naturalHeight}});
})()
