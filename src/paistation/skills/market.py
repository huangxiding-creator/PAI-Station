"""技能市场（提案 4.2 skills）：GitHub 零服务器发布/安装。

发布 = 本地打包 zip（上传走 git/GitHub 网页，不在此硬编码凭据）；
安装 = 从市场 URL 拉取 zip 字节 → 五层安全扫描 → 解压落位。
扫描不过 = 拒装不留残骸（先扫后写，原子落位）。
"""
import io
import os
import shutil
import tempfile
import zipfile

from .scanner import scan_skill


class SkillMarket:
    """pack（发布侧）与 install（消费侧）。base 为市场根 URL。"""

    def __init__(self, base: str):
        self._base = base.rstrip("/")

    def pack(self, skill_dir: str, out_dir: str) -> str:
        skill_md = os.path.join(skill_dir, "SKILL.md")
        if not os.path.isfile(skill_md):
            raise FileNotFoundError(f"不是技能目录（缺 SKILL.md）：{skill_dir}")
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
            report = scan_skill(staged)
            if report["verdict"] == "block":
                raise ValueError(f"技能 {name} 安全扫描不通过：{report['layers']}")
            os.makedirs(dest, exist_ok=True)
            target = os.path.join(dest, name)
            if os.path.exists(target):
                shutil.rmtree(target)
            shutil.copytree(staged, target)


def scan_skill_text(raw: bytes) -> dict:
    """单文件 SKILL.md 的轻量扫描（无目录结构时的降级路径）。"""
    import tempfile

    with tempfile.TemporaryDirectory() as tmp:
        d = os.path.join(tmp, "_solo")
        os.makedirs(d)
        with open(os.path.join(d, "SKILL.md"), "wb") as fh:
            fh.write(raw)
        return scan_skill(d)
