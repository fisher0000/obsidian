# 飞书知识库自动同步脚本
# 功能：将本地知识库文件同步到飞书云盘
# 运行方式：PowerShell -ExecutionPolicy Bypass -File sync_knowledge_base.ps1

param(
    [string]$LocalPath = "D:\WT\Github\obsidian\知识库",
    [string]$LogPath = "D:\WT\Github\obsidian\sync_log.txt",
    [switch]$WhatIf  # 模拟运行，不实际上传
)

# 配置
$FolderMapping = @{
    "ICH" = "MadJfDDtYldc8zdDXiycZnqunoc"
    "FDA" = "VBuzfII5FltYy4dDqc8cMKIunFf"
    "EMA" = "CQtbf6MBwlUd6kdBHI6cvmNMngf"
    "NMPA CFDA CFDI" = "GRZwfHxW6lfdJFdsWfbcaPOnnTI"
    "研究专题" = "GTELfptFVlvft5ddVvdcCh1Fn0c"
}

# 记录日志函数
function Write-Log {
    param([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "[$timestamp] $Message"
    Write-Host $logEntry
    Add-Content -Path $LogPath -Value $logEntry -ErrorAction SilentlyContinue
}

# 主程序
Write-Log "=== 知识库同步任务开始 ==="
Write-Log "本地路径: $LocalPath"

# 检查本地路径
if (-not (Test-Path $LocalPath)) {
    Write-Log "错误: 本地路径不存在: $LocalPath"
    exit 1
}

# 遍历本地文件夹
$localFolders = Get-ChildItem -Path $LocalPath -Directory
$syncCount = 0
$skipCount = 0
$errorCount = 0

foreach ($folder in $localFolders) {
    $folderName = $folder.Name
    Write-Log "处理文件夹: $folderName"
    
    # 查找对应的飞书文件夹token
    $targetFolderToken = $null
    foreach ($mapKey in $FolderMapping.Keys) {
        if ($folderName -like "*$mapKey*" -or $mapKey -like "*$folderName*") {
            $targetFolderToken = $FolderMapping[$mapKey]
            Write-Log "  匹配到飞书文件夹: $mapKey"
            break
        }
    }
    
    if (-not $targetFolderToken) {
        Write-Log "  警告: 未找到对应的飞书文件夹映射，跳过: $folderName"
        continue
    }
    
    # 获取本地文件列表
    $localFiles = Get-ChildItem -Path $folder.FullName -File -Filter "*.md"
    Write-Log "  本地文件数: $($localFiles.Count)"
    
    foreach ($file in $localFiles) {
        $fileName = $file.Name
        $lastModified = $file.LastWriteTime
        
        # 这里应该调用飞书API检查文件是否存在并比较修改时间
        # 由于飞书API限制，目前仅记录日志
        
        if ($WhatIf) {
            Write-Log "  [模拟] 将同步: $fileName (修改时间: $lastModified)"
        } else {
            # 实际同步逻辑需要飞书文件上传API支持
            # 当前仅记录需要同步的文件
            Write-Log "  待同步: $fileName -> 飞书文件夹"
        }
        $syncCount++
    }
}

Write-Log "=== 同步任务完成 ==="
Write-Log "统计: 待同步=$syncCount, 跳过=$skipCount, 错误=$errorCount"
Write-Log "日志文件: $LogPath"
