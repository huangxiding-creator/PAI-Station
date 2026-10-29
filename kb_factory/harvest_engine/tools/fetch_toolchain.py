# -*- coding: utf-8 -*-
"""SWF 工具链定位器 + 自举拉取（FR4.1 工具链层；DOC88_SPEC §1.7/§6-7）。

三件事：
1. **定位器**：rea-tools 约定目录下找 java（jdk*/bin）、ffdec.jar、presse
   （FFDec+JDK 本机已落位则直用，不重复下载）。
2. **自举兜底**：缺位组件从 GitHub latest release 拉取（坐标与原工具
   config.py 同源：ffdec=cmy2008/jpexs-decompiler（上游 jindrapetrik）、
   presse=cmy2008/presse），gh 代理前缀可配（KB_HARVEST_GH_PROXY，国内加速，
   只挂 github.com 下载位、api.github.com 位不挂）。幂等：在位=零网络。
3. **java 不在拉取射程**：JDK 属工作站预装约定（rea-tools/jdk-*），缺位只
   如实报缺（notes），不自动装。

铁律（CLAUDE.md 清理纪律）：全程零删除——旧件/坏件只留档+notes 提示人工
处置，不自动删改任何文件/目录。下载物落 rea-tools/.downloads/（gitignore
已覆盖 rea-tools/），解包校验用 zipfile/tarfile 的 filter="data"（防路径穿越）。

NFR6：FFDec/presse=GPL-3.0，本件只下载/落位二进制供子进程调用，不 import
其码、不 vendoring 进仓；核对表见同目录 LICENSES.md。
"""
from __future__ import annotations

import argparse
import json
import os
import re
import shutil
import subprocess
import sys
import tarfile
import urllib.error
import urllib.request
import zipfile
from dataclasses import dataclass, field, replace
from pathlib import Path
from platform import machine as _machine

__all__ = [
    "ToolchainError", "ToolchainReport", "PRESSE_REPO", "FFDEC_REPO",
    "FFDEC_UPSTREAM", "GH_PROXY_ENV", "TOOLCHAIN_ROOT_ENV", "JAVA_ENV",
    "FFDEC_JAR_ENV", "PRESSE_ENV", "default_toolchain_root", "proxied_url",
    "pick_presse_asset", "pick_ffdec_asset", "locate_java", "locate_ffdec",
    "locate_presse", "ffdec_banner", "parse_ffdec_banner", "probe_toolchain",
    "ensure_toolchain", "latest_release_assets", "download_to",
    "extract_archive", "main",
]

PRESSE_REPO = "cmy2008/presse"                    # 原工具 config.py presse_repo
FFDEC_REPO = "cmy2008/jpexs-decompiler"           # 原工具 config.py ffdec_repo
FFDEC_UPSTREAM = "jindrapetrik/jpexs-decompiler"  # 上游正主（溯源备注用）

GH_PROXY_ENV = "KB_HARVEST_GH_PROXY"        # 例: https://ghproxy.net/
TOOLCHAIN_ROOT_ENV = "KB_HARVEST_TOOLCHAIN_DIR"
JAVA_ENV = "KB_HARVEST_JAVA"
FFDEC_JAR_ENV = "KB_HARVEST_FFDEC_JAR"
PRESSE_ENV = "KB_HARVEST_PRESSE"

_GH_API_LATEST = "https://api.github.com/repos/{repo}/releases/latest"
_UA = "kb-harvest-toolchain/1.0 (doc88 swf chain)"
_BANNER_RE = re.compile(r"JPEXS Free Flash Decompiler v\.(\d+\.\d+\.\d+)")
_NET_ERRORS = (urllib.error.URLError, OSError, ValueError, KeyError)  # 收窄：测试注入的 AssertionError 等不吞


class ToolchainError(RuntimeError):
    """工具链缺位/拉取失败/解包异常（含补救指引）。"""


@dataclass(frozen=True)
class ToolchainReport:
    """一次 probe/ensure 的工具链事实快照（全部实测，无声明值）。"""

    root: Path
    java_exe: Path | None
    ffdec_jar: Path | None
    ffdec_version: str | None = None   # ffdec_banner 实测（opt-in，跑 JVM）
    presse_exe: Path | None = None
    fetched: list[str] = field(default_factory=list)  # 形如 "presse@v0.0.2"
    notes: list[str] = field(default_factory=list)    # 缺位/留档提示（不炸流程）


def default_toolchain_root() -> Path:
    """工具区根：环境变量优先，缺省=仓库根旁 rea-tools/（kb_factory 同级约定）。"""
    env = os.environ.get(TOOLCHAIN_ROOT_ENV)
    if env:
        return Path(env)
    return Path(__file__).resolve().parents[3] / "rea-tools"


