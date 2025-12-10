# 获取进程
$process1 = Get-Process -Name SGuardSvc64
$process2 = Get-Process -Name SGuard64

# 检查是否找到进程
if ($process1 -eq $null -or $process2 -eq $null) {
    Write-Host "未找到指定的进程。"
    exit
}

# 设置进程优先级为“最最最低”
$process1.PriorityClass = "Idle"
$process2.PriorityClass = "Idle"

# 获取系统中的最后一个内核处理器编号
$lastProcessorNumber = (Get-WmiObject Win32_Processor).NumberOfLogicalProcessors - 1

# 设置进程相关性为最后一个内核
$process1.ProcessorAffinity = [math]::Pow(2, $lastProcessorNumber)
$process2.ProcessorAffinity = [math]::Pow(2, $lastProcessorNumber)

Write-Host "进程优先级已设置为'低'，相关性已设置为最后一个内核。"