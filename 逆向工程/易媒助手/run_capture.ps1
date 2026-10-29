
$dir = 'E:\AI-Station\逆向工程\易媒助手\carve\payload'
$before = @(Get-ChildItem $dir -Recurse -File -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName)
try {
  $p = Start-Process -FilePath "$dir\WEMedia.exe" -WorkingDirectory $dir -PassThru -ErrorAction Stop
  Write-Output ("STARTED PID=" + $p.Id)
} catch { Write-Output ("ERR: " + $_.Exception.Message); exit }
Start-Sleep -Seconds 18
Write-Output "=== processes ==="
Get-Process | Where-Object { $_.Path -like '*carve*' -or ($_.Name -match 'WEMedia|BugReport') } | Select-Object Id,Name,Path | Format-Table -AutoSize | Out-String -Width 220
Write-Output "=== network ==="
$pids = (Get-Process | Where-Object { $_.Path -like '*carve*' }).Id
foreach ($procId in $pids) {
  Get-NetTCPConnection -OwningProcess $procId -ErrorAction SilentlyContinue | Select-Object LocalAddress,LocalPort,RemoteAddress,RemotePort,State | Format-Table -AutoSize | Out-String -Width 200
}
Write-Output "=== new files ==="
$after = @(Get-ChildItem $dir -Recurse -File -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName)
Compare-Object $before $after | Where-Object SideIndicator -eq '=>' | ForEach-Object { $_.InputObject }
Write-Output "=== appdata new dirs ==="
Get-ChildItem 'C:\Users\91216\AppData\Roaming' -Directory | Where-Object { $_.LastWriteTime -gt (Get-Date).AddMinutes(-1) } | Select-Object -ExpandProperty Name
Write-Output "=== kill ==="
Get-Process | Where-Object { $_.Path -like '*carve*' } | Stop-Process -Force -ErrorAction SilentlyContinue
Write-Output "done"
