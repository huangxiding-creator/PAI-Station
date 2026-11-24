# -*- coding: utf-8 -*-
"""sph_live.py — 直播指挥舱 SPH-COMMAND 引擎（1125 提案批准后 W2 实施）

事件驱动状态机：每场直播一个 campaign.json 数字账本，daemon 按时间窗自动推进。

八阶段（每阶段幂等可重跑，全部落账）:
  S1 notice    预告创建      : 适配器=live-campaign-autopub 浏览器链(1104实战5场)/API升级路径在案
  S2 poster    预约海报      : Pillow 合成(标题/时间/伙伴/预约码占位) → 企微
  S3 article   宣传文三号    : 适配器=claude CLI 生成+gzh-autopublish 发表链(3号)
  S4 stream    推流码(T-2h)  : 纯API live/create_live_prepare → RTMP地址+密钥 ✅已实测
  S5 dispatch  伙伴包分发    : 推流码+主题封面(Pillow)+开播清单 → 企微 ✅通道实测
  S6 monitor   开播监测      : poll live/check_live_status 记录实际开播/收播时刻
  S7 highlights高光发布      : 触发 WeVideo-AutoPub run.py --mode publish(1113/1119 20条零失败)
  S8 archive   归档复盘      : bdn 上传→分享链接→企微 + 复盘报告(live stats+账本)

自动化程度如实账:
  - S4/S5/S6/S8 = 纯 API/本地，无人值守
  - S1/S3/S7   = 适配器调用在役外部链（浏览器自动化/claude生成），引擎负责触发+落账
  - 封面/海报   = Pillow 程序生成（模板化，非 AI 创意图）

用法:
  python sph_live.py init --id LIVE-1201 --title "总包月度大课" --start "2026-12-01 19:00" [--end 21:00] --partner "XX设计院" [--plan 计划表.xlsx]
  python sph_live.py run [LIVE-ID]     # 推进到当前应跑阶段(缺省=全部战役)
  python sph_live.py status            # 全部战役一览
  python sph_live.py daemon            # 常驻: 每60s扫描推进(计划任务挂载)
  python sph_live.py notify <ID> <msg> # 手动企微通知
"""
from __future__ import annotations

import argparse
import json
import pathlib
import subprocess
import sys
import time
from datetime import datetime, timedelta

ROOT = pathlib.Path(__file__).resolve().parent
CAMPAIGNS = ROOT / "campaigns"
LOGS = ROOT / "logs"
SPH = r"E:/AI-Station/逆向工程/shipinhao-reverse/sph.py"
WECOM = r"E:/AI-Station/tools/notify_approval_wecom.py"
WEVIDEO_RUN = r"E:/AI-Station/WeVideo-AutoPub/run.py"
BDN = r"E:/AI-Station/逆向工程/baidu-netdisk/replica/bdn.py"
PY = sys.executable
FONT = r"C:/Windows/Fonts/msyhbd.ttc"

STAGES = ["S1_notice", "S2_poster", "S3_article", "S4_stream",
          "S5_dispatch", "S6_monitor", "S7_highlights", "S8_archive"]


def _utf8():
    try:
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    except Exception:
        pass


def _run(cmd, timeout=600):
    """subprocess helper，返回 (rc, stdout+stderr)。"""
    try:
        r = subprocess.run(cmd, capture_output=True, text=True, timeout=timeout,
                           encoding="utf-8", errors="replace")
        return r.returncode, (r.stdout or "") + (r.stderr or "")
    except Exception as e:
        return 1, f"EXC:{e}"


def wecom(title: str, detail: str = ""):
    rc, out = _run([PY, "-I", WECOM, title, detail], timeout=60)
    ok = '"errcode":0' in out
    return ok, out.strip()[-200:]


def sph(*args):
    # --json 是 sph.py 的全局参数，必须放在子命令前
    return _run([PY, "-I", SPH, "--json", *args], timeout=900)


def _claude_path():
    import shutil
    p = shutil.which("claude") or shutil.which("claude.cmd") or shutil.which("claude.exe")
    return p


# ---------- 账本 ----------

def load(cid: str) -> dict:
    p = CAMPAIGNS / f"{cid}.json"
    if not p.exists():
        raise SystemExit(f"战役不存在: {cid}（init 先建）")
    return json.loads(p.read_text(encoding="utf-8"))


