(() => {
  const img = document.querySelector("img.back-img") || document.querySelector(".verify-img-panel img");
  if (!img) return JSON.stringify({err: "no img"});
  const r = img.getBoundingClientRect();
  const ix = 186, iy = 56;
  const x = r.x + ix * r.width / img.naturalWidth;
  const y = r.y + iy * r.height / img.naturalHeight;
  const el = document.elementFromPoint(x, y) || img;
  const base = {bubbles: true, cancelable: true, view: window,
                clientX: x, clientY: y, screenX: x + 100, screenY: y + 100,
                button: 0, buttons: 1};
  for (const T of ["pointerdown","mousedown","pointerup","mouseup","click"])
    el.dispatchEvent(T.startsWith("pointer") ? new PointerEvent(T, base) : new MouseEvent(T, base));
  return JSON.stringify({hit: "qing", tag: el.tagName, cx: +x.toFixed(1), cy: +y.toFixed(1),
    points: document.querySelectorAll(".point-area").length});
})()
