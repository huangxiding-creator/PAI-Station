(() => {
  const out = {};
  const vc = document.querySelector("#vc");
  out.vcValue = vc ? vc.value : null;
  out.vcHtml = vc ? vc.outerHTML.slice(0, 150) : null;
  const img = document.querySelector("img.back-img") || document.querySelector(".verify-img-panel img");
  if (img) {
    const evts = jQuery._data(img, "events");
    if (evts && evts.click) {
      out.imgClickSrc = evts.click.map(h => (h.handler || "").toString()).join("\n---\n").slice(0, 1800);
    }
  }
  const btn = document.querySelector("#submit");
  const be = jQuery._data(btn, "events");
  if (be && be.click) out.submitSrc = be.click.map(h => (h.handler||"").toString()).join("").slice(0, 900);
  return JSON.stringify(out);
})()
