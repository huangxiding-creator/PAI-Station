(() => {
  const btn = document.querySelector("#submit") ||
              [...document.querySelectorAll("a,button,div,span,input")].find(
                e => (e.innerText||"").trim() === "提交" || e.value === "提交");
  if (!btn) return JSON.stringify({err: "no submit btn"});
  const r = btn.getBoundingClientRect();
  const base = {bubbles: true, cancelable: true, view: window,
                clientX: r.x + r.width/2, clientY: r.y + r.height/2,
                button: 0, buttons: 1};
  for (const T of ["pointerdown","mousedown","pointerup","mouseup","click"]) {
    try { btn.dispatchEvent(T.startsWith("pointer")
      ? new PointerEvent(T, base) : new MouseEvent(T, base)); } catch(e) {}
  }
  return JSON.stringify({clicked: true, tag: btn.tagName, id: btn.id,
                         cls: btn.className, rect: [r.x, r.y, r.width, r.height]});
})()
