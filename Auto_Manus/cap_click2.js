(() => {
  const img = document.querySelector(".verify-img-panel img") || document.querySelector("img[src^='data:']");
  if (!img) return JSON.stringify({err: "no img"});
  const r = img.getBoundingClientRect();
  const pts = [["A",32,50],["B",108,76],["C",226,142],["D",157,121]];
  const toC = (ix, iy) => [r.x + ix * r.width / img.naturalWidth,
                           r.y + iy * r.height / img.naturalHeight];
  const fire = (x, y) => {
    const el = document.elementFromPoint(x, y) || img;
    const base = {bubbles: true, cancelable: true, view: window,
                  clientX: x, clientY: y, screenX: x + 100, screenY: y + 100,
                  button: 0, buttons: 1, isTrusted: false};
    const log = [];
    for (const T of ["pointerdown","mousedown","pointerup","mouseup","click"]) {
      try {
        const E = T.startsWith("pointer") ? new PointerEvent(T, base) : new MouseEvent(T, base);
        log.push(T + "=" + el.dispatchEvent(E));
      } catch(e) { log.push(T + "!err"); }
    }
    return {el: el.tagName + (el.className ? "." + el.className : ""), log: log.join(",")};
  };
  const out = [];
  for (const [tag, ix, iy] of pts) {
    const [x, y] = toC(ix, iy);
    const res = fire(x, y);
    out.push({t: tag, x: +x.toFixed(1), y: +y.toFixed(1), el: res.el, ev: res.log});
  }
  return JSON.stringify(out);
})()
