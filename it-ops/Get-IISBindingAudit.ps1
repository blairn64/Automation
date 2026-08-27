[CmdletBinding()]
param(
    [string[]]$ComputerName = @($env:COMPUTERNAME),
    [int]$WarningDays = 45,
    [string]$OutputPath
)

$results = foreach ($computer in $ComputerName) {
    try {
        $rows = Invoke-Command -ComputerName $computer -ScriptBlock {
            Import-Module WebAdministration -ErrorAction Stop
            Get-WebBinding | Select-Object protocol, bindingInformation
        } -ErrorAction Stop

        foreach ($binding in $rows) {
            $hostHeader = $binding.bindingInformation.Split(':')[-1]
            $certificateDays = $null
            if ($binding.protocol -eq 'https') {
                $parts = $binding.bindingInformation.Split(':')
                $port = $parts[1]
                $certificateDays = 'Review certificate store / thumbprint mapping'
            }

            [pscustomobject]@{
                ComputerName = $computer
                Protocol = $binding.protocol
                Binding = $binding.bindingInformation
                HostHeader = $hostHeader
                CertificateCheck = $certificateDays
                Status = 'REVIEW'
            }
        }
    }
    catch {
        [pscustomobject]@{
            ComputerName = $computer
            Protocol = $null
            Binding = $null
            HostHeader = $null
            CertificateCheck = $null
            Status = "ERROR: $($_.Exception.Message)"
        }
    }
}

$results | Format-Table -Wrap -AutoSize
if ($OutputPath) { $results | Export-Csv -Path $OutputPath -NoTypeInformation }
