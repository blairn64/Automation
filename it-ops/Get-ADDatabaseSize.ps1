[CmdletBinding()]
param(
    [string[]]$ComputerName = @((Get-ADDomainController -Filter *).HostName),
    [string]$OutputPath
)

Import-Module ActiveDirectory -ErrorAction Stop

$results = foreach ($computer in $ComputerName) {
    try {
        $properties = Invoke-Command -ComputerName $computer -ScriptBlock {
            Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\NTDS\Parameters' -ErrorAction Stop
        }

        $dbPath = $properties.'DSA Database File'
        if (-not $dbPath -or -not (Test-Path -LiteralPath $dbPath)) {
            throw "NTDS database path was not found."
        }

        $file = Get-Item -LiteralPath $dbPath -ErrorAction Stop
        [pscustomobject]@{
            ComputerName = $computer
            DatabasePath  = $file.FullName
            SizeBytes     = $file.Length
            SizeMB        = [math]::Round($file.Length / 1MB, 2)
            CheckedAt     = Get-Date
            Status        = 'OK'
        }
    }
    catch {
        [pscustomobject]@{
            ComputerName = $computer
            DatabasePath  = $null
            SizeBytes     = $null
            SizeMB        = $null
            CheckedAt     = Get-Date
            Status        = "ERROR: $($_.Exception.Message)"
        }
    }
}

$results | Sort-Object SizeBytes -Descending | Format-Table -AutoSize
if ($OutputPath) { $results | Export-Csv -Path $OutputPath -NoTypeInformation }
