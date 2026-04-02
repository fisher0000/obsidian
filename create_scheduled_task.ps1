# 创建飞书知识库同步定时任务
# 以管理员身份运行 PowerShell 后执行此脚本

$TaskName = "FeishuKnowledgeBaseSync"
$ScriptPath = "D:\WT\Github\obsidian\sync_knowledge_base.ps1"
$LogPath = "D:\WT\Github\obsidian\sync_log.txt"

# 检查脚本是否存在
if (-not (Test-Path $ScriptPath)) {
    Write-Error "同步脚本不存在: $ScriptPath"
    exit 1
}

# 删除已有任务（如果存在）
$existingTask = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue
if ($existingTask) {
    Write-Host "删除已有任务: $TaskName"
    Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false
}

# 创建任务动作
$Action = New-ScheduledTaskAction `
    -Execute "powershell.exe" `
    -Argument "-ExecutionPolicy Bypass -WindowStyle Hidden -File `"$ScriptPath`""

# 创建任务触发器 - 工作日每天早晨9:00
$Trigger = New-ScheduledTaskTrigger `
    -Daily `
    -At "09:00" `
    -DaysInterval 1

# 设置任务只在工作日运行
$Trigger.DaysOfWeek = @("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")

# 创建任务设置
$Settings = New-ScheduledTaskSettingsSet `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries `
    -StartWhenAvailable `
    -RunOnlyIfNetworkAvailable

# 创建任务对象
$Task = New-ScheduledTask `
    -Action $Action `
    -Trigger $Trigger `
    -Settings $Settings

# 注册任务（需要管理员权限）
try {
    Register-ScheduledTask `
        -TaskName $TaskName `
        -InputObject $Task `
        -Force
    
    Write-Host "✅ 定时任务创建成功!" -ForegroundColor Green
    Write-Host "任务名称: $TaskName"
    Write-Host "执行时间: 工作日 09:00"
    Write-Host "执行脚本: $ScriptPath"
    Write-Host "日志文件: $LogPath"
    Write-Host ""
    Write-Host "查看任务: Get-ScheduledTask -TaskName '$TaskName'"
    Write-Host "手动运行: Start-ScheduledTask -TaskName '$TaskName'"
    Write-Host "删除任务: Unregister-ScheduledTask -TaskName '$TaskName' -Confirm:`$false"
} catch {
    Write-Error "创建任务失败: $_"
    Write-Host "请确保以管理员身份运行 PowerShell"
}
