# PAI-Station 服务卸载（需管理员 PowerShell）
$ErrorActionPreference = "Stop"
$exe = Join-Path $PSScriptRoot "winsw\PAI-Station.exe"
if (Test-Path $exe) {
    & $exe stop
    & $exe uninstall
    Write-Host "PAI-Station 服务已卸载。"
} else {
    Write-Host "未找到 $exe（服务未安装？）"
}
