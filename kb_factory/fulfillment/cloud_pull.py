# -*- coding: utf-8 -*-
"""W11 云端履约拉取桥：引擎 accepted 订单 → 本地 inbox/。

链路：GET {KB_ENGINE_URL}/api/kb/orders/pending（X-KB-Bridge 共享密钥）→
按 version_sha 在本地蓝图目录解析全量蓝图 → 写 inbox/<otn>.json
（Order 契约字段）→ POST /api/kb/orders/ack 标 pulled。

凭据优先级（凭据零打印——日志只报状态码与计数）：
  1) env KB_ENGINE_URL / KB_BRIDGE_KEY
  2) env KB_BRIDGE_KEY_FILE 指向的密钥文件（缺省 E:\\AI-Station\\data\\secrets\\
     kb_bridge.key——与引擎 SECRETS_DIR 同一把钥匙）
  3) 07 任务 credentials ini（env KB_CREDENTIALS_INI 覆盖；键 engine_url=/bridge_key=）

蓝图解析：云端订单只带摘要五键（domain/files/gb/total/version_sha）；
本地按 djb2→8hex 摘要（与小程序 kbfactory_pay.js summarySha 逐字节同构，
数字格式对齐 JS String(number)：29.0→"29"）扫描蓝图目录匹配全量蓝图。
解析失败不 ack——订单留在云端 accepted 池，补蓝图后下轮重拉（不丢单）。
纪律：任何分支绝不删除文件。
"""
from __future__ import annotations

import json
import os
import urllib.error
import urllib.request
from pathlib import Path

from .order import OrderInbox

REPO_ROOT = Path(__file__).resolve().parents[2]
DEFAULT_BLUEPRINTS_DIR = REPO_ROOT / "kb_factory" / "seeds"
DEFAULT_KEY_FILE = Path(r"E:\AI-Station\data\secrets\kb_bridge.key")
DEFAULT_CREDENTIALS_INI = (REPO_ROOT / "07 任务" / "自动建库Agent"
                           / "_credentials" / "kb_bridge.secret.ini")
DEFAULT_ENGINE_URL = "https://ai.epcschool.top"


# ── 摘要算法（与 kbfactory_pay.js summarySha 同构锚）─────────────────────

def _js_num(v) -> str:
    """JS String(number)：整数值去 '.0'（29.0→'29'），其余最短表示。"""
    if isinstance(v, bool):
        return str(v)
    if isinstance(v, float) and v.is_integer():
        return str(int(v))
    return repr(v) if isinstance(v, float) else str(v)


def _djb2(s: str) -> int:
    h = 5381
    for ch in s:
        h = ((h << 5) + h + ord(ch)) & 0xFFFFFFFF
    return h


def digest_of_blueprint(bp: dict) -> str:
    sum_ = {
        "domain": (bp.get("domain") or ""),
        "files": ((bp.get("stats") or {}).get("files") or 0),
        "gb": ((bp.get("stats") or {}).get("gb") or 0),
        "total": ((bp.get("quote") or {}).get("total") or 0),
        "engine_version": ((bp.get("provenance") or {}).get("engine_version") or ""),
    }
    raw = "|".join(_js_num(sum_[k]) for k in
                   ("domain", "files", "gb", "total", "engine_version"))
    return format(_djb2(raw), "08x")


def resolve_blueprint(version_sha: str, blueprints_dir: Path) -> Path | None:
    """按摘要匹配全量蓝图 JSON（确定性：文件名序扫全目录）。"""
    if not version_sha or not blueprints_dir.is_dir():
        return None
    for p in sorted(blueprints_dir.glob("*.json")):
        try:
            bp = json.loads(p.read_text(encoding="utf-8"))
        except (OSError, ValueError):
            continue
        if isinstance(bp, dict) and digest_of_blueprint(bp) == version_sha:
            return p
    return None


# ── 凭据装配（零打印）─────────────────────────────────────────────────────

def load_bridge_config() -> tuple:
    """(engine_url, bridge_key)；密钥缺位=空串（调用方如实报错，不猜不编）。"""
    engine_url = (os.environ.get("KB_ENGINE_URL") or "").strip()
    bridge_key = (os.environ.get("KB_BRIDGE_KEY") or "").strip()
    ini = {}
    ini_path = Path(os.environ.get("KB_CREDENTIALS_INI") or DEFAULT_CREDENTIALS_INI)
    if not bridge_key and not engine_url and ini_path.is_file():
        for line in ini_path.read_text(encoding="utf-8").splitlines():
            line = line.strip()
            if line and "=" in line and not line.startswith(("#", ";")):
                k, v = line.split("=", 1)
                ini[k.strip()] = v.strip()
    if not engine_url:
        engine_url = ini.get("engine_url") or DEFAULT_ENGINE_URL
    if not bridge_key:
        key_file = Path(os.environ.get("KB_BRIDGE_KEY_FILE") or DEFAULT_KEY_FILE)
        if key_file.is_file():
            bridge_key = key_file.read_text(encoding="utf-8").strip()
        elif ini.get("bridge_key"):
            bridge_key = ini["bridge_key"]
    return engine_url.rstrip("/"), bridge_key