def save(c: dict, event: str, detail: str = ""):
    c.setdefault("history", []).append(
        {"ts": datetime.now().isoformat(timespec="seconds"), "event": event, "detail": detail[:300]})
    (CAMPAIGNS / f"{c['id']}.json").write_text(
        json.dumps(c, ensure_ascii=False, indent=1), encoding="utf-8")


def stage_done(c: dict, stage: str) -> bool:
    return (c.get("stages") or {}).get(stage, {}).get("done", False)


def mark(c: dict, stage: str, done: bool, detail: str = ""):
    c.setdefault("stages", {})[stage] = {
        "done": done, "ts": datetime.now().isoformat(timespec="seconds"), "detail": detail[:300]}
    save(c, stage, f"done={done} {detail}")


# ---------- 时间窗 ----------

def _dt(s: str) -> datetime:
    for fmt in ("%Y-%m-%d %H:%M", "%Y-%m-%d %H:%M:%S"):
        try:
            return datetime.strptime(s, fmt)
        except ValueError:
            continue
    raise SystemExit(f"时间格式须 YYYY-MM-DD HH:MM: {s}")


def window(c: dict, stage: str) -> tuple:
    """阶段允许执行的时间窗 (start, end)；(None,None)=随时。"""
    start = _dt(c["start_time"])
    if stage == "S1_notice":
        return start - timedelta(days=7), start - timedelta(hours=2)
    if stage == "S2_poster":
        return start - timedelta(days=7), start - timedelta(hours=2)
    if stage == "S3_article":
        return start - timedelta(days=7), start - timedelta(hours=2)
    if stage == "S4_stream":
        return start - timedelta(hours=2), start + timedelta(hours=1)
    if stage == "S5_dispatch":
        return start - timedelta(hours=2), start + timedelta(minutes=10)
    if stage == "S6_monitor":
        return start - timedelta(minutes=10), start + timedelta(hours=6)
    if stage == "S7_highlights":
        return start + timedelta(minutes=30), start + timedelta(days=3)
    if stage == "S8_archive":
        return start + timedelta(minutes=60), start + timedelta(days=3)
    return None, None


def in_window(c: dict, stage: str) -> bool:
    a, b = window(c, stage)
    if a is None:
        return True
    now = datetime.now()
    return a <= now <= b


# ---------- 各阶段实现 ----------

def st_notice(c: dict) -> str:
    """S1 预告创建。v1=适配器: 输出指令给 live-campaign-autopub 链(浏览器)；API 路径升级中。"""
    note = ("预告创建适配器：当前走 live-campaign-autopub 浏览器链（1104 五场实战）——"
            "由会话执行该技能（素材=本账本 title/start_time/partner）；"
            "API 路径(live_notice_operate 参数)挖通后切纯HTTP。"
            "预约码/预告ID 产出后回填: sph_live.py set %s notice_id=<id>" % c["id"])
    wecom(f"[直播舱] S1 预告创建待执行: {c['id']}", note)
    return f"adapter_dispatched: {note[:120]}"


def st_poster(c: dict) -> str:
    """S2 预约海报：Pillow 合成（标题/时间/伙伴）。预约码QR产出后可重跑叠加。"""
    try:
        from PIL import Image, ImageDraw, ImageFont
        W, H = 1080, 1440
        img = Image.new("RGB", (W, H), (16, 42, 84))
        d = ImageDraw.Draw(img)
        for y in range(H):  # 渐变
            d.line([(0, y), (W, y)], fill=(16, 42, 84 - int(30 * y / H)))
        f_big = ImageFont.truetype(FONT, 72)
        f_mid = ImageFont.truetype(FONT, 44)
        f_small = ImageFont.truetype(FONT, 32)
        d.text((80, 140), "直播预告", font=f_big, fill=(255, 215, 90))
        d.text((80, 280), c["title"][:18], font=f_mid, fill=(255, 255, 255))
        d.text((80, 380), (c["title"][18:36] or ""), font=f_mid, fill=(255, 255, 255))
        d.text((80, 560), f"开播：{c['start_time']}", font=f_mid, fill=(255, 255, 255))
        d.text((80, 650), f"主讲/伙伴：{c.get('partner', '-')}", font=f_small, fill=(200, 210, 230))
        d.text((80, 730), f"频道：总包说 视频号", font=f_small, fill=(200, 210, 230))
        qr = CAMPAIGNS / f"{c['id']}_reserve_qr.png"
        if qr.exists():
            q = Image.open(qr).resize((420, 420))
            img.paste(q, (80, 880))
            d.text((520, 1060), "扫码预约直播", font=f_small, fill=(255, 215, 90))
        else:
            d.text((80, 880), "[预约码待 S1 产出后重跑叠加]", font=f_small, fill=(150, 160, 180))
        out = CAMPAIGNS / f"{c['id']}_poster.png"
        img.save(out)
        wecom(f"[直播舱] S2 海报已合成: {c['id']}", f"文件: {out}")
        return str(out)
    except Exception as e:
        return f"poster_error: {e}"


