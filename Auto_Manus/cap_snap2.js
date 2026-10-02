(() => {
  const img = document.querySelector(".verify-img-panel img") || document.querySelector("img.back-img") || document.querySelector("img[src^='data:']");
  if (!img) return JSON.stringify({err: "no img"});
  const r = img.getBoundingClientRect();
  const src = img.src;
  let h = 0; for (let i = 0; i < src.length; i += 997) h = (h * 31 + src.charCodeAt(i)) >>> 0;
  return JSON.stringify({
    rect: {x: r.x, y: r.y, w: r.width, h: r.height},
    natural: {w: img.naturalWidth, h: img.naturalHeight},
    srcLen: src.length, hash: h,
    instr: (document.body.innerText.match(/请依次点击【[^】]*】/)||[""])[0],
    points: document.querySelectorAll(".point-area").length
  });
})()