def _recompute_fen(bp: dict, version: str) -> int:
    """按蓝图真值复算 A 档价（fen）：base 2900 + gb*200；含 md ×1.5；含 import +1900（可组合）。缺数据返 0。"""
    try:
        gb = float((bp.get("stats") or {}).get("gb") or 0)
        fen = 2900 + gb * 200
        v = (version or "original").lower()
        if "md" in v or "markdown" in v:
            fen = round(fen * 1.5)
        if "import" in v or "ima_pack" in v:
            fen += 1900
        return int(round(fen))
    except Exception:
        return 0


def _wecom_alert(otn: str, got_fen: int, expect_fen: int) -> None:
    """篡价疑似告警（KB_WECOM_NOTIFY=0 静默，与 deliver 同闸；凭据零涉）。"""
    if str(os.environ.get("KB_WECOM_NOTIFY", "1")).strip() == "0":
        return
    try:
        import subprocess
        subprocess.run(
            ["py", "-X", "utf8", str(Path(__file__).resolve().parents[2] / "tools" / "notify_approval_wecom.py"),
             "KB篡价疑警（已拦截不发）",
             f"订单 {otn} 云端价 {got_fen}fen ≠ 蓝图真值 {expect_fen}fen，已不ack留云端待人工核"],
            timeout=15, capture_output=True)
    except Exception:
        pass  # 告警腿失败不阻断主链（拦截本身已生效）


# ── 拉取主链 ──────────────────────────────────────────────────────────────

class BridgeError(RuntimeError):
    """桥不可用（认证/配置/网络）——如实带状态码，绝不带密钥。"""


def _http_json(url: str, bridge_key: str, method: str = "GET",
               payload: dict | None = None) -> dict:
    data = json.dumps(payload or {}, ensure_ascii=False).encode("utf-8") \
        if method == "POST" else None
    req = urllib.request.Request(
        url, data=data, method=method,
        headers={"X-KB-Bridge": bridge_key,
                 "Content-Type": "application/json"})
    try:
        with urllib.request.urlopen(req, timeout=30) as resp:
            return json.loads(resp.read().decode("utf-8"))
    except urllib.error.HTTPError as e:
        raise BridgeError(f"履约桥 {method} {url.rsplit('/', 1)[-1]} "
                          f"HTTP {e.code}") from e
    except (urllib.error.URLError, OSError, ValueError) as e:
        raise BridgeError(f"履约桥不可达: {type(e).__name__}") from e


def pull_once(base_dir, engine_url: str = "", bridge_key: str = "",
              blueprints_dir=None) -> dict:
    """拉一轮 accepted 订单 → 逐单写 inbox → ack。返回执行摘要（凭据零打印）。"""
    if not engine_url or not bridge_key:
        env_url, env_key = load_bridge_config()
        engine_url = engine_url or env_url
        bridge_key = bridge_key or env_key
    if not bridge_key:
        raise BridgeError("KB_BRIDGE_KEY 未配置（env/密钥文件/credentials ini 均缺）")

    bp_dir = Path(blueprints_dir or os.environ.get("KB_BLUEPRINTS_DIR")
                  or DEFAULT_BLUEPRINTS_DIR)
    inbox = OrderInbox(base_dir)
    inbox.ensure_dirs()
    page = _http_json(f"{engine_url}/api/kb/orders/pending", bridge_key)
    summary = {"pulled": 0, "written": 0, "acked": 0,
               "unresolved": [], "otn": []}
    for o in (page.get("orders") or []):
        otn = (o.get("otn") or "").strip()
        if not otn:
            continue
        summary["pulled"] += 1
        bp_path = resolve_blueprint((o.get("blueprint") or {})
                                    .get("version_sha") or "", bp_dir)
        if bp_path is None:
            summary["unresolved"].append(otn)   # 不 ack：留云端下轮重拉
            continue
        # judge-W11#1 封门：云端 total_fen 必须与 sha 对应蓝图的服务端复算价一致
        # （引擎侧 gb 系客户端自报——攻击面=低价摘要下单大库；本地按蓝图真值复核，不符不ack+告警）
        try:
            with open(bp_path, encoding="utf-8") as f:
                bp_truth = json.load(f)
            expect_fen = _recompute_fen(bp_truth, (o.get("version") or "original"))
            got_fen = int(o.get("total_fen") or 0)
            if expect_fen and abs(got_fen - expect_fen) > 50:
                summary.setdefault("price_mismatch", []).append(
                    {"otn": otn, "cloud_fen": got_fen, "truth_fen": expect_fen})
                _wecom_alert(otn, got_fen, expect_fen)
                continue   # 不写单不ack：留云端待人工/下轮处置，绝不低价发大库
        except Exception as e:
            summary["unresolved"].append(f"{otn}:verify_exc:{type(e).__name__}")
            continue
        total_fen = int(o.get("total_fen") or 0)
        order = {
            "id": otn,
            "need_text": o.get("need_text") or "",
            "blueprint_ref": str(bp_path),
            "email": o.get("email") or "",
            "version_selection": o.get("version") or "original",
            "price": f"{total_fen / 100:.2f}",
            "paid_at": o.get("confirmed_at") or "",
            "status": "paid",
            "blueprint_digest": o.get("blueprint") or {},   # 审计随单（from_dict 过滤）
        }
        (inbox.inbox_dir / f"{otn}.json").write_text(
            json.dumps(order, ensure_ascii=False, indent=1), encoding="utf-8")
        summary["written"] += 1
        ack = _http_json(f"{engine_url}/api/kb/orders/ack", bridge_key,
                         method="POST", payload={"otn": otn})
        if ack.get("acknowledged"):
            summary["acked"] += 1
        summary["otn"].append(otn)
    return summary