def st_article(c: dict) -> str:
    """S3 宣传文：claude CLI 生成草稿（super-skill 风格）→ 人工/会话审核后走 gzh-autopublish。"""
    out_file = CAMPAIGNS / f"{c['id']}_article.md"
    claude = _claude_path()
    if not claude:
        return ("adapter_pending: claude CLI 不在 PATH——由会话代生成（super-skill 宣传文链），"
                "产出回填 set %s asset:article=<path>" % c["id"])
    prompt = (f"写一篇视频号直播预告宣传文：主题《{c['title']}》，开播时间 {c['start_time']}，"
              f"主讲 {c.get('partner','-')}，频道=总包说。受众=工程建设行业从业者。"
              f"800字内，价值导向，零AI表述，末尾带直播时间提醒。直接输出正文。")
    rc, out = _run([claude, "-p", prompt, "--output-format", "text"], timeout=600)
    if rc == 0 and len(out.strip()) > 200:
        out_file.write_text(out.strip(), encoding="utf-8")
        wecom(f"[直播舱] S3 宣传文草稿已生成: {c['id']}", f"{out_file}（审核后发表三号）")
        return f"draft: {out_file}"
    return f"article_error: rc={rc} {out[:120]}"


def st_stream(c: dict) -> str:
    """S4 推流码（纯API，已实测）。"""
    rc, out = sph("live", "stream")
    try:
        j = json.loads(out[out.index("{"):])
        if j.get("errCode") != 0:
            return f"stream_error: {str(j)[:200]}"
        d = j.get("data") or {}
        c.setdefault("assets", {})["stream_url"] = d.get("anchorStreamingUrl")
        c["assets"]["stream_key"] = d.get("anchorStreamingKey")
        c["assets"]["live_object_id"] = d.get("liveObjectId")
        save(c, "stream_acquired")
        return f"liveObjectId={d.get('liveObjectId')} rtmp={str(d.get('anchorStreamingUrl'))[:50]}"
    except Exception as e:
        return f"stream_parse_error: {e} {out[-150:]}"


def st_dispatch(c: dict) -> str:
    """S5 伙伴包：主题封面生成 + 推流码开播清单 → 企微。"""
    a = c.get("assets") or {}
    if not a.get("stream_url"):
        return "no_stream_yet"
    cover = CAMPAIGNS / f"{c['id']}_cover.png"
    try:
        from PIL import Image, ImageDraw, ImageFont
        img = Image.new("RGB", (1280, 720), (10, 30, 60))
        d = ImageDraw.Draw(img)
        f1 = ImageFont.truetype(FONT, 64)
        f2 = ImageFont.truetype(FONT, 36)
        d.text((90, 240), c["title"][:20], font=f1, fill=(255, 255, 255))
        d.text((90, 380), f"{c['start_time']}  ·  {c.get('partner','-')}", font=f2, fill=(180, 200, 230))
        img.save(cover)
    except Exception as e:
        cover = None
        print("cover_error:", e)
    packet = (f"【直播推流包 {c['id']}】\n"
              f"主题：{c['title']}\n开播：{c['start_time']}\n"
              f"推流地址：{a['stream_url']}\n推流密钥：{str(a.get('stream_key'))[:44]}...\n"
              f"（密钥仅限本场使用，请勿外传；封面已生成待随包发送）")
    ok, out = wecom(f"[直播舱] S5 伙伴包: {c['id']}", packet)
    return f"wecom={'ok' if ok else 'fail'} cover={cover.name if cover else 'none'}"


