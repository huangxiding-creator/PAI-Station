# M6.3 装后脚本（installer.iss [Run] 调用）：离线建 venv → 装应用 → 自检
# 参数 $appDir = 安装目录（含 wheel 与 wheels\）
param([string]$AppDir = "$env:LOCALAPPDATA\PAI-Station")
$ErrorActionPreference = "Stop"

Write-Host "[postinstall] 1/3 离线建 venv（ensurepip 自带 pip，不联网）" -ForegroundColor Cyan
$py = "python"
if (Get-Command py -ErrorAction SilentlyContinue) { $py = "py -3.11" }
& $py -m venv "$AppDir\.venv"
$np = "$AppDir\.venv\Scripts\python.exe"

Write-Host "[postinstall] 2/3 离线安装依赖+应用" -ForegroundColor Cyan
& $np -m pip install --no-index --find-links "$AppDir\wheels" `
    watchdog APScheduler tenacity
if ($LASTEXITCODE -ne 0) { throw "离线依赖安装失败" }
$whl = Get-ChildItem "$AppDir\dist\paistation-*.whl" | Select-Object -First 1
if ($whl) {
    & $np -m pip install --no-deps --no-index "$($whl.FullName)"
} else {
    & $np -m pip install --no-deps --no-index -e "$AppDir\src" 2>$null
}

Write-Host "[postinstall] 3/3 自检（doctor）" -ForegroundColor Cyan
& $np -X utf8 -m paistation --doctor
Write-Host "[postinstall] 完成。模型增强（可选）：python scripts\fetch_bge_m3.py"
