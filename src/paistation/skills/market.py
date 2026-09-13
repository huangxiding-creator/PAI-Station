"""技能市场（提案 4.2 skills + M6.8 FR17 元数据层）。

发布 = 本地打包 zip（上传走 git/GitHub 网页，不在此硬编码凭据）；
安装 = 从市场 URL 拉取 zip 字节 → 五层安全扫描 → 解压落位。
扫描不过 = 拒装不留残骸（先扫后写，原子落位）。

M6.8 交易生态最小接口：meta.yaml（author/version/license/price/
requires）——发布侧 export 自动带元数据；消费侧 import_from 校验
（安全扫描→元数据完整性→同版拒覆盖）。积分结算与市场服务器是
v0.2+ 的事，本周只留接口。
"""
import io
import json
import os
import shutil
import tempfile
import zipfile
from pathlib import Path

from .scanner import scan_skill

META_FILE = "meta.yaml"
DEFAULT_META = {"author": "local", "version": "0.1.0",
                "license": "MIT", "price": 0, "requires": []}


def write_meta(skill_dir: str, meta: dict) -> dict:
    merged = {**DEFAULT_META, **{k: v for k, v in meta.items() if v != ""}}
    lines = []
    for key, value in merged.items():
        if isinstance(value, (list, tuple)):
            lines.append(f"{key}: {json.dumps(list(value), ensure_ascii=False)}")
        else:
            lines.append(f"{key}: {value}")
    path = os.path.join(skill_dir, META_FILE)
    with open(path, "w", encoding="utf-8") as fh:
        fh.write("\n".join(lines) + "\n")
    return merged


def read_meta(skill_dir: str) -> dict:
    path = os.path.join(skill_dir, META_FILE)
    if not os.path.isfile(path):
        return dict(DEFAULT_META)
    meta: dict = {}
    with open(path, encoding="utf-8") as fh:
        for line in fh:
            if ":" not in line:
                continue
            key, _, value = line.partition(":")
            key, value = key.strip(), value.strip()
            if not key or key.startswith("#"):
                continue
            if value.startswith("["):
                try:
                    meta[key] = json.loads(value)
                except ValueError:
                    meta[key] = []
            elif value.replace(".", "", 1).isdigit():
                meta[key] = float(value) if "." in value else int(value)
            else:
                meta[key] = value
    return {**DEFAULT_META, **meta}


class SkillMarket:
    """pack（发布侧）与 install（消费侧）。base 为市场根 URL。"""

    def __init__(self, base: str):
        self._base = base.rstrip("/")

    def pack(self, skill_dir: str, out_dir: str) -> str:
        skill_md = os.path.join(skill_dir, "SKILL.md")
        if not os.path.isfile(skill_md):
            raise FileNotFoundError(f"不是技能目录（缺 SKILL.md）：{skill_dir}")
        if not os.path.isfile(os.path.join(skill_dir, META_FILE)):
            write_meta(skill_dir, {})          # 发布必带元数据（FR17）
        name = os.path.basename(os.path.normpath(skill_dir))
        os.makedirs(out_dir, exist_ok=True)
        zpath = os.path.join(out_dir, f"{name}.zip")
        with zipfile.ZipFile(zpath, "w", zipfile.ZIP_DEFLATED) as zf:
            for dirpath, _dirnames, filenames in os.walk(skill_dir):
                for fname in filenames:
                    full = os.path.join(dirpath, fname)
                    arc = os.path.join(name, os.path.relpath(full, skill_dir))
                    zf.write(full, arc)
        return zpath

    def install(self, name: str, dest: str, fetch) -> str:
        """fetch(url) -> bytes（可注入；生产用 urllib 直连）。"""
        urls = [f"{self._base}/{name}.zip", f"{self._base}/{name}/SKILL.md"]
        last_exc: Exception | None = None
        for url in urls:
            try:
                data = fetch(url)
            except Exception as exc:  # noqa: BLE001 - 逐 URL 试
                last_exc = exc
                continue
            target = os.path.join(dest, name)
            if url.endswith(".zip"):
                self._install_zip(data, name, dest)
            else:
                report = scan_skill_text(data)
                if report["verdict"] == "block":
                    raise ValueError(f"技能 {name} 安全扫描不通过：{report['layers']}")
                os.makedirs(target, exist_ok=True)
                with open(os.path.join(target, "SKILL.md"), "wb") as fh:
                    fh.write(data)
            return target
        raise FileNotFoundError(f"市场拉取失败：{urls} 最后错误={last_exc}")

    def _install_zip(self, data: bytes, name: str, dest: str) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            with zipfile.ZipFile(io.BytesIO(data)) as zf:
                zf.extractall(tmp)  # noqa: S108 - 临时目录
            staged = os.path.join(tmp, name)
            if not os.path.isdir(staged):
                raise ValueError(f"zip 内无 {name}/ 目录")
            self.import_from(staged, dest)

    # ---- M6.8 元数据导入导出（FR17 交易接口） ----

    def export(self, skill_dir: str, out_dir: str) -> str:
        """发布侧：带 meta.yaml 打包（缺元数据自动补默认）。"""
        return self.pack(skill_dir, out_dir)

    def import_from(self, src_dir: str, dest: str) -> str:
        """消费侧：安全扫描→元数据校验→同版拒覆盖→原子落位。"""
        report = scan_skill(src_dir)
        if report["verdict"] == "block":
            raise ValueError(f"安全扫描不通过，拒装：{report['layers']}")
        meta = read_meta(src_dir)
        for field in ("author", "version"):
            if not str(meta.get(field, "")).strip():
                raise ValueError(f"元数据缺 {field}，拒绝安装")
        name = os.path.basename(os.path.normpath(src_dir))
        os.makedirs(dest, exist_ok=True)
        target = os.path.join(dest, name)
        if os.path.isdir(target):
            existing = read_meta(target)
            if str(existing.get("version")) == str(meta["version"]):
                raise ValueError(
                    f"技能 {name} 版本 {meta['version']} 已安装，"
                    "同版拒绝覆盖（升级请递增 version）")
            shutil.rmtree(target)               # 新版本替换旧版本
        shutil.copytree(src_dir, target, ignore=shutil.ignore_patterns(".git"))
        return Path(target)


def scan_skill_text(raw: bytes) -> dict:
    """单文件 SKILL.md 的轻量扫描（无目录结构时的降级路径）。"""
    import tempfile

    with tempfile.TemporaryDirectory() as tmp:
        d = os.path.join(tmp, "_solo")
        os.makedirs(d)
        with open(os.path.join(d, "SKILL.md"), "wb") as fh:
            fh.write(raw)
        return scan_skill(d)