def proxied_url(url: str, gh_proxy: str) -> str:
    """gh 代理前缀规则：空前缀=原样；仅 https://github.com/ 下载位挂前缀。

    api.github.com 与第三方域不挂（代理站通常只代理 release/raw 下载）。
    """
    if not gh_proxy:
        return url
    if url.startswith("https://github.com/"):
        return gh_proxy.rstrip("/") + "/" + url
    return url


def pick_presse_asset(asset_names: list[str], platform: str | None = None,
                      machine: str | None = None) -> str | None:
    """按平台选 presse release 资产（资产真名 2026-10-22 实测：
    presse-{x86_64|aarch64}-{pc-windows-msvc.zip|apple-darwin.tar.gz|
    unknown-linux-gnu.tar.gz|unknown-linux-musl.tar.gz}）。"""
    platform = sys.platform if platform is None else platform
    machine = _machine() if machine is None else machine
    m = machine.lower()
    if m in ("amd64", "x86_64", "x64"):
        arch = "x86_64"
    elif m in ("arm64", "aarch64"):
        arch = "aarch64"
    else:
        return None
    os_part = {"win32": "pc-windows-msvc", "darwin": "apple-darwin"}.get(platform)
    if platform == "linux":
        os_part = "unknown-linux-musl" if arch == "aarch64" else "unknown-linux-gnu"
    if os_part is None:
        return None
    target = f"presse-{arch}-{os_part}"
    for name in asset_names:
        if name.startswith(target) and (name.endswith(".zip") or name.endswith(".tar.gz")):
            return name
    return None


def pick_ffdec_asset(asset_names: list[str]) -> str | None:
    """选 ffdec 主 zip（排除 src/source/checksum；cli jar 等非 zip 天然出局）。"""
    for name in asset_names:
        low = name.lower()
        if (low.startswith("ffdec") and low.endswith(".zip")
                and "src" not in low and "source" not in low and "checksum" not in low):
            return name
    return None


def locate_java(root: Path) -> Path | None:
    """JDK 定位：root/jdk*/bin/java(.exe)（字典序取首）；否则 PATH 上 java。"""
    exe = "java.exe" if os.name == "nt" else "java"
    cands = sorted(root.glob(f"jdk*/bin/{exe}"))
    if cands:
        return cands[0]
    which = shutil.which("java")
    return Path(which) if which else None


def locate_ffdec(root: Path) -> Path | None:
    """FFDec 定位：root/ffdec/ffdec.jar 优先，次 root/ffdec*/ffdec.jar。"""
    direct = root / "ffdec" / "ffdec.jar"
    if direct.is_file():
        return direct
    for cand in sorted(root.glob("ffdec*/ffdec.jar")):
        if cand.is_file():
            return cand
    return None


def locate_presse(root: Path) -> Path | None:
    """presse 定位：root/presse/presse(.exe)（含子目录递归）；次顶层平放件。"""
    exe = "presse.exe" if os.name == "nt" else "presse"
    direct = root / "presse" / exe
    if direct.is_file():
        return direct
    holder = root / "presse"
    if holder.is_dir():
        cands = sorted(holder.rglob(exe))
        if cands:
            return cands[0]
    top = root / exe
    return top if top.is_file() else None


def ffdec_banner(java_exe: str | Path, ffdec_jar: str | Path,
                 timeout_s: int = 90) -> str:
    """真实 JVM 调 `-help` 取首行横幅（版本真源：CHANGELOG 会滞后，不采用）。"""
    try:
        proc = subprocess.run([str(java_exe), "-jar", str(ffdec_jar), "-help"],
                              capture_output=True, text=True, errors="replace",
                              timeout=timeout_s)
    except (subprocess.TimeoutExpired, OSError) as exc:
        raise ToolchainError(f"ffdec -help 执行失败: {exc}") from exc
    lines = (proc.stdout or proc.stderr or "").splitlines()
    return lines[0].strip() if lines else ""


def parse_ffdec_banner(text: str) -> str | None:
    """横幅析版：『JPEXS Free Flash Decompiler v.X.Y.Z』→ 'X.Y.Z'（不符→None）。"""
    m = _BANNER_RE.search(text)
    return m.group(1) if m else None


def latest_release_assets(repo: str, *, gh_proxy: str = "",
                          timeout_s: int = 30) -> tuple[str, dict[str, str]]:
    """GitHub latest release 元数据 → (tag, {资产名: 浏览器下载 URL})。"""
    url = _GH_API_LATEST.format(repo=repo)  # api 位不挂代理（proxied_url 规则）
    req = urllib.request.Request(url, headers={"User-Agent": _UA,
                                               "Accept": "application/vnd.github+json"})
    try:
        with urllib.request.urlopen(req, timeout=timeout_s) as resp:
            data = json.loads(resp.read().decode("utf-8"))
        tag = data["tag_name"]
        assets = {a["name"]: a["browser_download_url"] for a in data["assets"]}
    except _NET_ERRORS as exc:
        raise ToolchainError(f"GitHub release 元数据获取失败（{repo}）: {exc}") from exc
    return tag, assets


