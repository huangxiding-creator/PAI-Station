(() => {
  const img = document.querySelector("img.back-img");
  if (!img) return JSON.stringify({err: "no img"});
  const r = img.getBoundingClientRect();
  const ix = 144, iy = 136;
  const x = r.x + ix * r.width / img.naturalWidth;
  const y = r.y + iy * r.height / img.naturalHeight;
  const el = document.elementFromPoint(x, y) || img;
  const base = {bubbles: true, cancelable: true, view: window,
                clientX: x, clientY: y, screenX: x + 100, screenY: y + 100,
                button: 0, buttons: 1};
  for (const T of ["pointerdown","mousedown","pointerup","mouseup","click"])
    el.dispatchEvent(T.startsWith("pointer") ? new PointerEvent(T, base) : new MouseEvent(T, base));
  return JSON.stringify({hit: "cao", tag: el.tagName, cx: +x.toFixed(1), cy: +y.toFixed(1),
    points: document.querySelectorAll(".point-area").length});
})()
