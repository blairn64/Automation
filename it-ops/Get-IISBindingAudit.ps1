[CmdletBinding()]
param(
    [string[]]$ComputerName = @($env:COMPUTERNAME),
    [string]$OutputPath
)

$results = foreach ($computer in $ComputerName) {
    try {
        $rows = Invoke-Command -ComputerName $computer -ScriptBlock {
            Import-Module WebAdministration -ErrorAction Stop
            Get-WebBinding | Select-Object protocol, bindingInformation
        } -ErrorAction Stop

        foreach ($binding in $rows) {
            $parts = $binding.bindingInformation.Split(':')
            $hostHeader = if ($parts.Count -ge 3) { $parts[2] } else { '' }
            $port = if ($parts.Count -ge 2) { $parts[1] } else { '' }
            $certificateCheck = if ($binding.protocol -eq 'https') {
                'Review certificate store/thumbprint mapping for this HTTPS binding'
            } else {
                'Not applicable'
            }

            [pscustomobject]@{
                ComputerName = $computer
                Protocol = $binding.protocol
                Binding = $binding.bindingInformation
                Port = $port
                HostHeader = $hostHeader
                CertificateCheck = $certificateCheck
                Status = 'REVIEW'
            }
        }
    }
    catch {
        [pscustomobject]@{
            ComputerName = $computer
            Protocol = $null
            Binding = $null
            Port = $null
            HostHeader = $null
            CertificateCheck = $null
            Status = "ERROR: $($_.Exception.Message)"
        }
    }
}

$results | Format-Table -Wrap -AutoSize
if ($OutputPath) { $results | Export-Csv -Path $OutputPath -NoTypeInformation }