def download_to(url: str, dest: Path, *, gh_proxy: str = "",
                timeout_s: int = 300) -> Path:
    """下载到 dest（代理前缀可配）；已存在非空=幂等直返（零删除纪律）。"""
    if dest.is_file() and dest.stat().st_size > 0:
        return dest
    dest.parent.mkdir(parents=True, exist_ok=True)
    actual = proxied_url(url, gh_proxy)
    req = urllib.request.Request(actual, headers={"User-Agent": _UA})
    part = dest.with_name(dest.name + ".part")
    try:
        with urllib.request.urlopen(req, timeout=timeout_s) as resp, open(part, "wb") as fh:
            while True:
                chunk = resp.read(65536)
                if not chunk:
                    break
                fh.write(chunk)
        os.replace(part, dest)
    except _NET_ERRORS as exc:
        raise ToolchainError(f"下载失败（{actual}）: {exc}") from exc
    return dest


def _validate_zip_paths(zf: zipfile.ZipFile, dest_dir: Path) -> None:
    """zip 条目路径白名单校验（Python 3.13 zipfile.extractall 无 filter 形参，
    3.14+ 才有；本函数为 3.13 兜底：拒绝绝对路径/盘符/.. 穿越，名单全过后才解包）。"""
    dest = dest_dir.resolve()
    for info in zf.infolist():
        name = info.filename
        if name.startswith(("/", "\\")) or (len(name) > 1 and name[1] == ":"):
            raise ToolchainError(f"zip 条目路径非法（绝对/盘符）: {name}")
        if ".." in Path(name).parts:
            raise ToolchainError(f"zip 条目路径非法（.. 穿越）: {name}")
        target = (dest / name).resolve()
        if target != dest and dest not in target.parents:
            raise ToolchainError(f"zip 条目越界: {name} → {target}")


def extract_archive(archive: Path, dest_dir: Path) -> Path:
    """解包 zip/tar.gz 到目录（防路径穿越：zip=filter 或 3.13 手动校验兜底；
    tar=tarfile filter='data'）。"""
    suffix = archive.name.lower()
    dest_dir.mkdir(parents=True, exist_ok=True)
    try:
        if suffix.endswith(".zip"):
            with zipfile.ZipFile(archive) as zf:
                try:
                    zf.extractall(dest_dir, filter="data")  # 3.14+
                except TypeError:  # 3.13：无 filter 形参 → 白名单校验后常规解包
                    _validate_zip_paths(zf, dest_dir)
                    zf.extractall(dest_dir)
        elif suffix.endswith((".tar.gz", ".tgz")):
            with tarfile.open(archive, "r:*") as tf:
                tf.extractall(dest_dir, filter="data")
        else:
            raise ToolchainError(f"不支持的压缩形态: {archive.name}")
    except (zipfile.BadZipFile, tarfile.TarError, OSError) as exc:
        raise ToolchainError(f"解包失败（{archive}）: {exc}") from exc
    return dest_dir


def probe_toolchain(root: Path | None = None,
                    with_version: bool = False) -> ToolchainReport:
    """盘点三件在位性（只读）。with_version=True 时跑 JVM 实测 ffdec 版本。"""
    r = root if root is not None else default_toolchain_root()
    r = Path(r)
    java = locate_java(r)
    jar = locate_ffdec(r)
    presse = locate_presse(r)
    version = None
    if with_version and java and jar:
        version = parse_ffdec_banner(ffdec_banner(java, jar))
    return ToolchainReport(r, java, jar, version, presse)


