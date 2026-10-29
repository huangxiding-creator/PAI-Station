# W4 daemon deploy - Windows scheduled task (logon + every 5min guard relaunch)
# Entry: python -m zqg.daemon (single-instance lock inside daemon)
$ErrorActionPreference = "Stop"
$py = "E:\AI-Station\.venv\Scripts\python.exe"
$proj = "E:\AI-Station\zhipu-quota-guard"
$taskName = "ZhipuQuotaGuard"
$action = New-ScheduledTaskAction -Execute $py -Argument "-X utf8 -m zqg.daemon" -WorkingDirectory $proj
$boot = New-ScheduledTaskTrigger -AtLogOn
$repeat = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 5) -RepetitionDuration (New-TimeSpan -Days 3650)
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -RestartCount 3 -RestartInterval (New-TimeSpan -Minutes 1) -ExecutionTimeLimit ([TimeSpan]::Zero) -MultipleInstances IgnoreNew
Register-ScheduledTask -TaskName $taskName -Action $action -Trigger @($boot, $repeat) -Settings $settings -Force | Out-Null
Write-Host "[deploy] task $taskName registered (logon + 5min guard)"
