(() => {
  const out = {};
  const btn = document.querySelector("#submit");
  out.btnFound = !!btn;
  out.btnHtml = btn ? btn.outerHTML.slice(0, 200) : null;
  try {
    const evts = jQuery._data(btn, "events");
    out.jqueryEvents = evts ? Object.keys(evts).map(k =>
      k + ":" + evts[k].map(h => (h.handler || "").toString().slice(0, 150)).join(" | ")) : null;
  } catch(e) { out.jqueryErr = String(e).slice(0, 100); }
  try { out.hasJq = typeof jQuery !== "undefined"; } catch(e) { out.hasJq = false; }
  // 图片上的事件 (点选收集)
  const img = document.querySelector(".verify-img-panel img") || document.querySelector("img.back-img");
  if (img) {
    try {
      const ievts = jQuery._data(img, "events");
      out.imgEvents = ievts ? Object.keys(ievts) : null;
    } catch(e) {}
    // 原生 listeners 探测不到, 看父容器
    try {
      const pevts = jQuery._data(img.parentElement, "events");
      out.imgParentEvents = pevts ? Object.keys(pevts) : null;
    } catch(e) {}
  }
  return JSON.stringify(out);
})()