def ensure_toolchain(components: tuple[str, ...] | list[str] = ("presse",),
                     root: Path | None = None, gh_proxy: str | None = None,
                     timeout_s: int = 300) -> ToolchainReport:
    """组件就绪保证（幂等）：在位直用零网络；缺 ffdec/presse 才拉；java 只报缺。

    :param components: "ffdec" / "presse" / "java" 子集（java=只盘点不拉取）。
    :param gh_proxy: None=读 KB_HARVEST_GH_PROXY；显式 ""=不走代理。
    :raises ToolchainError: 未知组件 / 拉取解包失败 / 拉取后仍未定位到件。
    """
    comps = tuple(components)
    for c in comps:
        if c not in ("ffdec", "presse", "java"):
            raise ToolchainError(f"未知组件: {c}（合法=ffdec/presse/java）")
    r = Path(root) if root is not None else default_toolchain_root()
    proxy = os.environ.get(GH_PROXY_ENV, "") if gh_proxy is None else gh_proxy
    rep = probe_toolchain(r)
    notes: list[str] = list(rep.notes)
    fetched: list[str] = []
    for comp in comps:
        if comp == "java":
            if rep.java_exe is None:
                notes.append(f"java 未落位且不在自举射程：请置于 {r}/jdk-*/bin/"
                             f"java(.exe) 或设 {JAVA_ENV} 指向在位 JDK")
            continue
        present = rep.ffdec_jar if comp == "ffdec" else rep.presse_exe
        if present is not None:
            continue  # 在位直用，零网络
        repo, picker = ((FFDEC_REPO, pick_ffdec_asset) if comp == "ffdec"
                        else (PRESSE_REPO, pick_presse_asset))
        marker = "ffdec.jar" if comp == "ffdec" else ("presse.exe" if os.name == "nt" else "presse")
        tag, assets = latest_release_assets(repo, gh_proxy=proxy, timeout_s=timeout_s)
        asset = picker(list(assets)) if comp == "ffdec" else pick_presse_asset(list(assets))
        if not asset:
            raise ToolchainError(f"{comp}: {repo}@{tag} 无匹配平台资产（候选={sorted(assets)}）")
        dl = download_to(assets[asset], r / ".downloads" / asset,
                         gh_proxy=proxy, timeout_s=timeout_s)
        stage = r / ".downloads" / f"extracted_{comp}_{tag}"
        if not any(stage.rglob(marker)):  # stage 缺失或半成品（上次解包中断）→ 重解
            extract_archive(dl, stage)
        hits = sorted(stage.rglob(marker))
        if not hits:
            raise ToolchainError(f"{comp}: 解包后未见 {marker}（留档 {stage} 待人工处置）")
        final_dir = r / comp
        src_dir = hits[0].parent
        if final_dir.exists():
            # 铁律（清理纪律）：已有目录不删不改，新拉件留档待人工处置
            notes.append(f"{comp}: {final_dir} 已存在但定位未命中，本次拉取留档 "
                         f"{stage}（不自动删改，人工核后处置）")
        elif src_dir == stage:
            shutil.move(str(stage), str(final_dir))
        else:
            shutil.move(str(src_dir), str(final_dir))
        newloc = locate_ffdec(r) if comp == "ffdec" else locate_presse(r)
        if newloc is None:
            raise ToolchainError(f"{comp}: 拉取落位后仍未定位到 {marker}（root={r}）")
        fetched.append(f"{comp}@{tag}")
        field_name = "ffdec_jar" if comp == "ffdec" else "presse_exe"
        rep = replace(rep, **{field_name: newloc})
        if comp == "ffdec" and rep.java_exe is None:
            notes.append("ffdec 已落位但 JVM 未落位：请装 JDK（见 java 组件说明）")
    return replace(rep, fetched=fetched, notes=notes)


def main(argv: list[str] | None = None) -> int:
    """CLI：--probe（盘点）/--ensure ffdec,presse（缺才拉，默认 presse）。"""
    parser = argparse.ArgumentParser(
        prog="fetch_toolchain",
        description="doc88 SWF 工具链定位/自举（FFDec+JDK 在位直用，缺 presse/ffdec 才拉）")
    parser.add_argument("--probe", action="store_true", help="只盘点不拉取")
    parser.add_argument("--with-version", action="store_true",
                        help="probe 时跑 JVM 实测 ffdec 版本（约数秒）")
    parser.add_argument("--ensure", default="",
                        help="逗号分隔组件（ffdec/presse/java），默认 presse")
    parser.add_argument("--root", default=None, help="工具区根（默认 rea-tools）")
    parser.add_argument("--gh-proxy", dest="gh_proxy", default=None,
                        help=f"gh 代理前缀（默认读 ${GH_PROXY_ENV}）")
    args = parser.parse_args(argv if argv is not None else sys.argv[1:])
    root = Path(args.root) if args.root else None
    if args.probe:
        rep = probe_toolchain(root, with_version=args.with_version)
    else:
        comps = tuple(c.strip() for c in args.ensure.split(",") if c.strip()) or ("presse",)
        rep = ensure_toolchain(comps, root=root, gh_proxy=args.gh_proxy)
    print(f"root={rep.root}")
    print(f"java={rep.java_exe}")
    print(f"ffdec={rep.ffdec_jar} version={rep.ffdec_version}")
    print(f"presse={rep.presse_exe}")
    print(f"fetched={rep.fetched}")
    for note in rep.notes:
        print(f"note: {note}")
    return 0


if __name__ == "__main__":  # pragma: no cover
    sys.exit(main())
