(async () => {
  const img = document.querySelector("img.back-img");
  if (!img) return JSON.stringify({err: "no img", url: location.href.slice(0, 50)});
  const src = img.src; let h = 0;
  for (let i = 0; i < src.length; i += 997) h = (h * 31 + src.charCodeAt(i)) >>> 0;
  if (h !== 2385913007)
    return JSON.stringify({err: "img changed, coords stale", hash: h, srcLen: src.length});
  if (document.querySelectorAll(".point-area").length > 0)
    return JSON.stringify({err: "already clicked", points: document.querySelectorAll(".point-area").length});

  const r = img.getBoundingClientRect();
  const click = (ix, iy) => {
    const x = r.x + ix * r.width / img.naturalWidth;
    const y = r.y + iy * r.height / img.naturalHeight;
    const el = document.elementFromPoint(x, y) || img;
    const base = {bubbles: true, cancelable: true, view: window,
      clientX: x, clientY: y, screenX: x + 100, screenY: y + 100, button: 0, buttons: 1};
    for (const T of ["pointerdown", "mousedown", "pointerup", "mouseup", "click"])
      el.dispatchEvent(T.startsWith("pointer") ? new PointerEvent(T, base) : new MouseEvent(T, base));
  };
  const sleep = ms => new Promise(res => setTimeout(res, ms));

  const PTS = [[220, 84], [97, 163], [37, 93], [165, 182]];  // 郝 泰 爸 黎（指令序）
  for (const [ix, iy] of PTS) { click(ix, iy); await sleep(700); }

  const t1 = performance.now();
  let ok = false, how = "";
  while (performance.now() - t1 < 5000) {
    const vc = document.querySelector("#vc");
    if (vc && vc.value) { ok = true; how = "vc"; break; }
    if (/success/i.test(document.cookie)) { ok = true; how = "cookie"; break; }
    await sleep(120);
  }
  let submitted = false;
  if (ok) {
    const btn = document.querySelector("#submit");
    if (btn) {
      const b = btn.getBoundingClientRect();
      const base = {bubbles: true, cancelable: true, view: window,
        clientX: b.x + b.width / 2, clientY: b.y + b.height / 2,
        screenX: b.x + 100, screenY: b.y + 100, button: 0, buttons: 1};
      for (const T of ["pointerdown", "mousedown", "pointerup", "mouseup", "click"])
        btn.dispatchEvent(T.startsWith("pointer") ? new PointerEvent(T, base) : new MouseEvent(T, base));
      submitted = true;
    }
  }
  const gap = Math.round(performance.now() - t1);
  await sleep(800);
  return JSON.stringify({hash: h, clicked: PTS.length, ok, how, submitted, gapMs: gap,
    points: document.querySelectorAll(".point-area").length,
    vcLen: ((document.querySelector("#vc") || {value: ""}).value || "").length,
    url: location.href.slice(0, 60)});
})()
