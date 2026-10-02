(() => {
  const img = document.querySelector(".verify-img-panel img") || document.querySelector("#seccodeImage") || document.querySelector("img[src^='data:']");
  if (!img) return JSON.stringify({err: "no img"});
  const r = img.getBoundingClientRect();
  const src = img.src || "";
  // data-URI 内容指纹: 长度 + 魔数段 + 尾段 (足以判同图)
  const head = src.slice(0, 60), tail = src.slice(-40);
  let h = 0; for (let i = 0; i < src.length; i += 997) h = (h * 31 + src.charCodeAt(i)) >>> 0;
  return JSON.stringify({
    rect: {x: r.x, y: r.y, w: r.width, h: r.height},
    natural: {w: img.naturalWidth, h: img.naturalHeight},
    srcLen: src.length, hash: h, head: head, tail: tail,
    instr: (document.querySelector(".verify-img-panel")?.innerText || document.body.innerText.match(/请依次点击【[^】]*】/)?.[0] || "").slice(0, 40)
  });
})()
