# M6.3 构建脚本：测试门禁 → wheel → 离线依赖 wheels
# 用法：powershell -ExecutionPolicy Bypass -File setup\build.ps1
# 产物：dist\paistation-*.whl + setup\wheels\*.whl（给 installer.iss 打包）
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
Set-Location $root
$py = ".venv\Scripts\python.exe"
if (-not (Test-Path $py)) { $py = "python" }

Write-Host "[build] 1/4 测试门禁" -ForegroundColor Cyan
& $py -X utf8 -m pytest -q
if ($LASTEXITCODE -ne 0) { throw "测试未全绿，拒绝打包" }

Write-Host "[build] 2/4 打 wheel" -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path dist | Out-Null
& $py -m pip wheel --no-deps -w dist .
if ($LASTEXITCODE -ne 0) { throw "wheel 构建失败" }

Write-Host "[build] 3/4 离线依赖 wheels（干净环境无网也能装）" -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path setup\wheels | Out-Null
& $py -m pip download -d setup\wheels watchdog APScheduler tenacity
if ($LASTEXITCODE -ne 0) { throw "依赖 wheels 下载失败" }

Write-Host "[build] 4/4 完成" -ForegroundColor Cyan
Get-ChildItem dist\*.whl | ForEach-Object { Write-Host "  wheel: $($_.Name)" }
Write-Host "  wheels: $((Get-ChildItem setup\wheels\*.whl).Count) 个依赖已就位"
Write-Host "下一步（装有 Inno Setup 6 的机器）：ISCC setup\installer.iss"