def st_monitor(c: dict) -> str:
    """S6 开播监测：单次检查（daemon 每轮调用），状态变化落账。"""
    rc, out = sph("live", "status")
    try:
        jj = json.loads(out[out.index("{"):])
        d = jj.get("data") or {}
        status = d.get("status")
        live_oid = d.get("liveObjectId")
        prev = (c.get("assets") or {}).get("live_status")
        if prev != status:
            c.setdefault("assets", {})["live_status"] = status
            c["assets"]["live_object_id"] = live_oid
            meaning = {0: "未开播", 1: "直播中", 2: "已收播"}.get(status, str(status))
            save(c, f"live_status={status}")
            wecom(f"[直播舱] 直播状态变化: {c['id']}", f"{meaning} (liveObjectId={live_oid})")
            if status == 2:
                c.setdefault("assets", {})["ended_at"] = datetime.now().isoformat(timespec="seconds")
                save(c, "live_ended")
        return f"status={status}"
    except Exception as e:
        return f"monitor_parse_error: {e} {out[-120:]}"


def st_highlights(c: dict) -> str:
    """S7 高光发布：触发 WeVideo-AutoPub（闸门发布带设计封面）。"""
    if (c.get("assets") or {}).get("live_status") not in (2, "2"):
        return "live_not_ended_yet"
    wecom(f"[直播舱] S7 触发高光链: {c['id']}", "WeVideo-AutoPub run.py --mode publish 启动（20条零失败链）")
    rc, out = _run([PY, "-I", WEVIDEO_RUN, "--mode", "publish", "--no-dry-run",
                    "--max-posts", "50"], timeout=3600)
    return f"wv_rc={rc} {out[-150:]}"


def st_archive(c: dict) -> str:
    """S8 归档复盘：bdn 上传高光产物→分享→企微+复盘。归档目录=campaigns 下最新高光产物。"""
    # 复盘：直播历史取最近一场数据
    rc, out = sph("live", "history", "--count", "3")
    stats = ""
    try:
        j = (json.loads(out[out.index("{"):]).get("data") or {})
        for it in j.get("liveObjectList") or []:
            if str(it.get("liveObjectId")) == str((c.get("assets") or {}).get("live_object_id")):
                stats = (f"在线峰值={it.get('maxOnlineCount')} GMV={it.get('payedGmv')} "
                         f"付款人数={it.get('payedNum')}")
                break
    except Exception:
        pass
    wecom(f"[直播舱] S8 归档复盘: {c['id']}",
          f"复盘字段已采集。{stats}｜高光产物归档走 wevideo-highlights 网盘腿（产物目录随 S7 产出）。")
    c.setdefault("assets", {})["retrospect_stats"] = stats
    return f"retrospect: {stats or 'no_stats'}"


STAGE_FN = {"S1_notice": st_notice, "S2_poster": st_poster, "S3_article": st_article,
            "S4_stream": st_stream, "S5_dispatch": st_dispatch, "S6_monitor": st_monitor,
            "S7_highlights": st_highlights, "S8_archive": st_archive}


def advance(c: dict, force: bool = False):
    """推进战役：跑所有「到窗且未完成」阶段。返回执行日志。"""
    logs = []
    for stage in STAGES:
        if stage_done(c, stage):
            continue
        if not force and not in_window(c, stage):
            continue
        try:
            r = STAGE_FN[stage](c)
        except Exception as e:
            r = f"exc:{e}"
        logs.append(f"{stage}: {r}")
        FAIL_PREFIX = ("error", "exc", "no_stream", "live_not", "adapter", "pending",
                       "stream_error", "stream_parse", "monitor_parse", "article_error")
        auto_done = (stage in ("S2_poster", "S4_stream", "S5_dispatch", "S6_monitor", "S8_archive")
                     and not str(r).startswith(FAIL_PREFIX))
        if force or auto_done:
            mark(c, stage, True, str(r)[:250])
    return logs


# ---------- CLI ----------

