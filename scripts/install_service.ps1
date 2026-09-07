# PAI-Station 服务安装（需管理员 PowerShell）
# 用法：右键"以管理员身份运行"或 Start-Process powershell -Verb RunAs -ArgumentList "-File install_service.ps1"
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot   # 仓库根
$winsw = Join-Path $PSScriptRoot "winsw"
$exe = Join-Path $winsw "PAI-Station.exe"

if (-not (Test-Path $exe)) {
    # 二进制不入库（.gitignore），首次安装自动下载
    $url = "https://github.com/winsw/winsw/releases/download/v2.12.0/WinSW-x64.exe"
    Write-Host "下载 WinSW -> $exe"
    Invoke-WebRequest -Uri $url -OutFile $exe -Proxy "http://127.0.0.1:7890"
}

# 自检先行：配置/密钥/依赖/数据目录（附录 P：不带病运行）
& (Join-Path $root ".venv\Scripts\python.exe") -m paistation --doctor
if ($LASTEXITCODE -ne 0) { throw "doctor 自检未通过，拒绝安装服务" }

& $exe install
& $exe start
Write-Host "PAI-Station 服务已安装并启动。状态："
& $exe status
