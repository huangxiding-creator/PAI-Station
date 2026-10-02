// CDP evaluate helper: node cdp_eval.js <port> <targetIdSubstring|urlSubstring> <js-file-or-'-:expr'>
// Sends Runtime.evaluate (awaitPromise) and prints the JSON result value.
const [, , portArg, sel, jsArg] = process.argv;
const port = portArg || "9333";

async function main() {
  const list = await (await fetch(`http://127.0.0.1:${port}/json`)).json();
  const pages = list.filter((t) => t.type === "page");
  let target = pages.find((t) => (t.id || "").includes(sel) || (t.url || "").includes(sel));
  if (!target) target = pages[0];
  if (!target) throw new Error("no page target");
  let expr;
  if (jsArg && jsArg.startsWith("-:")) expr = jsArg.slice(2);
  else expr = require("fs").readFileSync(jsArg, "utf8");
  const ws = new WebSocket(target.webSocketDebuggerUrl);
  await new Promise((res, rej) => { ws.onopen = res; ws.onerror = rej; });
  const send = (id, method, params) =>
    new Promise((res) => {
      const onmsg = (ev) => {
        const m = JSON.parse(ev.data);
        if (m.id === id) { ws.removeEventListener("message", onmsg); res(m); }
      };
      ws.addEventListener("message", onmsg);
      ws.send(JSON.stringify({ id, method, params }));
    });
  await send(1, "Runtime.enable", {});
  const r = await send(2, "Runtime.evaluate", {
    expression: expr, awaitPromise: true, returnByValue: true, replMode: true,
  });
  if (r.result && r.result.exceptionDetails)
    console.log("EXCEPTION:", JSON.stringify(r.result.exceptionDetails).slice(0, 800));
  else if (r.result && r.result.result)
    console.log(JSON.stringify(r.result.result.value ?? r.result.result.description ?? null));
  ws.close();
}
main().catch((e) => { console.error("ERR", e.message); process.exit(1); });