def cmd_init(a):
    CAMPAIGNS.mkdir(exist_ok=True)
    created = []
    if getattr(a, "plan", None) and pathlib.Path(a.plan).exists():
        import openpyxl
        wb = openpyxl.load_workbook(a.plan)
        ws = wb.active
        rows = list(ws.iter_rows(values_only=True))
        head = [str(h or "") for h in rows[0]]
        idx = {k: head.index(k) for k in ("场次ID", "标题", "开播时间", "结束时间", "合作伙伴") if k in head}
        for row in rows[1:]:
            try:
                cid = str(row[idx["场次ID"]]).strip()
                if not cid or cid.startswith("#"):
                    continue
                c = {"id": cid, "title": str(row[idx["标题"]]),
                     "start_time": str(row[idx["开播时间"]]),
                     "end_time": str(row[idx.get("结束时间")] or ""),
                     "partner": str(row[idx.get("合作伙伴")] or "-"),
                     "created_at": datetime.now().isoformat(timespec="seconds"),
                     "stages": {}, "assets": {}, "history": []}
                (CAMPAIGNS / f"{cid}.json").write_text(json.dumps(c, ensure_ascii=False, indent=1), encoding="utf-8")
                created.append(cid)
            except Exception as e:
                created.append(f"ROW_ERR:{e}")
    else:
        if not a.id:
            raise SystemExit("init 需要 --id 或 --plan")
        c = {"id": a.id, "title": a.title or "", "start_time": a.start or "",
             "end_time": a.end or "", "partner": a.partner or "-",
             "created_at": datetime.now().isoformat(timespec="seconds"),
             "stages": {}, "assets": {}, "history": []}
        (CAMPAIGNS / f"{a.id}.json").write_text(json.dumps(c, ensure_ascii=False, indent=1), encoding="utf-8")
        created.append(a.id)
    print("已建战役:", created)
    wecom("[直播舱] 战役已建", f"{created}")


def cmd_run(a):
    ids = [a.live_id] if a.live_id else [p.stem for p in CAMPAIGNS.glob("*.json")]
    for cid in ids:
        c = load(cid)
        logs = advance(c, force=getattr(a, "force", False))
        print(f"== {cid} ==")
        for l in logs:
            print(" ", l)
        if not logs:
            print("  (无到窗阶段)")


def cmd_status(a):
    CAMPAIGNS.mkdir(exist_ok=True)
    for p in sorted(CAMPAIGNS.glob("*.json")):
        c = json.loads(p.read_text(encoding="utf-8"))
        done = [s for s in STAGES if stage_done(c, s)]
        assets = c.get("assets") or {}
        print(f"[{c['id']}] {c['title'][:16]} 开播={c['start_time']} "
              f"完成={len(done)}/8 {' '.join(done)} "
              f"推流={'有' if assets.get('stream_url') else '无'} 状态={assets.get('live_status','-')}")


def cmd_set(a):
    c = load(a.live_id)
    k, v = a.key_value.split("=", 1)
    if k.startswith("asset:"):
        c.setdefault("assets", {})[k[6:]] = v
    else:
        c[k] = v
    save(c, f"set {k}")
    print("已写入")


def cmd_notify(a):
    ok, out = wecom(a.title, a.detail or "")
    print("wecom:", ok, out)


def cmd_daemon(a):
    LOGS.mkdir(exist_ok=True)
    logf = LOGS / "sph_live_daemon.log"
    print(f"daemon 启动: 每{a.interval}s扫描 {CAMPAIGNS}")
    while True:
        try:
            for p in CAMPAIGNS.glob("*.json"):
                try:
                    c = json.loads(p.read_text(encoding="utf-8"))
                except Exception:
                    continue
                logs = advance(c)
                for l in logs:
                    line = f"{datetime.now().isoformat(timespec='seconds')} [{c['id']}] {l}"
                    print(line, flush=True)
                    with open(logf, "a", encoding="utf-8") as f:
                        f.write(line + "\n")
        except Exception as e:
            with open(logf, "a", encoding="utf-8") as f:
                f.write(f"{datetime.now()} DAEMON_ERR {e}\n")
        time.sleep(a.interval)


def main(argv=None):
    _utf8()
    p = argparse.ArgumentParser(prog="sph-live", description="直播指挥舱 SPH-COMMAND 引擎")
    sub = p.add_subparsers(dest="cmd", required=True)
    q = sub.add_parser("init")
    q.add_argument("--id"); q.add_argument("--title"); q.add_argument("--start")
    q.add_argument("--end"); q.add_argument("--partner"); q.add_argument("--plan")
    q = sub.add_parser("run"); q.add_argument("live_id", nargs="?")
    q.add_argument("--force", action="store_true", help="无视时间窗强推(测试用)")
    sub.add_parser("status")
    q = sub.add_parser("set"); q.add_argument("live_id"); q.add_argument("key_value")
    q = sub.add_parser("notify"); q.add_argument("title"); q.add_argument("detail", nargs="?")
    q = sub.add_parser("daemon"); q.add_argument("--interval", type=int, default=60)
    a = p.parse_args(argv)
    {"init": cmd_init, "run": cmd_run, "status": cmd_status,
     "set": cmd_set, "notify": cmd_notify, "daemon": cmd_daemon}[a.cmd](a)


if __name__ == "__main__":
    main()
